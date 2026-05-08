select
    cast(session_id as text) as session_id,
    cast(account_id as text) as account_id,
    cast(user_id as text) as user_id,
    cast(started_at as timestamptz) as started_at,
    cast(duration_seconds as bigint) as duration_seconds,
    cast(is_internal as boolean) as is_internal,
    cast(is_test as boolean) as is_test
from {{ source('orbit_raw', 'sessions') }}
