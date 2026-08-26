# Global Personal Instructions

Personal workflow preferences that apply across all projects.

## CRITICAL: Implementation Workflow

When implementing features in this project, follow this workflow:

1. **Complete one task at a time**: Each numbered section in a plan represents
   an independently reviewable unit of work
2. **Include tests with implementation**: Any tests related to a task should be
   implemented as part of that task, not as a separate follow-up task. All tests
   must pass before the task is considered complete
3. **Commit after each task**: Once a task is complete (implementation + tests passing),
   commit with a conventional commit message:
   - `feat(area): <description>` for new features
   - `test(area): <description>` for test additions
   - `refactor(area): <description>` for structural changes
   - Example: `feat(micropub): add endpoint discovery via IndieAuth metadata`

This ensures each change is independently reviewable, fully tested, and commits
remain atomic.

## GitHub Operations

When working with GitHub (issues, PRs, repos, etc), ALWAYS prefer the `gh` CLI over WebFetch or other web-based approaches.

- View issues: `gh issue view <number> --json title,body,comments`
- View PRs: `gh pr view <number> --json title,body,comments`
- Search issues: `gh issue list --search "<query>"`
- Repo info: `gh repo view --json description,url`
- Authenticated API: `gh api <endpoint>` for anything not covered by a specific subcommand

Only fall back to WebFetch when:
- The `gh` CLI doesn't support the operation
- You need to view a non-GitHub URL
- You're fetching public documentation or external resources
