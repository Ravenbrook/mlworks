#!/bin/sh
#
# Copyright (C) 1998 Harlequin Group plc.  All rights reserved.
#
# Currently the ndbm demos do not run on Irix.
#
# Revision Log
# ------------
# $Log: platform_unix_except_irix.sh,v $
# Revision 1.1  1998/01/27 17:34:46  jkbrook
# new unit
# Temporary workaround: don't run some FI demos on Irix while
# development on FI is suspended
#
#

mlw_os=${1:-$OS}

case "$mlw_os" in
  Win95|NT) exit 1;;
  Irix) exit 1;;
  *) exit 0;;
esac
