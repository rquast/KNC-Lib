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

SYSROOT=/home/mpss-3.8.1/k1om
MPSSDIR=$SYSROOT

# Build k1om #
cd $BUILDTREE \
&& CC=icc CXX=icpc \
CXXFLAGS="-g -O3 -fPIC -mmic" \
CFLAGS="-g -O3 -fPIC -mmic" \
cmake3 \
-DCMAKE_SYSTEM_NAME=Linux \
-DCMAKE_SYSTEM_PROCESSOR=k1om \
-DCMAKE_FIND_ROOT_PATH=$MPSSDIR \
-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
-DCMAKE_INSTALL_PREFIX=$SRC/../install-mic/gsl \
-C$SRC/TryRunResults-mic.cmake \
$SRC/
cd $BUILDTREE && make -j12 install VERBOSE=1

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

