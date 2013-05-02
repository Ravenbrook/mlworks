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
