select
    cast(account_hierarchy_id as text) as account_hierarchy_id,
    cast(parent_account_id as text) as parent_account_id,
    cast(child_account_id as text) as child_account_id,
    cast(relationship_type as text) as relationship_type,
    cast(effective_start_date as date) as effective_start_date,
    cast(effective_end_date as date) as effective_end_date
from {{ source('orbit_raw', 'account_hierarchy') }}
