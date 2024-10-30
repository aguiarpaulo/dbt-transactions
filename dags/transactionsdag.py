from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator

# Default settings for the DAG
default_args = {
    'owner': 'paulo',
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# DAG definition
with DAG(
    'dbt_data_pipeline',
    default_args=default_args,
    description='Run DBT models in staging, intermediate, and marts layers',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2023, 1, 1),
    catchup=False,
) as dag:

    # Task to run staging models
    run_dbt_staging = BashOperator(
        task_id='dbt_run_staging',
        bash_command='cd C:/Users/user/Python/dbt-transactions/transactions && dbt run --select staging',
    )

    # Task to run intermediate models
    run_dbt_intermediate = BashOperator(
        task_id='dbt_run_intermediate',
        bash_command='cd C:/Users/user/Python/dbt-transactions/transactions && dbt run --select intermediate',
    )

    # Task to run marts models
    run_dbt_marts = BashOperator(
        task_id='dbt_run_marts',
        bash_command='cd C:/Users/user/Python/dbt-transactions/transactions && dbt run --select marts',
    )

    # Defining the order of task execution
    run_dbt_staging >> run_dbt_intermediate >> run_dbt_marts
