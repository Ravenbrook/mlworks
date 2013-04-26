(*
 *
 * $Log: environment.sml,v $
 * Revision 1.2  1998/06/08 18:04:54  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
environment.sml

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/07/90
Glasgow University and Rutherford Appleton Laboratory.

The MERILL environment contains all those adjustable bits which do not fit well
else where!  This basically gives all the options that the user can set.

*)


functor EnvironmentFUN (structure Sig : SIGNATURE
			structure E : EQUALITY
			structure O : ORDER
			structure P : PRECEDENCE
			structure W : WEIGHTS
			structure L : LOCAL_ORDER
			structure Str : STRATEGY
			sharing type Sig.Signature = E.Signature = 
				     Str.Signature = P.Signature = L.Signature 
			and     type E.Equality = L.Equality = Str.Equality
			and 	type O.ORIENTATION = E.ORIENTATION = L.Order.ORIENTATION
		       ) : ENVIRONMENT =

struct

type OpId = Sig.O.OpId
type Signature = Sig.Signature
type Equality = E.Equality
type Precedence = P.Precedence
type Weights = W.Weights
type ORIENTATION = O.ORIENTATION
  
open Sig E O P W L Str 

abstype Environment = Env of 
		    { GlobOrd  :  (string * (Signature -> Environment -> Equality -> 
		    				(ORIENTATION * Environment))) ,
		      LocOrd   :  (string * (Signature -> Equality -> ORIENTATION)),
		      OrdPrec  :  Precedence,
		      Weights  :  Weights ,
		      LocStrat :  (string * (Signature -> Equality -> Equality -> Order))
		    } 
with
		      
fun set_globord f (Env{GlobOrd=sOrd,LocOrd=or,OrdPrec=p,Weights=w,LocStrat=s }) = 
	(Env{GlobOrd=f sOrd,LocOrd=or,OrdPrec=p,Weights=w,LocStrat=s }) 

fun set_locord sOrd (Env{GlobOrd=ord,LocOrd=_,OrdPrec=p,Weights=w,LocStrat=s }) = 
	(Env{GlobOrd=ord,LocOrd=sOrd,OrdPrec=p,Weights=w,LocStrat=s }) 

fun set_precord f (Env{GlobOrd=ord,LocOrd=or,OrdPrec=p,Weights=w,LocStrat=s }) =
    (Env{GlobOrd=ord,LocOrd=or,OrdPrec=f p,Weights=w,LocStrat=s }) 

fun set_weights f (Env{GlobOrd=ord,LocOrd=or,OrdPrec=p,Weights=w,LocStrat=s }) = 
	(Env{GlobOrd=ord,LocOrd=or,OrdPrec=p,Weights=f w,LocStrat=s }) 

fun set_locstrat s (Env{GlobOrd=ord,LocOrd=or,OrdPrec=p,Weights=w,LocStrat=_ }) = 
	(Env{GlobOrd=ord,LocOrd=or,OrdPrec=p,Weights=w,LocStrat=s }) 

fun get_globord (Env{GlobOrd=ord, ... }) = ord 
fun get_locord (Env{LocOrd=ord, ... }) = ord
fun get_precord (Env{OrdPrec=p, ... }) = p 
fun get_weights (Env{Weights=w, ... }) = w 
fun get_locstrat (Env{LocStrat=loc, ... }) = loc 

(* 
We declare a default global order, which you will get it you do not declare any, 
which is to get the local-ordering condition.

bmm    7/8/90
*)

fun default_global_order A env e = (snd (get_locord env) A e , env) ;

val Initial_Env = Env{GlobOrd = ("none",  default_global_order ),
		       LocOrd = ("manual",   manual_ord),
		       OrdPrec = Null_Precedence,
		       Weights = No_Weights,
		      LocStrat = ("by_size", by_size_strat)
		     } 

end (* of abstype Environment *)

end (* of functor EnvironmentFUN *)
;


