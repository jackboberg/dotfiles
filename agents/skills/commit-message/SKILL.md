---
name: commit-message
description: (no description)
disable-model-invocation: true
---

## Context

Write a git commit message for the staged changes.
Do NOT consider unstaged changes.
Be concise and clear.

- Uncommited changes: !`git diff --staged`
- Changes since last merge: !`git diff origin/main...HEAD`
- Current branch: !`git branch --show-current`

## Your task

- Analyze the git diff of staged changes
- Analyze the git diff since last merge for additional context on the staged changes
- Generate the commit message
- Format the message in Markdown
- Output the formatted message in a code fence/code block so it can be easily copied

Follow good Git style:

- Separate the subject from the body with a blank line
- Try to limit the subject line to 50 characters
- Capitalize the subject line
- Do not end the subject line with any punctuation
- Use the imperative mood in the subject line
- Wrap the body at 72 characters
- Keep the body short and concise (omit it entirely if not useful)
