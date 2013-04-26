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
# Distribute the foreign examples.  Expects the directory that will
# contain all the foreign examples as an argument.
#
# Usage: dist_foreign_files.sh dist-dir [ OS ARCH ]
#
# Example:
#
# To distribute all the files to /u/sml/distributions/examples/foreign :-
#
#   $ ./dist_foreign_files.sh /u/sml/distributions/examples/foreign
#
# Revision Log
# ------------
# $Log: dist_foreign_files.sh,v $
# Revision 1.1  1997/05/21 13:02:07  stephenb
# new unit
# [Bug #30121]
#

dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

if { ./platform_win32.sh ; }
then
  readme_type="win32"
  readme_ext=".TXT"
else
  readme_type="unix"
  readme_ext=""
fi

cat README.dist README.${readme_type} > $dist_dir/README${readme_ext}

for dist_script in */DIST.sh
do
  example_dir=`dirname $dist_script`
  $example_dir/PLATFORM.sh && ( cd $example_dir && ./DIST.sh $dist_dir/$example_dir $OS $ARCH )
done


#
# The following is needed because if the last example to be tested
# is not meant to be included in the distribution, then the script
# would return failure.
#
exit 0
