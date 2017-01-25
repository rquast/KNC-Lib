#!/bin/bash

# Build Systems #
SRC=$PWD
cd $SRC && git rev-parse HEAD

# Incremental Build #
INCREMENTDISABLE=TRUE

# Dual Build #
#XEONX64BUILD=TRUE
XEONPHIBUILD=TRUE


if test ${XEONPHIBUILD+defined}; then

# XEON PHI Build #
echo "XEON PHI Build"
BUILDTREE=$SRC/build-mic
MPSSDIR=/home/mpss-3.7

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
-DCMAKE_INSTALL_PREFIX=$SRC/../install-mic/freetype2 \
$SRC/
cd $BUILDTREE && make -j12 install VERBOSE=1

mkdir -p $SRC/../install-mic/freetype2/lib/pkgconfig
cp $SRC/freetype2.pc $SRC/../install-mic/freetype2/lib/pkgconfig/

fi

if test ${XEONX64BUILD+defined}; then

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

cd $BUILDTREE \
&& CC=icc CXX=icpc \
CXXFLAGS="-fPIC" \
cmake3 \
-DCMAKE_INSTALL_PREFIX=$SRC/install-x64 \
$SRC/
cd $BUILDTREE && make install VERBOSE=1

fi

