#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


alias vim='nvim'

if [[ "$(tty)" == /dev/tty* ]]; then
setfont ter-v32n
export LANG=C    
fi
