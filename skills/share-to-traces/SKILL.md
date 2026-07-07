---
name: share-to-traces
description: Share the current coding session to Traces and return the share URL.
metadata:
  author: traces
  version: "1.2.0"
  cli-contract-version: "1"
  argument-hint: [optional trace id or source path]
---

# Share To Traces

Publish the active trace to Traces and return the URL.

## Triggers

- "share to traces"
- "publish this trace"
- "share this session"

## How Session Resolution Works

When this skill is triggered from a Claude Code session, the session ID is
automatically injected into the environment via the `traces-session-env.sh`
SessionStart hook. This means `traces share` will deterministically identify
the correct session.

If the hook is NOT installed, the command falls back to most-recent-trace
matching by working directory. To avoid ambiguity, use `--list` first.

## Command

### When the SessionStart hook is installed (recommended):

The hook automatically sets `TRACES_CURRENT_TRACE_ID` — just run:

```bash
traces share --cwd "$PWD" --agent claude-code --json
```

### When the hook is NOT installed (fallback with discovery):

```bash
# Step 1: List available traces
traces share --list --cwd "$PWD" --agent claude-code --json

# Step 2: Share a specific trace by ID
traces share --trace-id <selected-id> --json
```

### With explicit session hint (alternative):

```bash
TRACES_CURRENT_TRACE_ID="<session-id>" traces share --cwd "$PWD" --agent claude-code --json
```

## Visibility

Do NOT pass `--visibility` unless the user explicitly requests it. The CLI
defaults to the correct visibility based on the user's namespace type.

## Output Behavior

- Parse the JSON output and reply with the `sharedUrl`.
- Include which selector resolved the trace (`selectedBy`).
- On failure, use terse remediation:
  - `AUTH_REQUIRED`: run `traces login`, then retry.
  - `TRACE_NOT_FOUND`: use `traces share --list` to discover traces, then retry with `--trace-id`.
  - `INVALID_ARGUMENTS`: fix selector usage and retry.
  - `UPLOAD_FAILED`: check network/config, then retry.
