(*

Result: OK
 
$Log: constant_fold.sml,v $
Revision 1.3  1997/05/28 11:53:33  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.2  1996/05/01  17:10:49  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/11/25  13:41:32  matthew
 * Initial revision
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

(* Test that side-effecting expressions aren't removed by the optimizer in this context *)

exception Test;

val result =
(((raise Test) - (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) * 0) handle Test => 10) = 10
andalso
((0 * (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) div (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) mod 1) handle Test => 10) = 10
andalso
((0 mod (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) mod 0) handle Test => 10 | Mod => 0) = 10
andalso
not (((raise Test) =  (raise Test)) handle Test => false)
andalso
(((raise Test) <>  (raise Test)) handle Test => true)

val _ = if result then print"Pass\n" else print"Fail\n"
