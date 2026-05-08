select
    cast(refund_id as text) as refund_id,
    cast(invoice_id as text) as invoice_id,
    cast(account_id as text) as account_id,
    cast(amount_cents as bigint) as amount_cents,
    cast(status as text) as status,
    cast(refunded_at as timestamptz) as refunded_at,
    cast(reason as text) as reason
from {{ source('orbit_raw', 'refunds') }}
