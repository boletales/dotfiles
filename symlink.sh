#!/bin/bash

# make symlinks from ./files/** to $HOME

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

read -n1 -r -p "Symlink all files from ./files to ~/ ? [y/N] " response
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

