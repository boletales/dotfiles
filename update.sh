#!/bin/sh
cd `dirname $0`
git pull origin master
sh deploy.sh
