(*
 * The arrays module.
 *
 * Copyright (c) 1992 Harlequin Ltd.
 *
 * $Log: array.sml,v $
 * Revision 1.6  1996/05/21 11:48:15  matthew
 * Removing Copy exception, (replacing with Subscript)
 *
 * Revision 1.5  1993/02/25  18:13:17  matthew
 * Removed Array.T from signature
 *
 *  Revision 1.4  1992/12/21  12:41:04  daveb
 *  Added the agreed 'Array' structure.  Renamed the existing Array structure
 *  to ExtendedArray.
 *
 *  Revision 1.3  1992/08/25  13:51:36  richard
 *  Strengthened the types of all values for which it was possible.
 *  Added tabulate.
 *
 *  Revision 1.2  1992/08/20  12:24:43  richard
 *  Enriched the ARRAY signature.
 *
 *  Revision 1.1  1992/08/07  10:17:13  davidt
 *  Initial revision
 *
 *
 *)

signature ARRAY =
  sig
    eqtype 'a array
(*
    eqtype 'a T
    sharing type T = array
*)
    exception Size
    exception Subscript
    val array: int * '_a -> '_a array
    val arrayoflist: '_a list -> '_a array
    val tabulate: int * (int -> '_a) -> '_a array
    val sub: 'a array * int -> 'a
    val update: 'a array * int * 'a -> unit
    val length: 'a array -> int
  end

signature EXTENDED_ARRAY =
  sig
    (* include "ARRAY" -- omitted to keep SML/NJ happy. *)
    eqtype 'a array
(*
    eqtype 'a T
    sharing type T = array
*)
    exception Size
    exception Subscript
    exception Find

    val array		: int * '_a -> '_a array
    val length		: 'a array -> int
    val update		: 'a array * int * 'a -> unit
    val sub		: 'a array * int -> 'a
    val arrayoflist	: '_a list -> '_a array
    val tabulate	: int * (int -> '_a) -> '_a array

    val from_list	: '_a list -> '_a array
    val to_list		: 'a array -> 'a list
    val fill		: 'a array * 'a -> unit
    val map		: ('a -> '_b) -> 'a array -> '_b array
    val map_index	: (int * 'a -> '_b) -> 'a array -> '_b array
    val iterate		: ('a -> unit) -> 'a array -> unit
    val iterate_index	: (int * 'a -> unit) -> 'a array -> unit
    val rev		: '_a array -> '_a array
    val duplicate	: '_a array -> '_a array
    val subarray	: '_a array * int * int -> '_a array
    val append		: '_a array * '_a array -> '_a array
    val reducel		: ('a * 'b -> 'a) -> ('a * 'b array) -> 'a
    val reducer		: ('a * 'b -> 'b) -> ('a array * 'b) -> 'b
    val reducel_index	: (int * 'a * 'b -> 'a) -> ('a * 'b array) -> 'a
    val reducer_index	: (int * 'a * 'b -> 'b) -> ('a array * 'b) -> 'b
    val copy		: 'a array * int * int * 'a array * int -> unit
    val fill_range	: 'a array * int * int * 'a -> unit
    val find		: ('a -> bool) -> 'a array -> int
    val find_default	: (('a -> bool) * int) -> 'a array -> int
    val maxLen          : int
  end;
