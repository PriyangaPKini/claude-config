---
name: memory-review
description: Review all stored memories, identify items that belong in rules, and clean up stale or redundant entries
---

When the user runs this skill:

## Step 1: Gather all memories

Scan `~/.claude/projects/*/memory/` for all memory files across projects. List each memory with its type, project, and a one-line summary.

## Step 2: Identify redundancies

Check each memory against existing rules in `~/.claude/rules/` and any project-level `.claude/rules/`. Flag memories that duplicate what's already in a rule file.

## Step 3: Identify candidates for promotion

Flag memories that are generic (not project-specific) and would be better as a permanent rule. Present them grouped by which rule file they'd fit in (e.g. `contributing.md`, `coding-principles.md`).

## Step 4: Present a summary

Show the user a table:

| Memory | Project | Action | Reason |
|--------|---------|--------|--------|

Actions: `keep`, `promote to <rule-file>`, `delete (redundant)`, `delete (stale)`

Wait for the user to confirm before making any changes.

## Step 5: Apply approved changes

- For promotions: append the content to the appropriate rule file and delete the memory
- For deletions: remove the memory file and update MEMORY.md
- For keeps: leave as-is
