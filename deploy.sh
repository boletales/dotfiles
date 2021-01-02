#!/bin/sh
cd `dirname $0`
shopt -s dotglob
cp -v files/* ~/
shopt -u dotglob
