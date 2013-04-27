(* __sparc_assembly.sml the structure *)
(*
$Log: __sparc_assembly.sml,v $
Revision 1.10  1995/12/27 15:54:55  jont
Remove __option

Revision 1.9  1994/03/21  15:39:39  matthew
Added IntBTree and Map structures.

Revision 1.8  1993/08/24  11:54:15  jont
Changed $Log to $Log: __sparc_assembly.sml,v $
Changed $Log to Revision 1.10  1995/12/27 15:54:55  jont
Changed $Log to Remove __option
Changed $Log to
Revision 1.9  1994/03/21  15:39:39  matthew
Added IntBTree and Map structures.
 to get the change log

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
require "../utils/__intbtree";
require "../mir/__mirtypes";
require "../debugger/__debugger_types";
require "__machtypes";
require "__sparc_opcodes";
require "_sparc_assembly";

structure Sparc_Assembly_ = Sparc_Assembly(
  structure Crash = Crash_
  structure Lists = Lists_
  structure Map = IntBTree_
  structure MirTypes = MirTypes_
  structure MachTypes = MachTypes_
  structure Sparc_Opcodes = Sparc_Opcodes_
  structure Debugger_Types = Debugger_Types_
)
