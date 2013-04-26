#!/bin/sh
#
# Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
#
# Check the answer for a given test.
#
# Usage: check_foreign_answer.sh [ test-dir ] [ MLWorks-src-dir ]
#
# Example:
#
# Check the ndbm test :-
#
#   $ ./check_foreign_result.sh ndbm
#
# Check the add test using the runtime, images ... etc. in /u/sml/MLW/src :-
#
#   $ ./check_foreign_result.sh add /u/sml/MLW/src
#
# Revision Log
# ------------
# $Log: check_foreign_result.sh,v $
# Revision 1.3  1997/07/01 10:58:55  stephenb
# [Bug #30038]
# Ensure that stderr is dumped to the output file since some of
# the tests do write to stderr.
#
# Revision 1.2  1997/05/15  09:49:31  stephenb
# [Bug #20035]
# Change from using cmp to diff since the former seems to have
# problems with the ^M that can appear in the output under Win32.
#
# Revision 1.1  1997/05/14  10:36:57  stephenb
# new unit
# [Bug #20035]
#


test_dir=$1
src_dir=$2

if { ./platform_win32.sh ; }
then
  mlw_null=NUL
else
  mlw_null=/dev/null
fi

cd $test_dir
output_file=TEST.out
answer_file=TEST.ans
if { ./TEST.sh $src_dir > $output_file 2>&1 ; }
then
  if test -f $answer_file
  then
    if { diff $answer_file $output_file > $mlw_null ; } 
    then
      rm -f $output_file
      exit 0
    else
      echo $test_dir output differs.
      exit 1
    fi
  else
    echo $test_dir: answer file missing
    exit 1
  fi
else
  echo $test_dir: problem generating output
  exit 1
fi
