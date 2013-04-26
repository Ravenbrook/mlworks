(*
 *
 * $Log: skeleton.fun,v $
 * Revision 1.2  1998/06/03 12:08:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1992 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

functor Skeleton (structure Term : TERM) : SKELETON =
struct

structure Term = Term

local open Term
in

  datatype skeleton
    = Rigid of term * skeleton list   (* rigid compound term *)
    | FirstVarOcc                     (* first occurrence of a variable *)
    | Other                           (* all other terms: no information *)

  fun occurs_in (x:string) nil = false
    | occurs_in x (y::l) = (x = y) orelse occurs_in x l

  fun free_vars bvars (Bvar(y)) lvars =
         if occurs_in y bvars orelse occurs_in y lvars
	    then lvars
	    else y::lvars
    | free_vars bvars (Appl(M1,M2)) lvars =
         let val lvars1 = free_vars bvars M1 lvars
	  in free_vars bvars M2 lvars1 end
    | free_vars bvars (Abst(xofA_M)) lvars =
         free_vars_bd bvars xofA_M lvars
    | free_vars bvars (Pi((Varbind(y,A),B),Vacuous)) lvars =
         let val lvars1 = free_vars bvars A lvars
	 in free_vars bvars B lvars1 end
    | free_vars bvars (Pi(yofA_B, Maybe)) lvars =
         free_vars_bd bvars yofA_B lvars
    | free_vars bvars (HasType(M,A)) lvars =
         let val lvars1 = free_vars bvars M lvars
	 in free_vars bvars A lvars1 end
    | free_vars bvars (Mark(_,M)) lvars =
         free_vars bvars M lvars
    | free_vars bvars M lvars = lvars (* Evar, Uvar, Fvar, Const, Type *)
  and free_vars_bd bvars (Varbind(x,A),M) lvars =
      let val lvars1 = free_vars bvars A lvars
      in free_vars (x::bvars) M lvars1 end

  fun free_vars_list nil lvars = lvars
    | free_vars_list (M::rest) lvars =
        free_vars_list rest (free_vars nil M lvars)

  (* Is this correct?  Recall that variables also occur in types! *)
  fun dbone lvars (M as Const _) args =
        let val (lvars', skargs) = dbonelist lvars args
	in (lvars', Rigid(M,skargs)) end
    | dbone lvars (Appl(M1,M2)) args =
        dbone lvars M1 (M2::args)
    | dbone lvars (Bvar(x)) nil =
        if (occurs_in x lvars)
	   then (lvars, Other)
	   else (x::lvars, FirstVarOcc)
    | dbone lvars M args =
        (free_vars_list args (free_vars nil M lvars), Other)
  and dbonelist lvars nil = (lvars, nil)
    | dbonelist lvars (M1::rest) =
        let val (lvars1, S1) = dbone lvars M1 nil
	    val (lvars', skargs) = dbonelist lvars1 rest
	in (lvars', S1::skargs) end

  fun debone M = #2 (dbone nil M nil)

end  (* local open *)

end  (* functor Skeleton *)
