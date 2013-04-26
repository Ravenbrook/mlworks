(*
 *
 * $Log: print_var_verbose.fun,v $
 * Revision 1.2  1998/06/03 12:12:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor PrintVarVerbose (structure Basic : BASIC
			 structure Term : TERM
			 structure Print : PRINT
			    sharing Print.Term = Term) : PRINT_VAR =
struct

structure Term = Term

local open Term
in

  fun makestring_uvars nil str = str
    | makestring_uvars (uv::uvars) "" = makestring_uvars uvars (Print.makestring_term uv)
    | makestring_uvars (uv::uvars) str = makestring_uvars uvars (Print.makestring_term uv ^ "," ^ str)

  fun makestring_var conflict_fun (M as Bvar _) = Print.makestring_term M
    | makestring_var conflict_fun (M as Evar(Varbind(x,A),stamp,uvars,ref NONE)) =
        Print.makestring_term M ^ " [" ^ makestring_uvars uvars "" ^ "] : " ^ Print.makestring_term A
    | makestring_var conflict_fun (M as Uvar(Varbind(x,A),_)) =
        Print.makestring_term M ^ " : " ^ Print.makestring_term A
    | makestring_var conflict_fun (M as Fvar(Varbind(x,A))) =
        Print.makestring_term M ^ " : " ^ Print.makestring_term A
    | makestring_var conflict_fun _ =
        raise Basic.Illegal("makestring_var: not a variable")

end  (* local ... *)

end  (* functor PrintVarVerbose *)
