(*
 *
 * $Log: i_variable.sig,v $
 * Revision 1.2  1998/06/08 18:08:00  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature I_VARIABLE = 
   sig 
	type Variable_Store
	type Sort_Store

	val enter_variables : Sort_Store -> Variable_Store -> Variable_Store 
	val display_variables : Variable_Store -> unit
	val delete_variables : Variable_Store -> Variable_Store
	val load_variables :  (unit -> string) -> Sort_Store -> 
			      Variable_Store -> Variable_Store
	val save_variables : (string -> unit) -> Variable_Store -> unit

	val variable_options : Sort_Store * Variable_Store -> Variable_Store 

   end (* of signature I_VARIABLE *)
   ;
