---
name: stig-migrations
description: >
  Use when creating, applying, reverting, or troubleshooting SQLite migrations
  with the stig CLI. Triggered by requests involving stig init, stig new,
  stig migrate, stig status, stig redo, stig reset, stig restore, migration
  drift, checksum errors, or snapshot recovery.
---

# Skill: stig Migrations

stig is a forward-only SQLite migration CLI. Migrations are timestamped SQL
files in `db/migrations/`, tracked in `schema_migrations` with checksums.

Use for `stig init`, `stig new`, `stig migrate`, `stig status`, or drift
recovery (`stig redo`, `stig reset`, `stig restore`).

Do **not** use for `stig generate`, `stig backups`, schema-only design, or
other migration tools.

## Core Migration Workflow

1. `stig init` — create `stig.toml`, migrations dir, and backup dirs.
2. `stig new <description>` — scaffold a timestamped migration file. Use this
   instead of creating files by hand.
3. Edit the generated SQL file.
4. `stig migrate` — apply pending migrations.
5. `stig status` — verify state.

## Command Quick Reference

| Command | Purpose | Common flags |
|---|---|---|
| `stig init` | Bootstrap a new stig project | `--database-path`, `--migrations-dir` |
| `stig new <desc>` | Create a timestamped migration file | `--no-edit` |
| `stig migrate` | Apply pending migrations | `--dry-run` |
| `stig status` | Show applied/pending/drifted state | |
| `stig redo [version]` | Restore pre-version snapshot and re-apply forward | `--yes` |
| `stig reset` | Destructive: back up live DB and re-migrate from empty | `--yes` |
| `stig restore [timestamp]` | Restore a reset backup | `--yes` |

## Drift & Recovery

A checksum mismatch means the migration file was edited after it was applied.

| Situation | Action |
|---|---|
| Snapshot exists | `stig redo <version>` restores the snapshot and re-applies forward. |
| Snapshot pruned | Revert the edit, or use `stig reset` to start fresh (live DB is backed up). |
| Intentional drift in production | Set `checksum_check = false` or use `STIG_NO_CHECKSUM=1`. |

## Red Flags — STOP

Redirect to the stig workflow when you see:

- "Just create the migration file manually" or "skip `stig new`"
- "Apply the migrations without checking status first"
- "Edit the already-applied migration file directly"
- "Run `stig apply`" (not a real command)

## Common Mistakes

- **Hand-crafting migration files.** Use `stig new <description>` for correct
  timestamps and slugs.
- **Editing an applied migration without recovery.** This causes checksum drift;
  use `stig redo` or `stig reset`.
- **Using `stig apply`.** The command is `stig migrate`.
- **Forgetting `--yes` in scripts.** `stig redo`, `stig reset`, `stig restore`,
  and `stig backups prune` prompt unless `--yes` is passed.
- **Using `:memory:` for dev workflows.** Snapshots and resets are disabled.

## Worked Example

Create and apply a migration for a `users` table:

```bash
stig new create_users
# edit db/migrations/<timestamp>_create_users.sql
stig status
stig migrate
```

Recover from a bad already-applied migration:

```bash
stig status
stig redo <version> --yes   # if snapshot exists
# OR
stig reset --yes            # if snapshot is gone
```
