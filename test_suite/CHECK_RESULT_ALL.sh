#!/bin/sh
# CHECK_RESULT_ALL
# 
# Shell script to perform regression testing on the Harlequin
# SML compiler.
#
# $Log: CHECK_RESULT_ALL.sh,v $
# Revision 1.11  1999/02/23 12:55:12  mitchell
# [Bug #190507]
# Ignore DEPEND directories
#
# Revision 1.10  1998/09/24  10:56:54  jont
# [Bug #70180]
# Change nul to nul:
#
# Revision 1.9  1997/11/19  17:46:20  daveb
# [Bug #30323]
#
# Revision 1.8  1997/08/13  15:41:18  jont
# [Bug #30151]
# Modify to work with installed MLWorks as well
#
# Revision 1.7  1997/07/21  16:57:19  jont
# [Bug #30163]
# Add a per test variable to control deletion of .out file
# keeping STATUS for overall suite result
#
# Revision 1.6  1997/01/02  14:41:35  stephenb
# [Bug #1881]
# Modified so that now knows how to skip architecture specific
# directories that aren't of interest to the architecture being
# tested.  Also changed the way OS specific directories are skipped
# to use the same mechanism.
#
# Revision 1.5  1996/12/20  17:03:37  jont
# [Bug #1879]
# Remove default setting of ARCH_OS
#
# Revision 1.4  1996/08/15  09:51:24  io
# (No reason given.)
#
# Revision 1.3  1996/08/14  15:52:21  io
# handle os specific directories
#
# Revision 1.2  1996/05/23  10:48:25  jont
# Improvements to make it work on NT
#
# Revision 1.1  1996/05/22  15:35:58  jont
# new unit
#
# Revision 1.19  1996/05/07  09:59:16  daveb
# Changed to keep the .out file around in case of error.
#
# Revision 1.18  1996/01/09  12:46:48  matthew
# Renaming motif.img to gui.img
#
# Revision 1.17  1995/09/09  21:13:38  io
# forgot a . in ./CHECK_RESULT..
#
# Revision 1.16  1995/09/06  16:53:54  io
# use rts/bin/$ARCH/$OS/main to help multiarch testing
#
# Revision 1.15  1995/08/15  14:00:46  daveb
# The version in ~sml and the version in Hope had got out of sync.
# Added a full stop to avoid spurious differences in output.
#
# Revision 1.14  1995/08/15  11:51:03  daveb
# Changed default SRC_DIR to /u/sml ...
#
# Revision 1.13  1995/06/16  16:46:14  daveb
# Converted this script to /bin/sh because Irix csh choked on "too many arguments"
#
# Revision 1.12  1995/03/15  14:35:31  jont
# Pass on -dir parameter
#
# Revision 1.11  1995/02/09  15:15:29  jont
# Modify to use new image directory structure
#
# Revision 1.10  1994/07/14  10:30:33  jont
# Add better message when answer file missing
#
# Revision 1.9  1994/06/17  12:04:07  daveb
# Changed default SRC_DIR to /usr/sml ...
#
# Revision 1.8  1994/05/03  14:31:57  daveb
# Added exit status.
#
# Revision 1.7  1994/03/15  14:47:16  jont
# Change default source directory to /usr/users/sml/MLW/src
#
# Revision 1.6  1993/09/28  14:13:14  daveb
# Merged in bug fix.
#
# Revision 1.5.1.2  1993/09/27  11:55:37  daveb
# No longer checks output of erroneous cases.
#
# Revision 1.5.1.1  1993/04/15  09:58:24  jont
# Fork for bug fixing
#
# Revision 1.5  1993/04/15  09:58:24  daveb
# Added call to CHECK_SUCCESS.
#
# Revision 1.4  1993/04/14  17:17:45  daveb
# Replaced call to mlworks with call to COMPILE_FILE.
# Changed name to CHECK_RESULT.
#
# Revision 1.3  1993/04/14  15:10:18  daveb
# Changed interpreter.img to motif.img.  Optimised sed processing.
#
# Revision 1.2  1993/02/02  12:46:40  daveb
# Script was printing 'OK' when it failed to create the .out file.
#
# Revision 1.1  1993/01/07  18:06:41  daveb
# Initial revision
#
#
# Copyright Harlequin Ltd. 1992.

TESTDIR=.
SRCDIR=/u/sml/MLW/src
ARCH_OS_DIR=""

IMAGE=guib.img

installed=""

usage='Usage: CHECK_RESULT_ALL \[-src \<source dir\>\] \[-dir \<architecture/OS\>\] \[-test \<dir\>\] \[-installed\]'

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
    -test)
      shift
      if [ "$1" != "" ]
      then
        TESTDIR=$1
	shift
      else
  	echo $usage
	exit 1
      fi;;
    -installed)
      installed="-installed"
      shift;;
    *)
      echo $usage
      exit 1;;
  esac
done

if [ "$ARCH_OS_DIR" = "" ]
then
  echo "parameter -dir missing"
  exit 1
fi

#
# See <URI:CHECK_SUCCESS_ALL.sh#arch> for an explanation of the following or
# if you prefer, create a separate script for it.
#
architectures="SPARC MIPS I386"
ARCH=`dirname $ARCH_OS_DIR`
arch_dirs_to_prune=""
for a in $architectures
do
  if test $a != $ARCH
  then
    arch_dirs_to_prune=${arch_dirs_to_prune}" -o -name $a"
  fi
done


# See <URI:CHECK_SUCCESS_ALL.sh#os>

case "`basename $ARCH_OS_DIR`" in
  Win95|NT) os_dir_to_prune=unix; RTS_NAME=main.exe; NULL_FILE=nul:; OS_TYPE=Win32 ;;
  *)        os_dir_to_prune=win32; RTS_NAME=main; NULL_FILE=/dev/null; OS_TYPE=Unix ;;
esac

files=`find $TESTDIR -type d \( -name $os_dir_to_prune $arch_dirs_to_prune -o -name DEPEND \) -prune -o -type f -name \*.sml -print | egrep -v "^.$"`

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

cd $TESTDIR
STATUS=0

for i in $files; do
  TEST_STATUS=0
  if ./CHECK_SUCCESS.sh -keep -src $SRCDIR -dir $ARCH_OS_DIR $installed $i
  then
    base=`dirname $i`/`basename $i .sml`
    if ( grep OK $i > $NULL_FILE 2>&1 )
    then
      if [ ! -r $base.ans ]
      then
        echo Can\'t find $base.ans
        TEST_STATUS=1
      elif (cmp $base.out $base.ans > $NULL_FILE 2>&1)
      then
        echo $i: output check succeeded.
      else
        echo $i: output check failed \(see $base.out\).
        TEST_STATUS=1
      fi
    else
      echo $i: erroneous case, no output check.
    fi
    if [ $TEST_STATUS -eq 0 ]
    then
      rm -f $base.out
    else
      STATUS=1
    fi
  else
    STATUS=1
  fi
done

exit $STATUS
