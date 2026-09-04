---
name: new-branch
description: Use when creating a new git branch and worktree for a task. Detects issue tracker references to form branch names following naming conventions, creates worktrees with the wt CLI, and sets the agent's working context to the new directory. Use proactively when the user describes a new task, mentions a ticket, or says "new branch" or "start work".
---

# Start Work

Create a new branch and worktree when beginning a new piece of work.

## When to use

- User explicitly says "start work", "new branch", "new worktree", or similar
- User describes a new task and you detect no existing branch context for it
- An issue tracker ticket is referenced and there's no branch for it yet

## Branch naming convention

### With a ticket

Format: `{ticket-lowercase}__{subject-kebab-case}`

Examples:
- CAN-1234 "Make table sortable" → `can-1234__make-table-sortable`
- PAT-193 "White label legal screens" → `pat-193__white-label-legal-screens`

Rules:
- Ticket prefix is lowercased
- Subject is lowercased, spaces become hyphens
- Remove articles (a, an, the) and filler words if the name gets long
- Max ~50 chars for the subject portion
- Never include a username or owner in the branch name
- Never use `/` anywhere in the branch name

### Without a ticket

Format: `{subject-kebab-case}`

Derive a concise branch name from the task description and **ask the user to confirm** before creating it. If there's no ticket, also offer to create one on their behalf.

## Workflow

1. **Identify the branch name**
   - If a ticket is in context, derive the name automatically
   - If no ticket, propose a branch name and ask the user to confirm
   - If no ticket exists, offer to create one

2. **Determine the base branch**
   - Default: the repo's default branch (let `wt` handle this — do not pass `--base`)
   - If the user specifies a base (e.g., "branch from release"), pass `--base <branch>`

3. **Create the worktree**
   ```bash
   wt switch --create <branch-name> --format json --no-cd
   ```
   Use `--no-cd` because the shell session won't change directory. Use `--format json` to parse the worktree path from the output.

4. **Set working context**
   Parse the worktree path from the JSON output. For all subsequent operations in this session:
   - Set the working directory to the worktree path for all commands
   - Use absolute paths for all file operations
   
   Tell the user the worktree path so they know where work is happening.

5. **Confirm to the user**
   Report: the branch name, base branch, and worktree path.

## Important notes

- The `wt` CLI must be run from within a git repository. Use the repo path if the current directory isn't one.
- Never use `--no-hooks` unless the user explicitly requests it.
- If `wt switch` fails (e.g., branch already exists), report the error and ask the user how to proceed.
- After creating the worktree, all subsequent file operations and commands should target the new worktree path, not the original directory.
