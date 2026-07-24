#!/usr/bin/env bash
# Week 13 autograder: static analysis only.
# dbt and PySpark run against the shared Databricks workspace, which CI cannot
# reach. This checks file presence, incremental config patterns, WRITEUP content,
# SCHEDULING content and screenshots, and secrets hygiene. Teacher rubric covers quality beyond this score.
# Total points: 100. Passing score: 60.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TASK1="$REPO_ROOT/task-1"
TASK2="$REPO_ROOT/task-2"
TASK3="$REPO_ROOT/task-3"

source "$SCRIPT_DIR/grader_lib.sh"

cat > "$SCRIPT_DIR/score.json" <<'INIT'
{"score": 0, "pass": false, "passingScore": 60}
INIT

score=0
PASSING=60

file_has_content() {
  local f="$1"
  [[ -s "$f" ]] || return 1
  local body
  body="$(grep -vE '^[[:space:]]*$|^[[:space:]]*<!--' "$f" 2>/dev/null || true)"
  [[ -n "$body" ]] || return 1
  return 0
}

find_notebook() {
  find "$TASK1" -maxdepth 1 \( -name '*.ipynb' -o -name '*.py' \) -type f 2>/dev/null | head -1
}

# ── Secrets blockers (must pass before any points) ───────────────────────────
if [[ -f "$REPO_ROOT/.env" ]]; then
  blocker ".env is committed — run: git rm --cached .env, then rotate your Databricks token"
fi
if [[ -f "$TASK2/profiles.yml" ]]; then
  blocker "task-2/profiles.yml is committed — run: git rm --cached task-2/profiles.yml, then rotate your Databricks token"
fi
if grep -rE 'dapi[0-9a-f]{20,}' "$REPO_ROOT" --include='*.yml' --include='*.py' --include='*.ipynb' --include='*.md' --include='*.sql' --exclude-dir='.git' 2>/dev/null | grep -qv 'dapi\.\.\.'; then
  blocker "Possible Databricks token (dapi...) found in committed files — remove it and rotate the token"
fi

# ── Level 1 (15 pts): required files ───────────────────────────────────────
l1=0
missing=0
nb="$(find_notebook || true)"
if [[ -n "$nb" ]]; then pass "task-1 notebook: $(basename "$nb")"; else fail "task-1: add pyspark_exploration.ipynb or .py"; missing=$((missing + 1)); fi
if [[ -f "$TASK2/dbt_project.yml" ]]; then pass "task-2/dbt_project.yml"; else fail "task-2/dbt_project.yml missing"; missing=$((missing + 1)); fi
if file_has_content "$TASK2/WRITEUP.md"; then pass "task-2/WRITEUP.md"; else fail "task-2/WRITEUP.md empty or missing"; missing=$((missing + 1)); fi
if file_has_content "$TASK3/SCHEDULING.md"; then pass "task-3/SCHEDULING.md"; else fail "task-3/SCHEDULING.md empty or missing"; missing=$((missing + 1)); fi
if [[ "$missing" -eq 0 ]]; then l1=15; fi
score=$((score + l1))
pass "Level 1: required files ($l1/15 pts)"

# ── Level 2 (25 pts): Task 1 patterns ──────────────────────────────────────
l2=0
if [[ -n "$nb" ]]; then
  nb_text="$(cat "$nb" 2>/dev/null || true)"
  if echo "$nb_text" | grep -qiE 'show\s*\('; then l2=$((l2 + 10)); pass "notebook uses show()"; else fail "notebook should use show() for results"; fi
  if echo "$nb_text" | grep -qiE 'borough|payment_type|groupBy|groupby'; then l2=$((l2 + 15)); pass "notebook addresses borough and/or payment_type"; else fail "notebook should join zones and aggregate payment_type"; fi
fi
score=$((score + l2))
pass "Level 2: PySpark notebook ($l2/25 pts)"

