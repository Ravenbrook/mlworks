(*
Some cases that have broken the switch translation: 3 and 3a

Result: OK

$Log: switch3.sml,v $
Revision 1.2  1993/01/21 12:05:09  daveb
Updated header.

Revision 1.1  1992/11/04  17:11:54  daveb
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


(* Case 3:
   2 VCCs and 2 IMMs.
   Need VCC in switch.  Extra one doesn't affect things.
   Need 0 IMMs in switch.
*)

datatype Action =
      Shift
    | Reduce of int * int * int
    | Funcall of int * int * Action * Action
    | NoAction

fun convert_action a =
  if a = ~1 then
    NoAction
  else
    Reduce (2,3,4)

fun is_reduction n =
  case (convert_action n) of
    Reduce _ => true
  | _ => false

fun f _ = is_reduction 3 


(* Case 3a:
   2 VCCs and 2 IMMs.
   Need IMM in switch.  Extra one doesn't affect things.
   Need 0 VCCs in switch.
*)

datatype Action =
      Shift
    | Reduce of int * int * int
    | Funcall of int * int * Action * Action
    | NoAction

fun convert_action a =
  if a = ~1 then
    NoAction
  else
    Reduce (2,3,4)

fun is_reduction n =
  case (convert_action n) of
    Shift => true
  | _ => false

fun f _ = is_reduction 3 

