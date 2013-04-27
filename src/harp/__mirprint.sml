(* __mirprint.sml the structure *)
(*
$Log: __mirprint.sml,v $
Revision 1.11  1993/05/18 15:18:53  jont
Removed integer parameter

Revision 1.10  1993/01/05  16:01:38  jont
Some tidying up

Revision 1.9  1992/06/16  19:02:56  jont
Added crash parameter to functor application

Revision 1.8  1992/02/06  11:12:27  jont
Removed lambdasub and pretty from parameter list

Revision 1.7  1992/01/03  16:02:59  richard
Added Option module to dependencies.

Revision 1.6  1991/10/03  10:51:53  jont
Added Set parameter

Revision 1.5  91/09/20  13:54:31  richard
Modified register printing functions to display the names of the
special registers rather than their numbers.

Revision 1.4  91/09/09  14:06:10  davida
Changed to use reduce function from Lists

Revision 1.3  91/08/01  14:28:55  jont
More opcodes printed

Revision 1.2  91/07/30  11:42:54  jont
Added reference to __lambdasub

Revision 1.1  91/07/25  15:01:15  jont
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
require "../basics/__identprint";
require "__mirregisters";
require "_mirprint";

structure MirPrint_ = MirPrint(
  structure Lists = Lists_
  structure Crash = Crash_
  structure IdentPrint = IdentPrint_
  structure MirRegisters = MirRegisters_
)
