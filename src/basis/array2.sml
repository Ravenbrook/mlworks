(*  ==== INITIAL BASIS : 2D ARRAYS ====
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
 *  This is part of the extended Basis Library
 *
 *  Revision Log
 *  ------------
 *  $Log: array2.sml,v $
 *  Revision 1.3  1999/02/02 15:58:42  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.2  1997/08/07  10:06:13  brucem
 *  [Bug #30245]
 *  Standard basis signature has been revised, change this to match it.
 *
 *  Revision 1.1  1997/02/28  16:43:52  matthew
 *  new unit
 *
*)

require "__vector";

signature ARRAY2 =
  sig
    eqtype 'a array
    type 'a region = {
      base : 'a array,
      row : int, col : int,
      nrows:int option, ncols : int option}

    datatype traversal = RowMajor | ColMajor

    val array : int * int * 'a -> 'a array
    val fromList : 'a list list -> 'a array
    val tabulate : traversal -> int * int * (int * int -> 'a) -> 'a array

    val sub : 'a array * int * int -> 'a
    val update : 'a array * int * int * 'a -> unit

    val dimensions : 'a array -> int * int
    val nCols : 'a array -> int
    val nRows : 'a array -> int

    val row : 'a array * int -> 'a Vector.vector
    val column : 'a array * int -> 'a Vector.vector

    val copy : {src : 'a region,
                dst : 'a array,
                dst_row : int,
                dst_col : int} -> unit

    val appi    : traversal -> ((int * int * 'a) -> unit) -> 'a region -> unit
    val app     : traversal -> ('a -> unit) -> 'a array -> unit
    val modifyi : traversal -> ((int * int * 'a) -> 'a) -> 'a region -> unit
    val modify  : traversal -> ('a -> 'a) -> 'a array -> unit
    val foldi   : traversal -> (int * int * 'a * 'b -> 'b) -> 'b ->
                  'a region -> 'b
    val fold    : traversal -> (('a * 'b) -> 'b) -> 'b -> 'a array -> 'b

  end (* of signature ARRAY2 *)
