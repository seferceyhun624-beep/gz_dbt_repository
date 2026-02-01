with sales as (

    select
        date_date,
        orders_id,
        products_id,
        quantity,
        revenue
    from {{ ref('stg_raw_sales') }}

),

product as (

    select
        products_id,
        purchase_price
    from {{ ref('stg_raw_product') }}

)

select
    s.date_date,
    s.orders_id,
    s.products_id,
    s.quantity,
    s.revenue,

    p.purchase_price,

    s.quantity * p.purchase_price as purchase_cost,

    s.revenue - (s.quantity * p.purchase_price) as margin

from sales s
left join product p
    on s.products_id = p.products_id

