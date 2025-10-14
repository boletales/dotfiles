#!/bin/bash

dir="$(cd $(dirname $0) && pwd)"
cd $sourceroot || exit

$dir/bin/symlink.sh
$dir/bin/sshkey.sh

