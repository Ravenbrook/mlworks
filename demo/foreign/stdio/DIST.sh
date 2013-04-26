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
#  $ DIST.sh /u/sml/distributions/test/examples/foreign/stdio
#
# Revision Log
# ------------
# $Log: DIST.sh,v $
# Revision 1.1  1997/06/30 15:34:19  stephenb
# new unit
# ** No reason given. **
#
#

dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

rm -rf $dist_dir
mkdir $dist_dir

if { ../platform_win32.sh; }
then
  readme_ext=".TXT"
  os_kind=win32
else
  readme_ext=""
  os_kind=unix
fi


cat README.txt README.${os_kind} > $dist_dir/README${readme_ext}

for file in __cub.sml __kitten.sml $flags
do
  ../../../tools/remove_log.sh < $file > $dist_dir/`basename $file`
done
