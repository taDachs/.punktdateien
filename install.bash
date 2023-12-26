#!/usr/bin/env bash
set -ex

rm -rf $HOME/.zshrc $HOME/.bashrc $HOME/.profile

mkdir -p $HOME/.config

stow --target $HOME zsh
stow --target $HOME/.config alacritty
stow --target $HOME/.config i3
stow --target $HOME/.config nvim
stow --target $HOME/.config polybar
stow --target $HOME/.config git
stow --target $HOME tmux
stow --target $HOME/.config starship
stow --target $HOME/.config xdg
stow --target $HOME/.config gtk-3.0
stow --target $HOME/.config rofi
stow --target $HOME shell
stow --target $HOME/.config latexmk
stow --target $HOME/.config zathura
stow --target $HOME/.config robot_folders

mkdir -p $HOME/.local/bin
stow --target $HOME/.local/bin scripts
