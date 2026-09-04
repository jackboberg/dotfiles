---
name: triaging-review-findings
description: Use to run the Address/Decline/Defer decision loop over a set of normalized code-review findings — regardless of where they came from (GitHub PR threads, issue comments, automated reviews). Plans a fix per finding, prompts Address/Decline/Defer via the question tool (mandatory, never decided by the agent), implements Addressed findings with one commit each plus tests, and offers follow-up tickets for Deferred ones. Loaded by address-pr-feedback — the caller supplies the findings and handles whatever happens after (replying/resolving, pushing, or a terminal summary).
---

# Triaging Review Findings

Run the shared decision loop over a set of review findings: plan a fix for each,
get an Address/Decline/Defer decision from the user, implement and commit the
Addressed ones, and offer follow-up tickets for the Deferred ones.

This skill is **source-agnostic**. It does not fetch findings and does not know
whether they came from a PR, a local review, or a bot. The **caller** gathers the
findings, hands them to this loop, and consumes the decisions it returns.

## When to use

- Loaded by `address-pr-feedback` after it fetches and classifies unresolved PR
  review threads and issue comments.
- Any time you have a normalized list of review findings and need the user to
  decide Address/Decline/Defer on each before you act.

## Input contract

The caller provides a list of **items**. Each item has:

- `location` — the code location, e.g. `path:line` (or `path` when there is no
  line, or the PR itself for a top-level comment).
- `source` — where the finding came from: a bot name, a reviewer login, or a
  local check (e.g. `github-actions[bot]`, `cursor`, `apaslak`).
- `severity` — Blocking / Major / Minor / Info, or `unknown`.
- `finding` — the issue description text (verbatim comment body is fine).
- `suggested_fix` — optional concrete suggestion.
- `extra_context` — optional: check name/link, thread IDs, comment IDs, whether
  the item is resolvable, or anything the caller needs to reconcile decisions
  later. This loop passes it through untouched.

If the item list is empty, there is nothing to triage — return immediately and
let the caller report that.

## Step A: Plan each item

For every item:

- Read the referenced `location` and surrounding code to ground the plan.
- Decide the fix: follow `suggested_fix` when it's sound, or propose a justified
  alternative when the suggestion is wrong or suboptimal (note the reasoning).
- Identify which tests to add or update to cover the change.

## Step B: Batched Address/Decline/Defer prompt

**You MUST prompt the user for decisions using the appropriate question tool. You
MUST NOT decide Address/Decline/Defer yourself — always, no exceptions, regardless
of how many items there are or how obvious a fix appears.** This is a hard gate:
**Step C must not begin** until the user has returned a decision for **every**
item.

Present all items and collect one decision per item:

- `header` — a short location tag (e.g. `resolver.rb:116`).
- `question` — pack in `location`, `source`, `severity` (if known), the
  `finding`, and the proposed plan from Step A.
- `options` — always exactly these three, in this order:
  - **Address** — "Implement this fix now."
  - **Decline** — "Won't change; I'll record why."
  - **Defer** — "Track as a follow-up, optionally file a ticket."

### Red flags — these thoughts mean STOP, you're rationalizing

| Thought | Reality |
|---|---|
| "This fix is obviously correct" | Obviousness isn't a decision. Still prompt. |
| "It's a trivial one-line change" | Triviality doesn't grant authority. Still prompt. |
| "The bot is clearly right" | The user decides whether to act on it. Still prompt. |
| "There's only one item" | Count is irrelevant. Always prompt. |
| "I'll just Address it and ask later" | The prompt comes BEFORE Step C, never after. |
| "The user clearly wants this fixed" | Only an explicit decision via the prompt counts. |

## Step C: Implement, test, and commit (Address only)

Process **one Addressed item at a time**, running this loop per item: implement →
test → commit. This keeps history clean and lets each Addressed item be
referenced by a distinct commit SHA.

### C1. Implement

- Edit only the files relevant to this item's finding.
- Add or update tests covering the change — in the **same** commit, never
  deferred.
- If the change requires regenerating derived files (types, snapshots, schema),
  do it now and include those files in this commit.

### C2. Test

Detect and run the project's test command, scoped to the **affected/related
tests** for this item (not the whole suite):

1. `bin/test <affected paths>` if `bin/test` exists and is executable.
2. Otherwise infer from the repo: for Ruby repos, `bundle exec rails test
   <paths>` (minitest) or `bundle exec rspec <paths>` (rspec). For other
   stacks, check `package.json`, `deno.json`, `Cargo.toml`, or `AGENTS.md` for
   the right command (`npm test`, `deno test`, `cargo test`, etc).

**Never commit broken code.** If the affected tests fail, fix them before
committing this item.

### C3. Commit

Create **one commit per item**. Stage only the files changed for this item — do
not sweep in unrelated changes.

**The subject must describe what changed in the code, not the review process.**

Banned subject phrases (never use — they tell the reader nothing about the actual
change):

- "address PR review feedback" / "address review comments"
- "address fresh eyes feedback" / "address bot feedback"
- "fix review comments" / "fix reviewer feedback"
- "respond to feedback" / "respond to review"
- "apply suggestions" / "apply review suggestions"
- "incorporate feedback" / "update based on review"
- any subject whose only information is that feedback was addressed

Bad vs good examples:

| Bad (describes process) | Good (describes change) |
|---|---|
| `fix: address review feedback` | `Exclude returned requests from benign cancellation check` |
| `fix: fix review comments` | `Replace broad ArgumentError rescue with NoLegalEntityBreakdownsError` |
| `chore: respond to feedback` | `Add spec for request with no attempts` |

Rules:

- If the repo has an `AGENTS.md` (or similar) with a commit-message convention,
  follow it (e.g. `fix(<area>):` prefixes). Otherwise a plain descriptive subject
  is fine.
- Body lines should be concrete: what changed and why. Optionally reference the
  finding or check name.
- **Always create a new commit.** Never amend, never `--force`, never
  `--no-verify`.

**Self-validation gate** — before running `git commit`, state the proposed
subject and confirm:

1. It describes the actual code change, not the review process.
2. It passes the banned-phrase check above.
3. The type/scope matches the repo's convention (if any).

```bash
git add <files changed for this item>
git commit -m "<describe the actual change>

- <concrete detail of what changed and why>"
```

Record the resulting commit SHA for this item (`git rev-parse HEAD`).

## Step D: Offer follow-up tickets (Defer only)

For **Deferred** items, offer to create follow-up tickets in your project's issue
tracker (summarize the deferred finding and link the source PR/thread when the
caller provided one). Capture the new ticket key and URL per deferred item. If
the user declines, record a plain "tracked as follow-up" note with no link.

## Output contract

Return to the caller, per item:

- `decision` — Addressed / Declined / Deferred.
- `commit_sha` — for Addressed items.
- `ticket` — identifier + URL for Deferred items that got a ticket (else
  the plain note).
- the item's original `extra_context`, unchanged, so the caller can reconcile
  (e.g. reply to and resolve the matching thread).

This loop does **not** push, reply, resolve, or write a summary — those belong to
the caller.

## Guardrails

- Never decide Address/Decline/Defer on the user's behalf — the Step B
  prompt is mandatory and blocks Step C, with no exceptions.
- One commit per Addressed item; no squashing; never use "addressing
  feedback"-style subjects (see the banned-phrase list in Step C3).
- Per-item tests gate each commit — **never commit broken code**.
- Always a new commit — never amend, `--force`, or `--no-verify`.
- Do not push, reply, resolve, or summarize — return decisions to the caller.
- If the item list is empty, return immediately.
