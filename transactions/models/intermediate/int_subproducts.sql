WITH stg_subproducts AS (
    SELECT * FROM {{ref('stg_subproducts')}}
),

int_subproducts AS (
SELECT
    subproduct_id
    , subproduct_name
    , product_id
FROM
    stg_subproducts
)

SELECT * FROM int_products