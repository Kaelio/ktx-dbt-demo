select
    date '2026-03-31' as metric_date,
    sum(contract_arr_cents)::bigint as arr_cents,
    '$18.742M' as display
from {{ ref('int_active_contract_arr') }}
