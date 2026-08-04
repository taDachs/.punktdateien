---
name: taskwarrior
description: Operate the user's Taskwarrior CLI correctly and safely. Use this whenever a task involves reading, querying, adding, completing, or modifying tasks in Taskwarrior — including any GTD workflow, capturing a todo, reviewing or reporting on tasks, or any command that runs `task ...`. Critical reference: explains why to address tasks by their stable UUID rather than the unstable numeric id, how to read tasks as structured JSON, checking the active context, and how to modify tasks without triggering destructive bulk operations. Consult this before running any Taskwarrior command.
compatibility: Requires the `task` (Taskwarrior) CLI on PATH. `jq` is optional but convenient for parsing JSON output.
---

# Taskwarrior

Operational reference for the user's Taskwarrior. Read it before running any `task` command.

## Address tasks by UUID, never by id

Every task has an `id` (small integer) and a `uuid` (36-char identifier). The `id` is ephemeral — Taskwarrior reassigns ids when tasks are added, completed, or deleted, so the same id can point to a different task minutes later. The `uuid` is permanent. Whenever you read a task in one step and act on it in another, carry its `uuid` and target that. A `uuid` works anywhere an `id` does:

```bash
task 7e3a9b21-... modify +next -inbox
task 7e3a9b21-... done
```

After adding a task, get its `uuid` from the `+LATEST` virtual tag (which Taskwarrior points at the most recently added task) rather than trusting the printed id: `task +LATEST uuids` or `task +LATEST export`.

## Check the active context first

Taskwarrior contexts apply a hidden filter to reads and writes, so a context can silently narrow what you see and what a new task inherits. Before querying or modifying, check what's active:

```bash
task context show
```

Account for it: a filter like `task +inbox export` only returns inbox tasks *within the current context*. If the context could hide relevant tasks, note it to the user, and use `rc.context=none` on a command to bypass it when you need the full picture.

## Read tasks as JSON

Don't parse the human-readable report tables. Use `export`, which emits a JSON array (fields include `uuid`, `id`, `description`, `status`, `tags`, `project`, `due`, `scheduled`, `wait`, `annotations`):

```bash
task <filter> export
```

Helpers: `task <filter> count`, `task <filter> uuids`, `task _get <id_or_uuid>.<attr>`.

Note: UPPERCASE tags (`+PENDING`, `+WAITING`, `+OVERDUE`, …) are read-only virtual tags Taskwarrior computes; they are distinct from any lowercase user tags. Match case exactly and never `modify` them.

## Modify safely

Operate on one `uuid` at a time and show the user the change first. Single-uuid commands target exactly one task and avoid the bulk-confirmation prompt. Don't disable confirmations (`rc.confirmation=off` / `rc.bulk=0`) for convenience — they exist to catch over-broad changes.

```bash
task <uuid> modify <changes>
task <uuid> annotate "<note>"
task <uuid> done
task <uuid> delete
```

To act on several tasks, loop over their uuids and handle each explicitly.

## Don't assume structure

Detect from `export` output (or ask the user) before relying on `project:`, due/scheduled dates, contexts, UDAs, or dependencies. Don't fabricate conventions the user hasn't established.

## Examples

```bash
# Capture a new item and get its uuid back
task add "Email the contractor about the quote" +inbox
task +LATEST uuids                        # +LATEST = the most recently added task

# Read a filtered set as JSON to reason over
task +next export
task +waiting export
task status:pending project:home export

# Re-tag a captured item into a next action (by uuid)
task 7e3a9b21-... modify -inbox +next

# Record context on a delegated item
task 7e3a9b21-... modify -inbox +waiting
task 7e3a9b21-... annotate "waiting on Sam, asked 2026-06-29"

# Set or change attributes
task 7e3a9b21-... modify due:friday project:home

# Complete or remove
task 7e3a9b21-... done
task 7e3a9b21-... delete

# Quick checks
task +inbox count                        # how many are left
task context show                        # what filter is currently active
task +inbox export rc.context=none       # ignore the active context for this read
```
