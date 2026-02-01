with source as (

    select *
    from {{ source('raw', 'ship') }}

),

renamed as (

    select
        shipping_fee,
        * except (shipping_fee, shipping_fee_1)
    from source

)

select *
from renamed
