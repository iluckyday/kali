#!/bin/bash
set -e

apt-get update

wget https://http.kali.org/pool/main/k/kali-archive-keyring/kali-archive-keyring_2018.2_all.deb
wget https://archive.kali.org/kali/pool/main/l/live-build/live-build_20191221_all.deb
dpkg -i kali-archive-keyring_2018.2_all.deb
dpkg -i live-build_20190311_all.deb

apt-get install -y live-build

cd /usr/share/debootstrap/scripts/
echo "default_mirror http://http.kali.org/kali"; sed -e "s/debian-archive-keyring.gpg/kali-archive-keyring.gpg/g" sid > /tmp/kali
mv /tmp/kali .
ln -s kali kali-rolling

cd ~
git clone --depth=1 https://gitlab.com/kalilinux/build-scripts/live-build-config.git
cd live-build-config
./build.sh --variant minimal --verbose
ls -lh images
exit 1

d=$(date "+%Y%m%d")
cp output/images/rootfs.iso9660 /dev/shm/kali-$d.iso
ls -lh /dev/shm/kali-$d.iso
