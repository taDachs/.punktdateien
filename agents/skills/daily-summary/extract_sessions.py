#!/usr/bin/env python3
"""Extract the Claude Code conversation of given local days from ~/.claude/projects.

Usage: extract_sessions.py --out DIR YYYY-MM-DD [YYYY-MM-DD ...]

Per day, writes DIR/<day>/<session-id>.txt (user prompts, assistant text, commit
commands, in order) and prints an index line per session to stdout. Days are
local-time days; transcript timestamps are UTC.
"""
import argparse
import glob
import json
import os
from datetime import datetime

SKIP_USER_PREFIXES = ('<system', '<command', '<task-notification', '<local-command')


def local_day_and_time(ts):
    t = datetime.fromisoformat(ts.replace('Z', '+00:00')).astimezone()
    return t.strftime('%Y-%m-%d'), t.strftime('%H:%M')


def extract(path, days):
    per_day = {d: {'lines': [], 'times': [], 'first_prompt': None} for d in days}
    earliest = None
    for raw in open(path, errors='ignore'):
        try:
            o = json.loads(raw)
        except json.JSONDecodeError:
            continue
        ts = o.get('timestamp')
        if not ts or o.get('isSidechain'):
            continue
        day, hm = local_day_and_time(ts)
        earliest = min(earliest or day, day)
        if day not in per_day:
            continue
        d = per_day[day]
        d['times'].append(hm)
        content = o.get('message', {}).get('content')
        if o.get('type') == 'user' and isinstance(content, str):
            if content.startswith(SKIP_USER_PREFIXES):
                continue
            d['lines'].append(f'### USER [{hm}]: {content[:1500]}')
            d['first_prompt'] = d['first_prompt'] or content[:150].replace('\n', ' ')
        elif o.get('type') == 'assistant' and isinstance(content, list):
            for b in content:
                if b.get('type') == 'text' and len(b['text']) > 40:
                    d['lines'].append('--- A: ' + b['text'][:2500])
                elif b.get('type') == 'tool_use' and 'git commit' in json.dumps(b.get('input', {})):
                    d['lines'].append('[COMMIT] ' + json.dumps(b['input'])[:500])
    return per_day, earliest


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--out', required=True)
    ap.add_argument('days', nargs='+')
    args = ap.parse_args()

    files = glob.glob(os.path.expanduser('~/.claude/projects/*/*.jsonl'))
    for day in args.days:
        os.makedirs(os.path.join(args.out, day), exist_ok=True)
    for path in files:
        per_day, earliest = extract(path, args.days)
        session = os.path.basename(path)[:-len('.jsonl')]
        project = os.path.basename(os.path.dirname(path))
        for day, d in per_day.items():
            if not d['lines']:
                continue
            out = os.path.join(args.out, day, session + '.txt')
            with open(out, 'w') as f:
                f.write('\n'.join(d['lines']))
            cont = ' (continued from ' + earliest + ')' if earliest < day else ''
            print(f"{day} {min(d['times'])}-{max(d['times'])} {os.path.getsize(out):>7}B "
                  f"{project} {session}{cont} | {d['first_prompt'] or '-'}")


if __name__ == '__main__':
    main()
