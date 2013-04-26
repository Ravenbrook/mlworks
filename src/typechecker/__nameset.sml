(* __nameset.sml the structure *)
(*
$Log: __nameset.sml,v $
Revision 1.13  1999/02/02 16:01:38  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.12  1995/03/24  15:10:24  matthew
 * Adding structure Stamp
 *
Revision 1.11  1995/02/02  13:46:16  matthew
Removing debug stuff

Revision 1.10  1993/03/17  18:28:58  matthew
Added NamesetTypes structure

Revision 1.9  1993/03/02  16:27:35  matthew
Indentation change (hardly worth it)

Revision 1.8  1993/02/08  17:37:49  matthew
Nameset type definition moved to BasisTypes

Revision 1.7  1992/09/08  17:11:39  jont
Added Crash = Crash_ to main functor application

Revision 1.6  1992/08/04  15:45:50  davidt
Took out redundant Array arguement and require.

Revision 1.5  1992/07/16  19:12:29  jont
added btree parameter

Revision 1.4  1992/06/30  10:30:37  jont
Changed to imperative implementation of namesets with hashing

Revision 1.1  1992/04/21  17:20:19  jont
Initial revision

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

require "../utils/__set";
require "../utils/__crash";
require "../utils/__print";
require "__types";
require "__strnames";
require "__namesettypes";
require "__stamp";
require "_nameset";

structure Nameset_ = Nameset(
  structure Set       = Set_
  structure Crash     = Crash_
  structure Print     = Print_
  structure Types     = Types_
  structure NamesetTypes = NamesetTypes_
  structure Strnames  = Strnames_
  structure Stamp = Stamp_
);
