(*
 *
 * $Log: Trie.sig,v $
 * Revision 1.2  1998/06/02 15:35:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Trie.sig,v 1.2 1998/06/02 15:35:31 jont Exp $";
(************************************ Trie ***********************************)
(*                                                                           *)
(* This file contains a signature for functions handling tries, a data type  *)
(* for representing sets of lists efficiently, provided there is an ordering *)
(* relation on the elements of lists. Intuitively, a trie is an ordered tree *)
(* branches ordered on the basis of their arc labels; moreover, only one     *)
(* with arcs labeled by distinct elements of the ordered type. String ends   *)
(* are marked by an "EOS" marker, tagged by an associated value.             *)
(*                                                                           *)
(* ('a,'b) trie   - a type of tries having arc labels from 'a and            *)
(*                  "end of list" values from 'b.                            *)
(* ('a,'b) branch - a datatype of branches; these are components of tries.   *)
(*                                                                           *)
(* has_sublist - looks for a sublist of a list in a trie.                    *)
(* rm_superlists - removes the superlists of a list from a tree.             *)
(* subaccset - determines whether accset A << accset B, where A << B means   *)
(*    the following: For all S in A there is T in B  contained in S.         *)
(*    This is here to provide an efficient implementation for AccSet.        *)
(*                                                                           *)
(*****************************************************************************)

signature TRIE =
sig
   type ('a,'b) trie

   val empty  : ('a,'b) trie

   exception Already_in_trie
   exception Not_in_trie

   val insert : ('a * 'a -> bool) -> 'a list * 'b
                -> ('a,'b) trie -> ('a,'b) trie
   val lookup : ('a * 'a -> bool) -> 'a list * ('a,'b) trie -> 'b
   val member : ('a * 'a -> bool) -> 'a list * ('a,'b) trie -> bool
   val remove : ('a * 'a -> bool) -> 'a list -> ('a,'b) trie -> ('a,'b) trie
   val eq     : ('a * 'a -> bool) -> ('b * 'b -> bool)
                -> ('a,'b) trie * ('a,'b) trie -> bool
   val merge  : ('a * 'a -> bool) -> ('a,'b) trie -> ('a,'b) trie
                -> ('a,'b) trie
   val has_sublist : ('a * 'a -> bool) -> ('a,'b) trie -> 'a list -> bool
   val rm_superlists  : ('a * 'a -> bool) -> 'a list
                        -> ('a,'b) trie -> ('a,'b) trie
   val subaccset : ('a * 'a -> bool) -> ('a,unit) trie * ('a,unit) trie -> bool
end

