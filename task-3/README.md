# Task 3: Schedule a Git-backed dbt Job

Build on Chapter 5 ([Scheduling dbt Jobs](https://github.com/HackYourFuture/datatrack/blob/main/Data%20Track/Week%2013/week_13__5_scheduling_dbt_jobs.md)) by scheduling your ported dbt project directly from your GitHub repository fork.

## Instructions

1. Push your completed `task-2/` dbt project to your GitHub fork of `data-assignment-week-13` on branch `main`.
2. In Databricks **Workflows** → **Jobs**, create a Job named `dev_yourname_fct_trips`.
3. Add a `dbt` task type selecting **Git provider** as the source:
   - **Git repository URL:** `https://github.com/<your_username>/data-assignment-week-13.git`
   - **Git provider:** `GitHub`
   - **Git reference:** `main`
   - **Path / Project directory:** `task-2`
4. Configure task execution:
   - **dbt commands:** `dbt deps` followed by `dbt build --select fct_trips`
   - **SQL warehouse:** `hyf-dbt-warehouse`
   - **Catalog / Schema:** `hyf` / `dev_yourname`
5. Click **Run now** and verify that the run completes with a green checkmark.
6. Add a schedule (for example, daily at 06:00 UTC) and immediately **pause** the trigger.
7. Fill in `SCHEDULING.md` with your answers and place your screenshots into `task-3/screenshots/`.
