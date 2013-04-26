(*  ==== INITIAL BASIS : 2D ARRAYS ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
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
