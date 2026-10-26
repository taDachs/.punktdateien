---
name: daily-summary
description: Summarise what the user and Claude did on given days from the Claude Code transcripts, and write it to the Obsidian daily note.
disable-model-invocation: true
---

# Daily summary

Rebuild one or more days of work from the Claude Code transcripts, tell the user, and record it as a daily note in the vault.

1. **Resolve the days** from the arguments ("friday" is the most recent past Friday; "friday and thursday" is two days). Each day is a local calendar day.
2. **Extract** the transcripts into the scratchpad:
   ```
   python3 -I ~/.claude/skills/daily-summary/extract_sessions.py --out <scratchpad>/daily-summary <day> [<day> ...]
   ```
   It prints one index line per session (local time span, extract size, project, session id, first prompt) and writes the extracts to `<scratchpad>/daily-summary/<day>/<session>.txt`. Sessions marked "continued from" started earlier; only their part on that day is extracted.
3. **Read every extract**, all of it, including the large ones: the decisions, the commits and the "not done yet" caveats sit in the middle of long sessions, not just in their last answer. Done when every session with real content is accounted for. Skip trivial ones (a single question, an empty session) or give them one line. Two sessions with the same first prompt are usually a resumed copy of one conversation: the longer one contains the shorter, so read it and count the conversation once.
4. **Settle each open item's status.** For each thing left open on the day, check whether a later session or the repo (`git log`) resolved it, and mark it as resolved with the date. Where the transcript doesn't show the outcome, say so; never guess it.
5. **Report in chat**, grouped by project or topic rather than by session: what was done, the commits (hashes), what was deployed or only prepared, and the loose ends.
6. **Write the daily note** to `/home/max/notes/Personal/01 - Dailies/<day>.md`, one per day. Take the layout from the most recent note in that folder:
   - `# Daily <day>`, then `## Todo` with the open items as `- [ ]` (resolved ones as `- [x] … (done <date>)`);
   - one `##` per project and `###` per topic, written as short bullets with identifiers in backticks, commit hashes, and status words such as *uncommitted*, *not run*, *not deployed*.

   If the note already exists, read it and merge the new material into it, keeping what the user wrote.
