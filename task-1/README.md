# Task 1 — PySpark exploration

Put your exported PySpark notebook here (`.ipynb` or `.py`).

It should:

- Read `hyf.nyc_yellow.raw_trips` into a DataFrame.
- Answer the two questions using only PySpark transformations and a single action (`show()`):
  - Which pickup borough has the most trips? (Join `hyf.nyc_yellow.raw_zones` on `pickup_location_id = location_id`.)
  - What is the average `total_amount` per `payment_type`?
- Include your two-to-three sentences on PySpark versus dbt SQL (a markdown cell or a comment is fine).

Do **not** use `collect()` on the raw table.
