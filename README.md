# Data Track — Week 13 Assignment: Databricks Lab

Demonstrate the core skill of Week 13: running the analytics-engineering workflow you already know, at platform scale on **Databricks**. There is **no autograder** here: this assignment is reviewed by your teacher against the rubric below. You submit by opening a pull request with your work in the `task-1/` and `task-2/` folders.

> ⚠️ **Never commit your Databricks token or connection string.** Keep them in environment variables, exactly as you did with the Postgres password in Week 12. A committed secret is an automatic fail and a real-world security incident.

## Task 1 — PySpark exploration (required)

In a Databricks notebook, read `hyf.nyc_yellow.raw_trips` into a PySpark DataFrame and answer two questions using only transformations and a single action (`show()`, not `collect()` on the raw table):

- Which pickup borough has the most trips? (Join `hyf.nyc_yellow.raw_zones` on `pickup_location_id = location_id` to turn the location id into a `borough`.)
- What is the average `total_amount` per `payment_type`?

Then write two or three sentences on when you would reach for PySpark versus dbt SQL for a transformation.

**Deliverable:** export your notebook (`.ipynb` or `.py`) into `task-1/`. See `task-1/README.md`.

## Task 2 — dbt on Databricks (required)

Port your Week 10 dbt project to Databricks and run `fct_trips` as an incremental model.

1. Install `dbt-databricks` and configure a Databricks target in `profiles.yml` (token in an environment variable, never committed).
2. Confirm `dbt debug` passes against Databricks.
3. Change `fct_trips` to `materialized='incremental'` with `incremental_strategy='merge'` and a correct `unique_key`.
4. Run `dbt build --select fct_trips` twice and capture both run times.

**Deliverable:** your dbt project in `task-2/` (secrets and `target/` excluded) and the two build times plus explanation in `task-2/WRITEUP.md`. See `task-2/README.md`.

## Task 3 — optional bonuses

These build on the optional Going Further topics and do not affect whether the assignment passes.

- **Governance:** run `SHOW GRANTS` on `fct_trips`, capture its lineage graph, and write the `ALTER TABLE ... SET TAGS` statement you would use to tag a hypothetical PII column.
- **Streaming:** run the `rate`-source Structured Streaming demo, write the results to a Delta table, and describe what you observed.

## How to submit

1. **Fork** this repository.
2. Add your work to `task-1/` and `task-2/` (each folder has a README telling you what goes there).
3. Double-check that no token or connection string is committed anywhere (`.env` is git-ignored; a `.env.example` is provided as a template).
4. Open a **pull request** back to this repository. Your teacher reviews it against the rubric below.

## Rubric — what good looks like

- **PySpark:** your answers use a small aggregated result displayed with `show()`, not a `collect()` of the raw table; a sensible PySpark-versus-dbt answer.
- **dbt:** the project runs on Databricks with only the connection profile changed from Week 10; the `fct_trips` incremental config is correct (`merge`, a real `unique_key`, `>` not `>=`); the second `dbt build` is visibly faster than the first, and you can explain why.
- **Secrets:** no Databricks token or connection string committed anywhere.
