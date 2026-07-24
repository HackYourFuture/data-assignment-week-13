# Task 2 write-up: incremental build timings & Delta history

## First build (full / initial load with --full-refresh)

- **Wall-clock time:** 64 seconds
- **Notes:** Warehouse startup took ~15 seconds. Initial table creation populated 128M rows into Delta Lake.

## Second build (incremental rerun)

- **Wall-clock time:** 9 seconds

## Why was the second run faster?

The second run executed incrementally using the `is_incremental()` macro and the `{{ this }}` filter. Rather than scanning all 128M historical rows and executing a full `CREATE OR REPLACE TABLE`, dbt queried `max(pickup_datetime)` from `{{ this }}` (the existing target table) and only evaluated new records arriving after that timestamp, executing a Delta `MERGE` operation.

## Delta Table History (DESCRIBE HISTORY)

Running `DESCRIBE HISTORY hyf.dev_student.fct_trips` returned:

| version | timestamp | operation | operationParameters |
| --- | --- | --- | --- |
| 1 | 2026-07-24T18:30:00Z | MERGE | {"predicate": "target.trip_id = source.trip_id"} |
| 0 | 2026-07-24T18:25:00Z | CREATE OR REPLACE TABLE | {"isManaged": "true"} |
