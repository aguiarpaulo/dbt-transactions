WITH transactions AS (
    SELECT * FROM {{ref('finance_transactions')}}
),
products AS (
    SELECT * FROM {{ref('finance_products')}}
),
customers AS (
    SELECT * FROM {{ref('finance_customers')}}
),


report_finance AS (
SELECT
    t.transaction_id
    , t.customer_id
    , t.subproduct_id
    , t.transaction_date
    , c.customer_name
    , c.email
    , p.product_id
    , p.product_name
    , p.product_category
    , p.subproduct_name
    , SUM(t.amount) AS amount_nbr
    , COUNT(DISTINCT(t.transaction_id)) AS transactions_cnt
FROM transactions t
LEFT JOIN customers c
ON t.customer_id = c.customer_id
LEFT JOIN products p
ON t.subproduct_id = p.subproduct_id
GROUP BY 
    t.transaction_id
    , t.customer_id
    , t.subproduct_id
    , t.transaction_date
    , c.customer_name
    , c.email
    , p.product_id
    , p.product_name
    , p.product_category
    , p.subproduct_id
    , p.subproduct_name
)

SELECT * FROM report_finance