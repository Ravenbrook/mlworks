#!/bin/sh
# 
# $Log: COMPILE_FILE.sh,v $
# Revision 1.16  1998/10/19 11:36:17  jont
# [Bug #70203]
# Modify for new argument passing mechanism
#
# Revision 1.15  1997/11/19  17:43:53  daveb
# [Bug #30323]
# Replaced use of gui.img with guib.img.
#
# Revision 1.14  1997/08/13  16:21:54  jont
# [Bug #30151]
# Modify to work with installed MLWorks as well
#
# Revision 1.13  1997/07/31  14:49:39  jont
# [Bug #30236]
# Ensure LD_LIBRARY_PATH set appropriately before calling main for unix systems
#
# Revision 1.12  1997/05/30  17:22:10  daveb
# [Bug #30090]
# Preserved the stderr output in a .err file, so that CHECK_SUCCESS can grep
# it for "error", "warning", etc.
#
# Revision 1.11  1997/02/07  15:11:36  jont
# [Bug #1911]
# Fix to work again on Win32
#
# Revision 1.10  1997/02/05  18:17:06  jont
# [Bug #1909]
# Ensure pervasive dir set correctly
# Also pass in settings via command line rather than environment variables
# which would be ignored under Win32
#
# Revision 1.9  1996/12/20  17:00:41  jont
# [Bug #1879]
# Remove default setting of ARCH_OS
#
# Revision 1.8  1996/10/23  13:17:17  jont
# [Bug #1697]
# run -batch to avoid hanging on license failure
#
# Revision 1.7  1996/09/09  14:33:30  io
# update for commercial flyer
#
# Revision 1.6  1996/08/14  11:11:46  io
# switch off Compiling messages...
#
# Revision 1.5  1996/07/17  09:54:37  andreww
# Added missing -no-init flag to the branch for compiling many files.
#
# Revision 1.4  1996/07/12  14:06:50  jont
# Run system without using users preferences or startup file
#
# Revision 1.3  1996/06/13  10:33:23  jont
# Modifications to get perl onto the path under nt
#
# Revision 1.2  1996/05/23  10:29:52  jont
# Improvements to make it work on NT
#
# Revision 1.1  1996/05/22  13:47:33  jont
# new unit
#
# Revision 1.24  1996/01/09  12:47:43  matthew
# Renaming motif.img to gui.img
#
# Revision 1.23  1995/09/21  09:46:31  daveb
# Added flag to stop the run-time printing GC messages.
#
# Revision 1.22  1995/09/11  16:24:20  matthew
# Redirect std_err to output file also
#
# Revision 1.21  1995/08/24  15:27:15  io
# use rts/bin/$ARCH/$OS/main to help multiarch testing
#
# Revision 1.20  1995/08/15  12:37:18  daveb
# Changed default SRC_DIR to /u/sml ...
#
# Revision 1.19  1995/03/24  14:34:45  jont
# Fix use of global name compile.tmp
#
# Revision 1.18  1995/02/09  15:15:32  jont
# Modify to use new image directory structure
#
# Revision 1.17  1995/01/26  14:46:22  daveb
# Set source path to value of source directory.
#
# Revision 1.16  1994/10/10  17:29:02  daveb
# The exit status was always zero.  The only reasonable fix requires
# the use of a temp file!
#
# Revision 1.15  1994/08/24  16:39:29  daveb
# Removed previous change (which only appeared in one of two places anyway)
# in favour of changing the perl script.
#
# Revision 1.14  1994/07/27  10:38:04  daveb
# Redirected standard error into the perl script along with standard out.
#
# Revision 1.13  1994/07/27  09:44:30  daveb
# Added -tty flag to compile command.
#
# Revision 1.12  1994/06/15  10:05:29  daveb
# Changed a $1 to a $i.
#
# Revision 1.11  1994/06/08  13:20:56  daveb
# Now works for any number of arguments.  Also corrected default source
# directory.
#
# Revision 1.10  1994/03/15  14:47:55  jont
# Change default source directory to /usr/users/sml/MLW/src
#
# Revision 1.9  1993/12/15  17:28:01  nickh
# Change use of sed to use of perl (sed is brain-damaged).
#
# Revision 1.8  1993/08/29  20:41:18  daveb
# Capitalised "Setting" to match change in _io.
#
# Revision 1.7  1993/08/28  19:11:47  daveb
# Added sed commands to ignore lines beginning with Use or setting, e.g.
# setting source path to: .
# setting pervasive directory to: /usr/users/daveb/ml/src/pervasive
# Use: compiling /usr/users/daveb/.mlworks
#
# Revision 1.6  1993/06/17  08:48:05  matthew
# Changed for new prompt (MLWorks-1> rather than MLWorks%1)
#
# Revision 1.5  1993/06/04  08:42:51  matthew
# Change of prompt
#
# Revision 1.4  1993/05/26  11:15:30  matthew
# Only ignore first line -- no message for non-existent .mlworks now
#
# Revision 1.3  1993/04/14  16:49:09  daveb
# Changed sed command to delete second line of header as well as first.
#
# Revision 1.2  1993/04/14  14:40:39  daveb
# Changed interpreter.img to motif.img.
# Replaced call to tail and two calls to sed with one call to sed.
#
# Revision 1.1  1993/01/27  11:40:33  daveb
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

