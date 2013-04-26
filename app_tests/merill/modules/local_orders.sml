(*
 *
 * $Log: local_orders.sml,v $
 * Revision 1.2  1998/06/08 18:01:13  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/09/90
Glasgow University and Rutherford Appleton Laboratory.

local_order.sml

Built in strategies for locally ordering equations.

*)
(* this file gives a set of manual ordering for use when global orderings *)
(* have a choice as to which way to orient an equation.  They must be     *)
(* interchangeable and consequently all have the same signature:          *)

(* LocOrd : Algebra -> Equality -> ORIENTATION 				  *)

functor LocalOrderFUN(structure O : ORDER
		      structure S:SIGNATURE
		      structure E:EQUALITY
		      sharing type E.Signature = S.Signature 
		     ) : LOCAL_ORDER = 
struct

type Signature = S.Signature 
type Equality = E.Equality 

structure Order = O

open E Order

fun as_is_ord a (e:Equality) = LR

fun manual_ord a (e:Equality) = 
    let val (ls,rs) = show_equality a e
    in
    (write_terminal ("Manual Ordering: " ^ls ^" = " ^ rs) ; newline () ;
     write_terminal (">>>>>  a)     "^ls ^" => " ^ rs) ; newline () ;
     write_terminal (">>>>>  b)     "^rs ^" => " ^ ls) ; newline () ;
     write_terminal (">>>>>  c)     DO NOT ORDER") ; newline () ;
     case prompt_reply "" of
       "a" => LR
     | "b" => RL
     | "c" => UNORIENTABLE
     |  _  => manual_ord a e)
    end 

fun by_size_ord a e = 
    let val (ln,rn) = num_ops_in_eq e
    in if ln > rn then LR
       else if rn > ln then RL
       else UNORIENTABLE
    end 

end (* of functor LocalOrderFUN *)
;


    
