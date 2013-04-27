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
# $Log: mk_interface.sh,v $
# Revision 1.16  1997/01/06 13:24:48  jont
# [Bug #0]
# Ensure interface.sml and __interface.sml are always built when requested
# Remove some unnecessary stuff after simplifying flatten.sh
#
# Revision 1.15  1996/12/20  17:53:44  jont
# [Bug #1816]
# Leave compilation stuff to makefiles
# Considerable simplifications
#
#
#  This script delivers the FFI as an encapsulated object:
#
#  1. constructs a couple of ML source files from the current source
#     files:
#
#        foreign/interface.sml     --- signature
#        foreign/__interface.sml   --- structure
#
#  This script is invoked from images/GNUmake as a part of building foreign.img
#  
#  There are no options to this script:
#  
# Comments:
# ---------

cd `dirname $0`
flatten=../../tools/flatten.sh
remove_src_hdr=../../tools/remove_src_hdr.sh
echo "Making interface.sml"
rm -f interface.sml
set `date`
year=$6

cat - <<\%%%% > interface.sml
(* ==== Foreign Interface signature file : interface.sml ====
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)
%%%%

ptmp1=%ptmp1%.$$
cat foreign.sml | $remove_src_hdr > $ptmp1
sed -e 's;FOREIGN_INTERFACE;INTERFACE;g' $ptmp1 >> interface.sml 

rm -f $ptmp1 buildlist __interface.sml
cat - <<%%%% > buildlist
__libml.sml
__static_bytearray.sml
__types.sml
__utils.sml
__store.sml
__core.sml
__aliens.sml
__object.sml
__structure.sml
__c_object.sml
__signature.sml
__c_signature.sml
__c_structure.sml
__c_function.sml
__foreign.sml
%%%%

$flatten "interface" "INTERFACE" "Interface" buildlist

rm -f buildlist

if test -f interface.sml
then :
else echo "mk_interface : can't find foreign/interface.sml"
     exit 1
fi
if test -f __interface.sml
then :
else echo "mk_interface : can't find foreign/__interface.sml"
     exit 1
fi
