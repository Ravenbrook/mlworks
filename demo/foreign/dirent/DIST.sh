#! /bin/sh 
#
# Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
#
# Copy all the user visible files to a new directory
#
# Usage: DIST.sh dist-dir [ OS ARCH ]
#
# Example:
#
#  $ DIST.sh /u/sml/distributions/test/examples/foreign/ls
#
# Revision Log
# ------------
# $Log: DIST.sh,v $
# Revision 1.1  1997/06/30 15:34:58  stephenb
# new unit
# ** No reason given. **
#


dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

rm -rf $dist_dir
mkdir $dist_dir

../../../tools/remove_log.sh < Makefile.${OS} > $dist_dir/Makefile
cat README.txt > $dist_dir/README

for file in __dirent.sml __dirent_stub.sml __ls.sml dirent.sml dirent_stub.c
do
  ../../../tools/remove_log.sh < $file > $dist_dir/`basename $file`
done
