---
name: gtd-weekly-review
description: Guide the user step by step through their GTD weekly review in Taskwarrior, including project and tag memory, pausing for a decision at each step. Use whenever the user wants to run their weekly review, process their inbox, or review next actions, waiting-for, projects, or tags — even if they just say "let's do my review" or "process my inbox".
compatibility: Requires the `task` (Taskwarrior) CLI. Relies on the conventions in the `taskwarrior` skill.
---

# GTD Weekly Review

Guide the user through a Getting Things Done weekly review, conducted entirely in Taskwarrior. The defining quality of this skill is that it is **interactive and paced**: present one decision at a time, then **stop and wait for the user's response before doing anything**. Never batch-process or auto-decide. The user is the one making GTD decisions; you surface the items, propose options, and execute the choice they make.

## The user's structure

GTD lives entirely in Taskwarrior. The following is established and can be relied on:

- **`+inbox`** — captured, not yet processed.
- **`+next`** — a concrete next action, ready to do.
- **`+waiting`** — delegated / waiting on someone or something else.
- **`project:`** — GTD projects only: multi-step outcomes with a clear done state. Do not use `project:` for work/customer/industry buckets.
- **Work/customer/industry tags** — use tags for external or organizational buckets, e.g. `+intellirisk`, `+stack`, `+tfur`, `+husky`, `+phd`, `+julius_ba`.

When a phase depends on one of the unestablished items, first detect it from `export` output; if it's ambiguous, ask the user how they track it rather than inventing a tag or attribute.

## Project memory

Taskwarrior has no native place to store what a project is *about* — a project is just a string attribute on tasks. In this setup, that string must represent a GTD project outcome, not an external work bucket. This skill keeps outcome knowledge in a memory file so each review can show, and build on, a short description of every project's intended outcome.

**Location — keep it outside the skill directory, as mutable user data:**

```
~/.agents/memory/gtd-weekly-review/projects.md
```

On first run, create the `~/.agents/memory/gtd-weekly-review/` directory and seed the file from this skill's `assets/projects.template.md` if it doesn't exist yet.

**Format:** one section per GTD project, where the heading is the exact `project:` value:

```markdown
# GTD Project Memory

## website-redesign
Ship the refreshed marketing site. Done when the new design is live and the old pages redirect.

## taxes-2025
File the 2025 personal return. Done when submitted and confirmation received.
```

**Reading:** to find a project's description, match a `## <project name>` heading exactly.

**Updating:** to add a project, append a new section. To revise one, replace the body under its heading. Keep descriptions to one or two sentences focused on the intended outcome / what "done" looks like. Preserve existing entries — never rewrite the whole file from scratch or drop sections you didn't intend to change. If a task only needs a work/customer/industry bucket, add or adjust tags instead of adding a project memory entry.

If a project appears in the memory but no longer appears in `task projects`, leave it but mention it to the user at wrap-up in case it's finished or renamed. Never delete a memory entry without the user's say-so.

## Tag memory

Tags carry contexts, workflow states, people, robots, work/customer/industry buckets, and other cross-cutting labels. This skill keeps tag meanings in a separate memory file so reviews can distinguish GTD workflow tags from domain tags and avoid misusing `project:` for external buckets.

**Location — keep it outside the skill directory, as mutable user data:**

```
~/.agents/memory/gtd-weekly-review/tags.md
```

On first run, create the `~/.agents/memory/gtd-weekly-review/` directory and seed the file from this skill's `assets/tags.template.md` if it doesn't exist yet.

**Format:** one section per tag, where the heading is the exact lowercase tag name without the leading `+`:

```markdown
# GTD Tag Memory

## next
GTD workflow tag for a concrete next action that is ready to do.

## intellirisk
Work/customer bucket for Intellirisk-related tasks. Use as `+intellirisk`; do not use `project:intellirisk`.
```

**Reading:** to find a tag's meaning, match a `## <tag name>` heading exactly. Taskwarrior stores tags without the leading `+`; memory headings should also omit it.

**Updating:** to add a tag, append a new section. To revise one, replace the body under its heading. Keep descriptions to one or two sentences explaining what the tag means and when to use it. Preserve existing entries — never rewrite the whole file from scratch or drop sections you didn't intend to change.

If a tag appears in Taskwarrior but has no memory entry, ask the user for its meaning before relying on it for decisions. If a tag appears in memory but no longer appears in pending tasks, leave it but mention it at wrap-up in case it is obsolete or only used on completed tasks. Never delete a memory entry without the user's say-so.

## Before you start

1. **Consult the `taskwarrior` skill.** All command patterns, the read-as-JSON approach, and especially the rule of addressing tasks by `uuid` (never the unstable `id`) live there. Follow them. In particular, remember the user's lowercase `+waiting` is **not** Taskwarrior's virtual `+WAITING`.
2. **Check Taskwarrior is reachable**: `task --version`. If it errors, tell the user and stop.
3. **Load the project and tag memory files** (create and seed them on first run — see the Project memory and Tag memory sections for their locations).
4. **Orient the user.** Briefly say what the review will cover (the phases below) and ask if they're ready to begin. Then go phase by phase.

## How to pace every step

For each item or phase:

1. Read the relevant tasks with `task <filter> export` and parse the JSON.
2. Present what you found in a compact, readable form — include each task's `description` and enough context (age, project, tags, notes) to decide. Use tag memory to explain non-obvious tags when helpful. Keep the task's `uuid` associated internally so any action targets the right task.
3. Propose the GTD-appropriate options.
4. **Stop. Wait for the user's decision.**
5. Execute exactly what they chose, one `uuid` at a time, then move on.

