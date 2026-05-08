with line_components as (
    select
        line.recognized_at::date as revenue_date,
        sum(
            case
                when invoice.status = 'paid' and line.line_item_type <> 'credit'
                then line.amount_cents
                else 0
            end
        ) as gross_revenue_cents,
        sum(
            case
                when invoice.status = 'paid' and line.line_item_type = 'credit'
                then abs(line.amount_cents)
                else 0
            end
        ) as credits_cents
    from {{ ref('stg_invoice_line_items') }} line
    join {{ ref('stg_invoices') }} invoice
        on invoice.invoice_id = line.invoice_id
    group by 1
),
refund_components as (
    select
        refunded_at::date as revenue_date,
        sum(amount_cents) as refunds_cents
    from {{ ref('stg_refunds') }}
    where status = 'succeeded'
    group by 1
)
select
    coalesce(line_components.revenue_date, refund_components.revenue_date) as revenue_date,
    coalesce(line_components.gross_revenue_cents, 0) as gross_revenue_cents,
    coalesce(line_components.credits_cents, 0) as credits_cents,
    coalesce(refund_components.refunds_cents, 0) as refunds_cents,
    coalesce(line_components.gross_revenue_cents, 0)
        - coalesce(line_components.credits_cents, 0)
        - coalesce(refund_components.refunds_cents, 0) as net_revenue_cents
from line_components
full outer join refund_components
    on refund_components.revenue_date = line_components.revenue_date
