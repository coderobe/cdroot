#!/usr/bin/env bash

set -e
cd working

if [ "$(md5sum sfs | cut -d' ' -f1)" == "$(cat md5 | cut -d' ' -f1)" ]
  then
    if [ "$(../checkdeps.sh unsquashfs | grep -o missing)" == missing ]
      then
        echo "unsquashfs (squashfs-tools) is required to continue" >&2
        exit 1
    fi
    unsquashfs -user-xattrs -d ../build/rootfs sfs
    rm sfs
    rm md5
  else
    echo -e "downloading the rootfs failed: md5 mismatch\nplease try again" >&2
    exit 1
fi
