#!/bin/bash
set -e

apt-get update
apt-get install -y live-build

git clone --depth=1 https://gitlab.com/kalilinux/build-scripts/live-build-config.git
cd live-build-config
./build.sh --variant --verbose
ls -lh images
exit 1

d=$(date "+%Y%m%d")
cp output/images/rootfs.iso9660 /dev/shm/kali-$d.iso
ls -lh /dev/shm/kali-$d.iso
