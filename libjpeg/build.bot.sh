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

# Build k1om #
cd $BUILDTREE \
&& $SRC/configure CC=icc CXX=icpc \
CXXFLAGS="-g -O3 -fPIC -mmic" \
CFLAGS="-g -O3 -fPIC -mmic" \
LDFLAGS="-mmic" \
--host=x86_64 \
--prefix $SRC/../install-mic/libjpeg
cd $BUILDTREE && \
make -j12

mkdir -p $SRC/../install-mic/libjpeg/lib
mkdir -p $SRC/../install-mic/libjpeg/bin
mkdir -p $SRC/../install-mic/libjpeg/include
mkdir -p $SRC/../install-mic/libjpeg/man/man1
make install 
cp -rf $BUILDTREE/libjpeg.a $SRC/../install-mic/libjpeg/lib
cp -rf $SRC/*.h $SRC/../install-mic/libjpeg/include

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

