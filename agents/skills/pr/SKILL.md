---
name: pr
description: Use when creating or opening a pull request for the current branch. Pushes the branch, generates a title and body from commits, detects ticket references (Jira, Linear, etc.) for title prefixes, applies repo PR templates, and opens the PR via gh CLI. Use when the user says "open a PR", "create PR", "submit PR", "/pr", or similar.
---

# Open Pull Request

Create a pull request for the current branch.

## When to use

- User says "open a PR", "create PR", "submit PR", "/pr", or similar
- User indicates they're done with changes and want to send them for review

## Step 1: Gather branch context

Run these commands to understand the current state:

1. `git rev-parse --abbrev-ref HEAD` — get the current branch name
2. Determine the default branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||'` — fall back to `main`, then `master` if that fails.
3. `git log --oneline $(git merge-base HEAD <default-branch>)..HEAD` — summarize commits on this branch
4. `git diff $(git merge-base HEAD <default-branch>)..HEAD --stat` — get a file-change overview

If the branch has no commits ahead of the base, stop and inform the user there's nothing to open a PR for.

## Step 2: Check for a PR template

Look for a pull request template in these locations (in order):
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE/` (if directory exists, use the first `.md` file inside)

If found, read its contents and carry it into Step 3 to fill in. If not found, skip silently — Step 3 generates a body from scratch.

## Step 3: Generate PR title and body

- **Title**: Derive a concise, conventional title from the branch name and commit messages. Use sentence case (e.g. "Add user metrics export endpoint").
  - **Ticket reference**: If the branch name contains a ticket-style identifier (e.g. `CAN-1234`, `PROJ-567` — from Jira, Linear, or similar systems), or one was referenced in commit messages or the current session context, prefix the title with the ticket in brackets: `[CAN-1234] Add user metrics export endpoint`
- **Body**: Write a clear summary of what the PR does.
  - If a template was found (Step 2), fill in its sections following the writing principles below.
  - Otherwise use this default structure: a short summary paragraph (2-3 sentences) followed by a bullet list of notable changes.

### Writing principles

The audience is a reviewer with no knowledge of your planning session. Focus on **what changed and why** — not how you arrived there.

Do **not** reference agent/session artifacts:

- **Plan option labels** ("Option A", "Option B"). The reader has no context for these. If a decision matters, state the decision and its rationale plainly — e.g. "Computes regular pay on read rather than backfilling the column, because the calc path never populates it" — never "Approach decision (Option A)".
- **Session phases or task-list numbering** ("Phase 1", "Phases 2 & 3", "Phase 1 of the plan"). These describe your work session, not the change.

Follow-up and out-of-scope work is welcome, but phrase it by what the work *is* — with a tracking ticket if one exists — not by session phase.

#### Example

Bad (leaks planning-session context):

```
## Approach decision (Option A)
Compute on read rather than backfill the column.

## Out of scope
- web/Panda rendering of the column (Phases 2 & 3).
```

Good (focused on what changed and why):

```
## Approach
Computes regular pay on read in the resolver rather than backfilling the
unused DB column, because the calc path never populates it.

## Out of scope
- Frontend rendering of the column — tracked in CAN-1707.
```

## Step 4: Interpret user intent

Determine PR options from the user's natural language:

| User says | Behavior |
|-----------|----------|
| "open a PR", "create PR" (default) | Create as **draft** |
| "ready", "mark ready", "not a draft", "ready for review" | Create as **non-draft** |

## Step 5: Push and create the PR

1. Ensure the branch is pushed to the remote:
   `git push -u origin HEAD`

2. Create the pull request using `gh pr create`:
   - Default (draft): `gh pr create --draft --title "<title>" --body "<body>"`
   - If non-draft (ready): drop `--draft`

   Use a heredoc for the body to preserve formatting.

## Step 6: Report

Output the PR URL from the `gh pr create` output so the user can open it.
