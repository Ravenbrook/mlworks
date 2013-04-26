#!/bin/sh
#
# Copy all the user visible files to a new directory
#
# Usage: DIST.sh dist-dir [ OS ARCH ]
#
# Example:
#
#  $ DIST.sh /u/sml/distributions/test/samples/foreign/add
#
# Revision Log
# ------------
# $Log: DIST.sh,v $
# Revision 1.2  1997/07/03 09:03:57  stephenb
# [Bug #30029]
# Ensure that add_stub.c is distributed.
#
# Revision 1.1  1997/05/21  13:00:36  stephenb
# new unit
# [Bug #30121]
#

dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

# Remove the directory if it is already there.
# This is used in preference to the more obvious
#
#  rm -rf $dist_dir
#
# because this seems to take an age under NT whereas the following
# is much quicker.
#
( cd `dirname $dist_dir` && rm -rf add )

mkdir $dist_dir

if { ../platform_win32.sh; }
then
  readme_ext=".TXT"
  sub_dir=Win32
  make_type=Win32
else
  readme_ext=""
  sub_dir=Unix
  make_type=$OS
fi

../../../tools/remove_log.sh < Makefile.${make_type} > $dist_dir/Makefile
cat README.txt > $dist_dir/README$readme_ext

for file in __add.sml add.c add.h add_stub.c add.sml $sub_dir/*.sml
do
  ../../../tools/remove_log.sh < $file > $dist_dir/`basename $file`
done
