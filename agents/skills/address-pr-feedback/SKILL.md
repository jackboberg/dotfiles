---
name: address-pr-feedback
description: >
  Workflow for addressing open PR review feedback. Use when asked to
  "address PR feedback", "resolve review comments", "respond to PR
  comments", or "fix PR suggestions". Fetches unresolved review threads
  from the current branch's PR, plans and implements changes, runs tests,
  commits, pushes, then resolves addressed threads or replies to
  deferred/declined ones. Do not use for creating PRs or reviewing code
  yourself.
---

# Skill: Address PR Feedback

Complete workflow for reading open review threads on the current branch's
PR, implementing requested changes, and updating thread state afterward.

---

## Prerequisites

- `gh` CLI installed and authenticated (`gh auth status`)
- On the feature branch that has an open PR
- Working tree is clean before starting (or changes are understood)

---

## Step 1 — Discover the PR

```bash
gh pr view --json number,url,baseRefName,headRefName
gh repo view --json nameWithOwner
```

Extract `owner`, `repo`, and PR `number` from the output. If no open PR
exists for the current branch, stop and tell the user.

---

## Step 2 — Fetch unresolved review threads

### REST — comment bodies, paths, line numbers, database IDs

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments --paginate
```

Each object has: `id` (database ID), `path`, `line`, `body`,
`in_reply_to_id` (null for top-level).

### GraphQL — thread node IDs and resolution state

```bash
gh api graphql -f query='
{
  repository(owner: "{owner}", name: "{repo}") {
    pullRequest(number: {number}) {
      reviewThreads(first: 50) {
        nodes {
          id
          isResolved
          comments(first: 1) {
            nodes {
              databaseId
              body
            }
          }
        }
      }
    }
  }
}'
```

Correlate GraphQL nodes to REST comments via
`node.comments.nodes[0].databaseId == comment.id`.

**Filter to `isResolved: false` only.** Ignore already-resolved threads.

---

## Step 3 — Plan

Present a numbered list of unresolved threads, grouped by file. For each
thread, propose one of three dispositions:

| Disposition | Meaning |
|---|---|
| **Address** | Implement the change in this commit |
| **Decline** | Not applicable or intentionally out of scope; reply with reason, leave **unresolved** |
| **Defer** | Will be handled in a future task or issue; reply with a reference to that task/issue, leave **unresolved** |

Use `TodoWrite` to record the plan. **Pause and show the plan to the user.
Wait for approval before making any file changes.**

---

## Step 4 — Implement

Work through threads one file at a time. Mark each todo `in_progress` as
you start it, `completed` when done.

- Edit only the files relevant to the feedback.
- Add or update tests to cover the changes made, where possible. Tests
  related to addressed feedback should be included in the same commit,
  not deferred.
- Do not commit yet.
- If a change requires regenerating derived files (e.g. types, snapshots),
  do that now and include those files in the upcoming commit.

---

## Step 5 — Test

Detect and run the project's test command:

1. `bin/test` if it exists and is executable
2. Otherwise `deno test`, `npm test`, `cargo test`, etc. — check
   `package.json`, `deno.json`, `Cargo.toml` for hints.

**If tests fail, fix them before proceeding. Never push broken code.**

---

## Step 6 — Commit and push

Stage only the files changed to address feedback (do not sweep in
unrelated changes).

### Compose the commit message

The subject must describe **what changed in the code**, not the review
process. Before committing, verify the proposed subject against the
banned-phrase list below.

**Banned subject phrases** (never use these — they tell the reader nothing
about the actual change):

- "address PR review feedback" / "address review comments"
- "address copilot review comments" / "address copilot feedback"
- "fix review comments" / "fix reviewer feedback"
- "respond to feedback" / "respond to review"
- "apply suggestions" / "apply review suggestions"
- "incorporate feedback" / "incorporate review comments"
- "update based on review" / "changes from review"
- Any subject where the only information is that feedback was addressed

**Good vs bad examples:**

| Bad (describes process) | Good (describes change) |
|---|---|
| `fix(config): address copilot review comments` | `docs(config): fix MapEnv doc grammar and qualify intra-doc links` |
| `fix: fix review comments` | `refactor(auth): replace env var lookup with injectable trait` |
| `chore: respond to feedback` | `fix(cli): validate port range before binding listener` |

**Rules:**
- If the project has an `AGENTS.md` with a commit message convention,
  follow it.
- Use `fix(<area>):` as the type/scope by default, but choose the type
  that matches the actual change (`docs:`, `refactor:`, `test:`, etc.).
- Body lines should be concrete: what changed and why, not just "addressed
  comment".
- **Always create a new commit.** Never amend, never `--force`, never
  `--no-verify`.

### Self-validation gate

Before running `git commit`, state the proposed commit message and confirm:
1. The subject describes the **actual code change**, not the review process.
2. The subject passes the banned-phrase check above.
3. The type/scope matches the project's commit convention (if any).

```bash
git add <changed files>
git commit -m "fix(<area>): <describe the actual change, not the review process>

