#!/bin/bash
set -x
set +e

sh autogen.sh

# PhyML builds different binaries depending on configure flags.
# We build
#   - phyml
#   - phyml-mpi
#   - phyml-beagle
# but not
#   - phyrex
#   - phytime

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig"

for binary in beagle mpi phyml; do
    ./configure \
	--disable-dependency-tracking \
	--prefix $PREFIX \
	--disable-debug \
	--enable-$binary
    make -j$CPU_COUNT
    make check
    make install
    make clean
done


