---
name: gtd-weekly-review
description: Guide an interactive Taskwarrior GTD weekly Reflect/Review, including inbox clarification, next actions, waiting-for, projects, and tag memory. Use for "weekly review", "process my inbox", or requests to review projects, next actions, waiting-for, or tags. For choosing what to work on now ("what's next?", "start work"), use gtd-engage instead.
compatibility: Requires the `task` (Taskwarrior) CLI. Relies on the conventions in the `taskwarrior` skill.
---

# GTD Weekly Review

Guide the user through a Getting Things Done weekly review, conducted entirely in Taskwarrior. The defining quality of this skill is that it is **interactive and paced**: present one decision at a time, then **stop and wait for the user's response before doing anything**. Never batch-process or auto-decide. The user is the one making GTD decisions; you surface the items, propose options, and execute the choice they make.

## The user's structure

GTD lives entirely in Taskwarrior. The following is established and can be relied on:

- **`+inbox`** — captured, not yet processed.
- **`+next`** — a startable action the user could realistically choose before the next weekly review: can begin now, clear what doing it means, recognizable when finished. It can take five minutes or two hours. Not every project needs one this week.
- **`+waiting`** — the user's part is done; the ball is with someone or something else.
- **Pending task with `project:` but no workflow tag** — a known future project step, not currently actionable/current. No `+later` tag is needed.
- **`project:`** — GTD projects only: multi-step outcomes with a clear done state. Do not use `project:` for work/customer/industry buckets.
- **Work/customer/industry tags** — use tags for external or organizational buckets, e.g. `+intellirisk`, `+stack`, `+tfur`, `+husky`, `+phd`, `+julius_ba`.

Use `due:` for real deadlines and `scheduled:` only for genuine not-before constraints, never as a daily selection device. When a phase depends on another unestablished convention, detect it from `export` or memory; if ambiguous, ask rather than inventing it.

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
GTD workflow tag for a startable action I could realistically choose before the next weekly review; a project need not have one every week.

## intellirisk
Work/customer bucket for Intellirisk-related tasks. Use as `+intellirisk`; do not use `project:intellirisk`.
```

**Reading:** to find a tag's meaning, match a `## <tag name>` heading exactly. Taskwarrior stores tags without the leading `+`; memory headings should also omit it.

**Updating:** to add a tag, append a new section. To revise one, replace the body under its heading. Keep descriptions to one or two sentences explaining what the tag means and when to use it. Preserve existing entries — never rewrite the whole file from scratch or drop sections you didn't intend to change.

If a tag appears in Taskwarrior but has no memory entry, ask the user for its meaning before relying on it for decisions. If a tag appears in memory but no longer appears in pending tasks, leave it but mention it at wrap-up in case it is obsolete or only used on completed tasks. Never delete a memory entry without the user's say-so.

## Before you start

1. **Consult the `taskwarrior` skill.** All command patterns, the read-as-JSON approach, and especially the rule of addressing tasks by `uuid` (never the unstable `id`) live there. Follow them. In particular, remember the user's lowercase `+waiting` is **not** Taskwarrior's virtual `+WAITING`.
2. **Check Taskwarrior is reachable**: `task --version`. If it errors, tell the user and stop.
3. **Check the active Taskwarrior context** as described in `taskwarrior`; bypass a narrowing context for whole-system reads when needed. Load the project and tag memory files (create and seed them on first run — see their sections above). The current tag memory defines `+someday`; use that established mechanism where appropriate.
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
  - **Yes, startable now** → agree on wording that passes three tests: Can I actually start this now? Do I immediately know what doing it means? Will I recognize when this action is finished? If the user could realistically choose it before the next review, change `-inbox +next`. Otherwise, keep an agreed known future step with `project:` and no workflow tag, or ask how to hold an item without a project. Do not split work merely for being large. Ask about relevant domain/work/customer tags and real deadlines or not-before constraints only when relevant; use `project:` only for a GTD outcome. Record new tag meanings in tag memory.
  - **Yes, a multi-step outcome** → agree on its `project:` name and intended done state (append to project memory if new). If the user wants to work on it before the next review, rewrite the inbox item into a startable action with `-inbox +next project:<name>`. Otherwise retain an agreed known future step as a pending task with `-inbox project:<name>` and no workflow tag. Several independent current next actions are fine. Keep domain buckets as tags.
  - **Someone else must act** → if the user has not yet asked, the contact is their action ("Message Louis asking for deployment code"): make it `+next` only if they could choose it this week; otherwise keep it as a known future project step. After they ask, rewrite that same task as "Waiting for Louis to send deployment code" and change `-inbox -next +waiting` as applicable; annotate who and since when. Never assume the message was sent or convert it without the user's decision.

After each item, confirm what you did and continue to the next. The phase ends when `task +inbox count` returns 0 — or when the user decides to stop.

