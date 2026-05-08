select
    movement.arr_movement_id,
    movement.account_id,
    movement.parent_account_id,
    movement.contract_id,
    movement.movement_date,
    date_trunc('quarter', movement.movement_date)::date as quarter_start_date,
    to_char(date_trunc('quarter', movement.movement_date), 'YYYY-"Q"Q') as quarter_label,
    case
        when account.size_band = 'enterprise' or plan.canonical_plan_code = 'enterprise' then 'enterprise'
        when plan.canonical_plan_code = 'starter' and account.size_band = 'smb' then 'self_serve'
        else 'commercial'
    end as segment,
    movement.movement_type,
    movement.movement_reason,
    movement.arr_delta_cents,
    movement.starting_arr_cents,
    movement.ending_arr_cents,
    case when movement.movement_type = 'expansion' then movement.arr_delta_cents else 0 end
        as expansion_arr_cents,
    case when movement.movement_type = 'contraction' then abs(movement.arr_delta_cents) else 0 end
        as contraction_arr_cents,
    case when movement.movement_type = 'churn' then abs(movement.arr_delta_cents) else 0 end
        as churned_arr_cents,
    case
        when movement.movement_type = 'contraction'
            and movement.movement_reason = 'discount_expiration'
        then true
        else false
    end as is_discount_expiration_contraction,
    case when movement.movement_type = 'reactivation' then true else false end as is_reactivation
from {{ ref('stg_arr_movements') }} movement
join {{ ref('stg_accounts') }} account
    on account.account_id = movement.account_id
join {{ ref('stg_contracts') }} contract
    on contract.contract_id = movement.contract_id
join {{ ref('stg_plans') }} plan
    on plan.plan_id = contract.plan_id
