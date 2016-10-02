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
&& $SRC/configure CC=icc CXX=icpc \
CXXFLAGS="-g -O2 -fPIC -mmic" \
CFLAGS="-g -O2 -fPIC -mmic" \
LDFLAGS="-mmic" \
--host=x86_64 \
--prefix $BUILDTREE
cd $BUILDTREE && \
make -j12

exit
#TODO

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

