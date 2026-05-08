select
    cast(discount_term_id as text) as discount_term_id,
    cast(contract_id as text) as contract_id,
    cast(discount_type as text) as discount_type,
    cast(discount_cents as bigint) as discount_cents,
    cast(discount_percent as numeric) as discount_percent,
    cast(starts_on as date) as starts_on,
    cast(expires_on as date) as expires_on,
    cast(reason as text) as reason
from {{ source('orbit_raw', 'contract_discount_terms') }}
