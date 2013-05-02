(*
$Log: ndfa.sml,v $
Revision 1.3  1992/08/18 11:44:14  davidt
Now uses integers instead of strings to represent characters.

Revision 1.2  1992/05/07  11:34:38  richard
Added get_epsilon to extract epsilon edges instead of using a null
string.

Revision 1.1  1991/10/10  15:12:57  davidt
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

signature NDFA = 
  sig
    type ndfa
    eqtype state
    type transitions
    type action

    val epsilon : state list -> transitions
    val single_char : int * state -> transitions
    val mk_trans : (int * state) list -> transitions
    val get_epsilon : (transitions * state list) -> state list
    val get_char : (int * transitions * state list) -> state list

    val empty : ndfa
    val add : ndfa * transitions -> ndfa
    val add_final : ndfa * action -> ndfa
    val add_start : ndfa * state list -> ndfa
    val add_rec : ndfa * (ndfa -> ndfa) -> ndfa

    val start : ndfa -> state
    val set_start : ndfa * state -> ndfa

    val transitions : ndfa * state -> transitions
    val action : ndfa * state -> action
    val num_states : ndfa -> int
  end;
