#!/usr/bin/env bash
set -ex

stow --delete --target $HOME zsh
stow --delete --target $HOME/.config nvim
stow --delete --target $HOME tmux
stow --delete --target $HOME/.config starship
stow --delete --target $HOME shell
