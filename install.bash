#!/usr/bin/env bash
set -ex

rm -rf $HOME/.zshrc $HOME/.bashrc $HOME/.profile

mkdir -p $HOME/.config

stow --target $HOME zsh
stow --target $HOME/.config nvim
stow --target $HOME tmux
stow --target $HOME/.config starship
stow --target $HOME shell
mkdir -p $HOME/.local/bin
stow --target $HOME/.local/bin scripts
