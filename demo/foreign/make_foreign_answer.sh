#!/bin/sh
#
# Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
#
# Make the TEST.ans file for a given test.
#
# Usage: make_foreign_answer.sh [ test-dir ] [ MLWorks-src-dir ]
#
# Example:
#
# Make an answer for the ndbm test :-
#
#   $ ./make_foreign_answer.sh ndbm
#
# Make an answer for the add test using the runtime, images ... etc. in 
# /u/sml/MLW/src :-
#
#   $ ./make_foreign_answer.sh add /u/sml/MLW/src
#
# Revision Log
# ------------
# $Log: make_foreign_answer.sh,v $
# Revision 1.2  1997/07/01 10:58:36  stephenb
# [Bug #30029]
# Add a ";" to the "then" part of the final if test.
#
# Revision 1.1  1997/05/13  11:51:24  stephenb
# new unit
# [Bug #20035]
#

test_dir=$1
src_dir=$2
cd $test_dir
answer_file=TEST.ans

if test -f $answer_file -a ! -w $answer_file
then
  echo $test_dir: answer already exists but is not writable.
  exit 1
fi

if { ./TEST.sh $src_dir > $answer_file 2>&1; }
then
  :
else
  echo $test_dir: problem generating output
  exit 1
fi
