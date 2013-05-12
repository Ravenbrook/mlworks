(* mirtables.sml the structure *)

(* $Log: __mirtables.sml,v $
 * Revision 1.4  1993/11/01 16:31:50  nickh
 * Merging in structure simplification.
 *
Revision 1.3.1.2  1993/11/01  16:24:54  nickh
Removed unused substructures of MirTables

Revision 1.3.1.1  1992/01/31  09:26:00  jont
Fork for bug fixing

Revision 1.3  1992/01/31  09:26:00  richard
Added Option module.

Revision 1.2  1991/10/15  09:53:08  richard
Added Table to dependencies.

Revision 1.1  91/10/09  13:07:28  richard
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
require "../utils/__crash";
require "__mirregisters";
require "_mirtables";


structure MirTables_ = MirTables(
  structure Lists = Lists_
  structure Crash = Crash_
  structure MirRegisters = MirRegisters_
)
