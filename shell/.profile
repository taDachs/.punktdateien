#!/bin/bash

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.config/i3/scripts/" ] ; then
    PATH="$HOME/.config/i3/scripts:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
    source "$HOME/.cargo/env"
fi

if [ -d "/var/lib/flatpak/exports/share" ] ; then
    XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
fi

export EDITOR="nvim"
export BROWSER="firefox"
