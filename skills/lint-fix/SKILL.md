---
name: lint-fix
description: Auto-detect project language and run the appropriate linter/formatter to auto-fix issues
---

When the user runs this skill, perform the following steps:

## Step 1: Detect the project language(s)

Scan the current working directory to determine the language(s) in use. Check for:

- **Config files**: `package.json` / `tsconfig.json` (TypeScript), `pyproject.toml` / `setup.py` / `requirements.txt` (Python), `go.mod` (Go), `Gemfile` (Ruby), `pom.xml` / `build.gradle` / `build.gradle.kts` (Java/Kotlin)
- **File extensions**: `.ts`, `.tsx`, `.py`, `.go`, `.rb`, `.java`, `.kt`, `.kts`

Report what language(s) you detected.

## Step 2: Check for existing linter/formatter configuration

Look for existing configs (same detection as the `lint` skill). Use the project's configured tool if one exists, otherwise use the default.

## Step 3: Check if the tool is installed

Verify the linter/formatter is available. If not, tell the user what to install and the exact command — do NOT install without asking.

## Step 4: Run the fixer

Run the appropriate tool in **auto-fix mode**:

| Language | Default tool | Fix command |
|----------|-------------|-------------|
| TypeScript | `eslint` + `prettier` | `npx eslint --fix . && npx prettier --write .` |
| Python | `ruff` | `ruff check --fix . && ruff format .` |
| Go | `gofmt` + `goimports` | `gofmt -w . && goimports -w .` |
| Ruby | `rubocop` | `rubocop -a` |
| Java (Maven) | `spotless` | `mvn spotless:apply` |
| Java (Gradle) | `spotless` | `./gradlew spotlessApply` |
| Kotlin | `ktfmt` / `detekt` | `./gradlew spotlessApply` or `detekt --auto-correct` |

If the project has a custom fix script in `package.json` (`scripts.lint:fix` or `scripts.format`), prefer that.

## Step 5: Show what changed

After running the fix:
1. Run `git diff --stat` to show which files were modified
2. Summarize what was fixed (e.g., "formatted 12 files, fixed 5 import ordering issues")
3. If any issues remain that couldn't be auto-fixed, list them so the user can address them manually

Do NOT commit the changes — leave that to the user.
