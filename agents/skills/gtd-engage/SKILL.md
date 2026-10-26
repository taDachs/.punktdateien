---
name: gtd-engage
description: Help the user choose and start a current Taskwarrior GTD next action in a short work-session Engage flow. Use for "what should I work on?", "what's next?", "start work", "pick my next task", "help me choose something to do", or "engage" when they mean selecting work now. Use gtd-weekly-review instead for inbox clarification or a full review of next actions, waiting-for, projects, or tags.
compatibility: Requires the `task` (Taskwarrior) CLI. Consults the `taskwarrior` skill.
---

# GTD Engage

Help the user **choose → start → work**. This is a small work-session selection, not a weekly review. The `taskwarrior` skill is the source of truth for CLI safety, context, JSON exports, and UUID targeting; consult it before any `task` command.

1. Check reachability with `task --version` and the active context with `task context show`. If unavailable, say so and stop. A context may narrow the selection; say what is in scope and offer a wider read if needed.
2. Read pending tasks as JSON (`task status:pending export rc.context=none`) and identify those with a `start` field, even if they lack `+next`. Surface started work first. If there are several, show them compactly. Ask whether the user wants to continue one or choose something else. If continuing, stop here: it is already started.
3. Read `task +next export` as JSON (bypass a narrowing context only if the user wants a wider view). This is the menu of actions realistically choosable this week, not a representative action from every project. Consider pending `+next` items genuinely available now: exclude future `scheduled:` dates, waiting-on-others, and blocked/dependent actions. If a mislabeled item is encountered, point it out briefly and let the user choose another; leave its cleanup for the weekly review.
4. If the list is too large to scan, narrow with existing tags/project metadata or **one** context question (e.g. work or personal, at robot hardware or not, substantial block or small task). Then show a compact selection: description, GTD `project:` outcome if any, relevant domain/work tags, and age or real deadline/priority when useful. Treat urgency as context, not an automatic ranking. Do not interview or reprioritize the whole list.
5. Ask which action the user wants to work on now. If other tasks are started, ask which, if any, to stop **before** starting the choice. Use `task <old-uuid> stop` only for each task they explicitly approve. If they keep others started, use `task <chosen-uuid> start` anyway and note which tasks remain started. Use UUIDs from the JSON export; do not rely on numeric IDs. If the chosen task is already started, simply continue it.
6. Confirm the chosen action is started and stop. Completion stays with the normal Taskwarrior/GTD workflow.

If there are no available next actions, say so without treating projects without `+next` as broken; offer a brief choice to widen the context or do a separate clarification/review if the user wants to bring an action into play. Keep this session free of inbox processing, project/tag reviews, dates-as-priorities, and new `+today`/`+focus` tags. Never change multiple tasks without the user's explicit decisions.
