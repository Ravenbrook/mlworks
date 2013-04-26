(*  ==== INITIAL BASIS :  VECTORS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
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
