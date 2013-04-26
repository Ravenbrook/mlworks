#!/bin/sh
# 
# $Log: CHECK_RESULT.sh,v $
# Revision 1.6  1997/11/19 17:45:53  daveb
# [Bug #30323]
# Replaced use of gui.img with guib.img.
#
# Revision 1.5  1997/08/13  15:26:57  jont
# [Bug #30151]
# Modify to work with installed MLWorks as well
#
# Revision 1.4  1997/07/22  13:19:17  jont
# [Bug #30163]
# Ensure all .out files deleted except when we want to retain them
#
# Revision 1.3  1996/12/20  17:04:03  jont
# [Bug #1879]
# Remove default setting of ARCH_OS
#
# Revision 1.2  1996/05/23  10:41:07  jont
# Improvements to make it work on NT
#
# Revision 1.1  1996/05/22  15:29:12  jont
# new unit
#
# Revision 1.19  1996/05/07  09:40:18  daveb
# Changed to keep the .out file around in case of error.
#
# Revision 1.18  1996/01/09  12:46:28  matthew
# Renaming motif.img to gui.img
#
# Revision 1.17  1995/09/06  16:46:34  io
# use rts/bin/$ARCH/$OS/main to help multiarch testing
#
# Revision 1.16  1995/08/15  11:50:58  daveb
# Changed default SRC_DIR to /u/sml ...
#
# Revision 1.15  1995/03/15  14:34:24  jont
# Pass on -dir parameter
#
# Revision 1.14  1995/02/09  15:16:34  jont
# Modify to use new image directory structure
#
# Revision 1.13  1994/06/23  15:50:10  jont
# Add detection of missing answer files
#
# Revision 1.12  1994/06/17  12:03:54  daveb
# Changed default SRC_DIR to /usr/sml ...
#
# Revision 1.11  1994/05/03  14:29:19  daveb
# Added exit status.
#
# Revision 1.10  1994/03/15  14:46:55  jont
# Change default source directory to /usr/users/sml/MLW/src
#
# Revision 1.9  1993/09/28  14:11:32  daveb
# Merged in bug fix.
#
# Revision 1.8  1993/09/23  17:01:50  daveb
# Merged in bug fix.
#
# Revision 1.7.1.3  1993/09/27  11:55:56  daveb
# No longer checks output of erroneous cases.
#
# Revision 1.7.1.2  1993/09/23  17:00:09  daveb
# Added -diff flag, which shows diff between output and answer files in
# case when they differ.
#
# Revision 1.7.1.1  1993/04/15  09:56:31  jont
# Fork for bug fixing
#
# Revision 1.7  1993/04/15  09:56:31  daveb
# Added call to CHECK_SUCCESS.
#
# Revision 1.6  1993/04/14  17:16:03  daveb
# Replaced call to mlworks with call to COMPILE_FILE.
# Changed name to CHECK_RESULT.
#
# Revision 1.5  1993/04/14  15:06:43  daveb
# Replaced interpreter.img with motif.img.  Optimised sed processing.
# Added check for non-existent files.
#
# Revision 1.4  1993/02/02  12:39:48  daveb
# Script was printing 'OK' when it faled to create a .out file.
#
# Revision 1.3  1993/01/27  11:23:28  daveb
# Removed old description of file.
#
# Revision 1.2  1993/01/07  18:06:56  daveb
# Added argument handling, used interpreter.img instead of shell.img,
# and filtered out prompts and version message from output.
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

SRCDIR=/u/sml/MLW/src
DIFF=0

ARCH_OS_DIR=""

IMAGE=guib.img

installed=""

usage='Usage: CHECK_RESULT \[-diff\] \[-src \<source dir\>\] \[-dir \<architecture/OS\>\] \[-installed\] \<test files\>'

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
    -diff)
      shift
      DIFF=1;;
    -installed)
      installed="-installed"
      shift;;
    *)
      break 1;;
  esac
done

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
  OS_TYPE=Win32
  RTS_NAME=main.exe
  NULL_FILE=nul:
else
  OS_TYPE=Unix
fi

if [ $# -eq 0 ]
then
  echo $usage
  exit 1
fi

if [ "$installed" = "-installed" ]
then
  if [ "$OS_TYPE" = "Unix" ]
  then
    if [ ! -x $SRCDIR/bin/mlrun ]
    then
      echo Can\'t find $SRCDIR/bin/mlrun
      exit 1
    fi
    RTS_PATH=$SRCDIR/bin/mlrun
  else
    if [ ! -x $SRCDIR/bin/main.exe ]
    then
      echo Can\'t find $SRCDIR/bin/main.exe
      exit 1
    fi
    RTS_PATH=$SRCDIR/bin/main
  fi
  if [ ! -r $SRCDIR/images/$IMAGE ]
  then
    echo Can\'t find $SRCDIR/images/$IMAGE
    exit 1
  fi
else
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
fi

STATUS=0
for i in $*
do
  if [ ! -r $i ]
  then
    echo Can\'t find $i
    STATUS=1
  elif CHECK_SUCCESS.sh -keep -src $SRCDIR -dir $ARCH_OS_DIR $installed $i
  then
    TEST_STATUS=0
    ROOT_FILE=`dirname $i`/`basename $i .sml`
    SML_FILE=$ROOT_FILE.sml
    OUT_FILE=$ROOT_FILE.out
    ANS_FILE=$ROOT_FILE.ans
    if egrep OK $i 1> $NULL_FILE 2>&1
    then
      if [ ! -r $ANS_FILE ]
      then
        echo Can\'t find $ANS_FILE
        TEST_STATUS=1
      elif cmp $OUT_FILE $ANS_FILE 1> $NULL_FILE 2>&1
      then
        echo ${i}: output check succeeded.
      elif [ $DIFF -ne 0 ]
      then
        diff $OUT_FILE $ANS_FILE
        echo Output saved in $OUT_FILE
        TEST_STATUS=1
      else
        echo ${i}: output check failed \(see $OUT_FILE\).
        TEST_STATUS=1
      fi
    else
      echo ${i}: erroneous case, no output check.
    fi
    if [ $TEST_STATUS -eq 0 ]
    then
      rm -f $OUT_FILE
    else
      STATUS=1
    fi
  else
    STATUS=1
  fi
done
exit $STATUS
