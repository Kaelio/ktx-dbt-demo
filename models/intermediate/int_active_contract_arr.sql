select
    contract_id,
    account_id,
    parent_account_id,
    plan_id,
    contract_arr_cents
from {{ ref('stg_contracts') }}
where status = 'active'
    and start_date <= date '2026-03-31'
    and end_date > date '2026-03-31'
