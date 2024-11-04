WITH products AS (
    SELECT * FROM {{ref('int_products')}}
),

subproducts AS (
    SELECT * FROM {{ref('int_subproducts')}}
),

finance_products AS (
SELECT
    p.product_id
    , p.product_name
    , p.product_category
    , sp.subproduct_id
    , sp.subproduct_name
FROM products p
LEFT JOIN subproducts sp
ON p.product_id = sp.product_id
)

SELECT * FROM finance_products
