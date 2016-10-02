#!/bin/bash

# Build Systems #
SRC=$PWD
cd $SRC && git rev-parse HEAD

# Incremental Build #
INCREMENTDISABLE=TRUE

# XEON PHI Build #
echo "XEON PHI Build"
BUILDTREE=$SRC/build-mic

# Clean Build Tree #
if test ${INCREMENTDISABLE+defined}; then
echo "Incremental Build disabled"
rm -rf $BUILDTREE
else
echo "Incremental Build enabled"
fi
mkdir -p $BUILDTREE

SYSROOT=/home/mpss-3.7/k1om
MPSSDIR=$SYSROOT

# Build k1om #
cd $BUILDTREE \
&& CC=icc CXX=icpc \
CXXFLAGS="-g -O2 -fPIC -mmic" \
CFLAGS="-g -O2 -fPIC -mmic" \
cmake3 \
-DCMAKE_SYSTEM_NAME=Linux \
-DCMAKE_SYSTEM_PROCESSOR=k1om \
-DCMAKE_FIND_ROOT_PATH=$MPSSDIR \
-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
-DCMAKE_INSTALL_PREFIX=$SRC/install-mic \
-DBUILD_SHARED_LIBS=ON \
$SRC/
cd $BUILDTREE && make install VERBOSE=1

exit
cd $BUILDTREE && $SRC/configure \
--enable-shared \
LDFLAGS="-L${SYSROOT}/usr/lib64/" \
CC=icc CFLAGS="-mmic -fPIC -I${SYSROOT}/usr/include/" \
CPPFLAGS="-mmic -fPIC -I${SYSROOT}/usr/include/" \
--host=x86_64 --prefix $BUILDTREE
cd $BUILDTREE && make install

# XEON x64 Build #
BUILDTREE=$SRC/build

# Clean Build Tree #
if test ${INCREMENTDISABLE+defined}; then
echo "Incremental Build disabled"
rm -rf $BUILDTREE
else
echo "Incremental Build enabled"
fi
mkdir -p $BUILDTREE

# Build x64 #
cd $BUILDTREE && $SRC/configure CC=icc CFLAGS="-fPIC" \
--host=x86_64 --disable-assembly --prefix $BUILDTREE
cd $BUILDTREE && make install
