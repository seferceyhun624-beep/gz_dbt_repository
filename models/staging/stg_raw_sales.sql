with source as (

  select *
  from {{ source('raw', 'sales') }}

),

renamed as (

  select
    date_date,
    orders_id,
    pdt_id as products_id,
    revenue,
    quantity,
    concat(cast(orders_id as string), '-', cast(pdt_id as string)) as sales_pk
  from source

)

select *
from renamed
