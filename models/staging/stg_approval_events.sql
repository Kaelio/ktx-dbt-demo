select
    cast(approval_event_id as text) as approval_event_id,
    cast(purchase_request_id as text) as purchase_request_id,
    cast(account_id as text) as account_id,
    cast(approver_user_id as text) as approver_user_id,
    cast(decision as text) as decision,
    cast(decided_at as timestamptz) as decided_at
from {{ source('orbit_raw', 'approval_events') }}
