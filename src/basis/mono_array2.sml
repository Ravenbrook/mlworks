(*  ==== INITIAL BASIS : 2D MONO ARRAYS ====
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
 *  This is part of the Basis Library.
 *
 *  Revision Log
 *  ------------
 *  $Log: mono_array2.sml,v $
 *  Revision 1.4  1999/03/20 21:46:26  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.3  1997/08/08  08:33:08  brucem
 *  [Bug #30245]
 *  Fix mistake (traversal spelt as traveral).
 *
 *  Revision 1.2  1997/08/07  10:04:55  brucem
 *  [Bug #30245]
 *  Standard basis signature has been revised, change this to match it.
 *
 *  Revision 1.1  1997/02/28  16:46:22  matthew
 *  new unit
 *
*)

require "__array2";

signature MONO_ARRAY2 =
  sig
    eqtype array
    type elem
    type vector

    type region = {
      base : array,
      row : int, col : int,
      nrows : int option, ncols : int option}

    datatype traversal = datatype Array2.traversal

    val array : int * int * elem -> array
    val fromList : elem list list -> array
    val tabulate : traversal -> int * int * (int * int -> elem) -> array

    val sub : array * int * int -> elem
    val update : array * int * int * elem -> unit

    val dimensions : array -> int * int
    val nCols : array -> int
    val nRows : array -> int

    val row : array * int -> vector
    val column : array * int -> vector

    val copy : {src : region,
                dst : array,
                dst_row : int,
                dst_col : int} -> unit

    val appi    : traversal -> ((int * int * elem) -> unit) -> region -> unit
    val app     : traversal -> (elem -> unit) -> array -> unit
    val modifyi : traversal -> ((int * int * elem) -> elem) -> region -> unit
    val modify  : traversal -> (elem -> elem) -> array -> unit
    val foldi   : traversal -> (int * int * elem * 'a -> 'a) -> 'a ->
                  region -> 'a
    val fold    : traversal -> ((elem * 'a) -> 'a) -> 'a -> array -> 'a
  end
