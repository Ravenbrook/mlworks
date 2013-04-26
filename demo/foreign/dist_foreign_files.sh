#!/bin/sh
#
# Copyright 1997 The Harlequin Group Limited.  All rights reserved.
#
# Distribute the foreign examples.  Expects the directory that will
# contain all the foreign examples as an argument.
#
# Usage: dist_foreign_files.sh dist-dir [ OS ARCH ]
#
# Example:
#
# To distribute all the files to /u/sml/distributions/examples/foreign :-
#
#   $ ./dist_foreign_files.sh /u/sml/distributions/examples/foreign
#
# Revision Log
# ------------
# $Log: dist_foreign_files.sh,v $
# Revision 1.1  1997/05/21 13:02:07  stephenb
# new unit
# [Bug #30121]
#

dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

if { ./platform_win32.sh ; }
then
  readme_type="win32"
  readme_ext=".TXT"
else
  readme_type="unix"
  readme_ext=""
fi

cat README.dist README.${readme_type} > $dist_dir/README${readme_ext}

for dist_script in */DIST.sh
do
  example_dir=`dirname $dist_script`
  $example_dir/PLATFORM.sh && ( cd $example_dir && ./DIST.sh $dist_dir/$example_dir $OS $ARCH )
done


#
# The following is needed because if the last example to be tested
# is not meant to be included in the distribution, then the script
# would return failure.
#
exit 0
