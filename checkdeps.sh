#!/usr/bin/env bash

red () {
  echo -e "\e[31m$1\e[0m"
}

green () {
  echo -e "\e[32m$1\e[0m"
}

depcheck () {
  echo -n "$1: "
  if [ $(whereis -b $1 | cut -d" " -f2 | rev | cut -d/ -f1 | rev) == $1 ]
    then
      echo -e "$(green installed)"
    else
      echo -e "$(red missing)"
  fi
}

for line in $(cat Makedepends)
  do echo $(depcheck $line)
done
