(*

Result: OK
 
$Log: division.sml,v $
Revision 1.5  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.4  1997/05/28  11:53:54  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/02  15:27:33  matthew
 * Updating
 *
 * Revision 1.2  1996/05/01  17:11:12  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1994/11/23  16:59:20  matthew
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

(* Some tests for the correctness of division functions *)

let
fun f (x,y) = (x div y,x mod y)

val top = 536870911
val bot = ~536870912

in
  if 
    f (5,3) = (1,2) andalso
    f (~5,3) = (~2,1) andalso
    f (5,~3) = (~2,~1) andalso
    f (~5,~3) = (1,~2) andalso
    f (105,10) = (10,5) andalso
    f (1000000,100) = (10000,0) andalso
    f (bot,1) = (bot,0) andalso
    ((ignore(f (bot,~1)); false) handle Overflow => true) andalso
    ((ignore(f (bot,0)); false) handle Div => true) andalso
    ((ignore(f (0,0)); false) handle Div => true) andalso
    f (bot,~2) = (268435456, 0)
    then print"Div test succeeded\n"
  else print"Error: error in division test\n"
end;
