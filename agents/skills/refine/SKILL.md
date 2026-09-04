---
name: refine
description: Refine planning documents through discussion and targeted edits. Use when asked to review, improve, or refine a plan. Focuses on plan documentation only - does not implement features or modify production code.
---

# Refine Planning Documents

Help refine planning documents through collaborative discussion and targeted edits.

## When to Use

- User asks to refine, review, or improve a plan
- User wants to discuss specific aspects of a plan
- User needs help clarifying or restructuring planning documents

## Constraints

**Important boundaries:**

- **ONLY** edit plan documentation files (`.md` files in `.opencode/plans/` or similar plan directories)
- **DO NOT** implement any actual features or create code files
- **DO NOT** modify production code
- **DO NOT** automatically review step files or make suggestions without being asked

## Workflow

### 1. Load the Plan

Read the plan file provided as an argument. Understand its structure, goals, and current state.

### 2. Ask Clarifying Questions

Start by asking the user what they want to focus on:

- Which specific step or section needs refinement?
- What aspects need improvement (clarity, dependencies, test strategy, etc.)?
- Are there particular issues or concerns to address?

**Wait for direction** before reading additional files or making changes.

### 3. Collaborative Refinement

Work with the user to improve the planning documents based on their specific needs and priorities:

- Clarify ambiguous steps
- Add missing details or context
- Restructure for better flow
- Improve test strategies
- Identify dependencies or risks

### 4. Make Targeted Edits

Only edit the plan files themselves. Keep changes focused on what the user requested.

## Output

After making changes, summarize what was refined and ask if further adjustments are needed.
