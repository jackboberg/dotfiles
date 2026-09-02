---
name: pr-message
description: (no description)
disable-model-invocation: true
---

# Context
Write a pull request message for the current changes.
Do NOT consider any uncommitted changes.
Be concise and clear.

- Changes since last merge: !`git diff origin/latest...HEAD`
- Current branch: !`git branch --show-current`

## Your task
- Analyze the git diff
- Format the message in Markdown
- Output the formatted message in a code fence/code block so it can be easily copied

Only return the commit message in your response. Do not include any additional meta-commentary about the task. Do not include the raw diff output in the commit message.
