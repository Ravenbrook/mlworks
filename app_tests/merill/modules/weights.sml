(*
 *
 * $Log: weights.sml,v $
 * Revision 1.2  1998/06/08 17:58:47  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 
MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/09/90
Glasgow University and Rutherford Appleton Laboratory.

Weights on operator symbols as used in the Knuth-Bendix ordering 
This is extended to an abstract type of weights.                 

*)

functor WeightFUN (structure O : OPSYMB
		  ) : WEIGHTS = 
struct

type OpId = O.OpId
type Op_Store = O.Op_Store

open O

(*

add_weight : Weights -> OpId -> int -> Weights
find_wieght : Weights -> OpId Find -> int 
remove_weight : Weights -> OpId -> Weights 
show_weights  : Op_Store -> Weights -> (string * string) list

*)

abstype Weights  = Weights of (OpId * int) list 
with

val No_Weights = Weights []

fun add_weight (Weights rsw) symb n = 
    let fun a_weight ((s,w)::rsw) seen =
            if OpIdeq s symb 
	    then seen @ ((s,n)::rsw)
	    else a_weight rsw (snoc seen (s,w))
	  | a_weight [] seen = snoc seen (symb,n)
    in
       Weights (a_weight rsw [])       
    end (* of let..in *)

fun find_weight (Weights l) NoMatch = 1 (* obviously not the right implementation *)
  | find_weight (Weights []) (Match s) =
    (warning_message "No Weight Declared for Operator - chooses 1";1)
  | find_weight (Weights ((s,n)::rsn)) (Match sy) = 
    if OpIdeq s sy 
    then n 
    else find_weight (Weights rsn) (Match sy) 
    
fun remove_weight (Weights ws) symb = 
    let fun r_weight ((s,w)::rsw) seen =
            if OpIdeq s symb 
	    then seen @ rsw
	    else r_weight rsw ((s,w)::seen)
	  | r_weight [] seen = seen 
    in
       Weights (r_weight ws [])       
    end (* of let..in *)

fun show_weights show_op (Weights ((s,w)::rsw)) = 
    (show_op s, makestring w) :: show_weights show_op (Weights rsw)
  | show_weights show_op (Weights []) = []

end (* of abstype Weights *)

end (* of functor WeightFUN *)
;





