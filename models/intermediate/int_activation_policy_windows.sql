with pre_policy as (
    select
        'pre_policy' as policy_window,
        count(distinct cohort.user_id) as cohort_users,
        count(distinct activated.user_id) as activated_users
    from {{ ref('stg_activation_events') }} cohort
    left join {{ ref('stg_activation_events') }} activated
        on activated.user_id = cohort.user_id
        and activated.event_type = 'requester_activated'
        and activated.policy_version = 'pre_2026_01_15'
        and activated.event_at::date between date '2025-12-16' and date '2026-01-14' + interval '30 days'
    where cohort.event_type = 'first_requester_login'
        and cohort.policy_version = 'pre_2026_01_15'
        and cohort.event_at::date between date '2025-12-16' and date '2026-01-14'
),
post_policy as (
    select
        'post_policy' as policy_window,
        count(distinct cohort.user_id) as cohort_users,
        count(distinct activated.user_id) as activated_users
    from {{ ref('stg_activation_events') }} cohort
    left join {{ ref('stg_activation_events') }} activated
        on activated.user_id = cohort.user_id
        and activated.event_type = 'requester_activated'
        and activated.policy_version = 'post_2026_01_15'
        and activated.event_at::date between date '2026-01-15' and date '2026-02-14' + interval '30 days'
    where cohort.event_type = 'first_approved_purchase_request'
        and cohort.policy_version = 'post_2026_01_15'
        and cohort.event_at::date between date '2026-01-15' and date '2026-02-14'
)
select
    policy_window,
    cohort_users,
    activated_users,
    round((activated_users::numeric / nullif(cohort_users, 0)), 3) as activation_rate
from pre_policy

union all

select
    policy_window,
    cohort_users,
    activated_users,
    round((activated_users::numeric / nullif(cohort_users, 0)), 3) as activation_rate
from post_policy
