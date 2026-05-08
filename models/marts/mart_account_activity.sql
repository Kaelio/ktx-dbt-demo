select
    date '2026-01-15' as policy_change_date,
    max(case when policy_window = 'pre_policy' then activation_rate end)
        as pre_policy_30_day_activation_rate,
    max(case when policy_window = 'post_policy' then activation_rate end)
        as post_policy_30_day_activation_rate
from {{ ref('int_activation_policy_windows') }}
