#!/bin/bash

if [ ! "$PalmPDK" ];then
PalmPDK=/opt/PalmPDK
fi

###################################
### List your source files here ###
### SRC="<source1> <source2>"  ###
###################################
SRC="downloader.c"

###################################
### Name your output executable ###
### OUTFILE="<executable-name>"###
###################################
OUTFILE="downloader"


###################################
######## Do not edit below ########
###################################
PATH=$PATH:${PalmPDK}/arm-gcc/bin

CC="arm-none-linux-gnueabi-gcc"

SYSROOT="${PalmPDK}/arm-gcc/sysroot"

CURLDIR="curl-arm-build"
INCLUDEDIR="${PalmPDK}/include"
LIBDIR="${PalmPDK}/device/lib"

CPPFLAGS="-I${CURLDIR}/include  -I${INCLUDEDIR} -I${INCLUDEDIR}/SDL --sysroot=$SYSROOT"
LDFLAGS="-L${LIBDIR} -L${CURLDIR}/lib -Wl,--allow-shlib-undefined"
LIBS="-lSDL -lpdl -lcurl -lGLES_CM"

###################################

if [ "$SRC" == "" ];then
	echo "Source files not specified. Please edit the SRC variable inside this script."
	exit 1
fi

if [ "$OUTFILE" == "" ];then
	echo "Output file name not specified. Please edit the OUTFILE variable inside this script."
	exit 1
fi

$CC $CPPFLAGS $LDFLAGS $LIBS -o $OUTFILE $SRC

