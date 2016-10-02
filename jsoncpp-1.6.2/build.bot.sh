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
cd $BUILDTREE \
&& CC=icc CXX=icpc \
CXXFLAGS="-fPIC" \
cmake \
-DJSONCPP_WITH_TESTS=OFF \
-DCMAKE_BUILD_TYPE=debug \
-DJSONCPP_LIB_BUILD_STATIC=ON \
-DJSONCPP_LIB_BUILD_SHARED=OFF \
-G "Unix Makefiles" $SRC
cd $BUILDTREE && make

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
&& CC=icc CXX=icpc \
CFLAGS="-mmic" CXXFLAGS="-mmic -fPIC" \
cmake \
-DJSONCPP_WITH_TESTS=OFF \
-DCMAKE_BUILD_TYPE=debug \
-DJSONCPP_LIB_BUILD_STATIC=ON \
-DJSONCPP_LIB_BUILD_SHARED=OFF \
-G "Unix Makefiles" $SRC
cd $BUILDTREE && make
