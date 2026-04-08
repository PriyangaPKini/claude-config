# Claude Config

Personal Claude Code configuration — rules, skills, and plugins.

## What's included

- `CLAUDE.md` — global instructions (project rules, notifications)
- `settings.json` — permissions and marketplace config
- `rules/` — coding principles, contributing guidelines, notification preferences
- `skills/` — custom skills (lint-check, lint-fix, memory-review)
- `plugins/` — distributable plugins (linter)

## Setup

```bash
git clone git@github.com:PriyangaPKini/claude-config.git ~/claude-config

mkdir -p ~/.claude
ln -sf ~/claude-config/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/claude-config/settings.json ~/.claude/settings.json
ln -sf ~/claude-config/rules ~/.claude/rules
ln -sf ~/claude-config/skills ~/.claude/skills
```

## Using the plugins

Others can install plugins from this repo by adding to their `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "priyanga-plugins": {
      "source": {
        "source": "git",
        "url": "https://github.com/PriyangaPKini/claude-config.git"
      }
    }
  }
}
```

Then run `/plugin` in Claude Code to browse and install.
