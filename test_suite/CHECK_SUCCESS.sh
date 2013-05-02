#!/bin/sh
# 
# $Log: CHECK_SUCCESS.sh,v $
# Revision 1.9  1998/08/11 15:17:09  jont
# Fix problems checking result status on successful tests
#
# Revision 1.8  1998/06/09  10:33:36  jont
# [Bug #70130]
# Make sure checks for error and warning can't be triggered by correct code
#
# Revision 1.7  1997/11/19  17:46:47  daveb
# [Bug #30323]
#
# Revision 1.6  1997/08/13  15:25:47  jont
# [Bug #30151]
# Modify to work with installed MLWorks as well
#
# Revision 1.5  1997/05/30  17:24:48  daveb
# [Bug #30090]
# Error messages are now found on stderr, so COMPILE_FILE keeps that around
# in a .err file, and we search for errors there.
#
# Revision 1.4  1997/05/07  16:54:22  jont
# [Bug #20032]
# Prefix correct behaviour message with test filename
#
# Revision 1.3  1996/12/20  17:05:13  jont
# [Bug #1879]
# Remove default setting of ARCH_OS
#
# Revision 1.2  1996/05/23  10:39:06  jont
# Improvements to make it work on NT
#
# Revision 1.1  1996/05/22  15:44:11  jont
# new unit
#
# Revision 1.17  1996/01/09  12:47:02  matthew
# Renaming motif.img to gui.img
#
# Revision 1.16  1995/09/06  16:36:10  io
# use rts/bin/$ARCH/$OS/main to help multiarch testing
#
# Revision 1.15  1995/08/29  15:16:55  daveb
# Compiler faults and intolerable signals are now reported separately.
#
# Revision 1.14  1995/08/21  10:01:56  daveb
# Remove any existing .out file before run (we may not have
# permission to overwrite it, but we do have delete permission
# on the directory).
#
# Revision 1.13  1995/08/15  11:51:09  daveb
# Changed default SRC_DIR to /u/sml ...
#
# Revision 1.12  1995/03/15  14:21:38  jont
# Pass -dir parameter through
#
# Revision 1.11  1995/02/09  15:17:35  jont
# Modify to use new image directory structure
#
# Revision 1.10  1994/10/10  17:27:41  daveb
# Added check for the success status of the compile command itself.
#
# Revision 1.9  1994/09/15  13:31:21  daveb
# Added "Intolerable signal" to the list of strings to check for.
#
# Revision 1.8  1994/06/17  12:04:58  daveb
# Changed default SRC_DIR to /usr/sml ...
#
# Revision 1.7  1994/05/03  14:23:08  daveb
# Fixed erroneous early exit.  It now returns a non-zero status if any
# of its arguments fail.
#
# Revision 1.6  1994/03/15  14:47:32  jont
# Change default source directory to /usr/users/sml/MLW/src
#
# Revision 1.5  1993/12/16  11:31:52  nickh
# The string "error" occurs correctly in at least one test. We check instead
# for "error:".
#
# Revision 1.4  1993/09/28  14:14:51  daveb
# Merged in bug fix.
#
# Revision 1.3.1.2  1993/09/27  14:35:54  daveb
# Ensured that messages of failure all contain the word "failed".
#
# Revision 1.3.1.1  1993/08/29  12:12:19  jont
# Fork for bug fixing
#
# Revision 1.3  1993/08/29  12:12:19  daveb
# Added check for compiler faults.
#
# Revision 1.2  1993/07/12  12:23:09  daveb
# Made error check search for 'Uncaught exception' as well as error.
#
# Revision 1.1  1993/04/14  16:43:37  daveb
# Initial revision
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

SRCDIR=/u/sml/MLW/src
KEEP=0
ARCH_OS_DIR=""

IMAGE=guib.img

installed=""

usage='Usage: CHECK_SUCCESS \[-src \<source dir\>\] \[-dir \<architecture/OS\>\] \[-installed\] \<file\>'

while [ $# -gt 0 ]
do
  case $1 in
    -keep)
      shift
      KEEP=1;;
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
    -installed)
      installed="-installed"
      shift;;
    *)
      break;;
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
  RTS_NAME=main.exe
  NULL_FILE=nul:
  OS_TYPE=Win32
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
  else
    if [ ! -x $SRCDIR/bin/main.exe ]
    then
      echo Can\'t find $SRCDIR/bin/main.exe
      exit 1
    fi
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
  COMPILE_FAILED=0
  if [ ! -r $i ]
  then
    echo Can\'t find $i
  elif egrep Result: $i 1> $NULL_FILE 2>&1
  then
    ROOT_FILE=`dirname $i`/`basename $i .sml`
    OUT_FILE=$ROOT_FILE.out
    ERR_FILE=$ROOT_FILE.err
    rm -f $OUT_FILE
    if (COMPILE_FILE.sh -src $SRCDIR -dir $ARCH_OS_DIR $installed $i 1> $OUT_FILE) 1> $NULL_FILE 2>&1
    then
      if egrep 'compiler fault|Intolerable signal' $ERR_FILE 1> $NULL_FILE 2>&1
      then
        echo ${i}: test failed, compiler fault \(see $ERR_FILE\).
	STATUS=3
      elif egrep ': error:|Uncaught exception' $ERR_FILE 1> $NULL_FILE 2>&1
      then
	if egrep Result: $i | egrep FAIL 1> $NULL_FILE 2>&1
	then
	  echo ${i}: test succeeded.
	else
	  echo ${i}: test failed, unexpected error \(see $ERR_FILE\).
	  STATUS=1
	fi
      elif egrep ': warning:' $ERR_FILE 1> $NULL_FILE 2>&1
      then
	if egrep Result: $i | egrep WARNING 1> $NULL_FILE 2>&1
	then
	  echo ${i}: test succeeded.
	else
	  echo ${i}: test failed, unexpected warning \(see $ERR_FILE\).
	  STATUS=1
	fi
      else
	if egrep Result: $i | egrep OK 1> $NULL_FILE 2>&1
	then
	  echo ${i}: test succeeded.
	elif  egrep Result: $i | egrep FAIL 1> $NULL_FILE 2>&1
	then
	  echo ${i}: test failed, error expected \(see $OUT_FILE\).
	  STATUS=1
	elif egrep Result: $i | egrep WARNING 1> $NULL_FILE 2>&1
	then
	  echo ${i}: test failed, warning expected \(see $OUT_FILE\).
	  STATUS=1
	elif egrep Result: $i | egrep INTERPRETATION 1> $NULL_FILE 2>&1
	then
	  echo ${i}: test succeeded.
	else
	  echo ${i}: test failed, bad result status.
	  STATUS=2
        fi
      fi
      if egrep Result: $i | egrep INTERPRETATION 1> $NULL_FILE 2>&1
      then
	echo ${i}: The correct behaviour in this case is open to question.
      fi
    else
      echo ${i}: test failed: compiler crashed
      STATUS=3
    fi
  else
    echo ${i}: test failed, missing result status.
    STATUS=2
  fi
  if [ $STATUS -eq 0 ]
  then
    rm $ERR_FILE
    if [ $KEEP -eq 0 ]
    then
      rm $OUT_FILE
    fi
  fi
done
exit $STATUS
