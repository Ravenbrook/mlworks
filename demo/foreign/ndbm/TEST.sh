#!/bin/sh
#
# Copyright 1997 The Harlequin Group Limited.  All rights reserved.
# 
# This file is deliberatly UNIXocentric since the ndbm test doesn't run
# under Win32 -- it could, it is just that no effort has been put into 
# gettting a win32 version of ndbm.
#
# Revision Log
# ------------
# $Log: TEST.sh,v $
# Revision 1.4  1998/10/26 18:10:16  jkbrook
# [Bug #70184]
# Update for projects
#
# Revision 1.3  1998/01/27  17:38:05  jkbrook
# [Bug #70047]
# Shouldn't print `dumped ok' if executable delivery fails
#
# Revision 1.2  1997/07/10  15:13:04  stephenb
# [Bug #50016]
# Ensure that setting LD_LIBRARY_PATH takes notice of any previous
# LD_LIBRARY_PATH setting rather than unconditionally setting it to .
#
# Revision 1.1  1997/05/13  13:02:26  stephenb
# new unit
# [Bug #20035]
#
#
mlw_src=${1:-../../../src}
mlw_rts=${mlw_src}/rts/bin/$ARCH/$OS/main
mlw_image=${mlw_src}/images/$ARCH/$OS/gui.img
mlw_pervasive=${mlw_src}/pervasive
mlw_include=${mlw_src}/rts/src
mlw_db_name=$ARCH.$OS.db
LD_LIBRARY_PATH=.${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

case $OS in
  SunOS) mlw_src_path=SunOS:.:${mlw_src} ;;
  *) mlw_src_path=.:${mlw_src} ;;
esac


#
# Make sure the script cleans up after itself.
#

trap "{ rm -f ${mlw_db_name}.* phones; make -s -f Makefile.${OS} clean; }" 0 1


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
# Create a .sml file for the current configuration
#

rm -f TEST.sml
sed -e "s?ARCH_OS?$ARCH/$OS?" TEST.sml.in > TEST.sml

#
# Load in the phones code and dump an executable ...
#

if { ${mlw_rts} -MLWpass args -c 15 -batch -load ${mlw_image} args -silent -tty -pervasive-dir ${mlw_pervasive} < TEST.sml  1>/dev/null 2>&1 && test -f ./phones ; }
then
  echo "dump ok"
else
  echo "dump failed"
  exit 1
fi


rm -f ${mlw_db_name}.*

#
# Run some tests ...
#
./phones -c phones.dat ${mlw_db_name};
./phones -d ${mlw_db_name};
./phones -l jon ${mlw_db_name};

