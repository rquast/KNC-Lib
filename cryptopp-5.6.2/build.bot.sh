#!/bin/bash

# Build Systems #
SRC=$PWD
cd $SRC && git rev-parse HEAD

# Incremental Build #
INCREMENTDISABLE=TRUE

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
cd $SRC \
&& make clean
cd $SRC && \
CC=icc CXX=icpc \
CXXFLAGS="-fPIC" \
PREFIX=$BUILDTREE \
make
cd $SRC && PREFIX=$BUILDTREE make install

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
cd $SRC \
&& make clean
cd $SRC && \
CC=icc CXX=icpc \
CFLAGS="-mmic" \
LDFLAGS="-mmic" \
CXXFLAGS="-std=c++11 -mmic -DCRYPTOPP_DISABLE_ASM -DCRYPTOPP_DISABLE_SSE2 -DCRYPTOPP_DISABLE_SSSE3 -fPIC" \
PREFIX=$BUILDTREE \
make
cd $SRC && PREFIX=$BUILDTREE make install
