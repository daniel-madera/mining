#!/bin/bash

if [ $EUID -ne 0  ]; then
  echo "Not running as root"
  exit 2
fi

if [ -z $1 ]; then
  echo "Set script as parameter"
  exit 2
fi

file=$1

filename=$(basename "$file")
extension="${filename##*.}"
fn="${filename%.*}"

nohup $file > /var/log/mining/$fn.log 2>&1 &
