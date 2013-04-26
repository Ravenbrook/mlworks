#!/bin/sh
#
# Copyright 1997 The Harlequin Group Limited.  All rights reserved.
#
# Make the TEST.ans files for all appropriate tests.
#
# Usage: make_foreign_answers.sh [ MLWorks-src-dir ]
#
# Example:
#
# Make all the test answers :-
#
#   $ ./make_foreign_answers.sh
#
# Make all the test answers using the runtime, images ... etc. in 
# /u/sml/MLW/src :-
#
#   $ ./make_foreign_answer.sh add /u/sml/MLW/src
#
# Revision Log
# ------------
# $Log: make_foreign_answers.sh,v $
# Revision 1.1  1997/05/14 11:37:32  stephenb
# new unit
# [Bug #20035]
#


src_dir=$1

for test_script in */TEST.sh
do
  test_dir=`dirname $test_script`
  $test_dir/PLATFORM.sh && ./make_foreign_answer.sh $test_dir $src_dir
done
