#!/usr/bin/env bash
set -ex

rm -rf $HOME/.zshrc $HOME/.bashrc $HOME/.profile

mkdir -p $HOME/.config


ln -sf ${PWD}/zsh/.zshrc ${HOME}
ln -sf ${PWD}/alacritty ${HOME}/.config
mkdir -p "${HOME}/.config/ghostty"
ln -sfn "${PWD}/ghostty/config.ghostty" "${HOME}/.config/ghostty/config.ghostty"
# Desktop-specific lists take precedence over the generic terminal preference.
for desktop in xdg ubuntu-xdg gnome-xdg; do
  ln -sfn "${PWD}/xdg/xdg-terminals.list" "${HOME}/.config/${desktop}-terminals.list"
done
ln -sf ${PWD}/i3 ${HOME}/.config
ln -sf ${PWD}/nvim ${HOME}/.config
ln -sf ${PWD}/git ${HOME}/.config
ln -sf ${PWD}/tmux/.tmux.conf ${HOME}
ln -sf ${PWD}/starship/starship.toml ${HOME}/.config

ln -sf ${PWD}/shell/.bashrc ${HOME}
ln -sf ${PWD}/shell/.bash_profile ${HOME}
ln -sf ${PWD}/shell/.profile ${HOME}
ln -sf ${PWD}/shell/.profile_plugins ${HOME}
ln -sf ${PWD}/shell/.shellrc ${HOME}
ln -sf ${PWD}/shell/.zprofile ${HOME}
ln -sf ${PWD}/taskwarrior/.taskrc ${HOME}
ln -sf ${PWD}/timewarrior ${HOME}/.config

ln -sf ${PWD}/herdr ${HOME}/.config

# Pi configuration and declared extension packages (state stays in ~/.pi/agent).
bash "${PWD}/pi/install.bash"

# herdr plugins live in herdr/plugins/ (gitignored), so (re)install them here.
# Keep this list in sync with the plugin_action keybindings in herdr/config.toml.
herdr_plugins=(
  jeffarese/herdr-bar
  ChmaraX/herdr-gitview
  ChmaraX/herdr-nvim
  aimdevlee/herdr-nvim-nav
)
if command -v herdr >/dev/null; then
  for plugin in "${herdr_plugins[@]}"; do
    herdr plugin install -y "${plugin}" || echo "herdr: failed to install ${plugin} (already installed?)" >&2
  done
fi

ln -sf ${PWD}/robot_folders/robot_folders.yaml ${HOME}/.config

mkdir -p ${HOME}/.agents/skills
for skill in gtd-weekly-review taskwarrior; do
  ln -sfn "${PWD}/agents/skills/${skill}" "${HOME}/.agents/skills/${skill}"
done

if [ -L "${HOME}/.claude" ]; then
  echo "Refusing to install: ${HOME}/.claude is a symlink (would mix state into dotfiles repo)" >&2
  exit 1
fi

mkdir -p ${HOME}/.claude
ln -sf ${PWD}/claude/settings.json ${HOME}/.claude/settings.json
ln -sf ${PWD}/claude/rules ${HOME}/.claude/rules
ln -sf ${PWD}/claude/agents ${HOME}/.claude/agents
mkdir -p ${HOME}/.claude/skills
for skill in gtd-weekly-review taskwarrior; do
  ln -sfn "${PWD}/agents/skills/${skill}" "${HOME}/.claude/skills/${skill}"
done

if [ -L "${HOME}/.config/opencode" ]; then
  echo "Refusing to install: ${HOME}/.config/opencode is a symlink (keep opencode state out of repo)" >&2
  exit 1
fi

mkdir -p "${HOME}/.config/opencode"
for file in opencode.jsonc AGENTS.md cli.json; do
  ln -sf "${PWD}/opencode/${file}" "${HOME}/.config/opencode/${file}"
done
mkdir -p "${HOME}/.config/opencode/agents"
for agent in "${PWD}"/opencode/agents/*.md; do
  ln -sf "${agent}" "${HOME}/.config/opencode/agents/$(basename "${agent}")"
done

mkdir -p $HOME/.config/lazygit
ln -sf ${PWD}/lazygit/config.yml ${HOME}/.config/lazygit/config.yml

mkdir -p $HOME/.local/bin
ln -sf ${PWD}/scripts/* ${HOME}/.local/bin

# bootstrap nvim
nvim \
  --headless \
  -c "MasonInstall tree-sitter-cli ruff ty black" \
  -c "lua require('nvim-treesitter').install('all'):wait(300000)" \
  -c "qall"