- <one line per addressed thread, referencing the file/function changed>"
git push
```

---

## Step 7 — Resolve or reply

Process each thread according to its disposition:

### Resolve (addressed threads only)

```bash
gh api graphql -f query='
mutation {
  resolveReviewThread(input: { threadId: "{PRRT_node_id}" }) {
    thread { id isResolved }
  }
}'
```

Only resolve a thread when code changes were made to address it. Do **not**
resolve threads that were only replied to — leave those for the commenter or
the PR author to resolve manually once they agree the concern is settled.

### Reply (declined or deferred)

```bash
gh api repos/{owner}/{repo}/pulls/comments/{id}/replies \
  -f body="Your reply text here."
```

Use `{id}` of the **top-level comment** in the thread (the one with
`in_reply_to_id: null`).

### Decision table

| Outcome | Reply first? | Resolve? |
|---|---|---|
| Addressed in commit | No | **Yes** |
| Declined — not applicable or by design | Yes — explain the reasoning | **No — leave for commenter to resolve** |
| Deferred — future task or issue | Yes — reference the task/issue number | **No** |

---

## Step 8 — Verify PR description

Fetch the current PR title and body:

```bash
gh pr view --json title,body
```

Review both against the changes made in this session. Update if anything is
stale, missing, or no longer accurate:

```bash
gh pr edit --title "new title"        # only if title needs updating
gh pr edit --body "updated body text" # only if body needs updating
```

- Check that the title still reflects the scope of the PR.
- Check that the body accurately describes what the PR does, why, and any
  relevant context. Add notes about significant changes made during this
  review cycle if the body would otherwise be misleading.
- If the description is still accurate, no update is needed.

---

## Step 9 — Request re-review

After resolving and replying, request a fresh review from every person (or
bot) whose threads were **addressed** in this session.

Collect the unique set of `user.login` values from the REST comments that
belonged to addressed threads, then for each login:

```bash
gh pr edit {number} --add-reviewer {login}
```

- Works for human reviewers and Copilot alike (use login
  `copilot-pull-request-reviewer` for Copilot).
- Skip reviewers whose threads were only declined or deferred — they did not
  receive a code change to re-review.
- If a re-review request fails (e.g. the user no longer has repo access),
  note it in the summary but do not abort.

---

## Worked example (abbreviated)

```
# 1. Find PR
$ gh pr view --json number,url
{ "number": 134, "url": "https://github.com/owner/repo/pulls/134" }

# 2. Get unresolved threads (via GraphQL, filtered)
→ 3 unresolved threads

# 3. Plan
1. tasks/migrate.ts — wrap migration in transaction          → Address
2. lib/database/client.ts — load Honker extension            → Address
3. lib/database/types.ts — backward-compat shim divergence  → Defer (Task 2)

[pause for approval]

# 4. Implement changes for threads 1 and 2

# 5. Run tests
$ bin/test → 124 passed, 0 failed

# 6. Commit
$ git add tasks/migrate.ts lib/database/client.ts
$ git commit -m "fix(infra): wrap migration in transaction and load Honker extension"
...
$ git push

# 7. Resolve threads 1 and 2 (changes made); reply to thread 3, leave unresolved
$ gh api graphql ... resolveReviewThread PRRT_abc  # thread 1 — addressed
$ gh api graphql ... resolveReviewThread PRRT_def  # thread 2 — addressed
$ gh api repos/.../pulls/comments/123/replies \
    -f body="Deferred to Task 2 (#128) where DAOs are rewritten."
# thread 3 left unresolved — commenter resolves once they agree

# 8. Verify PR description is still accurate
$ gh pr view --json title,body
→ body is accurate, no update needed

# 9. Request re-review from commenters whose threads were addressed
$ gh pr edit 134 --add-reviewer octocat  # authored threads 1 and 2
# thread 3 commenter (hubot) not re-requested — their thread was only deferred
```
