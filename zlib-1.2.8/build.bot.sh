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
CC=icc CFLAGS="-mmic" \
LDFLAGS="-mmic -limf -lsvml -lirng -lintlc" \
CHOST=x86_64 ./configure --shared

cd $SRC && \
make

cd $SRC && \
make install prefix=$BUILDTREE
