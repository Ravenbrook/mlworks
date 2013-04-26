(* inthashtable the signature *)
(*
$Log: inthashtable.sml,v $
Revision 1.4  1997/05/01 12:57:49  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.3  1996/10/03  09:36:40  matthew
 * Generalizing type of map
 *
 * Revision 1.2  1995/01/03  16:48:06  matthew
 * Sorting out type names
 *
 * Revision 1.1  1994/09/23  14:49:21  matthew
 * new file
 *
 * Copyright (c) 1994 Harlequin Ltd.
 *)

signature INTHASHTABLE =
  sig
    type '_a T
    exception Lookup 
    val new     : int -> '_a T
    val lookup  : ('_a T * int) -> '_a
    val lookup_default  : ('_a T * '_a * int) -> '_a
    val tryLookup : ('_a T * int) -> '_a option
    val is_defined : ('_a T * int) -> bool
    val update  : ('_a T * int * '_a) -> unit
    val delete  : ('_a T * int) -> unit
    val to_list : '_a T -> (int * '_a) list
    val copy    : '_a T -> '_a T
    val map     : (int * '_a -> '_b) -> '_a T -> '_b T
    val fold    : ('b * int * '_a -> 'b) -> ('b * '_a T) -> 'b
    val iterate : (int * '_a -> unit) -> '_a T -> unit
    val stats : '_a T -> {size:int, count:int, smallest:int, largest:int}
    val print_stats : '_a T -> unit
  end
