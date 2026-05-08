select
    cast(support_ticket_id as text) as support_ticket_id,
    cast(account_id as text) as account_id,
    cast(requester_user_id as text) as requester_user_id,
    cast(severity as text) as severity,
    cast(category as text) as category,
    cast(status as text) as status,
    cast(created_at as timestamptz) as created_at,
    cast(resolved_at as timestamptz) as resolved_at,
    cast(owner_user_id as text) as owner_user_id
from {{ source('orbit_raw', 'support_tickets') }}
