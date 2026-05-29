#!/usr/bin/env bash
set -ex

rm -rf $HOME/.zshrc $HOME/.bashrc $HOME/.profile

mkdir -p $HOME/.config


ln -sf ${PWD}/zsh/.zshrc ${HOME}
ln -sf ${PWD}/alacritty ${HOME}/.config
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

ln -sf ${PWD}/robot_folders/robot_folders.yaml ${HOME}/.config

ln -sf ${PWD}/agents ${HOME}/.agents

if [ -L "${HOME}/.claude" ]; then
  echo "Refusing to install: ${HOME}/.claude is a symlink (would mix state into dotfiles repo)" >&2
  exit 1
fi

mkdir -p ${HOME}/.claude
ln -sf ${PWD}/claude/settings.json ${HOME}/.claude/settings.json
ln -sf ${PWD}/claude/rules ${HOME}/.claude/rules
ln -sf ${PWD}/claude/agents ${HOME}/.claude/agents
ln -sf ${PWD}/agents/skills ${HOME}/.claude/skills

if [ -L "${HOME}/.config/opencode" ]; then
  echo "Refusing to install: ${HOME}/.config/opencode is a symlink (keep opencode state out of repo)" >&2
  exit 1
fi

mkdir -p ${HOME}/.config/opencode
ln -sf ${PWD}/opencode/config.json ${HOME}/.config/opencode/config.json
ln -sf ${PWD}/opencode/AGENTS.md ${HOME}/.config/opencode/AGENTS.md


mkdir -p $HOME/.local/bin
ln -sf ${PWD}/scripts/* ${HOME}/.local/bin

# bootstrap nvim
nvim \
  --headless \
  -c "MasonInstall tree-sitter-cli ruff ty black" \
  -c "lua require('nvim-treesitter').install('all'):wait(300000)" \
  -c "qall"
