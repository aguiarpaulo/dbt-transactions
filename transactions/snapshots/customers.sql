{% snapshot customers_snapshot %}

    {{
        config(
            target_schema='staging_snapshot',
            unique_key='customer_id',
            strategy='check',
            check_cols=['email', 'phone']
        )
    }}

    SELECT * FROM {{ ref('stg_customers') }}

{% endsnapshot %}