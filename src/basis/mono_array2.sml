(*  ==== INITIAL BASIS : 2D MONO ARRAYS ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
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
