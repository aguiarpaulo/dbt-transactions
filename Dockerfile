FROM quay.io/astronomer/astro-runtime:12.2.0

WORKDIR '/usr/local/airflow'
COPY dbt-requirements.txt ./
RUN python -m virtualenv dbt_venv && source dbt venv/bin/activate &&
    pip install --no-cache-dir -r dbt-requirements.txt && deactivate