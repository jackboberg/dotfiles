---
description: Review branch changes with Copilot-style analysis
agent: plan
---

# Review Branch Changes

Analyze all changes on the current branch against the default branch.
Produces a structured review in the terminal — no remote API calls.

## Step 1 — Detect the branch diff

Find the merge base with the default branch:

```bash
DEFAULT=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")
git merge-base HEAD "$DEFAULT" 2>/dev/null || git merge-base HEAD main 2>/dev/null || git merge-base HEAD master
```

If `git merge-base` fails (no common ancestor, detached HEAD, etc.), fall back to
uncommitted changes only:

```bash
git diff HEAD
```

Get the diff and commit log from the merge base:

```bash
MERGE_BASE=<sha from above>
git diff "$MERGE_BASE"..HEAD
git log --oneline "$MERGE_BASE"..HEAD
```

If the diff is empty (no changes), tell the user and stop.

## Step 2 — Review

Analyze the diff file by file. Use this review prompt:

---

You are a code reviewer. Analyze the following diff and produce a structured review.

Review from these angles:

- **Correctness** — syntactic/semantic validity, logic errors, edge cases, off-by-one
- **Bugs** — null/undefined handling, error paths, race conditions, resource leaks
- **Security** — injection, secrets exposure, insecure patterns, hardcoded credentials
- **Readability** — naming, unnecessary complexity, dead code, unclear intent
- **Best practices** — conventions, anti-patterns, maintainability, missing error handling

Skip these file types entirely: `package.json`, `package-lock.json`, `yarn.lock`,
`pnpm-lock.yaml`, `Gemfile.lock`, `go.sum`, `go.work.sum`, `Cargo.lock`, `*.svg`,
`*.log`, `bun.lockb`, any generated or vendored files.

For each issue found:

- Identify the file path and line number
- Describe the problem clearly and specifically
- Explain WHY it is a problem (impact, risk, or maintenance cost)
- Suggest a concrete fix when possible
- Use "possible" or "consider" to flag potential false positives

If there are no issues, say so honestly — do not manufacture problems.
Do not comment on style preferences that are purely subjective.
Group findings by severity: bugs and security first, then correctness, then readability,
then general suggestions.

---

## Step 3 — Report

Output the review in this format:

```
## Review: branch "<branch>" vs <default> (<n> files, <n> lines changed)

### Commits
<one-line-per-commit from the log>

### Findings

#### Bugs / Security
<file:line — description + suggestion>

#### Correctness
<file:line — description + suggestion>

#### Readability
<file:line — description + suggestion>

#### Suggestions
<general observations, refactoring opportunities, things to consider>
```

If a severity category has no findings, omit it entirely.
Keep the output concise — do not pad with filler.
