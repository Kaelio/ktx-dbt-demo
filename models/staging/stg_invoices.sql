select
    cast(invoice_id as text) as invoice_id,
    cast(account_id as text) as account_id,
    cast(subscription_id as text) as subscription_id,
    cast(invoice_date as date) as invoice_date,
    cast(paid_at as timestamptz) as paid_at,
    cast(status as text) as status,
    cast(currency as text) as currency
from {{ source('orbit_raw', 'invoices') }}
