#!/bin/sh
# MAKE_ALL_ANS
# 
# Shell script to perform regression testing on the Harlequin
# SML compiler.
#
# $Log: MAKE_ALL_ANS.sh,v $
# Revision 1.5  1997/11/19 17:47:37  daveb
# [Bug #30323]
#
# Revision 1.4  1996/12/20  17:05:38  jont
# [Bug #1879]
# Remove default setting of ARCH_OS
#
# Revision 1.3  1996/08/15  09:50:20  io
# ** No reason given. **
#
# Revision 1.2  1996/08/14  15:53:45  io
# architecture specific handling
#
# Revision 1.1  1996/05/22  15:21:47  jont
# new unit
#
# Revision 1.11  1996/01/09  12:47:57  matthew
# Renaming motif.img to gui.img
#
# Revision 1.10  1995/08/15  11:51:18  daveb
# Changed default SRC_DIR to /u/sml ...
#
# Revision 1.9  1995/03/15  14:35:46  jont
# Pass on -dir parameter
#
# Revision 1.8  1995/02/09  15:16:08  jont
# Modify to use new image directory structure
#
# Revision 1.7  1994/06/17  12:11:33  daveb
# Changed default SRC_DIR to /usr/sml ...
#
# Revision 1.6  1994/03/15  14:48:13  jont
# Change default source directory to /usr/users/sml/MLW/src
#
# Revision 1.5  1993/09/28  14:17:33  daveb
# Merged in bug fix.
#
# Revision 1.4.1.2  1993/09/28  13:30:27  daveb
# No longer generates answer files for erroneous cases.
#
# Revision 1.4.1.1  1993/04/14  16:30:50  jont
# Fork for bug fixing
#
# Revision 1.4  1993/04/14  16:30:50  daveb
# Replaced much code with a call to CHECK_SUCCESS.
#
# Revision 1.3  1993/04/14  15:01:57  daveb
# Changed interpreter.img to motif.img.  Optimised sed processing.
#
# Revision 1.2  1993/01/22  16:21:39  daveb
# Added checks on results.
#
# Revision 1.1  1993/01/07  18:06:15  daveb
# Initial revision
# 
#
# Copyright Harlequin Ltd. 1992.

TESTDIR=.

SRCDIR=/u/sml/MLW/src

ARCH_OS_DIR=""

IMAGE=guib.img

usage='Usage: MAKE_ALL_ANS \[-src \<source dir\>\] \[-dir \<architecture/OS\>\] \[-test \< test dir\>\]'

# Argument handling here.
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

OS_NAME=`basename $ARCH_OS_DIR`
files=`find $TESTDIR -type f -name \*.sml -print | egrep -v "^.$"`
if [ "$OS_NAME" = NT -o "$OS_NAME" = Win95 ]; then
  files=`echo "$files" | egrep -v "\/unix\/"`
else
  files=`echo "$files" | egrep -v "\/win32\/"`
fi

if [ ! -x $SRCDIR/rts/bin/$ARCH_OS_DIR/main ]
then
  echo Can\'t find $SRCDIR/rts/bin/$ARCH_OS_DIR/main
  exit 1
fi

if [ ! -r $SRCDIR/images/$ARCH_OS_DIR/$IMAGE ]
then
  echo Can\'t find $SRCDIR/images/$ARCH_OS_DIR/$IMAGE
  exit 1
fi

cd $TESTDIR

for i in $files; do
  if CHECK_SUCCESS.sh -keep -src $SRCDIR -dir $ARCH_OS_DIR $i
  then
    ROOT_FILE=`dirname $i`/`basename $i .sml`
    SML_FILE=$ROOT_FILE.sml
    OUT_FILE=$ROOT_FILE.out
    ANS_FILE=$ROOT_FILE.ans
    if egrep OK $i 1> /dev/null 2>&1
    then
      mv $OUT_FILE $ANS_FILE
    else
      echo ${i}: erroneous case, no answer file needed
      rm $OUT_FILE
    fi
  fi
done
