# AI Usage Log

## Interaction 1

- **Tool used:** Cursor
- **Task / Problem:** SMOKE TEST — debugging dbt profiles.yml env_var syntax for Databricks
- **Prompt sent:**
  > How do I set host and token via env_var in a dbt-databricks profiles.yml?
- **Output provided by AI:**
  > Suggested `host: "{{ env_var('DBRICKS_HOST') }}"` and `token: "{{ env_var('DBRICKS_TOKEN') }}"`.
- **What I kept, changed, or rejected, and why:**
  > Kept the env_var pattern; rejected putting a real token in the file. This file is a grader smoke-test fixture only.
