#!/usr/bin/bash
target=""

if [ ! -d ~/trash ]; then
  mkdir ~/trash
fi

while getopts ":helr:" opt; do
  case ${opt} in
  h)
    echo "Options:"
    echo "	-h		Display this help message."
    echo "	-e		Empty trash"
    echo "	-l		List of contents"
    echo "	-r		FILENAME restore the specified FILENAME to FOLDER (default ./)"
    exit 0
    ;;

  e)
    rm ~/trash/*
    ;;

  l)
    cd ~/trash && ls
    ;;

  r)
    filename=$2
    foldername=$3
    if [ -n "$foldername" ]; then
      mv ~/trash/"$filename" "$foldername"
    elif [ -n "$filename" ]; then
      mv ~/trash/"$filename" ./
    else
      echo "Invalid Option, check -h"
    fi
    ;;
  \?)
    echo "Invalid Option: -$OPTARG" 1>&2
    ;;
  esac
done
shift $((OPTIND - 1))
for arg in "${@:OPTIND}"; do
  count_of_files=$(ls | wc -l)
  if [ ! -f ~/trash/${arg} ]; then
    mv "./${arg}" ~/trash
  else
    name=$arg
    while [ -f ~/trash/$name ]; do
      counter=$(($counter + 1))
      name=$arg${counter}
    done
    mv ./"$arg" ~/trash/"$name"
  fi
done
shift $((OPTIND - 1))
