#!/bin/sh
#
# Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
