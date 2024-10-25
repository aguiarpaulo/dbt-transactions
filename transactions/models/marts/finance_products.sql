WITH products AS (
    SELECT * FROM {{ref('int_products')}}
),

finance_products AS (
SELECT
    p.product_id
    , p.product_name
    , p.product_category
    , sp.subproduct_id
    , sp.subproduct_name
FROM int_products p
LEFT JOIN int_subproducts sp
ON p.product_id = sp.subproduct_id
)

SELECT * FROM finance_products
