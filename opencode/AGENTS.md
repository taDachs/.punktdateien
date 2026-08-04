<!-- context7 -->
Use the `ctx7` CLI to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service — even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer — your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Steps

1. Resolve library: `npx ctx7@latest library <name> "<user's question>"` — use the official library name with proper punctuation (e.g., "Next.js" not "nextjs", "Customer.io" not "customerio", "Three.js" not "threejs")
2. Pick the best match (ID format: `/org/project`) by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question)
3. Fetch docs: `npx ctx7@latest docs <libraryId> "<user's question>"` — run a separate `docs` command per distinct concept if the question spans multiple topics, unless it's about how they interact
4. Answer using the fetched documentation

You MUST call `library` first to get a valid ID unless the user provides one directly in `/org/project` format. Use the user's full question as the query — specific and detailed queries return better results than vague single words, but keep each query to a single concept unless the question is about how concepts interact; combined multi-topic queries dilute ranking and return shallow results for each topic. Do not run more than 3 commands per question. Do not include sensitive information (API keys, passwords, credentials) in queries.

For version-specific docs, use `/org/project/version` from the `library` output (e.g., `/vercel/next.js/v14.3.0`).

If a command fails with a quota error, inform the user and suggest `npx ctx7@latest login` or setting `CONTEXT7_API_KEY` env var for higher limits. Do not silently fall back to training data.
<!-- context7 -->

## Sequential thinking

Use the `sequential-thinking` MCP tool for tasks that require substantial
reasoning, including:

- debugging problems with multiple plausible causes
- architecture and API design
- planning non-trivial implementations or refactorings
- comparing alternatives with meaningful trade-offs
- tasks involving unclear requirements or uncertain assumptions

When using it:

1. Inspect the relevant code and context first.
2. Use sequential thinking before proposing or implementing the solution.
3. Break the problem into explicit reasoning steps.
4. Revise earlier thoughts when evidence contradicts an assumption.
5. Branch into alternatives when multiple approaches are plausible.
6. Continue until the reasoning is sufficiently complete.
7. Then implement the selected approach and verify it using tests, builds,
   diagnostics, or other appropriate tools.

Do not use sequential thinking for trivial edits, simple lookups, formatting,
or tasks with an obvious one-step solution.

Treat the sequential-thinking output as internal working material. In the final
response, provide the conclusion, important assumptions, decisions, and
verification results rather than reproducing the complete thought trace.

## Persistent memory

Use the `memory` MCP to retain useful information across OpenCode sessions.

### At the beginning of a task

Search memory when previous context could improve the result, especially for:

* project architecture and important design decisions
* established coding conventions
* build, test, deployment, and development workflows
* previously encountered problems and their solutions
* user preferences that affect implementation or communication
* ongoing tasks, unresolved issues, and explicitly deferred work

Use targeted searches with `search_nodes`. Do not read the entire knowledge
graph unless a targeted search is insufficient.

Treat retrieved memories as potentially outdated. Verify project facts against
the current repository before relying on them.

### What to remember

Store information only when it is likely to be useful in future sessions.

Good memories include:

* non-obvious architectural decisions and their rationale
* stable project-specific conventions
* commands or setup steps that were verified to work
* recurring environment constraints
* important interfaces between components
* user corrections and durable preferences
* causes and verified solutions for difficult problems
* explicit decisions to postpone, reject, or prefer an approach

Do not store:

* temporary debugging output
* speculative conclusions
* information that is obvious from the repository
* large code snippets or complete file contents
* transient task details that will not matter later
* passwords, API keys, tokens, credentials, or private keys
* sensitive personal information unless the user explicitly requests it

### Before writing memory

1. Search for an existing entity or related observation.
2. Reuse existing entities instead of creating slightly different duplicates.
3. Verify that the information is factual rather than speculative.
4. Prefer information confirmed by code, tests, documentation, or the user.
5. Store one fact per observation.
6. Include enough context for the fact to remain understandable later.

Organize project-specific memories under a stable project entity, such as
`project:<repository-name>`.

### Updating memory

When new information supersedes an existing memory:

1. Remove the obsolete observation.
2. Add the corrected observation.
3. Preserve relevant rationale or historical context only when it remains
   useful.

Do not keep contradictory observations without explaining which one is current.

Create relations in active voice, for example:

* `project:robot-driver` `uses` `ROS_2`
* `project:robot-driver` `depends_on` `libserial`
* `David` `prefers` `concise_technical_explanations`

### After completing a task

Update memory when the task produced a durable insight, decision, verified
procedure, or correction that is likely to help a future session.

Do not announce every memory operation. Briefly mention it only when the stored
information is important, potentially sensitive, or explicitly requested by
the user.


