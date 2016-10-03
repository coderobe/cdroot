#!/usr/bin/env bash

ERR=0

seterr () {
  ERR=1
}

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
      seterr
  fi
}

bulkcheck () {
  for dep in $@
    do echo -e "$(depcheck $dep)"
  done
}

if [ -n "$1" ]
  then echo -e "$(bulkcheck $@)"
  else echo -e "$(bulkcheck $(cat Makedepends))"
fi

exit $ERR
