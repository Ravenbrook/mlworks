#!/bin/sh
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
# Test the add sample
#
# Revision Log
# ------------
# $Log: TEST.sh,v $
# Revision 1.5  1999/03/12 11:50:53  johnh
# [Bug #190506]
# Fix pointer to .lib file.
#
# Revision 1.4  1998/10/26  17:37:24  jkbrook
# [Bug #70184]
# Update for projects, particularly configurations
#
# Revision 1.3  1997/06/27  14:25:10  stephenb
# [Bug #30029]
# Remove the perl stuff now that 20033 has been implemented.
#
# Revision 1.2  1997/05/15  08:14:56  stephenb
# [Bug #20035]
# Some Win32 specific things: use NUL instead of /dev/null; don't
# use {} in trap command.
#
# Revision 1.1  1997/05/13  15:44:28  stephenb
# new unit
# [Bug #20035]
#
#


mlw_src=${1:-../../../src}
mlw_rts_dir=${mlw_src}/rts/bin/$ARCH/$OS
mlw_rts=${mlw_rts_dir}/main
mlw_image=${mlw_src}/images/$ARCH/$OS/gui.img
mlw_pervasive=${mlw_src}/pervasive
mlw_include=${mlw_src}/rts/src

LD_LIBRARY_PATH=.${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

if { ../platform_win32.sh ; }
then
  mlw_null=NUL
  mlw_os_type=Win32
  mlw_make_type=Win32
  mlw_sep=";"
  mlw_lib=${mlw_rts_dir}/libmlw.lib
else
  mlw_null=/dev/null
  mlw_os_type=Unix
  mlw_make_type=$OS
  mlw_sep=":"
  mlw_lib=${mlw_rts_dir}/main.lib
fi


#
# Make sure the script cleans up after itself.
#

trap "make -s -f Makefile.${mlw_make_type} clean;" 0 1

#
# Build the .so/.dll.  Redirecting to $mlw_null is done because
# VC++ insists on outputing info as it is compiling and I can't
# find the switches to turn it off.
#

if { make -s -f Makefile.${mlw_make_type} MLWORKS_INCLUDE=${mlw_include} MLWORKS_LIB=${mlw_lib} clean all > $mlw_null ;}
then
  echo "make ok" 
else
  echo "make failed"
  exit 1
fi

#
# Create a .sml file for the current configuration
#

rm -f TEST.sml
sed -e "s?ARCH_OS?$ARCH/$OS?" TEST.sml.in > TEST.sml

# 
# Run the demo. 
#

${mlw_rts} -MLWpass args -batch -load ${mlw_image} args -silent -tty -no-banner -pervasive-dir ${mlw_pervasive} < TEST.sml 2> $mlw_null 


