(*
 *
 * $Log: sortedlist.sig,v $
 * Revision 1.2  1998/06/11 12:57:11  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(******************************** SortedList *********************************)
(*                                                                           *)
(*  Operations on sorted lists.                                              *)
(*                                                                           *)
(*  Most functions take a (reflexive) ordering relation.                     *)
(*  Some functions take a boolean which is true if duplicates are deleted.   *)
(*  Function add replaces an existing element if duplicates are deleted.     *)
(*  Function sort is stable -- the order of equal elements is maintained if  *)
(*  duplicates are not deleted; otherwise the first element is kept.         *)
(*                                                                           *)
(*****************************************************************************)

signature SORTEDLIST =
sig
   exception Retrieve

   val member   : ('a * 'a -> bool) -> 'a * 'a list -> bool
   val sublist  : ('a * 'a -> bool) -> 'a list * 'a list -> bool
   val le       : ('a * 'a -> bool) -> 'a list * 'a list -> bool
   val sort     : ('a * 'a -> bool) -> bool -> 'a list -> 'a list
   val add      : ('a * 'a -> bool) -> bool -> 'a * 'a list -> 'a list
   val merge    : ('a * 'a -> bool) -> bool -> 'a list * 'a list -> 'a list
   val bigmerge : ('a * 'a -> bool) -> bool -> 'a list list -> 'a list
   val inter    : ('a * 'a -> bool) -> 'a list * 'a list -> 'a list
   val retrieve : ('a -> 'k) -> ('k * 'k -> bool) -> 'k * 'a list -> 'a
   val remove   : ('a -> 'k) -> ('k * 'k -> bool) -> 'k * 'a list -> 'a list
   val del_dups : ('a * 'a -> bool) -> 'a list -> 'a list
   val minus : ('a -> 'k) -> ('k * 'k -> bool) -> 'a list * 'k list -> 'a list
end

