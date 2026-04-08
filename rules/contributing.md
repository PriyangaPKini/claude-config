# Contributing Guide

These conventions apply across all projects.

---

## Branch Strategy

### Naming Convention

Branches follow the format:

```
<type>/<short-description>
```

| Type       | When to use                            | Example                          |
| :--------- | :------------------------------------- | :------------------------------- |
| `feat`     | New functionality                      | `feat/sandbox-timeout`           |
| `refactor` | Restructuring without behaviour change | `refactor/extract-tool-registry` |
| `fix`      | Bug fix                                | `fix/clone-lock-race`            |
| `chore`    | Tooling, deps, CI                      | `chore/upgrade-pi-ai`            |

---

## Pull Requests

### What Makes a Good PR

A good PR is **small, focused, and reviewable**. It should do one thing well.

| Guideline     | Target                              |
| :------------ | :---------------------------------- |
| Lines changed | **< 400 lines** (ideally under 200) |
| Files changed | **< 15 files**                      |
| Scope         | Single logical change               |
| Review time   | **< 30 minutes** to understand      |

### When to Break a PR Down

Split a PR when:

- It introduces a new concept AND uses it — introduce first, wire second.
- The diff is large enough that a reviewer has to scroll extensively.
- It mixes refactoring with new functionality.

### PR Creation

When asked to create a PR, use `gh pr create` with this template:

```
Title: <Short imperative description of the change>

Body:
Ref: #<issue-number>

## Because
- <why the change is being made>

## This addresses
- <bullet per meaningful change — what was added/updated/removed>

## Test Plan
- [x] Tests pass
- [x] Linter/formatter clean
```

- Never merge branches or push to remote without explicit user request.
- Never commit root-level `.md` files (e.g., `CLAUDE.md`) or unrelated files unless explicitly asked. Always review staged files before committing.

---

## Commits

### Commit Message Format

```
<Operation>. <lowercase message>
```

| Operation  | When to use                            | Example                                     |
| :--------- | :------------------------------------- | :------------------------------------------ |
| `Add`      | Introducing something entirely new     | `Add. sandbox timeout configuration`        |
| `Update`   | Enhancing existing functionality       | `Update. compaction to preserve tool calls`  |
| `Fix`      | Correcting a bug                       | `Fix. clone lock race condition`            |
| `Refactor` | Restructuring without behaviour change | `Refactor. extract tool registry`           |
| `Remove`   | Deleting code or files                 | `Remove. unused config defaults`            |

### What Makes a Good Commit

- **Atomic** — one logical change per commit. If you can describe it with "and", it should be two commits.
- **Buildable** — the project should compile and tests should pass at every commit.
- **Descriptive** — the message explains _what_ changed at a glance, without needing to read the diff.

### Commit Hygiene

- Don't mix refactoring with feature work in the same commit.
- Don't commit commented-out code.
- Don't commit debug logs or temporary test overrides.
- Don't add `Co-Authored-By` trailers or any agent/AI attribution to commit messages.
- Stage files intentionally — review `git diff --staged` before committing.
