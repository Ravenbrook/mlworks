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
# $Log: set_sml_time.sh,v $
# Revision 1.5  1998/10/19 16:38:35  jont
# [Bug #70203]
# Modify for new argument passing
#
# Revision 1.4  1997/04/23  16:13:43  jont
# [Bug #20012]
# Run MLWorks with -batch -no-init -silent
#
# Revision 1.3  1997/04/08  10:22:06  jont
# Reduce amount of output
#
# Revision 1.2  1997/01/08  18:07:33  jont
# [Bug #1816]
# Modify to cope with GNU style pathnames, eg //d/poo
#
# Revision 1.1  1996/12/04  14:26:50  jont
# new unit
# Utility to set file times on sml files in distributions
# after processing to remove headers and add copyrights
#
#
# Set the time stamps on distributed sml basis files
# $1 is ARCH
# $2 is OS
# $3 is file we're copying from
# $4 is file we created
#
NULL=/dev/null
if [ "$OS" = "Windows_NT" -o "$OS" = "NT" -o "$OS" = "Win95" ]
then
  NULL=NUL:
fi
../src/rts/runtime -MLWpass MLWargs -batch -load ../src/images/$1/$2/guib.img MLWargs -no-init -silent -tty -pervasive-dir ../src/pervasive -source-path ../src << EOF 1>$NULL 2>&1
val src_file = "../src/$3"
val dest_file = "$4"
(* Deal with possibility of GNU style pathnames on Win32 *)
val dest_file =
  if String.size dest_file < 4 then
    dest_file
  else
    case String.substring(dest_file, 0, 2) of
      "//" =>
        let
          val char = String.sub(dest_file, 2)
        in
          if Char.isAlpha char andalso String.sub(dest_file, 3) = #"/" then
            Char.toString char ^ ":" ^ String.substring(dest_file, 3, size dest_file - 3)
          else
            dest_file
        end
    | _ => dest_file
val time = OS.FileSys.modTime src_file
val _ = OS.FileSys.setTime(dest_file, SOME time)
EOF
