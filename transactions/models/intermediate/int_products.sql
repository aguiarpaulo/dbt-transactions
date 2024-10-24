    WITH stg_products AS (
        SELECT * FROM {{ref('stg_products')}}
    ),

int_products AS (
SELECT
    product_id
    , product_name
    , product_category
FROM
    stg_products
)

SELECT * FROM int_products

