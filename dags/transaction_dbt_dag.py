from datetime import datetime, timedelta
from airflow import DAG
from airflow.decorators import dag, task
import subprocess
import os

# Configurações padrão da DAG
default_args = {
    'owner': 'paulo',
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define a DAG com o decorador @dag
@dag(
    'dbt_pipeline',
    default_args=default_args,
    description='Run DBT models in staging, intermediate, and marts layers',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2024, 10, 1),
    catchup=False,
)
def dbt_pipeline():
    
    # Função para executar o comando DBT
    def run_dbt_command(select_layer):
        # Define o diretório onde o DBT está localizado
        dbt_dir = '/usr/local/airflow/transactions'
        # Altera para o diretório do DBT
        os.chdir(dbt_dir)
        # Executa o comando DBT com o subprocess
        command = f"dbt run --select {select_layer}"
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        if result.returncode != 0:
            raise Exception(f"Erro ao executar {command}: {result.stderr}")
        print(result.stdout)

    @task
    def print_working_directory():
        print("Current working directory:", os.getcwd())

    @task
    def dbt_run_staging():
        run_dbt_command('staging')

    @task
    def dbt_run_intermediate():
        run_dbt_command('intermediate')

    @task
    def dbt_run_marts():
        run_dbt_command('marts')

    # Define a ordem de execução das tarefas
    
    t1 = print_working_directory()
    t2 = dbt_run_staging()
    t3 = dbt_run_intermediate()
    t4 = dbt_run_marts()
    
    t1 >> t2 >> t3 >> t4

# Instancia a DAG
dbt_pipeline()

