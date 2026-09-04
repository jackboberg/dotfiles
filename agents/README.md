# Shared AI Agent Configuration

Harness-agnostic instructions and skills consumed by multiple AI coding assistants.
Skills and instructions follow the [Agent Skills](https://agentskills.io) open standard.

## Structure

```
agents/
├── instructions/          # Global behavioral rules loaded into every session
│   ├── communication-style.md
│   ├── github-preferences.md
│   ├── implementation-workflow.md
│   └── no-co-author.md
└── skills/                # Reusable workflows loaded on demand
    ├── address-pr-feedback/
    ├── commit-message/
    ├── pr/
    └── stig-migrations/
```

## How Each Harness Consumes This

### OpenCode

- **Instructions**: Loaded via `opencode.jsonc` `instructions` glob:
  ```jsonc
  { "instructions": ["~/.agents/instructions/*.md"] }
  ```
- **Skills**: Symlinked from `config/opencode/skills/` → `../../agents/skills/`

### Claude Code

- **Instructions**: Symlinked from `~/.claude/rules/` → `~/.agents/instructions/`
- **Skills**: Symlinked from `~/.claude/skills/` → `~/.agents/skills/`

### Symlink Setup

```bash
# Global symlink (created by rcrc or manually)
ln -s $DOTFILES/agents ~/.agents

# Claude Code
ln -s ~/.agents/instructions ~/.claude/rules
ln -s ~/.agents/skills ~/.claude/skills

# OpenCode (within the dotfiles repo)
ln -s ../../agents/skills config/opencode/skills
```

## Writing Harness-Agnostic Content

### Instructions

- Use plain markdown with no harness-specific syntax
- Keep each instruction focused on a single concern (one file per topic)
- Avoid referencing harness-specific tools or commands unless necessary

### Skills

Skills in `agents/skills/` should work across harnesses when possible. Avoid:

- Harness-specific tool names (e.g., don't assume `AskUserQuestion` vs `question`)
- Harness-specific file paths or config formats
- References to harness-specific features

If a skill must be harness-specific, use the `compatibility` frontmatter field to document which harness it targets:

```yaml
---
name: my-skill
description: ...
compatibility: opencode  # or claude
---
```

Note: Neither OpenCode nor Claude Code currently enforces `compatibility` — both harnesses load all skills from `agents/skills/` via symlink. The field serves as documentation for maintainers, as defined by the [Agent Skills](https://agentskills.io) spec.

## Adding a New Skill

1. Create `agents/skills/<skill-name>/SKILL.md`
2. The skill is automatically available to all harnesses via symlink
3. Test in each harness to verify it loads correctly
