(* __sharetypes.sml the structure *)
(*
$Log: __sharetypes.sml,v $
Revision 1.5  1995/02/02 13:54:24  matthew
Removing debug stuff

Revision 1.4  1993/05/20  16:32:40  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.3  1992/01/27  18:17:52  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:40:45  jont
Added copyright message

Revision 1.1  91/06/07  11:22:51  colin
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
require "../typechecker/__datatypes";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__assemblies";
require "../typechecker/__nameset";
require "../typechecker/__namesettypes";
require "../typechecker/_sharetypes";

structure Sharetypes_ = Sharetypes(
  structure Print = Print_
  structure Datatypes = Datatypes_
  structure Types = Types_
  structure Conenv = Valenv_
  structure Assemblies = Assemblies_
  structure Nameset = Nameset_
  structure NamesetTypes = NamesetTypes_
);
