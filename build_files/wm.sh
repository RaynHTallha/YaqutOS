#!/bin/bash
set -ouex pipefail

dnf5 -y copr enable "solopasha/hyprland"
dnf5 -y install \
hyprland        \
hyprutils       \
wofi            \
alacritty       \
nautilus

dnf5 -y install --enable-repo=terra noctalia-shell
