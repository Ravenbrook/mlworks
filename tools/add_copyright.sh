#!/bin/sh
#
# $Log: add_copyright.sh,v $
# Revision 1.4  1997/06/13 13:59:27  daveb
# [Bug #30152]
# Corrected copyright message.
#
# Revision 1.3  1997/04/04  09:46:13  andreww
# [Bug #2021]
# Automatically determine the year field in the copyright string.
#
# Revision 1.2  1996/06/14  12:08:47  jont
# More work on getting this right for NT
#
# Revision 1.1  1996/06/06  11:37:28  jont
# new unit
# For the distribution mechanism only, to add copyright headers to distributed source
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
YEAR=`date | sed 's/.* //'`
if [ "$OS" = "Windows_NT" -o "$OS" = "NT" -o "$OS" = "Win95" ]
then
  PATH="$PATH;C:/usr/local/bin";export PATH
else
  SML=/u/sml/MLW; export SML
  PATH=$SML/tools:$PATH; export PATH
fi
if [ $# -ne 1 ]
then
  echo $#
  exit 1
fi
echo "(* $1"
echo " * Copyright (C)" $YEAR "The Harlequin Group Limited.  All rights reserved."
echo " *)"
foo="`dirname $0`"
export foo
if [ "$foo" = "" ]
then
  remove_src_hdr.sh < $1
else
  $foo/remove_src_hdr.sh < $1
fi

