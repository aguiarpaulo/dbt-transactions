WITH int_transactions AS (
    SELECT * FROM {{ref('int_transactions')}}
),

finance_transactions AS (
SELECT
    transaction_id
    , customer_id
    , subproduct_id
    , transaction_date
    , SUM(amount) AS amount
FROM
    int_transactions
GROUP BY 
    transaction_id
    , customer_id
    , subproduct_id
    , transaction_date
)

SELECT * FROM finance_transactions