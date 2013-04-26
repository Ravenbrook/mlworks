(*
 *
 * $Log: path.sml,v $
 * Revision 1.2  1998/06/08 17:43:10  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/04/92
Glasgow University and Rutherford Appleton Laboratory.

path.sml

Paths through terms.  Fot efficiency rarely used in practise, but
good for prototyping.

*)

functor PathFUN (structure T : TERM
		) : PATH =

struct
   
   type Term = T.Term
   
   open T

   type Path = int list
   val root = []
   val is_root = null
   val PathEq = eq
   val deepen = snoc
   fun broaden [] = [] | broaden [a] = [a+1] 
     | broaden (a::b::l) = a::broaden (b::l)
   val subpath = fn x =>  C initial_sublist x
   
   val nullary = ou variable constant

   fun termatpath T1 [] = T1
     | termatpath T1 (a::l) = 
       if nullary T1 then T1
       else termatpath (nth_subterm T1 a) l

   fun replace T1 [] T2 = T2
     | replace T1 (a::l) T2 = 
       if nullary T1 then T1
       else mk_OpTerm (root_operator T1) 
       	   (exchange (subterms T1) (a-1)            (* exchange starts at 0 *)
       	   	(replace (nth_subterm T1 a) l T2))  (* nth_subterm starts at 1 *)

   val show_path = stringlist (makestring:int -> string) ("",".","")

end (* of functor PathFUN *)
;



