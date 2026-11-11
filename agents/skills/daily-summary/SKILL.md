---
name: daily-summary
description: Summarise what the user and the coding agents (Claude Code and opencode) did on given days, and write it to the Obsidian daily notes and their index.
disable-model-invocation: true
---

# Daily summary

Rebuild one or more days of work from the Claude Code and opencode transcripts, tell the user, and record it as daily notes in the vault.

1. **Resolve the days** from the arguments ("friday" is the most recent past Friday; "friday and thursday" is two days). Each day is a local calendar day. When asked for the missing days, list `/home/max/notes/Personal/01 - Dailies/` and take every day after the newest note up to yesterday; days without sessions (weekends) get no note.
2. **Extract** both agents' transcripts into the scratchpad:
   ```
   python3 -I ~/.claude/skills/daily-summary/extract_sessions.py --out <scratchpad>/daily-summary <day> [<day> ...]
   python3 -I ~/.claude/skills/daily-summary/extract_opencode.py --out <scratchpad>/daily-summary <day> [<day> ...]
   ```
   Each prints one index line per session (local time span, extract size, project, session id, first prompt or title) and writes the extracts to `<scratchpad>/daily-summary/<day>/`; opencode files are prefixed `opencode-`. Sessions marked "continued from" started earlier; only their part on that day is extracted.
   - opencode keeps its sessions in `~/.local/share/opencode/opencode.db`, in the `session_v2` and `session_message` tables. The older `session`/`message`/`part` tables stopped being written around 2026-10-26, so a query against them silently misses later days.
   - The opencode extractor first prints when the database's last message was written. If a day falls after that, opencode wasn't used on this machine that day; tell the user, since they may have run it on another machine.
3. **Read every extract**, all of it, including the large ones: the decisions, the commits and the "not done yet" caveats sit in the middle of long sessions, not just in their last answer. Done when every session with real content is accounted for. Skip trivial ones (a single question, an empty session) or give them one line. Two sessions with the same first prompt are usually a resumed copy of one conversation: the longer one contains the shorter, so read it and count the conversation once.
4. **Settle each open item's status.** For each thing left open on the day, check whether a later session or the repo (`git log`) resolved it, and mark it as resolved with the date. Also check the to-do lists of earlier notes for items these days resolved. Where the transcript doesn't show the outcome, say so; never guess it.
5. **Report in chat**, grouped by project or topic rather than by session or agent: what was done, the commits (hashes), what was deployed or only prepared, and the loose ends.
6. **Write the daily note** to `/home/max/notes/Personal/01 - Dailies/<day>.md`, one per day. Take the layout from the most recent note in that folder:
   - `# Daily <day>`, then `## Todo` with the open items as `- [ ]` (resolved ones as `- [x] … (done <date>)`);
   - one `##` per project and `###` per topic, written as short bullets with identifiers in backticks, commit hashes, and status words such as *uncommitted*, *not run*, *not deployed*.

   If the note already exists, read it and merge the new material into it, keeping what the user wrote.
7. **Update the index** `/home/max/notes/Personal/01 - Dailies/index.md`: one line per note, oldest first, as `- [[<day>]]: <one-sentence summary of the day>`. Add lines for new notes and rewrite the line of any note whose content changed noticeably.
