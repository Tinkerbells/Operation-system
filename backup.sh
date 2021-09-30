#!/usr/bin/bash
dir=$(pwd)
for entry in "$dir"/*
do
	filename=$(basename "$entry")
        ext="${filename##*.}"
  if [ "$ext" != "bak" ]
	then 
	cp "$entry" "$entry".bak
  fi
done
