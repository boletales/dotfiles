#!/bin/bash

# Settings

github_user="boletales"



# 1. make symlinks from ./files/** to $HOME

ESC=$(printf '\033')

dotfiles_linker() {
  local sourcedir="$sourceroot$1"
  local homedir="$HOME$1"
  echo "Processing directory: ./files$1"
  # files first
  for item in $sourcedir/*; do
    local name=$(basename "$item")
    if [ -f "$item" ]; then
      if [ ! -e "$homedir/$name" ]; then
        ln -s "$sourcedir/$name" "$homedir/$name"
        echo "  + ${ESC}[32mLinking $sourcedir/$name to $homedir/$name.${ESC}[m"
      else
        echo "  * ${ESC}[34m$homedir/$name already exists, skipping.${ESC}[m"
      fi
    fi
  done
  # then directories
  for item in $sourcedir/*; do
    local name=$(basename "$item")
    if [ -d "$item" ]; then
      if [ -f "$homedir/$name" ]; then
        echo "  ! ${ESC}[31m$homedir/$name is a file, cannot create directory, skipping.${ESC}[m"
      elif [ ! -d "$homedir/$name" ]; then
        mkdir "$homedir/$name"
        echo "  + ${ESC}[32mCreated directory $homedir/$name${ESC}[m"
        (dotfiles_linker "$1/$name")
      else
        echo "  * ${ESC}[34mDirectory $homedir/$name already exists, skipping.${ESC}[m"
        (dotfiles_linker "$1/$name")
      fi
    fi
  done
}

read -n1 -r -p "#1 This will symlink all files from ./files to ~/. Are you sure? [y/N] " response
echo ""
if [[ $response =~ ^[Yy]$ ]]; then
  shopt -s nullglob
  shopt -s dotglob

  sourceroot="$(cd $(dirname $0) && pwd)/files"
  cd $sourceroot || exit

  dotfiles_linker ""
else
  echo "Skipping."
fi

# 2. ask to download ssh keys from https://github.com/[user].keys
read -n1 -r -p "#2 Do you want to append https://github.com/$github_user.keys to your authorized_keys? [y/N] " response
echo ""
if [[ $response =~ ^[Yy]$ ]]; then
  ssh_dir="$HOME/.ssh"
  mkdir -p "$ssh_dir"
  curl -s "https://github.com/$github_user.keys" >> "$ssh_dir/authorized_keys"
  echo "  + ${ESC}[32mAppended keys of $github_user to $ssh_dir/authorized_keys${ESC}[m"
else
  echo "Skipping."
fi