with active_large_contract_accounts as (
    select distinct account_id
    from {{ ref('int_active_contract_arr') }}
    where contract_arr_cents > 20000000
),
actions as (
    select
        purchase_request.purchase_request_id as action_id,
        purchase_request.account_id,
        purchase_request.requester_user_id as user_id,
        purchase_request.created_at::date as action_date,
        'purchase_request' as action_type
    from {{ ref('stg_purchase_requests') }} purchase_request
    where purchase_request.status in ('submitted', 'approved')

    union all

    select
        approval.approval_event_id as action_id,
        approval.account_id,
        purchase_request.requester_user_id as user_id,
        approval.decided_at::date as action_date,
        'approval_event' as action_type
    from {{ ref('stg_approval_events') }} approval
    join {{ ref('stg_purchase_requests') }} purchase_request
        on purchase_request.purchase_request_id = approval.purchase_request_id
    where approval.decision = 'approved'

    union all

    select
        purchase_order.purchase_order_id as action_id,
        purchase_order.account_id,
        purchase_request.requester_user_id as user_id,
        purchase_order.created_at::date as action_date,
        'purchase_order' as action_type
    from {{ ref('stg_purchase_orders') }} purchase_order
    join {{ ref('stg_purchase_requests') }} purchase_request
        on purchase_request.purchase_request_id = purchase_order.purchase_request_id
    where purchase_order.status in ('created', 'sent', 'fulfilled')
)
select distinct
    actions.action_id,
    actions.account_id,
    actions.user_id,
    actions.action_date,
    actions.action_type
from actions
join active_large_contract_accounts
    on active_large_contract_accounts.account_id = actions.account_id
join {{ ref('stg_users') }} users
    on users.user_id = actions.user_id
join {{ ref('stg_accounts') }} accounts
    on accounts.account_id = actions.account_id
where actions.action_date between date '2026-03-23' and date '2026-03-29'
    and users.is_requester
    and not users.is_internal
    and not users.is_test
    and not accounts.is_internal
    and not accounts.is_test
