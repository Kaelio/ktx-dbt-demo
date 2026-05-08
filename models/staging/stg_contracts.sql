select
    cast(contract_id as text) as contract_id,
    cast(account_id as text) as account_id,
    cast(parent_account_id as text) as parent_account_id,
    cast(plan_id as text) as plan_id,
    cast(contract_arr_cents as bigint) as contract_arr_cents,
    cast(booked_arr_cents as bigint) as booked_arr_cents,
    cast(start_date as date) as start_date,
    cast(end_date as date) as end_date,
    cast(status as text) as status,
    cast(renewal_type as text) as renewal_type
from {{ source('orbit_raw', 'contracts') }}
