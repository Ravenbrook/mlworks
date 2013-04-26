(*
 *
 * $Log: path.sig,v $
 * Revision 1.2  1998/06/08 17:42:41  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/04/92
Glasgow University and Rutherford Appleton Laboratory.

path.sig

Paths through terms.  Fot efficiency rarely used in practise, but
good for prototyping.

*)

signature PATH =
   sig 
	type Term 

	type Path
   	val root : Path
   	val is_root : Path -> bool
   	val PathEq : Path -> Path -> bool
   	val deepen : Path -> int -> Path
   	val broaden : Path -> Path
   	val subpath : Path -> Path -> bool
   	val termatpath : Term -> Path -> Term
   	val replace : Term -> Path -> Term -> Term
   	
   	val show_path : Path -> string

   end (* of signature PATH *)
   ;


