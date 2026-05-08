select
    cast(user_id as text) as user_id,
    cast(account_id as text) as account_id,
    cast(email as text) as email,
    cast(role as text) as role,
    cast(is_requester as boolean) as is_requester,
    cast(is_internal as boolean) as is_internal,
    cast(is_test as boolean) as is_test,
    cast(created_at as timestamptz) as created_at,
    cast(slack_user_id as text) as slack_user_id,
    cast(looker_user_id as text) as looker_user_id,
    cast(notion_user_id as text) as notion_user_id,
    cast(drive_owner_id as text) as drive_owner_id
from {{ source('orbit_raw', 'users') }}
