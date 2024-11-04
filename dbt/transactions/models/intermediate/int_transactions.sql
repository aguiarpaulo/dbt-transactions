WITH stg_transactions AS (
    SELECT * FROM {{ref('stg_transactions')}}
),

int_transactions AS (
SELECT
    transaction_id
    , customer_id
    , subproduct_id
    , transaction_date
    , amount
FROM
    stg_transactions
)

SELECT * FROM int_transactions