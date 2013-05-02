(*
Check that we can handle exceptions raised from c correctly

Result: OK
 
$Log: handler_c_raise.sml,v $
Revision 1.7  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.6  1997/11/21  10:54:56  daveb
 * [Bug #30323]
 *
 * Revision 1.5  1997/07/15  15:50:11  daveb
 * [Bug #30200]
 * Made the handler allocate a large list, to check that the in_ML flag
 * is being set correctly.
 *
 * Revision 1.4  1997/05/28  16:40:12  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/31  12:36:57  jont
 * Io has moved into MLWorks.IO
 *
 * Revision 1.2  1996/05/01  17:37:25  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/08/17  12:01:28  jont
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


fun long_list (a,0) = a
  | long_list (a,n) = long_list (n::a, n-1);

val _ =
  (ignore(TextIO.openIn"pooooo"); [])
  handle IO.Io _ =>
    long_list ([], 1000000);
