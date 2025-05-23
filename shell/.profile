#!/bin/bash

if [ -d "/usr/games" ] ; then
    PATH="/usr/games:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.config/i3/scripts/" ] ; then
    PATH="$HOME/.config/i3/scripts:$PATH"
fi

if [ -d "$HOME/.scripts" ] ; then
    PATH="$HOME/.scripts:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.cargo" ] ; then
  . "$HOME/.cargo/env"
fi

export EDITOR="nvim"
export MANPAGER='nvim +Man!'
export BROWSER="firefox"
export GOPATH="$HOME/.go"

export PROFILE_IS_SOURCED=1
