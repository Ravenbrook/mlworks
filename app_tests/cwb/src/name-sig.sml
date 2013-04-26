(*
 *
 * $Log: name-sig.sml,v $
 * Revision 1.2  1998/06/02 15:44:11  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 	$Id: name-sig.sml,v 1.2 1998/06/02 15:44:11 jont Exp $	 *)
(* name-sig.sml
 *
 * COPYRIGHT (c) 1992 by AT&T Bell Laboratories
 *
 * AUTHOR:	John Reppy
 *		AT&T Bell Laboratories
 *		Murray Hill, NJ 07974
 *		jhr@research.att.com
 *)
(* MODIFICATION: *)
(* Perdita added hashOf to this sig. This breaks the encapsulation,    *)
(* but is a win since we often want to plug these hash values into     *)
(* hash values for bigger things, and it saves recalculating them. *)
signature NAME =
  sig

  (* unique names *)
    type name

    val mkName : string -> name
	(* Map a string to the corresponding unique name. *)
    val sameName : (name * name) -> bool
	(* return true if the names are the same *)
    val stringOf : name -> string
	(* return the string representation of the name *)
(* CAUTION: broken encapsulation! *)
    val hashOf : name -> int
	(* return the hash value of the name *)

  (* hash tables keyed by symbols *)
    type 'a name_tbl

    val mkNameTbl : (int * exn) -> '1a name_tbl
	(* create a new table; the int is a size hint and the exception
	 * is to be raised by find.
	 *)
    val numItems : 'a name_tbl -> int
	(* return the number of elements in the table *)
    (* MLA -- made imperative *)
    val listItems : '_a name_tbl -> (name * '_a) list
	(* return the keyed list of table entries *)
    val insert : '2a name_tbl -> (name * '2a) -> unit
	(* insert a new entry; this will replace any previous entry with the
	 * same key.
	 *)
    val remove : 'a name_tbl -> name -> 'a
	(* remove an entry, returning the item.  Raise the table's exception
	 * if there is no entry with the given key.
	 *)
    val find : 'a name_tbl -> name -> 'a
	(* find an entry; raise the table's exception if there is no entry with
	 * the given key.
	 *)
    val peek : 'a name_tbl -> name -> 'a option
	(* Look for an entry; return NONE if there is no entry with the given key. *)
    val apply : ((name * 'a) -> 'b) -> 'a name_tbl -> unit
	(* apply a function to the entries of the table *)
    val filter : ((name * 'a) -> bool) -> 'a name_tbl -> unit
	(* remove any name table items that do not satisfy the given
	 * predicate.
	 *)
    val map : ((name * 'a) -> '2b) -> 'a name_tbl -> '2b name_tbl
	(* apply a function to the entries of the table *)
    val transform : ('a -> '2b) -> 'a name_tbl -> '2b name_tbl
	(* map a table to a new table *)
    val copy : '1a name_tbl -> '1a name_tbl
	(* create a copy of a name table *)

  end (* signature NAME *)
