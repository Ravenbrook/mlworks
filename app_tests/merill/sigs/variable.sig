(*
 *
 * $Log: variable.sig,v $
 * Revision 1.2  1998/06/08 17:39:01  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
Status: R

variable.sig			BMM   27-02-90

This signature gives the interface for the available functions for handling variables.

*)

signature VARIABLE =
  sig
	type Sort
	type Sort_Store 

	type Variable
	val variable_sort : Variable -> Sort
	val variable_label : Variable -> string
	val generate_variable : Sort -> Variable
	val make_variable : string -> Sort -> Variable 
	val VarEq : Variable -> Variable -> bool
	val rename_variable : Variable -> Variable
	val ord_v : Variable -> Variable -> bool

	type Variable_Store
	val Empty_Variable_Store : Variable_Store
	val read_variable : Variable_Store -> string -> Variable Search
	val declare_variable : Variable_Store -> string * Sort -> Variable_Store
	val declare_prefix : Variable_Store -> string * Sort -> Variable_Store
	val delete_variable : Variable_Store -> string -> Variable_Store

	val display_variable : Variable_Store -> Variable -> string
	val names_of_vars : Variable_Store -> ((string * string) list * (string * string) list)
	val variable_parser : Sort_Store -> Variable_Store -> 
		    	      (string , Variable)  Assoc.Assoc ->
		    	       string list ->
		   	      ((Variable * string list) * 
		   		(string , Variable) Assoc.Assoc) Maybe

	type Variable_Print_Env
	val Empty_Var_Print_Env : Variable_Print_Env
	val lookup_var_print_env : Variable_Print_Env -> Variable_Store -> 
			Variable -> string * Variable_Print_Env

  end (* of signature VARIABLE *);

