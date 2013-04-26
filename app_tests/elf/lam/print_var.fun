(*
 *
 * $Log: print_var.fun,v $
 * Revision 1.2  1998/06/03 12:12:46  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* $Id: print_var.fun,v 1.2 1998/06/03 12:12:46 jont Exp $ *)
(* Author: Amy Felty <felty@research.att.com>           *)

(* Printing of variables *)

functor PrintVar (structure Basic : BASIC
		  structure Term : TERM
		  structure Naming : NAMING
		     sharing Naming.Term = Term) : PRINT_VAR =
struct

structure Term = Term

local open Term
in

  fun makestring_var conflict_fun (Bvar(x)) = x
    | makestring_var conflict_fun
                     (M as Evar(Varbind(x,A),stamp,uvars,ref NONE)) =
         Naming.name_var conflict_fun M
    | makestring_var conflict_fun (M as Uvar(Varbind(x,_),stamp)) =
	 ("!" ^ (Naming.name_var conflict_fun M))
    | makestring_var conflict_fun (Fvar(Varbind(x,_))) = ("^" ^ x)
    | makestring_var conflict_fun _ =
         raise Basic.Illegal("makestring_var: not a variable")

end  (* local ... *)
end  (* functor PrintVar *)
