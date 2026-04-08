---
name: lint-check
description: Auto-detect project language and run the appropriate linter to report issues
---

When the user runs this skill, perform the following steps:

## Step 1: Detect the project language(s)

Scan the current working directory to determine the language(s) in use. Check for:

- **Config files**: `package.json` / `tsconfig.json` (TypeScript), `pyproject.toml` / `setup.py` / `requirements.txt` (Python), `go.mod` (Go), `Gemfile` (Ruby), `pom.xml` / `build.gradle` / `build.gradle.kts` (Java/Kotlin)
- **File extensions**: `.ts`, `.tsx`, `.py`, `.go`, `.rb`, `.java`, `.kt`, `.kts`

Report what language(s) you detected.

## Step 2: Check for existing linter configuration

Look for existing linter/formatter configs in the project:

| Language | Config files to check |
|----------|----------------------|
| TypeScript | `.eslintrc*`, `eslint.config.*`, `.prettierrc*`, `biome.json` |
| Python | `ruff.toml`, `.ruff.toml`, `pyproject.toml` (ruff/black/flake8 sections), `.flake8`, `setup.cfg` |
| Go | `.golangci.yml`, `.golangci.yaml` |
| Ruby | `.rubocop.yml` |
| Java | `checkstyle.xml`, `.editorconfig`, `pmd.xml` |
| Kotlin | `.editorconfig`, `detekt.yml`, `.detekt.yml` |

If a config exists, use that linter. If not, use the default for the language.

## Step 3: Check if the linter is installed

Run the linter's version command to verify it's available. If it's not installed, tell the user what to install and the exact install command — do NOT install it yourself without asking.

## Step 4: Run the linter

Run the appropriate linter in **check/report mode only** (no auto-fix):

| Language | Default linter | Check command |
|----------|---------------|---------------|
| TypeScript | `eslint` | `npx eslint .` |
| Python | `ruff` | `ruff check .` |
| Go | `golangci-lint` | `golangci-lint run` |
| Ruby | `rubocop` | `rubocop --format simple` |
| Java (Maven) | `checkstyle` | `mvn checkstyle:check` |
| Java (Gradle) | `checkstyle` | `./gradlew checkstyleMain` |
| Kotlin | `detekt` | `detekt --input .` or `./gradlew detekt` |

If the project has a custom lint script in `package.json` (`scripts.lint`), prefer that over the default.

## Step 5: Report results

Summarize the linter output:
- Total number of issues found
- Breakdown by severity (errors vs warnings)
- Top 3-5 most common issue types
- Whether issues are auto-fixable

If there are zero issues, congratulate the user on clean code.
