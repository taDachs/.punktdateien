#!/usr/bin/env bash
set -x

stow --target $HOME zsh
stow --target $HOME/.config alacritty
stow --target $HOME/.config sway
stow --target $HOME/.config waybar
stow --target $HOME/.config i3
stow --target $HOME/.config i3status
stow --target $HOME/.config awesome
stow --target $HOME/.config nvim
stow --target $HOME/.config polybar
stow --target $HOME/.config git
stow --target $HOME/.config nort
stow --target $HOME tmux
stow --target $HOME/.config starship
stow --target $HOME/.config gtk-3.0
stow --target $HOME/.config rofi
stow --target $HOME shell
stow --target $HOME/.config latexmk

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]] ; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]] ; then
  p
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zlong_alert" ]] ; then
  git clone https://github.com/kevinywlui/zlong_alert.zsh ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zlong_alert
fi
