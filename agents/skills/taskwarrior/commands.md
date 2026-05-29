# TaskWarrior Command Reference

## Common Patterns

### Adding Tasks
```bash
# Basic task
task add "Description"

# With project and priority
task add "Description" project:myproject priority:H

# With due date
task add "Description" due:2026-05-15

# With tags
task add "Description" +tag1 +tag2

# Combined
task add "Write API docs" project:backend due:2026-05-07 priority:M +docs +urgent
```

### Modifying Tasks
```bash
# Using UUID (preferred)
task <uuid> modify due:2026-05-10
task <uuid> modify +review
task <uuid> modify project:frontend

# Set dependency
task <uuid> modify depends:<other-uuid>
```

### Task Queries
```bash
# Overdue tasks
task overdue

# Due today
task due:today

# Due in next 3 days
task due.before:+3d

# High urgency, no due date
task urgency>8 -SCHEDULED -DUE

# Blocked tasks
task +BLOCKED

# Active tasks
task +ACTIVE

# By project
task project:myproject

# By tag
task +mytag
```

### Completing Tasks
```bash
task <uuid> done
```

### Deleting Tasks
```bash
task <uuid> delete
```

## Date Interpretation

| Phrase | Interpretation |
|--------|----------------|
| "today" | 2026-05-29 (current date) |
| "tomorrow" | 2026-05-30 |
| "next Friday" | Next occurrence of Friday |
| "end of month" | 2026-05-31 |
| "in 2 weeks" | 2026-06-12 |
| "ASAP" | priority:H, due:today |
| "someday" | priority:L, no due date |

## Dependency Chain Example

```bash
# Create parent task
task add "Launch new feature" project:release

# Create subtasks with dependencies
task add "Write spec" project:release depends:<parent-uuid>
task add "Implement feature" project:release depends:<spec-uuid>
task add "Write tests" project:release depends:<impl-uuid>
task add "Deploy to staging" project:release depends:<tests-uuid>
task add "Deploy to production" project:release depends:<staging-uuid>
```

## Slipping Task Detection Workflow

```bash
# 1. Check overdue
task overdue

# 2. Check due soon (today + 3 days)
task due:today
task due.before:+3d

# 3. High urgency without scheduling
task urgency>8 -SCHEDULED -DUE

# 4. Check for blocked tasks with overdue blockers
task +BLOCKED

# 5. Stale active tasks (active > 1 day)
task +ACTIVE and modified.before:today
```

## Annotation Examples

```bash
# Add context
task <uuid> annotate "Deliverable for backend team"

# Add acceptance criteria
task <uuid> annotate "Done when: all endpoints documented, reviewed by team, merged to main"

# Add stakeholder info
task <uuid> annotate "Requested by: product team for Q2 release"
```

## Priority Levels

- **H** (High): Urgent, do today
- **M** (Medium): Important, do this week
- **L** (Low): Nice to have, someday
- **Unset**: Normal priority

## Useful Reports

```bash
# Summary by project
task summary

# Calendar view
task calendar

# Gantt chart (if plugin installed)
task gantt

# History
task history
```
