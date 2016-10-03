#!/usr/bin/env bash

set -e
cd working

if [ $(../checkdeps.sh curl | grep -o installed) == installed ]
  then
    curl "https://mirror.rackspace.com/archlinux/iso/latest/arch/x86_64/airootfs.md5" -o md5
    curl "https://mirror.rackspace.com/archlinux/iso/latest/arch/x86_64/airootfs.sfs" -o sfs
  else
    if [ $(../checkdeps.sh wget | grep -o installed) == installed ]
      then
        wget "https://mirror.rackspace.com/archlinux/iso/latest/arch/x86_64/airootfs.md5" -O md5
        wget "https://mirror.rackspace.com/archlinux/iso/latest/arch/x86_64/airootfs.sfs" -O sfs
      else
        echo "curl or wget is required to continue" >&2
        exit 1
    fi
fi
