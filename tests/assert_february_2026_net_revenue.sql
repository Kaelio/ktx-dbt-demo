select
    sum(net_revenue_cents)::bigint as actual_net_revenue_cents
from {{ ref('mart_revenue_daily') }}
where revenue_date >= date '2026-02-01'
    and revenue_date < date '2026-03-01'
having sum(net_revenue_cents)::bigint <> 168400000
