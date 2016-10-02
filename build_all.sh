#!/bin/bash

KNC_LIB=$PWD
echo $KNC_LIB

# TODO:
# add additional KNC-LIBS
# boost_1_60_0
# microhttpd-0.9.28
# gmp-6.1.0
# json-rpc-cpp-0.5.0 < -requires microhttpd

#cd $KNC_LIB/gmp-6.1.0/ && \
#sh $KNC_LIB/gmp-6.1.0/build.bot.log.sh
#cd $KNC_LIB/boost_1_60_0/ && \
#sh $KNC_LIB/boost_1_60_0/build.bot.log.sh
cd $KNC_LIB/leveldb-1.3/ && \
sh $KNC_LIB/leveldb-1.3/build.bot.log.sh
cd $KNC_LIB/jsoncpp-1.6.2 && \
sh $KNC_LIB/jsoncpp-1.6.2/build.bot.log.sh
cd $KNC_LIB/cryptopp-5.6.2/ && \
sh $KNC_LIB/cryptopp-5.6.2/build.bot.log.sh
#cd $KNC_LIB/microhttpd-0.9.28/ && \
#sh $KNC_LIB/microhttpd-0.9.28/build.bot.log.sh
#cd $KNC_LIB/json-rpc-cpp-0.5.0/ && \
#sh $KNC_LIB/json-rpc-cpp-0.5.0/build.bot.log.sh
cd $KNC_LIB/szip-2.1/ && \
sh $KNC_LIB/szip-2.1/build.bot.log.sh
cd $KNC_LIB/zlib-1.2.8/ && \
sh $KNC_LIB/zlib-1.2.8/build.bot.log.sh
cd $KNC_LIB/freetype2/ && \
sh $KNC_LIB/freetype2/build.bot.log.sh
cd $KNC_LIB/libpng/ && \
sh $KNC_LIB/libpng/build.bot.log.sh
cd $KNC_LIB/pcre/ && \
sh $KNC_LIB/pcre/build.bot.log.sh
cd $KNC_LIB/gsl/ && \
sh $KNC_LIB/gsl/build.bot.log.sh
cd $KNC_LIB/libjpeg/ && \
sh $KNC_LIB/libjpeg/build.bot.log.sh
cd $KNC_LIB/qt5/ && \
sh $KNC_LIB/qt5/build.bot.log.sh



