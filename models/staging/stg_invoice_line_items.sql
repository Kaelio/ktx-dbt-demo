select
    cast(invoice_line_item_id as text) as invoice_line_item_id,
    cast(invoice_id as text) as invoice_id,
    cast(line_item_type as text) as line_item_type,
    cast(amount_cents as bigint) as amount_cents,
    cast(recognized_at as timestamptz) as recognized_at
from {{ source('orbit_raw', 'invoice_line_items') }}
