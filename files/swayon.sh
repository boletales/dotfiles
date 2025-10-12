#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_CURRENT_SESSION=sway
export LIBSEAT_BACKEND=logind
export QT_QPA_PLATFORM=wayland
export GDK_DPI_SCALE=1.25
export QT_SCALE_FACTOR=1.25
export MOZ_ENABLE_WAYLAND=1
export WINIT_UNIX_BACKEND=x11
export LANG=ja_JP.utf-8
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

fcitx5 -d --replace &

exec sway
