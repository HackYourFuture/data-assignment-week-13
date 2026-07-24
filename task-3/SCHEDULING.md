# Task 3 Write-up: Git-backed Job Scheduling

## Databricks Job Run URL

https://adb-3180479709664531.11.azuredatabricks.net/#job/76801905206306/run/1049281726058284

## Screenshots

1. `job_config.png` — Showing the dbt task configuration with Git repository URL, branch `main`, path `task-2`, and warehouse `hyf-dbt-warehouse`.
2. `job_run_success.png` — Showing a successful run log with a green checkmark and stdout execution output.
3. `job_schedule_paused.png` — Showing the scheduled trigger set to **Paused**.

## Orchestration Comparison

### When would you choose Databricks Jobs versus Apache Airflow for pipeline orchestration?

Use Databricks Jobs for Databricks-native workloads (dbt on Databricks, PySpark notebooks, Delta Lake tasks) when you want zero external infrastructure management, tight Unity Catalog integration, and simple cron scheduling. Reach for Apache Airflow when orchestrating complex heterogeneous pipelines spanning multiple cloud platforms, external APIs, data warehouses (e.g. Postgres, Snowflake, BigQuery), or when requiring advanced branching, dynamic task mapping, and cross-team DAG dependencies.
