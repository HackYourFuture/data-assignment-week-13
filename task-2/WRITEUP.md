# Task 2 write-up: incremental build timings & Delta history

Fill in after running `dbt build --select fct_trips --full-refresh` baseline followed by `dbt build --select fct_trips` incremental rerun against Databricks.

## First build (full / initial load with --full-refresh)

- **Wall-clock time:**
- **Notes:** (optional: warehouse size, any errors you fixed)

## Second build (incremental rerun)

- **Wall-clock time:**

## Why was the second run faster?

Write two or three sentences in your own words (see the assignment for the concepts you must name):

`___`

## Delta Table History (DESCRIBE HISTORY)

Paste the output or summary of `DESCRIBE HISTORY hyf.dev_yourname.fct_trips` (showing `CREATE OR REPLACE TABLE` and `MERGE` operations) or reference a screenshot:

`___`
