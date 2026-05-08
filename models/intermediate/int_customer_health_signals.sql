with active_accounts as (
    select distinct account_id
    from {{ ref('int_active_contract_arr') }}
),
unresolved_ticket_accounts as (
    select distinct account_id
    from {{ ref('stg_support_tickets') }}
    where severity in ('high', 'critical')
        and status in ('open', 'pending')
        and created_at::date >= date '2026-03-01'
),
recent_activity_accounts as (
    select distinct account_id
    from {{ ref('stg_purchase_requests') }}
    where created_at::date >= date '2026-03-01'
        and status in ('submitted', 'approved')

    union

    select distinct account_id
    from {{ ref('stg_approval_events') }}
    where decided_at::date >= date '2026-03-01'
        and decision = 'approved'

    union

    select distinct account_id
    from {{ ref('stg_purchase_orders') }}
    where created_at::date >= date '2026-03-01'
        and status in ('created', 'sent', 'fulfilled')
)
select
    account.account_id,
    account.parent_account_id,
    account.account_name,
    true as is_active_customer,
    unresolved_ticket_accounts.account_id is not null as has_unresolved_high_ticket,
    recent_activity_accounts.account_id is not null as has_recent_procurement_activity,
    case
        when unresolved_ticket_accounts.account_id is not null
            and recent_activity_accounts.account_id is null
        then 'high'
        when unresolved_ticket_accounts.account_id is not null
        then 'medium'
        else 'low'
    end as risk_level
from active_accounts
join {{ ref('stg_accounts') }} account
    on account.account_id = active_accounts.account_id
left join unresolved_ticket_accounts
    on unresolved_ticket_accounts.account_id = account.account_id
left join recent_activity_accounts
    on recent_activity_accounts.account_id = account.account_id
