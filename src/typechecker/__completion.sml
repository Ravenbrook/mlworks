(* __completion.sml the structure *)
(*
$Log: __completion.sml,v $
Revision 1.8  1996/02/26 11:32:28  jont
Change newhashtable to hashtable

 * Revision 1.7  1995/03/24  14:59:36  matthew
 * Adding structure Stamp
 *
Revision 1.6  1993/03/31  13:39:54  jont
Added NameHash and NewHashTable parameters to functor application

Revision 1.5  1993/02/22  10:56:50  matthew
Removed Env structure

Revision 1.4  1993/01/27  14:25:00  matthew
Rationalised structures

Revision 1.3  1992/11/24  17:03:40  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.2  1991/11/21  16:38:07  jont
Added copyright message

Revision 1.1  91/06/07  11:11:04  colin
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

require "../basics/__identprint";
require "../utils/__lists";
require "../utils/__hashtable";
require "__namehash";
require "__types";
require "__stamp";
require "_completion";

structure Completion_ = Completion(
  structure Types      = Types_
  structure IdentPrint = IdentPrint_
  structure HashTable = HashTable_
  structure NameHash = NameHash_
  structure Stamp = Stamp_
  structure Lists      = Lists_);
