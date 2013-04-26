(*  ==== INITIAL BASIS : ARRAYS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
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
