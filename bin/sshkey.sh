#!/bin/bash

github_user="boletales"

read -n1 -r -p "Do you want to append https://github.com/$github_user.keys to your authorized_keys? [y/N] " response
echo ""
if [[ $response =~ ^[Yy]$ ]]; then
  ssh_dir="$HOME/.ssh"
  mkdir -p "$ssh_dir"
  curl -s "https://github.com/$github_user.keys" >> "$ssh_dir/authorized_keys"
  echo "  + ${ESC}[32mAppended keys of $github_user to $ssh_dir/authorized_keys${ESC}[m"
else
  echo "Skipping."
fi

