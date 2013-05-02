(* __valenv.sml the structure *)
(*
$Log: __valenv.sml,v $
Revision 1.9  1995/05/26 10:10:52  matthew
Get list of builtin library values from Primitives

Revision 1.8  1995/02/02  14:08:26  matthew
Removing debug structure

Revision 1.7  1994/05/04  17:32:19  daveb
Added Info structure.

Revision 1.6  1992/08/11  17:54:11  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/07/16  18:59:28  jont
added btree parameter

Revision 1.4  1992/01/27  18:57:45  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.3  1992/01/27  18:57:45  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:43:32  jont
Added copyright message

Revision 1.1  91/06/07  11:33:58  colin
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

require "../utils/__crash";
require "../utils/__lists";
require "../main/__info";
require "../main/__primitives";
require "../basics/__identprint";
require "../typechecker/__types";
require "../typechecker/__scheme";

require "../typechecker/_valenv";

structure Valenv_ = Valenv(
  structure Crash     = Crash_
  structure Lists     = Lists_
  structure Info      = Info_
  structure Primitives      = Primitives_
  structure IdentPrint = IdentPrint_
  structure Types     = Types_
  structure Scheme    = Scheme_
);



