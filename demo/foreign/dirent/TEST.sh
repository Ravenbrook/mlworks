#!/bin/sh
#
# Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
# 
# This file is deliberatly UNIXocentric since the ls test only runs under Unix.
#
# Revision Log
# ------------
# $Log: TEST.sh,v $
# Revision 1.3  1998/01/23 11:53:59  jkbrook
# [Bug #70047]
# Shouldn't print `dumped ok' if executable delivery fails
#
# Revision 1.2  1997/07/07  13:36:53  stephenb
# [Bug #30038]
# Remove any reference to "phones" (script was cut&paste from
# the ndbm example).
#
# Revision 1.1  1997/06/30  15:35:24  stephenb
# new unit
# ** No reason given. **
#


mlw_src=${1:-../../../src}
mlw_rts=${mlw_src}/rts/bin/$ARCH/$OS/main
mlw_image=${mlw_src}/images/$ARCH/$OS/gui.img
mlw_pervasive=${mlw_src}/pervasive
mlw_include=${mlw_src}/rts/src

LD_LIBRARY_PATH=.${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

mlw_src_path=.:${mlw_src}


#
# Make sure the script cleans up after itself.
#

trap "{ rm -rf simplels test-dir ; make -s -f Makefile.${OS} clean; }" 0 1


#
# Build the shared library ...
#

if { make -s -f Makefile.${OS} MLWORKS_INCLUDE=${mlw_include} clean all; }
then
  echo "make ok" 
else
  echo "make failed"
  exit 1
fi


#
# Load in the ls code and dump an executable ...
#

if { ${mlw_rts} -c 15 -batch -load ${mlw_image} -pass args -silent -tty -pervasive-dir ${mlw_pervasive} -source-path ${mlw_src_path} args < TEST.sml 1>/dev/null 2>&1 && test -f ./simplels; }
then
  echo "dump ok"
else
  echo "dump failed"
  exit 1
fi



#
# Run some tests ...
#
rm -rf test-dir
mkdir test-dir
touch test-dir/a
touch test-dir/b
touch test-dir/c

./simplels -pass args test-dir args
./simplels -pass args /doesnotexist args
