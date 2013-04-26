(*  ==== INITIAL BASIS : ARRAYS ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: array.sml,v $
 *  Revision 1.2  1996/10/03 15:19:14  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/05/07  15:54:02  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:40:50  jont
 * new unit
 *
 *  Revision 1.1  1995/03/08  16:22:11  brianm
 *  new unit
 *  No reason given
 *
 *
 *)

signature ARRAY =
  sig

    eqtype  'a array
    eqtype  'a vector

    val maxLen : int

    val array : (int * '_a) -> '_a array

    val fromList : '_a list -> '_a array

    val tabulate : (int * (int -> '_a)) -> '_a array

    val length : 'a array -> int

    val sub : ('a array * int) -> 'a

    val update : ('a array * int * 'a) -> unit

    val extract : ('a array * int * int option) -> 'a vector

    val copy : {src : 'a array, si : int, len : int option, dst : 'a array, di : int} -> unit
    val copyVec : {src : 'a vector, si : int, len : int option, dst : 'a array, di : int} -> unit

    val appi : ((int * 'a) -> unit) -> ('a array * int * int option) -> unit
    val app : ('a -> unit) -> 'a array -> unit

    val foldli : ((int * 'a * 'b) -> 'b) -> 'b -> ('a array * int * int option) -> 'b
    val foldri : ((int * 'a * 'b) -> 'b) -> 'b -> ('a array * int * int option) -> 'b
    val foldl : (('a * 'b) -> 'b) -> 'b -> 'a array -> 'b
    val foldr : (('a * 'b) -> 'b) -> 'b -> 'a array -> 'b

    val modifyi : ((int * 'a) -> 'a) -> ('a array * int * int option) -> unit
    val modify : ('a -> 'a) -> 'a array -> unit

  end
