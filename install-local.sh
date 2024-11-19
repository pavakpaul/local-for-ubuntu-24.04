#!/bin/bash

echo "checking if Ubuntu 24.04"
grep VERSION_ID /etc/os-release | grep 24.04 || exit

TMPDIR=$(mktemp -d)
cd $TMPDIR
echo "Downloading Local..."
wget https://cdn.localwp.com/stable/latest/deb -O local-orig.deb
echo "Replacing dependancies..."
fakeroot bash -c 'dpkg-deb -R local-orig.deb workingdir; sed -i 's/libaio1/libaio1t64/g' workingdir/DEBIAN/control; sed -i 's/libncurses5/libncurses6/g' workingdir/DEBIAN/control; dpkg-deb -b workingdir local-fixed.deb'
echo "Installing Local..."
pkexec apt install $TMPDIR/local-fixed.deb
echo "Removing temporary files..."
rm -rf $TMPDIR

echo "Creating symbolic links to resolve dependancies"
pkexec ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1
pkexec ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6.4 /usr/lib/x86_64-linux-gnu/libncurses.so.5
pkexec ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5
