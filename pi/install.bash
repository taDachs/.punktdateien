#!/usr/bin/env bash
set -euo pipefail

config_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
agent_dir="${PI_CODING_AGENT_DIR:-${HOME}/.pi/agent}"

# Link only configuration: auth, sessions, caches, and installed packages stay local.
if [[ -L "${agent_dir}" ]]; then
  echo "Refusing to install: ${agent_dir} is a symlink (keep Pi state out of dotfiles)" >&2
  exit 1
fi
mkdir -p "${agent_dir}/agents"

link_config() {
  local source="$1" target="$2" backup
  if [[ -L "${target}" && "$(readlink -- "${target}")" == "${source}" ]]; then
    return
  fi
  if [[ -e "${target}" || -L "${target}" ]]; then
    backup="$(mktemp -d "${agent_dir}/config-backup.XXXXXXXX")"
    mv -- "${target}" "${backup}/"
    echo "Pi: backed up ${target} to ${backup}" >&2
  fi
  ln -s -- "${source}" "${target}"
}

link_config "${config_dir}/settings.json" "${agent_dir}/settings.json"
for agent in "${config_dir}"/agents/*.md; do
  link_config "${agent}" "${agent_dir}/agents/$(basename -- "${agent}")"
done

if command -v pi >/dev/null 2>&1; then
  pi update --extensions
else
  echo "Pi is not installed; configured packages will auto-install on first launch." >&2
fi
