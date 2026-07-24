# Task 2: dbt on Databricks

Copy your **Week 10 dbt project** into this folder (or start from the `week-13-databricks` branch of [nyc-taxi-dbt-reference](https://github.com/lassebenni/nyc-taxi-dbt-reference)).

**Required changes:**

1. Install `dbt-databricks` locally (`pip install dbt-databricks` or `uv tool install dbt-databricks`).
2. Copy `profiles.yml.example` to `profiles.yml` (git-ignored) and export the env vars from `.env.example`.
3. Configure `fct_trips` as `materialized='incremental'` with `incremental_strategy='merge'` and a real `unique_key`.
4. Run `dbt build --select fct_trips` twice and document both timings plus your explanation in `WRITEUP.md`.

**Do not commit:** `profiles.yml`, `.env`, or any Databricks token.
