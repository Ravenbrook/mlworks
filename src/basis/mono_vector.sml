(*  ==== INITIAL BASIS : MONO-VECTORS ====
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
 *  $Log: mono_vector.sml,v $
 *  Revision 1.6  1998/11/13 10:32:10  mitchell
 *  [Bug #70225]
 *  Add a variant of the signature where the vector type admits equality
 *
 *  Revision 1.5  1997/08/08  10:19:39  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.4  1997/01/29  17:22:15  andreww
 *  [Bug #1904]
 *  elem type no longer an equality type
 *
 *  Revision 1.3  1996/10/03  15:22:14  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/05/17  14:17:15  matthew
 *  Updating
 *
 *  Revision 1.1  1996/04/18  11:44:20  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:44:20  jont
 * new unit
 *
 *  Revision 1.2  1995/03/18  18:37:05  brianm
 *  Made all types into eqtypes (as per the current draft).
 *
 * Revision 1.1  1995/03/16  21:18:41  brianm
 * new unit
 *renamed from mono_vectors.sml
 *
 *)

signature MONO_VECTOR =
  sig

    type elem
    type vector

    val maxLen : int
    val fromList : elem list -> vector
    val tabulate : (int * (int -> elem)) -> vector

    val length   : vector -> int
    val sub      : (vector * int) -> elem
    val extract  : (vector * int * int option) -> vector
    val concat   : vector list -> vector

    val appi : ((int * elem) -> unit) -> (vector * int * int option) -> unit
    val app : (elem -> unit) -> vector -> unit

    val foldli : ((int * elem * 'a) -> 'a) -> 'a -> (vector * int * int option)
                 -> 'a
    val foldri : ((int * elem * 'a) -> 'a) -> 'a -> (vector * int * int option)
                 -> 'a
    val foldl : ((elem * 'a) -> 'a) -> 'a -> vector -> 'a
    val foldr : ((elem * 'a) -> 'a) -> 'a -> vector -> 'a

    val map  : (elem -> elem) -> vector -> vector
    val mapi : (int * elem -> elem) -> vector * int * int option -> vector

  end

signature EQ_MONO_VECTOR =
  sig

    eqtype elem
    eqtype vector

    val maxLen : int
    val fromList : elem list -> vector
    val tabulate : (int * (int -> elem)) -> vector

    val length   : vector -> int
    val sub      : (vector * int) -> elem
    val extract  : (vector * int * int option) -> vector
    val concat   : vector list -> vector

    val appi : ((int * elem) -> unit) -> (vector * int * int option) -> unit
    val app : (elem -> unit) -> vector -> unit

    val foldli : ((int * elem * 'a) -> 'a) -> 'a -> (vector * int * int option)
                 -> 'a
    val foldri : ((int * elem * 'a) -> 'a) -> 'a -> (vector * int * int option)
                 -> 'a
    val foldl : ((elem * 'a) -> 'a) -> 'a -> vector -> 'a
    val foldr : ((elem * 'a) -> 'a) -> 'a -> vector -> 'a

    val map  : (elem -> elem) -> vector -> vector
    val mapi : (int * elem -> elem) -> vector * int * int option -> vector

  end

