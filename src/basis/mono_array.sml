(*  ==== INITIAL BASIS : MONO ARRAYS ====
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
 *  $Log: mono_array.sml,v $
 *  Revision 1.5  1999/03/20 21:46:05  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.4  1997/01/29  14:09:23  andreww
 *  [Bug #1904]
 *  elem type no longer an equality type
 *
 *  Revision 1.3  1996/10/03  15:22:04  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/05/17  12:23:37  matthew
 *  Updating
 *
 *  Revision 1.1  1996/04/18  11:44:00  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:44:00  jont
 * new unit
 *
 *  Revision 1.3  1995/03/18  17:52:59  brianm
 *  Changed spelling of arrayoflist to arrayOfList and
 *  made all types eqtypes (as per current draft).
 *
 * Revision 1.2  1995/03/17  16:59:49  brianm
 * Adding copy and copyv to signature ...
 *
 * Revision 1.1  1995/03/16  21:17:46  brianm
 * new unit
 * renamed from mono-arrays.sml
 *
 *)

signature MONO_ARRAY =
  sig

    eqtype array
    type elem
    type vector

    val maxLen : int

    (* array creation functions *)
    val array       : (int * elem) -> array
    val fromList : elem list -> array
    val tabulate    : (int * (int -> elem)) -> array

    val length      : array -> int
    val sub         : (array * int) -> elem
    val update      : (array * int * elem) -> unit
    val extract     : (array * int * int option) -> vector

    val copy        : { src : array, si : int, len : int option,
                        dst : array, di : int
                      } -> unit

    val copyVec       : { src : vector, si : int, len : int option,
                        dst : array, di : int
                      } -> unit

    val appi : ((int * elem) -> unit) -> (array * int * int option) -> unit
    val app : (elem -> unit) -> array -> unit

    val foldli : ((int * elem * 'b) -> 'b) -> 'b -> (array * int * int option) -> 'b
    val foldri : ((int * elem * 'b) -> 'b) -> 'b -> (array * int * int option) -> 'b
    val foldl : ((elem * 'b) -> 'b) -> 'b -> array -> 'b
    val foldr : ((elem * 'b) -> 'b) -> 'b -> array -> 'b

    val modifyi : ((int * elem) -> elem) -> (array * int * int option) -> unit
    val modify : (elem -> elem) -> array -> unit

  end
