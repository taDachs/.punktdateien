#!/usr/bin/env bash
set -ex

stow --delete --target $HOME zsh
stow --delete --target $HOME/.config alacritty
stow --delete --target $HOME/.config i3
stow --delete --target $HOME/.config nvim
stow --delete --target $HOME/.config polybar
stow --delete --target $HOME/.config git
stow --delete --target $HOME tmux
stow --delete --target $HOME/.config starship
stow --delete --target $HOME/.config xdg
stow --delete --target $HOME/.config gtk-3.0
stow --delete --target $HOME/.config rofi
stow --delete --target $HOME shell
stow --delete --target $HOME/.config latexmk
stow --delete --target $HOME/.config zathura
