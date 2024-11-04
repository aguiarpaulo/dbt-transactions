WITH stg_customers AS (
    SELECT * FROM {{ref('stg_customers')}}
),

int_customers AS (
SELECT
    customer_id
    , customer_name
    , email
FROM
    stg_customers
)

SELECT * FROM int_customers