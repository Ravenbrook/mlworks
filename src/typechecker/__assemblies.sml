(* __assemblies.sml the structure *)
(*
$Log: __assemblies.sml,v $
Revision 1.17  1996/02/26 11:31:24  jont
Change newhashtable to hashtable

 * Revision 1.16  1995/02/07  16:38:40  matthew
 * Removing debug stuff
 *
Revision 1.15  1993/05/25  14:54:32  jont
Added strenv and basistypes parameters

Revision 1.14  1993/05/18  18:10:51  jont
Removed integer parameter

Revision 1.13  1992/10/29  18:14:49  jont
Recast in terms of intnewmap

Revision 1.12  1992/09/21  11:37:36  clive
Changed hashtables to a single structure implementation

Revision 1.11  1992/08/13  18:06:12  jont
Added require of __datatypes

Revision 1.10  1992/08/12  10:57:50  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.9  1992/08/04  15:44:32  davidt
Took out redundant Array arguement and require.

Revision 1.8  1992/07/17  08:28:58  clive
The require "__array.sml" had been omitted

Revision 1.7  1992/07/15  16:19:27  jont
Extra parameters to do with hashsets added

Revision 1.5  1992/06/26  16:43:11  jont
Chnaged implementation of TypeAssemblies to avoid so much comparison of
tyfuns (expensive). Further improvements could be made by using namesets

Revision 1.4  1992/04/14  17:31:47  jont
Added lists parameter to functor application

Revision 1.3  1992/01/27  17:26:24  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  20:03:26  jont
Added copyright message

Revision 1.1  91/06/07  11:07:25  colin
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

require "../utils/__lists";
require "../utils/__intbtree";
require "../utils/__print";
require "../utils/__crash";
require "../utils/_hashset";
require "../utils/__hashtable";
require "../basics/__identprint";
require "__datatypes";
require "__types";
require "__strnames";
require "__valenv";
require "__tyenv";
require "__strenv";
require "__environment";
require "__basistypes";
require "../typechecker/__namehash";
require "_assemblies";

structure Assemblies_ = Assemblies(
  structure StrnameSet = HashSet(
    structure Crash = Crash_
    structure Lists = Lists_
    type element = Datatypes_.Strname
    val eq = Strnames_.strname_eq
    val hash = NameHash_.strname_hash
    val size = 512
  )
  structure TyfunSet = HashSet(
    structure Crash = Crash_
    structure Lists = Lists_
    type element = Datatypes_.Tyfun
    val eq = Types_.tyfun_eq
    val hash = NameHash_.tyfun_hash
    val size = 512
  )
  structure Lists     = Lists_
  structure IntMap    = IntBTree_
  structure Print     = Print_
  structure Crash     = Crash_
  structure IdentPrint = IdentPrint_
  structure Conenv    = Valenv_
  structure Types     = Types_
  structure Strnames  = Strnames_
  structure Tyenv     = Tyenv_
  structure Strenv    = Strenv_
  structure Env       = Environment_
  structure Basistypes = BasisTypes_
  structure NameHash  = NameHash_
  structure HashTable = HashTable_
);
