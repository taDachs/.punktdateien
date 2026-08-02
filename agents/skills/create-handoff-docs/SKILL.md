---
name: create-handoff-docs
description: Interview-driven generation of a single handoff documentation file about a codebase, for a coworker or student to receive. Use when the user wants to write up docs, an onboarding guide, or a handoff document they can pass on.
disable-model-invocation: true
argument-hint: "What part of the codebase, and who's it for?"
---

# Create Handoff Docs

Produces one polished documentation file — Markdown, HTML, or PDF — about a real codebase, shaped by an interview rather than a fixed template. The document is meant to be handed to a specific coworker or student, not published as ongoing project docs.

## Process

1. **Explore.** Read the relevant code/repo before asking anything. Build a real picture: what it does, key modules, public interfaces, what's already documented vs. not. Look up every fact you can this way — the interview is for decisions, not for things you can read yourself.

2. **Interview**, one question at a time, waiting for the answer before asking the next. Ground each question in what you found exploring — reference specifics ("I see three undocumented endpoints in `api/`...") rather than asking generically. Give a recommendation with each question. Cover the following, skipping anything exploration already answered, and adding follow-ups exploration surfaced:
   - **Audience** — who receives this, and their starting knowledge level
   - **Purpose** — what they should be able to do after reading it
   - **Scope** — which part of the codebase
   - **Depth** — overview vs. exhaustive reference
   - **Tone** — formal/reference vs. conversational/teaching, etc.
   - **Format** — Markdown, HTML, or PDF
   - **Delivery** — save into the repo, or hand off as a standalone file

3. **Outline.** Present a section-level outline for approval before writing full content. Revise until confirmed.

4. **Draft.** Write the full document against the approved outline. Present it for approval. Revise until confirmed — don't treat one round as sufficient if the user asks for changes.

5. **Finalize** in the chosen format:
   - **Markdown** — write the file directly.
   - **HTML** — semantic, minimal styling; content over design, no bundled design system.
   - **PDF** — check what's actually available on this machine (e.g. a headless-Chromium-family browser, `pandoc`, `wkhtmltopdf`, `weasyprint`) and render the HTML/Markdown version with whichever is present. If nothing suitable is found, tell the user and ask how they want to proceed rather than silently falling back or failing.

## Notes

- No fixed genre templates (README vs. API reference vs. onboarding guide, etc.) — structure comes from the interview and the outline step, not a canned skeleton.
- One document per run, addressed to the specific audience named in the interview — not a general-purpose project docs generator.