### 1b. Mind sweep

Ask the user if anything is on their mind that isn't captured yet — commitments, ideas, loose ends. For anything they volunteer, capture it with `task add "..." +inbox`, then either process it now (loop back to 1a) or leave it in the inbox for next time, as they prefer.

---

## Phase 2 — Get Current

### 2a. Review next actions

```bash
task +next export
```

Present the list. For each (or grouped sensibly, still pausing for the user's calls), ask: **Could you realistically choose to work on this before the next weekly review?** Apply the startable-action test above, without making task size itself a reason to split it.

Offer choices: keep `+next`; remove `+next` but retain `project:` as a known future step; rewrite as a clearer startable action; convert/rewrite the same task to `+waiting` if the user's part is done; move to the existing someday/maybe mechanism; mark done; or delete. For a future step without a GTD project, ask how it should be held instead of leaving an unclassified loose end. Stale `entry`/`modified` dates merit scrutiny; if an action has survived several reviews unchosen, probe what is blocking it. "Still valid" alone is not grounds to keep `+next`. Do not infer a review count from its age.

### 2b. Review waiting-for

```bash
task +waiting export
```

For each item, ask whether the ball is still outside the user's court, has come back, or needs a nudge. A nudge is the user's action (`+next` only if current this week); a request already sent remains `+waiting`. If received, agree whether to complete it, rewrite it as a current startable `+next`, or retain a known future project step without a workflow tag. Keep who/what/since-when annotations useful.

### 2c. Review the calendar (only if the user uses dates)

First detect whether dates are in play:

```bash
task +PENDING export   # inspect for `due` / `scheduled` fields
```

If present, confirm `due` represents a real deadline and `scheduled` a genuine not-before constraint; include overdue items. If absent, skip. Do not add dates just to choose today's work.

### 2d. Review projects

Derive projects with pending tasks from `export` JSON (including untagged future steps), and consult project memory. `task projects` is an optional overview, not a substitute for the pending tasks:

```bash
task projects        # projects and their pending counts
```

For each project with pending tasks:

1. **Check the `project:` value is a GTD outcome.** Flag suspected repository/customer/work buckets, especially imported ones, and ask what they mean. Do not silently migrate tasks or memory entries.
2. **Look up its description** in memory. For a genuine GTD project with no entry, ask for the one- or two-sentence intended outcome and append it. Do not invent or overwrite the description.
3. **Review its open steps**, including untagged future steps and waiting items. A project can remain active with no `+next`; that simply means none of its actions are on this week's menu. Do not relabel the project inactive or add a `+next` to satisfy a count.
4. **If several actions are `+next`**, check whether they are genuinely parallel/current or sequential future steps. With the user's approval, remove `+next` from future steps while retaining their `project:` and domain tags.

Show projects with no `+next` together with their outcomes and known steps; ask which, **if any**, the user wants to bring into play before the next review. Pause for their answer before changing anything. Leaving all of them without `+next` is a valid choice, not a gap to fix.

### 2e. Review tags

List user tags currently present on pending tasks and load the tag memory:

```bash
task +PENDING export   # inspect lowercase `tags` fields from JSON
```

For each active user tag with no memory entry, ask the user for a one- or two-sentence meaning and append it to tag memory. Do this one tag at a time. Do not ask about uppercase virtual tags like `PENDING`, `WAITING`, or `OVERDUE`; those are Taskwarrior-computed, not user tags.

If a tag's current usage appears inconsistent with its remembered meaning, show one or two examples and ask whether the tag meaning should be revised or the tasks should be retagged. Do not retag automatically.

### 2f. Review someday/maybe (only if the user tracks it)

If tag memory still establishes `+someday` (or another established mechanism), review those items: anything ready to activate into `+next` or `+inbox`? If no mechanism is established, ask without creating one unilaterally.

---

## Phase 3 — Get Creative

Prompt the user, lightly, for higher-altitude thinking: any new projects, goals, or ideas worth capturing while they have the full picture in front of them? Capture anything they offer with `task add "..." +inbox` (or process it immediately if they want). Keep this short — it's an invitation, not an interrogation.

---

## Wrap-up

Summarize the session for the user: how many inbox items were processed, how many next actions and waiting items were reviewed, any projects brought into this week's menu, any tag meanings added or revised, and anything captured during the mind sweep or creative phase. Confirm the review is complete. Don't over-explain — a tight summary of what changed is enough.

## Guardrails recap

- Address every task by `uuid`; act one task at a time (see the `taskwarrior` skill for why).
- Show the user each change before making it; let them decide. Never auto-resolve.
- Don't disable Taskwarrior confirmations to move faster.
- Don't assume `project:`, tag meanings, dates, contexts, or a someday/maybe bucket exist — detect or ask.
