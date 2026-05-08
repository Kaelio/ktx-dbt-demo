select
    date '2026-03-31' as as_of_date,
    account_id,
    parent_account_id,
    account_name,
    is_active_customer,
    has_unresolved_high_ticket,
    has_recent_procurement_activity,
    risk_level
from {{ ref('int_customer_health_signals') }}
