select
    cast(activation_event_id as text) as activation_event_id,
    cast(account_id as text) as account_id,
    cast(user_id as text) as user_id,
    cast(event_type as text) as event_type,
    cast(event_at as timestamptz) as event_at,
    cast(policy_version as text) as policy_version
from {{ source('orbit_raw', 'activation_events') }}
