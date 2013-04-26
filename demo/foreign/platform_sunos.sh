#!/bin/sh
#
# Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
#
# See <URI:hope://MLW/demo/foreign/README#platform.sunos>
#
# Revision Log
# ------------
# $Log: platform_sunos.sh,v $
# Revision 1.1  1997/07/01 10:59:03  stephenb
# new unit
# ** No reason given. **
#
#

mlw_os=${1:-$OS}

case "$mlw_os" in
  SunOS) exit 0;;
  *) exit 1;;
esac
