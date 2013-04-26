(*
 *
 * $Log: strategies.sml,v $
 * Revision 1.2  1998/06/08 17:59:44  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

strategies.sml

Strategies for selection equations from equality sets.

*)

functor StrategiesFUN (structure EQ : EQUALITY
		       structure ES : EQUALITYSET
		       structure E : ETOOLS
		       sharing type EQ.Equality = ES.Equality = E.Equality
		       and     type EQ.Signature = ES.Signature = E.Signature
		      ) : STRATEGY =
struct

type Equality = EQ.Equality
type EqualitySet = ES.EqualitySet

open EQ ES

val equality = E.equivalent

fun by_size_strat A e1 e2 =
    if equality A e1 e2 then EQ
    else if (plus (num_ops_in_eq e1) + plus (num_of_vars_in_eq e1))
          < (plus (num_ops_in_eq e2) + plus (num_of_vars_in_eq e2))
         then LT else GT 

fun by_age_strat A e1 e2 = if equality A e1 e2 then EQ else GT

val manual_strat = by_size_strat

fun insert_by_strat A strategy = eqinsert (strategy A)

fun merge_by_strat A strategy  = merge_eqsets (strategy A)

end (* of functor StrategiesFUN *)
;