id=$$

# A temporary file for stdout
tempfile=compile$id.tmp
# A temporary file for stderr
tempfile1=compile$id.tmp1
# We could redirect both to the same file, but then we would have
# no control over the interleaving.

silent="-silent"
installed=""

usage='Usage: COMPILE_FILE \[-not-silent\] \[-src \<source dir\>\] \[-dir \<architecture/OS\>\] \[-installed\] \<file\>'

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

if [ "$OS_NAME" = "NT" -o "$OS_NAME" = "Win95" ]
then
  OS_TYPE=Win32
  RTS_NAME=main.exe
else
  RTS_NAME=main
  OS_TYPE=Unix
  if [ "$installed" = "-installed" ]
  then
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SRCDIR/bin;export LD_LIBRARY_PATH
  else
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SRCDIR/rts/bin/$ARCH_OS_DIR;export LD_LIBRARY_PATH
  fi
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
  GUI_PATH=$SRCDIR/images/$IMAGE
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
  RTS_PATH=$SRCDIR/rts/bin/$ARCH_OS_DIR/$RTS_NAME
  GUI_PATH=$SRCDIR/images/$ARCH_OS_DIR/$IMAGE
fi

MLWORKS_SRC_PATH=$SRCDIR
MLWORKS_PERVASIVE=$SRCDIR/pervasive
STATUS=0
if [ $# -eq 1 ]
then
  $RTS_PATH -MLWpass MLWargs -batch -c 15 -load $GUI_PATH MLWargs $silent -tty -no-init -pervasive-dir $MLWORKS_PERVASIVE -source-path $MLWORKS_SRC_PATH < $1 1> $tempfile 2> $tempfile1 || STATUS=1
  ROOT_FILE=`dirname $1`/`basename $1 .sml`
  ERR_FILE=$ROOT_FILE.err
  cat $tempfile | perl perl_script
  mv $tempfile1 $ERR_FILE
else
  for i in $*
  do
    $RTS_PATH -MLWpass MLWargs -batch -c 15 -load $GUI_PATH MLWargs $silent -tty -no-init -pervasive-dir $MLWORKS_PERVASIVE -source-path $MLWORKS_SRC_PATH < $i  1> $tempfile 2> $tempfile1 || set STATUS=1
    ROOT_FILE=`dirname $1`/`basename $1 .sml`
    ERR_FILE=$ROOT_FILE.err
    echo ${i}:
    cat $tempfile | perl perl_script
    mv $tempfile1 $ERR_FILE
  done
fi
rm $tempfile
exit $STATUS
