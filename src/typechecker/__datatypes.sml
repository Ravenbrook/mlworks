(* __datatypes.sml the structure *)
(*
$Log: __datatypes.sml,v $
Revision 1.11  1996/02/21 17:17:06  jont
Removing map in favour of newmap

 * Revision 1.10  1995/12/27  15:56:53  jont
 * Remove __option
 *
Revision 1.9  1995/03/23  11:05:03  matthew
Replacing Tyname_id etc. with Stamp structure

Revision 1.8  1993/07/30  10:45:45  nosa
structure Option.

Revision 1.7  1993/07/06  13:14:44  daveb
Removed Interface structure.  Added Ident and NewMap structures.

Revision 1.6  1993/02/08  11:49:48  matthew
Removed redundant structures

Revision 1.5  1993/01/25  18:13:22  matthew
Rationalised parameter structures

Revision 1.4  1992/08/11  10:55:47  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1992/07/30  10:55:59  jont
Anel's changes to use NewMap instead of Map

Revision 1.2  1991/11/21  16:38:52  jont
Added copyright message

Revision 1.1  91/06/07  11:12:38  colin
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
require "../utils/__btree";
require "../basics/__ident";
require "__stamp";
require "_datatypes";

structure Datatypes_ =
  Datatypes (structure Stamp = Stamp_
	     structure Ident 	  = Ident_
	     structure NewMap 	  = BTree_
            )
