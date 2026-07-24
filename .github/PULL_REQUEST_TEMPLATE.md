## Summary
- **Databricks Job Run URL:** `<paste-your-job-run-url-here>`
- **Task 1 (PySpark):** Notebook in `task-1/` with aggregated borough and payment type queries.
- **Task 2 (dbt Incremental):** Ported dbt project in `task-2/` with `materialized='incremental'`, `merge` strategy, timing comparison, and `DESCRIBE HISTORY` proof in `WRITEUP.md`.
- **Task 3 (Job Scheduling):** Scheduled Databricks Job from GitHub fork on `hyf-dbt-warehouse` with screenshots and orchestration comparison in `task-3/SCHEDULING.md`.

## How to review
- Open `task-2/WRITEUP.md` to check initial vs incremental build times and `DESCRIBE HISTORY` output.
- Open `task-3/SCHEDULING.md` to verify the Databricks Job Run URL, screenshots, and Airflow comparison.
- Open `AI_ASSIST.md` for documented LLM interactions.

## Secrets hygiene checklist
- [ ] No `.env` or `profiles.yml` files committed.
- [ ] No Databricks personal access tokens (`dapi...`) hardcoded in any notebook or SQL file.
- [ ] `profiles.yml.example` and `.env.example` templates present.
