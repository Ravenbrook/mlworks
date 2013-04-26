#!/bin/sh
#
# Removes all lines between "Revision Log" or $Log
# and the end of an SML or C comment,
# preserving the end of comment itself.
#
# Can also be used on files that use a # to start lines of comments
# as long as the convention that the end of the comment is marked
# by a blank line is used.
#
# Used in removed logs from demo files, for example.
#
# $Log: remove_log.sh,v $
# Revision 1.5  1997/06/17 18:11:14  daveb
# [Bug #50007]
# Removed part of merge message erroneously left in previous change.
#
# Revision 1.4  1997/06/13  17:01:13  jkbrook
# [Bug #50007]
# Merging changes from 1.0r2c2 into 2.0m0
#
# Revision 1.2.4.2  1997/06/09  15:40:56  daveb
# [Bug #50007]
# Merging in changes from trunk to handle shell type comments.
#
# Revision 1.3  1997/05/14  10:13:59  stephenb
# [Bug #30121]
# Extend to cope with files (Makefiles primarily) that use #
# to mark comments and which do so using a particular style.
#
# Revision 1.2  1996/11/11  16:11:49  jont
# Detect log from $Log.
# Deal with C logs as well as ML ones.
#
# Revision 1.1  1996/08/19  13:58:39  daveb
# new unit
# Shell script to remove logs from demo files.
#
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

awk 'BEGIN {inlog = "no"}
     $0 ~ /[Rr][Ee][Vv][Ii][Ss][Ii][Oo][Nn] [Ll][Oo][Gg]/  {
	    inlog = "yes"
	    next
     }
     $0 ~ /\$Log/  {
	    inlog = "yes"
	    next
     }
     $0 ~ /\*\)/  {
	if (inlog == "yes") {
	   inlog = "no"
	}
     }
     /^#/ {
       in_hash_comment= 1;

     }
     /^$/ {
       if (in_hash_comment) {
         in_hash_comment= 0;
         inlog= "no"
       }
     }
     $0 ~ /\*\//  {
	if (inlog == "yes") {
	   inlog = "no"
	}
     }
     inlog != "yes" { print $0 }'
