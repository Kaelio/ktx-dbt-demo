select
    date '2026-03-23' as week_start_date,
    date '2026-03-29' as week_end_date,
    20000000::bigint as contract_arr_threshold_cents,
    count(distinct user_id)::bigint as active_requesters
from {{ ref('int_procurement_qualifying_actions') }}
