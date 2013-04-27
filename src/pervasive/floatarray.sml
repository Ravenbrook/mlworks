(*  ==== PERVASIVE FLOATARRAY STRUCTURE ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  Float arrays are mutable objects which differ from arrays of floats
 *  in that the entries are not individually boxed.
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: floatarray.sml,v $
 *  Revision 1.1  1997/01/07 12:44:38  andreww
 *  new unit
 *  [Bug #1818]
 *  Signature for the new pervasive FloatArray structure
 *
 *
 *)

signature FLOATARRAY =
  sig
    eqtype floatarray

    exception Range of int
    exception Size
    exception Subscript
    exception Find

    val array		: int * real -> floatarray
    val length		: floatarray -> int
    val update		: floatarray * int * real -> unit
    val sub		: floatarray * int -> real
    val arrayoflist	: real list -> floatarray

    val tabulate	: int * (int -> real) -> floatarray
    val from_list	: real list -> floatarray
    val to_list		: floatarray -> real list
    val fill		: floatarray * real -> unit
    val map		: (real -> real) -> floatarray -> floatarray
    val map_index	: (int * real -> real) -> floatarray -> floatarray
    val iterate		: (real -> unit) -> floatarray -> unit
    val iterate_index	: (int * real -> unit) -> floatarray -> unit
    val rev		: floatarray -> floatarray
    val duplicate	: floatarray -> floatarray
    val subarray	: floatarray * int * int -> floatarray
    val append		: floatarray * floatarray -> floatarray
    val reducel		: ('a * real -> 'a) -> ('a * floatarray) -> 'a
    val reducer		: (real * 'a -> 'a) -> (floatarray * 'a) -> 'a
    val reducel_index	: (int * 'a * real -> 'a) -> ('a * floatarray) -> 'a
    val reducer_index	: (int * real * 'a -> 'a) -> (floatarray * 'a) -> 'a
    val copy		: floatarray * int * int * floatarray * int -> unit
    val fill_range	: floatarray * int * int * real -> unit
    val find		: (real -> bool) -> floatarray -> int
    val find_default	: ((real -> bool) * int) -> floatarray -> int
    val maxLen          : int
  end;

