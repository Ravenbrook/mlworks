(*

Result: OK
 
$Log: floor.sml,v $
Revision 1.4  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.3  1997/05/28  12:06:52  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.2  1996/05/01  17:11:44  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1994/11/28  15:55:50  matthew
 * new file
 *

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
local
  val top = 536870911;   (* biggest int *)
  val bot = ~536870912;  (* smallest int *)
in    
  val t1 = (ignore(floor (~536870912.5)); false) handle Floor => true
  val t2 = (ignore(floor (536870912.0)); false) handle Floor => true
  val t3 = (floor (~536870912.0) = bot) handle Floor => false
  val t4 = (floor (~536870911.5) = bot) handle Floor => false
  val t5 = (floor (536870911.5) = top) handle Floor => false
  val t6 = (floor (536870911.0) = top) handle Floor => false
  val t7 = (floor (536870910.999) = top-1) handle Floor => false
    (* Normal range cases *)
  val t8 = floor (2.0) = 2
  val t9 = floor (2.8) = 2
  val t10 = floor (~1.8) = ~2
  val t11 = floor (~2.3) = ~3
  val t12 = floor (~2.5) = ~3
  val t13 = floor (~2.8) = ~3
  val t14 = floor (0.0) = 0
  val t15 = floor (~2.0) = ~2

  val _ = 
    if t1 andalso t2 andalso t3 andalso t4 andalso t5 andalso t6 andalso t7 andalso t8 andalso
       t9 andalso t10 andalso t11 andalso t12 andalso t13 andalso t14 andalso t15
      then print"Floor test OK\n"
    else print"Error: error in floor\n"
end
