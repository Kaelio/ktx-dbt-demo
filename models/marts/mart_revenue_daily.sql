select
    revenue_date,
    gross_revenue_cents::bigint as gross_revenue_cents,
    credits_cents::bigint as credits_cents,
    refunds_cents::bigint as refunds_cents,
    net_revenue_cents::bigint as net_revenue_cents,
    (gross_revenue_cents - credits_cents - refunds_cents = net_revenue_cents) as reconciliation_check
from {{ ref('int_revenue_components') }}
