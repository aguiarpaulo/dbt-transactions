WITH int_customers AS (
    SELECT * FROM {{ref('int_customers')}}
),

finance_customers AS (
SELECT
    customer_id
    , customer_name
    , email
FROM
    int_customers
)

SELECT * FROM finance_customers