Do not advance to the next item or phase on your own. If the user wants to skip a phase, let them.

---

## Phase 1 — Get Clear

### 1a. Empty the inbox to zero

This is the heart of the review. Pull the inbox:

```bash
task +inbox export
```

Then take the items **one at a time**. For each, present it and walk the user through the standard GTD clarifying decision:

- **Is it actionable?**
  - **No** → offer: delete it (`task <uuid> delete`); move it to someday/maybe (ask the user how they track that if you don't already know — don't assume a tag); or keep it as reference (ask how they want reference material handled).
  - **Yes, and it takes under ~2 minutes** → suggest doing it now, then `task <uuid> done`.
  - **Yes, single concrete action** → make it a next action: `task <uuid> modify -inbox +next`. Ask whether to set work/customer/industry tags, `due:`, or other attributes. Only set `project:` if it belongs to an existing GTD project. If the user introduces a new tag, ask for its meaning and append it to tag memory.
  - **Yes, but it's multi-step** → it's a GTD project. Set a `project:` on a `+next` action that captures the *very next* physical step (e.g. `task <uuid> modify -inbox +next project:<name>`), confirming the outcome-style project name with the user. Separately ask which work/customer/industry tags apply. If this is a **new** project (no entry in the project memory), ask the user for a one- or two-sentence description and append it to the memory file. If the user introduces a new tag, ask for its meaning and append it to tag memory.
  - **Yes, but it's delegated / depends on someone else** → `task <uuid> modify -inbox +waiting` and `task <uuid> annotate "..."` to record who and since when.

After each item, confirm what you did and continue to the next. The phase ends when `task +inbox count` returns 0 — or when the user decides to stop.

### 1b. Mind sweep

Ask the user if anything is on their mind that isn't captured yet — commitments, ideas, loose ends. For anything they volunteer, capture it with `task add "..." +inbox`, then either process it now (loop back to 1a) or leave it in the inbox for next time, as they prefer.

---

## Phase 2 — Get Current

### 2a. Review next actions

```bash
task +next export
```

Present the list. For each (or grouped sensibly, but still pausing for the user's calls), ask whether it is: still valid, still genuinely the *next* action, correctly prioritized, already done, or no longer relevant. Flag items that look stale (old `entry`/`modified` dates) since those are often where reality has drifted. Execute their decisions: `done`, `delete`, re-tag, or set/adjust `due:`/`project:` if they use them.

### 2b. Review waiting-for

```bash
task +waiting export
```

For each delegated item, ask: are you still waiting, or has it come back? Does it need a nudge? If it's been received, either complete it (`task <uuid> done`) or convert it to a next action (`task <uuid> modify -waiting +next`). Encourage adding/refreshing an annotation noting who and since when, so follow-ups are easy.

### 2c. Review the calendar (only if the user uses dates)

First detect whether dates are in play:

```bash
task +PENDING export   # inspect for `due` / `scheduled` fields
```

If they use them, present upcoming `due`/`scheduled`/`+OVERDUE` items and confirm each is still accurate. If they don't use dates, say so and skip — don't push date discipline they haven't asked for.

### 2d. Review projects

List the GTD projects in use, then load the project memory (see the Project memory section):

```bash
task projects        # projects and their pending counts
```

For each active project:

1. **Look up its description** in the memory. If there is **no entry**, ask the user for a one- or two-sentence description of the project's intended outcome, then append it to the memory file. This is required — don't review a project blind, and don't invent a description yourself.
2. With the description in hand for context, do the high-value GTD check: **every active project should have at least one next action.**

```bash
task project:<name> +next count
```

If a project has zero next actions, surface it (along with its description) and ask the user to define the very next physical step, then add it as a `+next` action on that project.

If you see a `project:` value that looks like a work/customer/industry bucket rather than a GTD outcome, flag it and ask whether it should be converted into tags. Do not perform that migration without the user's explicit decision.

### 2e. Review tags

List user tags currently present on pending tasks and load the tag memory:

```bash
task +PENDING export   # inspect lowercase `tags` fields from JSON
```

For each active user tag with no memory entry, ask the user for a one- or two-sentence meaning and append it to tag memory. Do this one tag at a time. Do not ask about uppercase virtual tags like `PENDING`, `WAITING`, or `OVERDUE`; those are Taskwarrior-computed, not user tags.

If a tag's current usage appears inconsistent with its remembered meaning, show one or two examples and ask whether the tag meaning should be revised or the tasks should be retagged. Do not retag automatically.

### 2f. Review someday/maybe (only if the user tracks it)

If you established earlier how the user holds someday/maybe items, review them now: anything ready to activate into `+next` or `+inbox`? If the user has no someday/maybe system, ask whether they want one — but don't create it unilaterally.

---

## Phase 3 — Get Creative

Prompt the user, lightly, for higher-altitude thinking: any new projects, goals, or ideas worth capturing while they have the full picture in front of them? Capture anything they offer with `task add "..." +inbox` (or process it immediately if they want). Keep this short — it's an invitation, not an interrogation.

---

## Wrap-up

Summarize the session for the user: how many inbox items were processed, how many next actions and waiting items were reviewed, any projects flagged for a missing next action, any tag meanings added or revised, and anything captured during the mind sweep or creative phase. Confirm the review is complete. Don't over-explain — a tight summary of what changed is enough.

## Guardrails recap

- Address every task by `uuid`; act one task at a time (see the `taskwarrior` skill for why).
- Show the user each change before making it; let them decide. Never auto-resolve.
- Don't disable Taskwarrior confirmations to move faster.
- Don't assume `project:`, tag meanings, dates, contexts, or a someday/maybe bucket exist — detect or ask.
