#!/bin/bash

if [ -d "/usr/games" ] ; then
    PATH="$PATH:/usr/games"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/.config/i3/scripts/" ] ; then
    PATH="$PATH:$HOME/.config/i3/scripts"
fi

if [ -d "$HOME/.scripts" ] ; then
    PATH="$PATH:$HOME/.scripts"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$PATH:$HOME/.cargo/bin"
fi

if [ -d "$HOME/.cargo" ] ; then
  . "$HOME/.cargo/env"
fi

export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export BROWSER="firefox"
export GOPATH="$HOME/.go"

export PROFILE_IS_SOURCED=1
