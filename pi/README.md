# Pi

Run `bash pi/install.bash` from the dotfiles checkout (also run by `install.bash`).
Install Pi first using <https://pi.dev> if it isn't on `PATH` yet.

The installer links settings and agent files into `~/.pi/agent`, backing up any
existing files there in `config-backup.*` directories. It honors
`PI_CODING_AGENT_DIR` and can be rerun independently of the full dotfiles install.
It reconciles the packages declared in `settings.json` with
`pi update --extensions`. Pi also auto-installs missing declared packages on
startup, so the config works even if Pi is installed later.

The three agents override the built-ins globally:

| Agent | Model | Thinking |
| --- | --- | --- |
| `general-purpose` | `openai-codex/gpt-6.1-sol` | medium |
| `Plan` | `openai-codex/gpt-6.1-sol` | high |
| `Explore` | `openai-codex/gpt-6-luna` | medium |

Plan and Explore use read-only tools with extensions disabled. General-purpose
inherits the parent instructions, extensions, and skills and can delegate.
Project-level agent definitions can override these defaults.

Credentials, sessions, model catalogs, installed packages, and backups remain
local; the whole `~/.pi/agent` directory must not point into this repo. Settings
are linked, so changes made with Pi's settings/package commands are tracked too
(Pi may also add bookkeeping fields to that file).

Authenticate models with `/login` in Pi. Supply `TAVILY_API_KEY` through your
local environment, not a tracked file. Shared skills are discovered from
`~/.agents/skills`; no Pi-specific copies are needed. Restart Pi or run `/reload`
after installing or changing this configuration; check the result with `pi list`
and `/agents`.
