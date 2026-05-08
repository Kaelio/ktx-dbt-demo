select
    cast(purchase_order_id as text) as purchase_order_id,
    cast(purchase_request_id as text) as purchase_request_id,
    cast(account_id as text) as account_id,
    cast(supplier_id as text) as supplier_id,
    cast(created_at as timestamptz) as created_at,
    cast(status as text) as status,
    cast(amount_cents as bigint) as amount_cents
from {{ source('orbit_raw', 'purchase_orders') }}
