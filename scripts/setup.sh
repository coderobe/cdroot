#!/usr/bin/env bash

set -e

cd build

if [ "$(../checkdeps.sh arch-chroot | grep -o missing)" == missing ]
  then
    echo "you need arch-chroot (arch-install-scripts) to finish the setup" >&2
    exit 1
fi

sudo arch-chroot rootfs sh -c "pacman-key --init"
sudo arch-chroot rootfs sh -c "pacman-key --populate archlinux"
sudo arch-chroot rootfs sh -c "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
sudo arch-chroot rootfs sh -c "pacman -Syyu --noconfirm"

cat <<EOF > launch
#!/usr/bin/env bash
set -e
rootfs/bin/proot -V
rootfs/bin/proot -v 0 -S rootfs bash
EOF

chmod +x launch

sudo tar czf ../cdroot.tar.gz launch rootfs

echo "successfully packaged cdroot as cdroot.tar.gz"
