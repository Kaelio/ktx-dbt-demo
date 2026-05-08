select
    quarter_start_date,
    quarter_label,
    segment,
    movement_type,
    movement_reason,
    count(distinct parent_account_id)::bigint as parent_account_count,
    sum(expansion_arr_cents)::bigint as expansion_arr_cents,
    sum(contraction_arr_cents)::bigint as contraction_arr_cents,
    sum(churned_arr_cents)::bigint as churned_arr_cents
from {{ ref('int_parent_account_arr_movements') }}
where segment = 'enterprise'
    and quarter_start_date = date '2026-01-01'
    and movement_type in ('expansion', 'contraction', 'churn')
group by 1, 2, 3, 4, 5
