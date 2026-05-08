select
    cast(arr_movement_id as text) as arr_movement_id,
    cast(account_id as text) as account_id,
    cast(parent_account_id as text) as parent_account_id,
    cast(contract_id as text) as contract_id,
    cast(movement_date as date) as movement_date,
    cast(movement_type as text) as movement_type,
    cast(movement_reason as text) as movement_reason,
    cast(arr_delta_cents as bigint) as arr_delta_cents,
    cast(starting_arr_cents as bigint) as starting_arr_cents,
    cast(ending_arr_cents as bigint) as ending_arr_cents
from {{ source('orbit_raw', 'arr_movements') }}
