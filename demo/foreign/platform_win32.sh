#!/bin/sh
#
# Copyright 1997 The Harlequin Group Limited.  All rights reserved.
#
# See <URI:hope://MLW/demo/foreign/README#platform.win32>
#
# Revision Log
# ------------
# $Log: platform_win32.sh,v $
# Revision 1.2  1997/05/14 15:16:08  stephenb
# [Bug #20035]
# OS -> $OS.  This should have been in the previous change.
#
# Revision 1.1  1997/05/13  12:58:40  stephenb
# new unit
# [Bug #20035]
#

mlw_os=${1:-$OS}

case "$mlw_os" in
  Win95|NT) exit 0;;
  *) exit 1;;
esac
