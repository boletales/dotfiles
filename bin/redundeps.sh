#!/bin/bash

for pkg in $(pacman -Qeq); do
    dependents=$(LANG=C pacman -Qi "$pkg" | grep '^Required By' | sed 's/Required By\s*:\s*//')

    if [[ -n "$dependents" && "$dependents" != "None" ]]; then
        printf "\e[1;36m%s\e[0m is required by: \e[1;33m%s\e[0m\n" "$pkg" "$dependents"
    fi
done
