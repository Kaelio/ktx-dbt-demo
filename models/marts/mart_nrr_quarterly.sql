select
    quarter_start_date,
    quarter_label,
    segment,
    sum(starting_arr_cents)::bigint as starting_arr_cents,
    sum(expansion_arr_cents)::bigint as expansion_arr_cents,
    sum(contraction_arr_cents)::bigint as contraction_arr_cents,
    sum(churned_arr_cents)::bigint as churned_arr_cents,
    round(
        (
            sum(starting_arr_cents)
            + sum(expansion_arr_cents)
            - sum(contraction_arr_cents)
            - sum(churned_arr_cents)
        )::numeric / nullif(sum(starting_arr_cents), 0),
        3
    ) as net_revenue_retention
from {{ ref('int_parent_account_arr_movements') }}
where segment = 'enterprise'
    and quarter_start_date in (date '2025-10-01', date '2026-01-01')
group by 1, 2, 3
