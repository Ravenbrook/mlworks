(* __topdecprint.sml the structure *)
(*
$Log: __topdecprint.sml,v $
Revision 1.7  1996/10/31 15:55:57  io
[Bug #1614]
remove Lists

 * Revision 1.6  1995/11/22  09:15:31  daveb
 * Removed ModuleId parameter.
 *
Revision 1.5  1993/07/29  14:03:00  daveb
Added ModuleId parameter.

Revision 1.4  1992/09/16  08:40:20  daveb
Type printing routines now require Lists_ structure.

Revision 1.3  1991/07/25  17:44:06  jont
Corrected the requires to use structures. This bug should be spotted by
the compiler, but ...

Revision 1.2  91/07/22  17:28:00  davida
Added pretty-printing for signature expressions, provisionally.

Revision 1.1  91/07/10  09:36:00  jont
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

require "__pretty";
require "../basics/__absyn";
require "../basics/__absynprint";
require "../basics/__identprint";
require "_topdecprint";

structure TopdecPrint_ = TopdecPrint(
  structure Pretty = Pretty_
  structure Absyn = Absyn_
  structure AbsynPrint = AbsynPrint_
  structure IdentPrint = IdentPrint_
  );

