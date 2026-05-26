#!/bin/bash
# Status line: cwd/branch on line 1; cost, context %, model • effort on line 2.
# Reads JSON from stdin (provided by Claude Code).

INPUT=$(cat)

# --- Line 1: cwd + git branch ---
CWD=$(pwd | sed "s|$HOME|~|")
BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
  B=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [ -n "$B" ] && BRANCH=" ($B)"
fi
LINE1="$CWD$BRANCH"

# --- Pull everything from stdin (Claude Code provides it all) ---
MODEL=$(echo "$INPUT" | jq -r '.model.display_name // .model.id // "claude"')
EFFORT=$(echo "$INPUT" | jq -r '.effort.level // "medium"')
COST=$(echo "$INPUT"  | jq -r '.cost.total_cost_usd // 0')
PERCENT=$(echo "$INPUT" | jq -r '.context_window.used_percentage // 0')
LIMIT_RAW=$(echo "$INPUT" | jq -r '.context_window.context_window_size // 200000')

# Format the context limit (1M / 200K)
if [ "$LIMIT_RAW" -ge 1000000 ]; then
  LIMIT_STR=$(awk -v l="$LIMIT_RAW" 'BEGIN { printf "%.1fM", l/1000000 }')
else
  LIMIT_STR=$(awk -v l="$LIMIT_RAW" 'BEGIN { printf "%dK", l/1000 }')
fi

COST_STR=$(awk -v c="$COST" 'BEGIN { printf "$%.3f", c }')

# --- Line 2: cost  context  model • effort (single space-separated) ---
LINE2=$(printf "%s (sub) %s%%/%s (auto)  %s • %s" \
  "$COST_STR" "$PERCENT" "$LIMIT_STR" "$MODEL" "$EFFORT")

echo "$LINE1"
echo "$LINE2"
