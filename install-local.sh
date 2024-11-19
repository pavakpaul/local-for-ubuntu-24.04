#!/bin/bash

echo "Checking OS compatibility"
grep VERSION_ID /etc/os-release | grep 24.04 || echo "This script is only meant for Ubuntu 24.04 LTS"; exit

TMPDIR=$(mktemp -d)
cd $TMPDIR
echo "Downloading original debfile"
wget https://cdn.localwp.com/stable/latest/deb -O local-orig.deb
echo "Patching deb file"
fakeroot bash -c 'dpkg-deb -R local-orig.deb workingdir; sed -i 's/libaio1/libaio1t64/g' workingdir/DEBIAN/control; sed -i 's/libncurses5/libncurses6/g' workingdir/DEBIAN/control; dpkg-deb -b workingdir local-fixed.deb'
echo "Installing patched debfile and creating necessary symlinks"
pkexec bash -c "apt install -y $TMPDIR/local-fixed.deb && ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1 && ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6.4 /usr/lib/x86_64-linux-gnu/libncurses.so.5 && ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5"
echo "Removing artifacts"
rm -rf $TMPDIR
