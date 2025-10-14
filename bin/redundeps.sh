#!/bin/bash

list_mode=0
while getopts "l" opt; do
    case ${opt} in
        l)
            list_mode=1
            ;;
        \?)
            exit 1
            ;;
    esac
done

if [ -t 1 ]; then
    # Terminal output: Use ANSI color codes
    C_PKG='\e[1;36m'   # Bold Cyan
    C_DEPS='\e[1;33m'  # Bold Yellow
    C_RESET='\e[0m'    # Reset color
else
    # Redirected output (to a file or pipe): No color
    C_PKG=''
    C_DEPS=''
    C_RESET=''
fi

# --- Main Logic ---
redundant_list=""
for pkg in $(pacman -Qeq); do
    # Get the "Required By" field for the package
    dependents=$(LANG=C pacman -Qi "$pkg" | grep '^Required By' | sed 's/Required By\s*:\s*//')

    # If the package is required by something other than "None"
    if [[ -n "$dependents" && "$dependents" != "None" ]]; then
        if [ "$list_mode" -eq 1 ]; then
            # List mode: Append package to the list string
            redundant_list+="$pkg "
        else
            # Normal mode: Print human-readable output with conditional color
            printf "${C_PKG}%s${C_RESET} is required by: ${C_DEPS}%s${C_RESET}\n" "$pkg" "$dependents"
        fi
    fi
done

if [ "$list_mode" -eq 1 ]; then
    # Trim the trailing space and print
    echo "${redundant_list% }"
fi
