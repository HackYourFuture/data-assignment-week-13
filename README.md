# HackYourFuture Data Track — Week 13 Assignment

**Databricks Lab:** PySpark exploration, dbt incremental models on Delta Lake, and Git-backed Job scheduling.

Full instructions live in the curriculum: [Week 13 Assignment](https://github.com/HackYourFuture/datatrack/blob/main/Data%20Track/Week%2013/week_13__7_assignment.md).

## Where to start

| Folder | What to submit | Points (autograder) |
| --- | --- | --- |
| `task-1/` | PySpark notebook (`show()` on aggregated results, PySpark-vs-dbt note) | 25 |
| `task-2/` | Ported dbt project + `WRITEUP.md` (timings + incremental explanation) | 30 |
| `task-3/` | Git-backed Databricks Job + screenshots + `SCHEDULING.md` (Jobs vs Airflow) | 15 |
| Required files | Presence of all required files across `task-1/`, `task-2/`, and `task-3/` | 15 |
| Secrets hygiene | No committed secrets (`profiles.yml`, `.env`, tokens) | 15 (blocker if violated) |

**Passing score:** 60/100 on the autograder. Your teacher also reviews quality against the rubric (incremental config, `>` boundary, tool-choice writing, Job configuration).

## Repository layout

```text
data-assignment-week-13/
├── task-1/
│   └── pyspark_exploration.ipynb    # or .py export from Databricks
├── task-2/
│   ├── dbt_project.yml              # your ported Week 10 project
│   ├── models/                      # your dbt models
│   ├── profiles.yml.example
│   └── WRITEUP.md                   # incremental build write-up
├── task-3/                          # Git-backed Job scheduling
│   ├── SCHEDULING.md                # Jobs vs Airflow write-up
│   └── screenshots/                 # Job config, green run, paused trigger
├── .env.example
└── README.md
```

## Setup

```bash
cp .env.example .env          # fill in Databricks connection values
cd task-2
cp profiles.yml.example profiles.yml
export $(grep -v '^#' ../.env | xargs)   # or source manually
dbt debug
```

Use Python 3.11 or 3.12 for dbt if `dbt debug` crashes on import (`uvx --python 3.11 --from dbt-databricks dbt debug`).

## Check your score locally

```bash
bash .hyf/test.sh
cat .hyf/score.json
```

## Scoring ladder (autograder)

| Score | What the grader checks |
| --- | --- |
| 15 | Required files present (`task-1` notebook, `task-2/dbt_project.yml`, `WRITEUP.md`, `SCHEDULING.md`) |
| 25 | Task 1 notebook mentions `show` and borough/payment_type work |
| 30 | Task 2 has incremental config (`materialized='incremental'`, `merge`, `unique_key`) and a filled `WRITEUP.md` |
| 15 | Task 3 has screenshots in `task-3/screenshots/` and a filled `SCHEDULING.md` |
| 15 | Secrets hygiene (no committed `.env` / `profiles.yml` / `dapi` tokens) |

Governance and streaming bonuses are teacher-reviewed only; they do not affect the autograder score.

## Instructor / track maintainer

This repo is the Week 13 student scaffold. Teacher rubric: `week_13__assignment_rubric.md` in the [datatrack](https://github.com/HackYourFuture/datatrack) curriculum repo (not shared with students).
