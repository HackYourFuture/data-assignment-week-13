# HackYourFuture Data Track — Week 13 Assignment

**Databricks Lab:** PySpark exploration + dbt incremental on Delta Lake.

Full instructions live in the curriculum: [Week 13 Assignment](https://github.com/HackYourFuture/datatrack/blob/main/Data%20Track/Week%2013/week_13__6_assignment.md).

## Where to start

| Folder | What to submit | Points (autograder) |
| --- | --- | --- |
| `task-1/` | PySpark notebook (`show()` on aggregated results, PySpark-vs-dbt note) | 35 |
| `task-2/` | Ported dbt project + `WRITEUP.md` (timings + incremental explanation) | 45 |
| Both | No committed secrets (`profiles.yml`, `.env`, tokens) | 20 (blocker if violated) |

**Passing score:** 60/100 on the autograder. Your teacher also reviews quality against the rubric (incremental config, `>` boundary, tool-choice writing).

## Repository layout

```text
data-assignment-week-13/
├── task-1/
│   └── pyspark_exploration.ipynb    # or .py export from Databricks
├── task-2/
│   ├── dbt_project.yml              # your ported Week 10 project
│   ├── models/
│   ├── profiles.yml.example
│   └── WRITEUP.md
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
| 20 | Required files present (`task-1` notebook, `task-2/dbt_project.yml`, `WRITEUP.md`) |
| 35 | Task 1 notebook mentions `show` and borough/payment_type work |
| 45 | Task 2 has incremental config (`materialized='incremental'`, `merge`, `unique_key`) and a filled `WRITEUP.md` |
| 20 | Secrets hygiene (no committed `.env` / `profiles.yml` / `dapi` tokens) |

Governance and streaming bonuses are teacher-reviewed only; they do not affect the autograder score.

## Instructor / track maintainer

This repo is the Week 13 student scaffold. Teacher rubric: `week_13__assignment_rubric.md` in the [datatrack](https://github.com/HackYourFuture/datatrack) curriculum repo (not shared with students).
