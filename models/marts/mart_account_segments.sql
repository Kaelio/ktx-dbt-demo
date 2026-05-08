with current_contract as (
    select distinct on (contract.account_id)
        contract.account_id,
        contract.parent_account_id,
        contract.plan_id,
        contract.contract_arr_cents,
        contract.status,
        contract.start_date,
        contract.end_date
    from {{ ref('stg_contracts') }} contract
    order by
        contract.account_id,
        case when contract.status = 'active' then 0 else 1 end,
        contract.start_date desc
)
select
    account.account_id,
    account.parent_account_id,
    plan.plan_code as current_plan_code,
    plan.canonical_plan_code as normalized_plan_code,
    account.size_band,
    segment.segment,
    current_contract.contract_arr_cents,
    current_contract.status as contract_status
from {{ ref('stg_accounts') }} account
left join current_contract
    on current_contract.account_id = account.account_id
left join {{ ref('stg_plans') }} plan
    on plan.plan_id = current_contract.plan_id
left join {{ ref('stg_plan_segment_mapping') }} segment
    on segment.canonical_plan_code = plan.canonical_plan_code
    and segment.size_band = account.size_band
    and segment.effective_start_date <= date '2026-03-31'
    and segment.effective_end_date > date '2026-03-31'
