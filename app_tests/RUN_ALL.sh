#!/bin/sh
#
# Copyright (c) 1998, Harlequin Group plc
# All rights reserved
#
# $Log: RUN_ALL.sh,v $
# Revision 1.4  1998/10/19 13:26:06  jont
# [Bug #70203]
# Modify so it calls RUN_SOME properly
#
# Revision 1.3  1998/08/06  15:27:36  jont
# [Bug #70148]
# Handle case when MLWORKS_PERVASIVE or MLWORKS_SRC_PATH are unset properly
#
# Revision 1.2  1998/06/08  10:25:41  jont
# [Bug #70127]
# Allow source parameter to be given as a relative path
#
# Revision 1.1  1998/05/28  15:07:54  jont
# new unit
# Adding scripts to run applications/tests into hope
#
#

for x in `cat dirs` ; do
  RUN_SOME.sh -dir $x $*
done
