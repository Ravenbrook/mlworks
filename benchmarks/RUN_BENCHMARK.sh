#!/bin/sh
# 
# $Log: RUN_BENCHMARK.sh,v $
# Revision 1.5  1998/10/19 13:02:17  jont
# [Bug #70203]
# Modify for new argument passing mechanism
#
# Revision 1.4  1997/11/20  12:21:56  daveb
# [Bug #30323]
# Replaced the use of gui.img by guib.img.
#
# Revision 1.3  1997/11/14  16:13:45  jont
# [Bug #70019]
# Ensure Unix LD_LIBRARY_PATH setting correct for main being used
#
# Revision 1.2  1997/01/23  13:41:53  matthew
# Improving
#
# Revision 1.1  1996/12/17  11:15:48  matthew
# new unit
# New unit
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

id=$$

tempfile=compile$id.tmp

IMAGE=guib.img

silent="-silent"

usage='Usage: RUN_BENCHMARK -src <source dir> -dir <architecture/OS> [-not-silent] [-new] [-results <results file>] <file>'

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
    -not-silent)
      silent=""
      shift;;
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
    -results)
      shift
      if [ "$1" != "" ]
      then
        RESULTSFILE=$1
	shift
      else
	echo $usage
	exit 1
      fi;;
    -new)
       new="yes"
       shift;;
    *)
      break;;
  esac
done

if [ "$ARCH_OS_DIR" = "" ]
then
   echo "-dir option not given"
   echo $usage
   exit 1
fi

if [ "$SRCDIR" = "" ]
then
   echo "-src option not given"
   echo $usage
   exit 1
fi

if [ "$RESULTSFILE" = "" ]
then
   RESULTSFILE="$ARCH_OS_DIR/`date '+%y%m%d'`"
   echo Results file set to $RESULTSFILE
fi

OS_NAME=`basename $ARCH_OS_DIR`

if [ "$OS_NAME" = "NT" -o "$OS_NAME" = "Win95" ]
then
  RTS_NAME=main.exe
else
  RTS_NAME=main
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SRCDIR/rts/bin/$ARCH_OS_DIR;export LD_LIBRARY_PATH
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

MLWORKS_SRC_PATH=$SRCDIR;export MLWORKS_SRC_PATH
MLWORKS_RESULTS_FILE=$RESULTSFILE;export MLWORKS_RESULTS_FILE

if [ $# -eq 0 ]
then
  echo $usage
  exit 1
fi

#Create the results directory if necessary
RESULTSDIR=`dirname $RESULTSFILE`
if [ ! -d $RESULTSDIR ]
then
  echo Creating $RESULTSDIR
  mkdir -p $RESULTSDIR
fi

#Clean out the results file if necessary
if [ "$new" = "yes" ]
then
  cat > $RESULTSFILE < /dev/null
fi

echo `hostname`: `date` >> $RESULTSFILE

STATUS=0
for i in $*
do
  echo ${i}:
  $SRCDIR/rts/bin/$ARCH_OS_DIR/main -MLWpass MLWargs -batch -c 15 -load $SRCDIR/images/$ARCH_OS_DIR/$IMAGE MLWargs $silent -tty -no-init < $i  || set STATUS=1
done
exit $STATUS
