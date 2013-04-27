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
# $Log: TIME_ALL.sh,v $
# Revision 1.2  1998/10/19 14:00:57  jont
# [Bug #70203]
# Modify for new argument passing mechanism
#
# Revision 1.1  1998/05/28  15:08:22  jont
# new unit
# Adding scripts to run applications/tests into hope
#
#

dirs=`cat dirs`

SRC=/u/sml/MLW/src
ARCH=SPARC/Solaris

while [ $# -gt 0 ]
do
  case $1 in
    -src) shift ; SRC=$1 ; shift ;;
    -arch) shift ; ARCH=$1 ; shift ;;
    *) echo "unknown parameter $1: use -src or -arch"; exit 1 ;;
  esac
done

for dir in $dirs; do
  echo Timing $dir
  STATUS=0
  time RUN_SOME -dir $dir -src $SRC -arch $ARCH 1>/dev/null 2>1 || STATUS=1
  if [ STATUS -eq 1 ]; then
    echo $dir failed
  fi
done
