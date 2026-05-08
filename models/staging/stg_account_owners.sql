select
    cast(account_owner_id as text) as account_owner_id,
    cast(account_id as text) as account_id,
    cast(owner_user_id as text) as owner_user_id,
    cast(owner_team as text) as owner_team,
    cast(role as text) as role,
    cast(effective_start_date as date) as effective_start_date,
    cast(effective_end_date as date) as effective_end_date
from {{ source('orbit_raw', 'account_owners') }}
