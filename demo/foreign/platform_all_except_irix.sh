#!/bin/sh
#
# Copyright (C) 1998 Harlequin Group plc.  All rights reserved.
#
# Currently the stdio demos do not run on Irix.
#
# Revision Log
# ------------
# $Log: platform_all_except_irix.sh,v $
# Revision 1.1  1998/01/27 17:34:01  jkbrook
# new unit
# Temporary workaround: don't run some FI demos on Irix while
# development on FI is suspended
#
#

mlw_os=${1:-$OS}

case "$mlw_os" in
  Irix) exit 1;;
  *) exit 0;;
esac
