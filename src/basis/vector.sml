(*  ==== INITIAL BASIS :  VECTORS ====
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
 *  $Log: vector.sml,v $
 *  Revision 1.3  1997/08/07 14:48:34  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.2  1996/10/03  15:27:39  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/05/07  16:14:09  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:47:04  jont
 * new unit
 *
 *  Revision 1.1  1995/03/08  16:26:21  brianm
 *  new unit
 *  No reason given
 *
 *
 *)

signature VECTOR =
  sig

    eqtype  'a vector

    val maxLen : int

    val fromList : 'a list -> 'a vector

    val tabulate : (int * (int -> 'a)) -> 'a vector

    val length : 'a vector -> int

    val sub : ('a vector * int) -> 'a

    val extract : ('a vector * int * int option) -> 'a vector

    val concat : 'a vector list -> 'a vector

    val appi : ((int * 'a) -> unit) -> ('a vector * int * int option) -> unit
    val app : ('a -> unit) -> 'a vector -> unit

    val foldli : ((int * 'a * 'b) -> 'b) -> 'b -> ('a vector * int * int option) -> 'b
    val foldri : ((int * 'a * 'b) -> 'b) -> 'b -> ('a vector * int * int option) -> 'b
    val foldl : (('a * 'b) -> 'b) -> 'b -> 'a vector -> 'b
    val foldr : (('a * 'b) -> 'b) -> 'b -> 'a vector -> 'b

    val map  : ('a -> 'b) -> 'a vector -> 'b vector
    val mapi : (int * 'a -> 'b) -> 'a vector * int * int option -> 'b vector

  end
