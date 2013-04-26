#!/bin/sh
#
# Copyright (c) 1998, Harlequin Group plc
# All rights reserved
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
