(*
 *
 * $Log: redundancy.fun,v $
 * Revision 1.2  1998/06/03 12:11:16  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Redundancy analysis of a type *)

functor Redundancy
   (structure Basic : BASIC
    structure Term : TERM
    structure Print : PRINT
	sharing Print.Term = Term
    structure Sb : SB
	sharing Sb.Term = Term
    structure Reduce : REDUCE
	sharing Reduce.Term = Term) : REDUNDANCY =
struct

structure Term = Term

local open Term
in

(* Taken from type_recon.fun *)
fun same_evar (Evar(_,stamp,_,_)) (Evar(_,stamp',_,_)) = (stamp = stamp')
  | same_evar _ _ = raise Basic.Illegal("same_evar: arg is not an Evar.")

(* Modified from constratints.fun *)
fun eq_uvar_or_non_uvar stamp1 (Uvar(_,stamp2)) = (stamp1 = stamp2)
  | eq_uvar_or_non_uvar stamp1 (Evar(_,_,_,ref(SOME(M0)))) =
       eq_uvar_or_non_uvar stamp1 M0
  | eq_uvar_or_non_uvar stamp1 _ = true

fun distinct_uvars nil = true
  | distinct_uvars (Uvar(_,stamp)::rest) =
       if exists (eq_uvar_or_non_uvar stamp) rest
	  then false
	  else distinct_uvars rest
  | distinct_uvars _ = false  (* first arg is not a Uvar *)

(* return true if ev has a rigid occurrence in M *)
(* M must be closed (no loose bvar's) *)
(* We assume that all introduced Uvar's automatically are dominated by ev *)

fun rigid_occ_norm ev (Type) = false
  | rigid_occ_norm ev (Pi(xofA_B as (xofA,B), _)) =
       rigid_occ_varbd ev xofA orelse rigid_occ_scope ev xofA_B
  | rigid_occ_norm ev (Abst(xofA_B as (xofA, B))) =
       rigid_occ_varbd ev xofA orelse rigid_occ_scope ev xofA_B
  | rigid_occ_norm ev M = rigid_occ_appl ev M nil
and rigid_occ_appl ev (ev' as Evar _) args =
       same_evar ev ev' andalso distinct_uvars args
  | rigid_occ_appl ev (Const _) args = rigid_occ_list ev args
  | rigid_occ_appl ev (Uvar _) args = rigid_occ_list ev args
  | rigid_occ_appl ev (Appl(M1,M2)) args =
       rigid_occ_appl ev M1 (M2::args)
  | rigid_occ_appl ev M args =
       raise Print.subtype("rigid_occ_norm", M, "unexpected term")
and rigid_occ_varbd ev (Varbind(x,A)) = rigid_occ ev A
and rigid_occ_scope ev (xofA, B) =
       let val a = Sb.new_uvar xofA
	in rigid_occ ev (Sb.apply_sb (Sb.term_sb xofA a) B) end
and rigid_occ_list ev nil = false
  | rigid_occ_list ev (M::rest) =
       rigid_occ ev M orelse rigid_occ_list ev rest
and rigid_occ ev M = rigid_occ_norm ev (Reduce.head_norm M)

(*
   Set up the redundancy check by substituting evar's and returning
   the target type C and triple consisting of three synchronized
   reversed list of the evars, the variable names, and their types.
*)

fun setup_check (Pi((Varbind(x,A),B),Vacuous)) sb (rev_evars, rev_xi, rev_Ai) =
       let val A' = Sb.apply_sb sb A
        in setup_check B sb (NONE::rev_evars, x::rev_xi, A'::rev_Ai) end
  | setup_check (Pi((Varbind(x,A),B),Maybe)) sb (rev_evars, rev_xi, rev_Ai) =
       let val A' = Sb.apply_sb sb A
       	   val xofA' = Varbind(x,A')
	   val ev' = Sb.new_evar xofA' nil
	   val sb' = Sb.add_sb xofA' ev' sb
	in setup_check B sb' (SOME(ev')::rev_evars, x::rev_xi, A'::rev_Ai) end
  | setup_check C sb rev_env = (Sb.apply_sb sb C, rev_env)

fun syn'able ev As = rigid_occ_list ev As
fun inh'able ev C = rigid_occ ev C

fun step nil nil nil C h (inh, syn) warnings =
      ((inh, syn), warnings)
  | step (NONE::evars) (x::xs) (A::As) C h (inh, syn) warnings =
      step evars xs As C h (inh @ [false], syn @ [false])  warnings
  | step (SOME(ev)::evars) (x::xs) (A::As) C (Appl(M,Wild)) (inh, syn) warnings =
      (* argument is implicit *)
      let val inh' = inh'able ev C
	  and syn' = syn'able ev As
      in step evars xs As C M
	  (inh @ [inh'], syn @ [syn'])
	  (case (syn', inh')
	     of (false, false) => warnings @ [x]
	      | _ => warnings)
     end
  | step (SOME(ev)::evars) (x::xs) (A::As) C h (inh, syn) warnings =
      (* argument is explicit *)
      let val inh' = inh'able ev C
	  and syn' = syn'able ev As
      in step evars xs As C h
	  (inh @ [inh'], syn @ [syn'])
	  warnings
     end
  | step _ _ _ _ _ _ _ = raise Basic.Illegal("step: argument lists out of sync")

fun append_string (s1,s2) = s1 ^ " " ^ s2

fun analyze A syndef =
      let val (C, (rev_evars, rev_xi, rev_Ai)) = 
	         setup_check A Sb.id_sb (nil, nil, nil)
	  val evars = rev rev_evars
	  and xs = rev rev_xi
	  and As = rev rev_Ai
	  val ((inh, syn), warnings) =
	         step evars xs As C syndef (nil, nil) nil
       in ((inh, syn), warnings) end

end  (* local open ... *)

end  (* functor Redundancy *)
