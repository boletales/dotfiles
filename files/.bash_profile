#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# --- Sync environment from systemd user session ---
#
# Check if we are in a systemd user session by looking for XDG_RUNTIME_DIR.
# This prevents errors when logging in under environments without systemd.
if [ -n "$XDG_RUNTIME_DIR" ]; then
    # Read each "KEY=VALUE" line from systemd's environment
    # and export it to the current shell.
    while read -r line; do
        export "$line"
    done < <(systemctl --user show-environment)
fi

if [[ "$(tty)" == /dev/tty* ]]; then
setfont ter-v32n
export LANG=C    
fi
