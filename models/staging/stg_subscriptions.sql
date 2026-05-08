select
    cast(subscription_id as text) as subscription_id,
    cast(account_id as text) as account_id,
    cast(contract_id as text) as contract_id,
    cast(plan_id as text) as plan_id,
    cast(mrr_cents as bigint) as mrr_cents,
    cast(status as text) as status,
    cast(started_at as timestamptz) as started_at,
    cast(ended_at as timestamptz) as ended_at,
    cast(cancelled_at as timestamptz) as cancelled_at
from {{ source('orbit_raw', 'subscriptions') }}
