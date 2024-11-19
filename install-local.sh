#!/bin/bash

grep VERSION_ID /etc/os-release | grep 24.04 || exit

TMPDIR=$(mktemp -d)
cd $TMPDIR
wget https://cdn.localwp.com/stable/latest/deb -O local-orig.deb
fakeroot bash -c 'dpkg-deb -R local-orig.deb workingdir; sed -i 's/libaio1/libaio1t64/g' workingdir/DEBIAN/control; sed -i 's/libncurses5/libncurses6/g' workingdir/DEBIAN/control; dpkg-deb -b workingdir local-fixed.deb'
pkexec apt install $TMPDIR/local-fixed.deb
rm -rf $TMPDIR
