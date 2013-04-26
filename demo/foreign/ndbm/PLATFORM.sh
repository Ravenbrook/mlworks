#!/bin/sh
#
# Copyright 1997 The Harlequin Group Limited.  All rights reserved.
#
# Revision Log
# ------------
# $Log: PLATFORM.sh,v $
# Revision 1.3  1998/10/27 11:34:39  jkbrook
# [Bug #70184]
# Run on Solaris and Irix now 70208 is fixed
# Do not run on Linux pending demo-specific porting work
#
# Revision 1.2  1998/01/27  16:58:51  jkbrook
# [Bug #70047]
# Restrict testing to non-Irix Unix platforms while development
# is suspended
#
# Revision 1.1  1997/05/14  11:32:27  stephenb
# new unit
# [Bug #20035]
#

exec ./platform_unix_except_linux.sh

