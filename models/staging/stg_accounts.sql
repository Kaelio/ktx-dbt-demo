select
    cast(account_id as text) as account_id,
    cast(parent_account_id as text) as parent_account_id,
    cast(account_name as text) as account_name,
    cast(domain as text) as domain,
    cast(industry as text) as industry,
    cast(sales_region as text) as sales_region,
    cast(size_band as text) as size_band,
    cast(lifecycle_status as text) as lifecycle_status,
    cast(is_internal as boolean) as is_internal,
    cast(is_test as boolean) as is_test,
    cast(created_at as timestamptz) as created_at
from {{ source('orbit_raw', 'accounts') }}
