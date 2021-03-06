#!/usr/bin/env sh

stow --target ~ zsh
stow --target ~/.config alacritty
stow --target ~/.config i3
stow --target ~/.config awesome
stow nvim
stow --target ~/.config polybar
stow --target ~/.config git
stow --target ~/.config nort
stow --target ~ tmux
stow --target ~/.config starship

# install plugin loaders for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install plugin loaders for zsh
curl \
  -sL --create-dirs \
  https://git.sr.ht/~yerinalexey/miniplug/blob/master/miniplug.zsh \
  -o $HOME/.local/share/miniplug.zsh
zsh -c "miniplug install"

