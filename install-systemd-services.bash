#!/usr/bin/env bash
set -ex

mkdir -p $HOME/.config

ln -sf ${PWD}/systemd ${HOME}/.config/

systemctl --user daemon-reload

systemctl --user enable auto-color-switch.service
systemctl --user start auto-color-switch.service
