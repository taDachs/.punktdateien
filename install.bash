#!/usr/bin/env bash
set -x

sh -c "$(curl -fsSL https://starship.rs/install.sh)" "" --help

stow --target ~ zsh
stow --target ~/.config alacritty
stow --target ~/.config sway
stow --target ~/.config waybar
stow --target ~/.config i3
stow --target ~/.config i3status
stow --target ~/.config awesome
stow --target ~/.config nvim
stow --target ~/.config polybar
stow --target ~/.config git
stow --target ~/.config nort
stow --target ~ tmux
stow --target ~/.config starship
stow --target ~/.config gtk-3.0
stow --target ~/.config rofi
stow --target ~ shell
stow --target ~/.config latexmk

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] ; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] ; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zlong_alert" ] ; then
  git clone https://github.com/kevinywlui/zlong_alert.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zlong_alert
fi
