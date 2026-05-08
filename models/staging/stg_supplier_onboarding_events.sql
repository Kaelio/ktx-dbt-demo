select
    cast(supplier_onboarding_event_id as text) as supplier_onboarding_event_id,
    cast(supplier_id as text) as supplier_id,
    cast(account_id as text) as account_id,
    cast(event_type as text) as event_type,
    cast(event_at as timestamptz) as event_at,
    cast(status as text) as status
from {{ source('orbit_raw', 'supplier_onboarding_events') }}
