(*  ==== PERVASIVE BYTEARRAY STRUCTURE ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  Byte arrays are mutable objects which resemble arrays by may only
 *  contain integers in the range [0, 255].
 *
 *  Revision Log
 *  ------------
 *  $Log: bytearray.sml,v $
 *  Revision 1.4  1996/05/21 11:47:55  matthew
 *  Removing Copy exception, (replacing with Subscript)
 *
 * Revision 1.3  1993/03/24  17:28:49  jont
 * Added Find to list of visible exceptions
 *
 *  Revision 1.2  1993/02/25  18:17:01  matthew
 *  Remove ByteArray.T from signature
 *
 *  Revision 1.1  1992/08/24  10:29:04  richard
 *  Initial revision
 *
 *)

signature BYTEARRAY =
  sig
    eqtype bytearray

    exception Range of int
    exception Size
    exception Subscript
    exception Substring
    exception Find

    val array		: int * int -> bytearray
    val length		: bytearray -> int
    val update		: bytearray * int * int -> unit
    val sub		: bytearray * int -> int
    val arrayoflist	: int list -> bytearray

    val tabulate	: int * (int -> int) -> bytearray
    val from_list	: int list -> bytearray
    val to_list		: bytearray -> int list
    val from_string	: string -> bytearray
    val to_string	: bytearray -> string
    val fill		: bytearray * int -> unit
    val map		: (int -> int) -> bytearray -> bytearray
    val map_index	: (int * int -> int) -> bytearray -> bytearray
    val iterate		: (int -> unit) -> bytearray -> unit
    val iterate_index	: (int * int -> unit) -> bytearray -> unit
    val rev		: bytearray -> bytearray
    val duplicate	: bytearray -> bytearray
    val subarray	: bytearray * int * int -> bytearray
    val substring	: bytearray * int * int -> string
    val append		: bytearray * bytearray -> bytearray
    val reducel		: ('a * int -> 'a) -> ('a * bytearray) -> 'a
    val reducer		: (int * 'a -> 'a) -> (bytearray * 'a) -> 'a
    val reducel_index	: (int * 'a * int -> 'a) -> ('a * bytearray) -> 'a
    val reducer_index	: (int * int * 'a -> 'a) -> (bytearray * 'a) -> 'a
    val copy		: bytearray * int * int * bytearray * int -> unit
    val fill_range	: bytearray * int * int * int -> unit
    val find		: (int -> bool) -> bytearray -> int
    val find_default	: ((int -> bool) * int) -> bytearray -> int
    val maxLen          : int
  end;
