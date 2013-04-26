(* simpletypes.sml the signature *)
(*
$Log: stamp.sml,v $
Revision 1.2  1996/02/26 12:47:57  jont
mononewmap becomes monomap

 * Revision 1.1  1995/04/06  12:52:30  matthew
 * new unit
 * Replacement for tyfun_id's etc
 *

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

require "../utils/monomap";

signature STAMP  =
  sig 
    structure Map : MONOMAP
    eqtype Stamp
    sharing type Stamp = Map.object
    val make_stamp_n : int -> Stamp
    val make_stamp : unit -> Stamp
    val stamp : Stamp -> int
    val string_stamp : Stamp -> string
    val stamp_lt : (Stamp * Stamp) -> bool
    val stamp_eq : Stamp * Stamp -> bool
    val reset_counter : int -> unit
    val read_counter : unit -> int
    val push_counter : unit -> unit
    val pop_counter : unit -> unit
  end;
