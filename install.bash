#!/usr/bin/env bash
set -ex

rm -rf $HOME/.zshrc $HOME/.bashrc $HOME/.profile

stow --target $HOME zsh
stow --target $HOME/.config nvim
stow --target $HOME tmux
stow --target $HOME/.config starship
stow --target $HOME shell
