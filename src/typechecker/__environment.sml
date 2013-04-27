(* __environment.sml the structure *)
(*
$Log: __environment.sml,v $
Revision 1.14  1996/02/26 11:30:30  jont
Change newhashtable to hashtable

 * Revision 1.13  1995/03/24  15:07:42  matthew
 * Adding structure Stamp
 *
Revision 1.12  1995/02/07  12:05:30  matthew
Stuff

Revision 1.11  1994/09/22  16:01:00  matthew
Added Tystr

Revision 1.10  1993/02/04  15:18:51  matthew
Added hashtable parameter
Used for caching structure operations.

Revision 1.9  1992/08/11  12:53:15  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.8  1992/08/06  13:36:19  jont
Anel's changes to use NewMap instead of Map

Revision 1.6  1992/07/16  16:25:51  jont
Added btree parameter

Revision 1.5  1992/04/15  13:21:30  jont
Changed to require __lists instead of __set

Revision 1.4  1992/01/27  17:44:31  jont
Added ty_debug parameter

Revision 1.3  1991/11/21  16:39:07  jont
Added copyright message

Revision 1.2  91/11/13  13:47:12  richard
Added dependency on the new Strenv module.

Revision 1.1  91/06/07  11:15:09  colin
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

require "../utils/__print";
require "../utils/__hashtable";
require "../basics/__identprint";
require "__strnames";
require "__types";
require "__scheme";
require "__valenv";
require "__tyenv";
require "__strenv";
require "__stamp";
require "_environment";

structure Environment_ = Environment(
  structure HashTable = HashTable_
  structure Print      = Print_
  structure Strnames   = Strnames_
  structure IdentPrint = IdentPrint_
  structure Types      = Types_
  structure Scheme     = Scheme_
  structure Valenv     = Valenv_
  structure Tyenv      = Tyenv_
  structure Strenv     = Strenv_
  structure Stamp      = Stamp_
);
