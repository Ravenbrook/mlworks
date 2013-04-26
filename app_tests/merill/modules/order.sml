(*
 *
 * $Log: order.sml,v $
 * Revision 1.2  1998/06/08 17:44:28  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

order.ml

Some datatypes and functions to help with the definitions
of term orderings.

*)

functor OrderFUN () : ORDER =

struct

datatype ORIENTATION = UNORIENTABLE | LR | RL 

(* LexicoExt gives the lexicographic extension of an ordering *)

fun LexicoExtLeft Teq Tord = 
    let fun f (a::l1) (b::l2) = if Teq a b then f l1 l2 else Tord a b 
	  | f [] (a::l)       = false
	  | f [] []           = false		(* strict ordering *)
	  | f _ [] 	      = true 
    in f 
    end 

fun LexicoExtRight Teq Tord l1 = uncurry (LexicoExtLeft Teq Tord)  o curry (apply_both rev) l1

fun MultiSetExt Tord l1 l2 = 
    let fun p l2 a  = forall (Tord a) l2
    in exists (p l1) l2
    end

fun ordered Tord t1 t2 = Tord t1 t2

fun compare Tord term1 term2 = 
   if Tord term1 term2 then LR
   else if Tord term2 term1 then RL
	else UNORIENTABLE 

end (* of functor OrderFUN *)
;
