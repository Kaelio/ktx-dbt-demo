select
    cast(supplier_id as text) as supplier_id,
    cast(account_id as text) as account_id,
    cast(supplier_name as text) as supplier_name,
    cast(status as text) as status,
    cast(created_at as timestamptz) as created_at
from {{ source('orbit_raw', 'suppliers') }}
