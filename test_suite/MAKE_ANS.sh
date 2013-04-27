#!/bin/sh
# 
# $Log: MAKE_ANS.sh,v $
# Revision 1.4  1997/11/19 17:47:57  daveb
# [Bug #30323]
#
# Revision 1.3  1996/12/20  17:05:09  jont
# [Bug #1879]
# Remove default setting of ARCH_OS
#
# Revision 1.2  1996/06/13  10:37:58  jont
# Modifications to allow running under nt
#
# Revision 1.1  1996/05/22  14:56:40  jont
# new unit
#
# Revision 1.18  1996/03/26  12:22:17  matthew
# Fixing bungle with $
#
# Revision 1.17  1996/01/09  12:48:09  matthew
# Renaming motif.img to gui.img
#
# Revision 1.16  1995/08/15  18:15:50  daveb
# Allowed files to have any extensions, which are automatically
# replaced with .sml.  This allows us to perform cout, MAKE_ANS,
# and cin on the same set of arguments (.ans files).
#
# Revision 1.15  1995/08/15  11:51:22  daveb
# Changed default SRC_DIR to /u/sml ...
#
# Revision 1.14  1995/03/15  14:20:35  jont
# Pass -dir parameter through
#
# Revision 1.13  1995/02/09  15:15:51  jont
# Modify to use new image directory structure
#
# Revision 1.12  1994/06/17  12:09:32  daveb
# Changed default SRC_DIR to /usr/sml ...
#
# Revision 1.11  1994/03/15  14:48:27  jont
# Change default source directory to /usr/users/sml/MLW/src
#
# Revision 1.10  1993/09/28  14:17:25  daveb
# Merged in bug fix.
#
# Revision 1.9.1.2  1993/09/28  13:29:03  daveb
# No longer generates answer files for erroneous cases.
#
# Revision 1.9.1.1  1993/04/14  16:21:33  jont
# Fork for bug fixing
#
# Revision 1.9  1993/04/14  16:21:33  daveb
# Replaced much code with a call to CHECK_SUCCESS.
#
# Revision 1.8  1993/04/14  14:53:00  daveb
# Fixed behaviour for missing files.  Optimised sed processing.
#
# Revision 1.7  1993/04/14  13:33:01  matthew
# Changed use of interpreter.img to motif.img
#
# Revision 1.6  1993/01/27  11:41:55  daveb
# Added needed backslashes to usage message.
#
# Revision 1.5  1993/01/27  11:22:22  daveb
# Removed old description of file.
#
# Revision 1.4  1993/01/22  15:21:59  daveb
# Added checks on results.
#
# Revision 1.3  1993/01/07  18:06:27  daveb
# Added argument handling, used interpreter.img instead of shell.img,
# and filtered out prompts and version message from output.
#
# Revision 1.2  1993/01/06  16:53:53  jont
# Improved to allow specification of a source directory in which exists
# an rts/runtime and a images/shell.img and an interpreter/interpreter.mo
# and multiple test file arguments. It's all jolly slow though.
#
# Revision 1.1  1992/12/16  16:45:35  jont
# Initial revision
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

SRCDIR=/u/sml/MLW/src

ARCH_OS_DIR=""

IMAGE=guib.img

usage='Usage: MAKE_ANS \[-src \<source dir\>\] \[-dir \<architecture/OS\>\] \<test files\>'

while [ $# -gt 0 ]
do
  case $1 in
    -src)
      shift
      if [ "$1" != "" ]
      then
        SRCDIR=$1
	shift
      else
  	echo $usage
	exit 1
      fi;;
    -dir)
      shift
      if [ "$1" != "" ]
      then
        ARCH_OS_DIR=$1
        shift
      else
        echo $usage
        exit 1
      fi;;
    *)
      break;;
  esac
done

if [ $# -eq 0 ]
then
  echo $usage
  exit 1
fi

if [ "$ARCH_OS_DIR" = "" ]
then
  echo "parameter -dir missing"
  exit 1
fi

OS_NAME=`basename $ARCH_OS_DIR`

NULL_FILE=/dev/null
RTS_NAME=main

if [ "$OS_NAME" = "NT" -o "$OS_NAME" = "Win95" ]
then
  RTS_NAME=main.exe
  NULL_FILE=nul:
fi

if [ ! -x $SRCDIR/rts/bin/$ARCH_OS_DIR/$RTS_NAME ]
then
  echo Can\'t find $SRCDIR/rts/bin/$ARCH_OS_DIR/$RTS_NAME
  exit 1
fi

if [ ! -r $SRCDIR/images/$ARCH_OS_DIR/$IMAGE ]
then
  echo Can\'t find $SRCDIR/images/$ARCH_OS_DIR/$IMAGE
  exit 1
fi

for i in $*
do
  ROOT_FILE=`dirname $i`/`basename $i .sml`
  SML_FILE=$ROOT_FILE.sml
  OUT_FILE=$ROOT_FILE.out
  ANS_FILE=$ROOT_FILE.ans
  if CHECK_SUCCESS.sh -keep -src $SRCDIR -dir $ARCH_OS_DIR $SML_FILE
  then
    if egrep OK $SML_FILE 1> $NULL_FILE 2>&1
    then
      mv $OUT_FILE $ANS_FILE
    else
      echo {$SML_FILE}: erroneous case, no answer file needed
      rm $OUT_FILE
    fi
  fi
done
