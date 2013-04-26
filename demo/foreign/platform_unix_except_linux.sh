#!/bin/sh
#
# Copyright (C) 1998 Harlequin Group plc.  All rights reserved.
#
# Currently the ndbm demos do not run on Linux.
#
# Revision Log
# ------------
# $Log: platform_unix_except_linux.sh,v $
# Revision 1.1  1998/10/27 11:36:04  jkbrook
# new unit
# [Bug #70184]
# Ndbm demo will not currently run on Linux due to differences
# in the library
#
#
#

mlw_os=${1:-$OS}

case "$mlw_os" in
  Win95|NT) exit 1;;
  Linux) exit 1;;
  *) exit 0;;
esac

