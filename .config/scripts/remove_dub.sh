#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Error: No file specified" >&2
  exit 1
fi

if [ ! -f $1 ]; then
  echo "Error: File not found" >&2
  exit 1
fi

sort $1 | uniq >temp.txt
mv temp.txt $1