# ── Level 3 (30 pts): Task 2 incremental + WRITEUP ─────────────────────────
l3=0
fct="$(find "$TASK2/models" -name 'fct_trips.sql' 2>/dev/null | head -1 || true)"
if [[ -n "$fct" ]]; then
  fct_body="$(cat "$fct")"
  if echo "$fct_body" | grep -qiE "materialized\s*=\s*'incremental'|materialized\s*:\s*'incremental'"; then
    l3=$((l3 + 10)); pass "fct_trips incremental materialization"
  else
    fail "fct_trips should be materialized='incremental'"
  fi
  if echo "$fct_body" | grep -qiE 'incremental_strategy|merge|unique_key'; then
    l3=$((l3 + 10)); pass "incremental merge config present"
  else
    fail "fct_trips needs merge strategy and unique_key"
  fi
else
  fail "models/marts/fct_trips.sql (or similar) not found"
fi
writeup="$(sed -E 's/<!--.*-->//g' "$TASK2/WRITEUP.md" 2>/dev/null || true)"
writeup_student="$(echo "$writeup" | grep -vE '^#|^\*\*|^[-*] |^<!--' || true)"
if [[ $(echo "$writeup_student" | wc -c | tr -d ' ') -lt 80 ]]; then
  fail "WRITEUP needs your timings and explanation (not just the template headers)"
else
  if echo "$writeup_student" | grep -qiE 'is_incremental|incremental'; then
    l3=$((l3 + 5)); pass "WRITEUP explains incremental behavior"
  else
    fail "WRITEUP should explain is_incremental()"
  fi
  if echo "$writeup_student" | grep -qE '\{\{\s*this\s*\}\}|this filter|max\(pickup_datetime\)'; then
    l3=$((l3 + 5)); pass "WRITEUP references {{ this }} or the boundary filter"
  else
    fail "WRITEUP should reference {{ this }} or the incremental filter"
  fi
fi
score=$((score + l3))
pass "Level 3: dbt incremental + WRITEUP ($l3/30 pts)"

# ── Level 4 (15 pts): Task 3 Job Scheduling + screenshots ───────────────────
l4=0
screenshots_dir="$TASK3/screenshots"
screenshot_count=0
if [[ -d "$screenshots_dir" ]]; then
  screenshot_count=$(find "$screenshots_dir" -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' \) 2>/dev/null | wc -l | tr -d ' ')
fi

if [[ "$screenshot_count" -ge 2 ]]; then
  l4=$((l4 + 8))
  pass "task-3/screenshots/ contains $screenshot_count screenshot(s)"
else
  fail "task-3/screenshots/ should contain screenshots of Job config, green run, and paused schedule"
fi

sched="$(sed -E 's/<!--.*-->//g' "$TASK3/SCHEDULING.md" 2>/dev/null || true)"
sched_student="$(echo "$sched" | grep -vE '^#|^\*\*|^[-*] |^<!--|^[0-9]+\. |`___`|When would you choose|Write two' || true)"
if [[ $(echo "$sched_student" | wc -c | tr -d ' ') -ge 50 ]]; then
  if echo "$sched_student" | grep -qiE 'airflow|jobs|schedule|orchestrat'; then
    l4=$((l4 + 7))
    pass "SCHEDULING.md contains orchestration comparison"
  else
    fail "SCHEDULING.md should explain when to use Databricks Jobs vs Airflow"
  fi
else
  fail "SCHEDULING.md needs your Jobs vs Airflow answer"
fi
score=$((score + l4))
pass "Level 4: Task 3 Job Scheduling ($l4/15 pts)"

# ── Level 5 (15 pts): secrets hygiene ──────────────────────────────────────
l5=15
if [[ -f "$REPO_ROOT/.gitignore" ]] && grep -qE '^\.env$|^profiles\.yml$' "$REPO_ROOT/.gitignore"; then
  pass ".gitignore excludes .env and profiles.yml"
else
  l5=$((l5 - 8)); fail ".gitignore should exclude .env and profiles.yml"
fi
if [[ -f "$TASK2/profiles.yml.example" ]]; then pass "profiles.yml.example present"; else l5=$((l5 - 7)); fail "task-2/profiles.yml.example missing"; fi
score=$((score + l5))
pass "Level 5: secrets hygiene ($l5/15 pts)"

if [[ "$score" -ge "$PASSING" ]]; then pass_flag=true; else pass_flag=false; fi
print_results "Databricks Lab Autograder"
write_score "$score" "$PASSING"
echo "Total: $score/100 — pass=$pass_flag (passing threshold: $PASSING)"
