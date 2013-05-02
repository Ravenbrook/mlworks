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
# Revision Log
# ------------
# $Log: TEST.sh,v $
# Revision 1.3  1998/10/26 19:43:29  jkbrook
# [Bug #70184]
# Update for projects
#
# Revision 1.2  1998/01/27  17:38:21  jkbrook
# [Bug #70047]
# Shouldn't print `dumped ok' if executable delivery fails
#
# Revision 1.1  1997/07/01  10:25:24  stephenb
# new unit
# ** No reason given. **
#
#


mlw_src=${1:-../../../src}
mlw_rts=${mlw_src}/rts/bin/$ARCH/$OS/main
mlw_image=${mlw_src}/images/$ARCH/$OS/gui.img
mlw_pervasive=${mlw_src}/pervasive
mlw_include=${mlw_src}/rts/src


if { ../platform_win32.sh ; }
then
  mlw_null=NUL
  mlw_sep=";"
else
  mlw_null=/dev/null
  mlw_sep=":"
fi


#
# Make sure the script cleans up after itself.
#

trap "rm -f kitten cub" 0 1

#
# Create configuration-specific versions of the tests
#

rm -f TEST_kitten.sml TEST_cub.sml
sed -e "s?ARCH_OS?$ARCH/$OS?" TEST_kitten.sml.in > TEST_kitten.sml
sed -e "s?ARCH_OS?$ARCH/$OS?" TEST_cub.sml.in > TEST_cub.sml

#
# Load in the kitten code and dump an executable ...
#

if { ${mlw_rts} -MLWpass args -c 15 -batch -load ${mlw_image} args -tty -pervasive-dir ${mlw_pervasive} < TEST_kitten.sml 1> ${mlw_null} 2>&1 && test -f ./kitten; }
then
  echo "kitten dump ok"
else
  echo "kitten dump failed"
  exit 1
fi


#
# Load in the cub code and dump an executable ...
#

if { ${mlw_rts} -MLWpass args -c 15 -batch -load ${mlw_image} args -tty -pervasive-dir ${mlw_pervasive} < TEST_cub.sml 1> ${mlw_null} 2>&1 && test -f ./cub; }
then
  echo "cub dump ok"
else
  echo "cub dump failed"
  exit 1
fi


#
# Run some tests ...
#
./kitten README.unix README.win32 
./kitten does-not-exist 

./cub README.unix README.win32 
./cub does-not-exist 

exit 0
