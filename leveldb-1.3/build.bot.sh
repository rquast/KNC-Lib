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
cd $SRC \
&& make CC="icc" CXX="icpc" \
INSTALL_PATH=$BUILDTREE
mv $SRC/libleveldb.a $BUILDTREE
mv $SRC/libleveldb.so $BUILDTREE
mv $SRC/libleveldb.so.1 $BUILDTREE
mv $SRC/libleveldb.so.1.3 $BUILDTREE

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
cd $SRC \
&& make CC="icc -mmic -fPIC" CXX="icpc -mmic -fPIC" \
LDFLAGS="-mmic" \
INSTALL_PATH=$BUILDTREE
mv $SRC/libleveldb.a $BUILDTREE
mv $SRC/libleveldb.so $BUILDTREE
mv $SRC/libleveldb.so.1 $BUILDTREE
mv $SRC/libleveldb.so.1.3 $BUILDTREE

