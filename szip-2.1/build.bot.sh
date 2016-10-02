#!/bin/bash

# Build Systems #
SRC=$PWD
cd $SRC && git rev-parse HEAD

# Incremental Build #
INCREMENTDISABLE=TRUE


BUILDTREE=$SRC/build

# Clean Build Tree #
if test ${INCREMENTDISABLE+defined}; then
echo "Incremental Build disabled"
rm -rf $BUILDTREE
else
echo "Incremental Build enabled"
fi
mkdir -p $BUILDTREE

# Build #
cd $SRC && \
CC=icc \
CXX=icpc \
FC=ifort \
CFLAGS='-O3 -mmic -ip' \
CXXFLAGS='-O3 -mmic -ip' \
FCFLAGS='-O3 -mmic -ip' \
./configure --host=x86_64 --prefix=$BUILDTREE
cd $SRC && \
make

cd $SRC && \
make install
