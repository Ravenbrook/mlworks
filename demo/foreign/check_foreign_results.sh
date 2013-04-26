#!/bin/sh
#
# Copyright 1997 The Harlequin Group Limited.  All rights reserved.
#
# Check the answers for all examples.
#
# Usage: check_foreign_results.sh [ MLWorks-src-dir ]
#
# Example:
#
# Checkk all the test answers :-
#
#   $ ./check_foreign_results.sh
#
# Check all the test answers using the runtime, images ... etc. in 
# /u/sml/MLW/src :-
#
#   $ ./check_foreign_results.sh add /u/sml/MLW/src
#
# Revision Log
# ------------
# $Log: check_foreign_results.sh,v $
# Revision 1.1  1997/05/14 10:36:46  stephenb
# new unit
# [Bug #20035]
#

src_dir=$1

for test_script in */TEST.sh
do
  test_dir=`dirname $test_script`
  $test_dir/PLATFORM.sh && ./check_foreign_result.sh $test_dir $src_dir
done
