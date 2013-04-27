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
# $Log: RUN_SOME.sh,v $
# Revision 1.4  1998/10/19 13:27:58  jont
# [Bug #70203]
# Modify for new argument passing mechanism
#
# Revision 1.3  1998/08/06  15:21:26  jont
# [Bug #70148]
# Handle case when MLWORKS_PERVASIVE or MLWORKS_SRC_PATH are unset properly
#
# Revision 1.2  1998/06/08  10:25:59  jont
# [Bug #70127]
# Allow source parameter to be given as a relative path
#
# Revision 1.1  1998/05/28  15:34:21  jont
# new unit
# Adding scripts to run applications/tests into hope
#
#

SRC=/u/sml/MLW/src
ARCH=SPARC/Solaris
DIR=
IMAGE=

while [ $# -gt 0 ]
do
  case $1 in
    -src) shift ; SRC=$1 ; shift ;;
    -arch) shift ; ARCH=$1 ; shift ;;
    -dir) shift ; DIR="$1 $DIR"; shift ;;
    -image) shift ; IMAGE=$1 ; shift ;;
    *) echo "unknown parameter $1: use -src, -dir or -arch"; exit 1 ;;
  esac
done

HERE=`pwd`
cd $SRC
SRC=`pwd`
cd $HERE
if [ -z "$IMAGE" ]; then
  MLWORKS="$SRC/rts/runtime-g -MLWpass MLWargs -batch -load $SRC/images/$ARCH/guib.img MLWargs -tty -no-init"
else
  MLWORKS="$SRC/rts/runtime-g -MLWpass MLWargs -batch -load $IMAGE MLWargs -tty -no-init"
fi
if [ -z "$MLWORKS_PERVASIVE" ] ; then
  MLWORKS_PERVASIVE=$SRC/pervasive;export MLWORKS_PERVASIVE
fi
for dir in $DIR
do
  ( 
    if [ -z "$MLWORKS_SRC_PATH" ] ; then
      MLWORKS_SRC_PATH=$dir;export MLWORKS_SRC_PATH
    else
      MLWORKS_SRC_PATH=.:$MLWORKS_SRC_PATH;export MLWORKS_SRC_PATH
    fi
    (echo "OS.FileSys.chDir\"$dir\";";cat $dir/load.sml ) | $MLWORKS
  )
done
