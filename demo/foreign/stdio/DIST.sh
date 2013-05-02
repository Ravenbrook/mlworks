#! /bin/sh
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
# Copy all the user visible files to a new directory
#
# Usage: DIST.sh dist-dir [ OS ARCH ]
#
# Example:
#
#  $ DIST.sh /u/sml/distributions/test/examples/foreign/stdio
#
# Revision Log
# ------------
# $Log: DIST.sh,v $
# Revision 1.1  1997/06/30 15:34:19  stephenb
# new unit
# ** No reason given. **
#
#

dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

rm -rf $dist_dir
mkdir $dist_dir

if { ../platform_win32.sh; }
then
  readme_ext=".TXT"
  os_kind=win32
else
  readme_ext=""
  os_kind=unix
fi


cat README.txt README.${os_kind} > $dist_dir/README${readme_ext}

for file in __cub.sml __kitten.sml $flags
do
  ../../../tools/remove_log.sh < $file > $dist_dir/`basename $file`
done
