(*  ==== INITIAL BASIS : MONO ARRAYS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
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
