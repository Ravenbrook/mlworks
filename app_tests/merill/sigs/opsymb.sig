(*
 *
 * $Log: opsymb.sig,v $
 * Revision 1.2  1998/06/08 17:38:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
opsymb.sig

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/02/90
Glasgow University and Rutherford Appleton Laboratory.

*)

signature OPSYMB = 
   sig

	structure Pretty : PRETTY

	type Sort 
	type OpSig 

	val mk_OpSig : Sort list * Sort -> OpSig
	val get_arg_sorts : OpSig -> Sort list
	val get_result_sort : OpSig -> Sort 
	val get_type : OpSig -> Sort list * Sort
	val is_generator : OpSig -> bool
	val set_generator : OpSig -> OpSig
	val unset_generator : OpSig -> OpSig
	val is_commutative : OpSig -> bool
	val set_commutative : OpSig -> OpSig
	val unset_commutative : OpSig -> OpSig
	val is_associative : OpSig -> bool
	val set_associative : OpSig -> OpSig
	val unset_associative : OpSig -> OpSig
	val is_ac : OpSig -> bool
	val set_ac : OpSig -> OpSig
	val unset_ac : OpSig -> OpSig
	val eq_OpSig : OpSig -> OpSig -> bool
	val show_OpSig : OpSig -> string


	type OpSigSet
	val mk_OpSigSet : Sort list * Sort ->  OpSigSet
	val get_OpSigs : OpSigSet -> OpSig list
	val get_flagged_signatures : OpSigSet -> OpSig list
	val null_OpSigSet : OpSigSet -> bool
	val numargs : OpSigSet -> int
	val remove_OpSig : OpSigSet -> OpSig -> OpSigSet
	val merge_OpSigSets : OpSigSet -> OpSigSet -> OpSigSet
	val set_as_generator : Sort list * Sort -> OpSigSet -> OpSigSet
	val unset_as_generator : Sort list * Sort -> OpSigSet -> OpSigSet
	val set_as_commutative : Sort list * Sort -> OpSigSet -> OpSigSet
	val unset_as_commutative : Sort list * Sort -> OpSigSet -> OpSigSet
	val set_as_associative : Sort list * Sort -> OpSigSet -> OpSigSet
	val unset_as_associative : Sort list * Sort -> OpSigSet -> OpSigSet
	val set_as_ac : Sort list * Sort -> OpSigSet -> OpSigSet
	val unset_as_ac : Sort list * Sort -> OpSigSet -> OpSigSet
	val generators_of : Sort -> OpSigSet -> OpSigSet
	val show_OpSigSet : OpSigSet -> string list


	type OpId
	val OpIdeq : OpId -> OpId -> bool
	val new_OpId : unit -> OpId
	val ord_o : OpId -> OpId -> bool

	type Form 
	val mk_form : string list -> Form
	val get_form : Form -> string list
	val unform : Form -> string
	val Formeq : Form -> Form -> bool
	
	type Op_Store
	val Empty_Op_Store : Op_Store
	val arity : Op_Store -> OpId -> int
	val operator_sig : Op_Store -> OpId -> OpSigSet 
	val display_format : Op_Store -> OpId -> Form
	val remove_operator : Op_Store -> OpId -> Op_Store
	val find_operator : Op_Store -> Form -> OpId Maybe
	val insert_op_opid : Op_Store -> OpId -> OpSigSet -> Form -> (Pretty.T list -> Pretty.T) -> Op_Store
	val insert_op_form : Op_Store -> Form -> (Pretty.T list -> Pretty.T) -> OpSigSet -> Op_Store
	val change_opsig : Op_Store -> OpId -> OpSigSet -> Op_Store
	val all_ops : Op_Store -> OpId list 
	val all_forms : Op_Store -> (Form * OpSigSet) list 
	val fold_over_ops : (OpId -> 'a -> 'a) -> 'a -> Op_Store -> 'a
	val C_Operator : Op_Store -> OpId -> bool
	val AC_Operator : Op_Store -> OpId -> bool
	val pretty_form : Op_Store -> OpId -> (Pretty.T list -> Pretty.T)
(*	val insert_pretty : Op_Store -> OpId -> (Pretty.T list -> Pretty.T) -> Op_Store *)

	val show_operator : Op_Store -> OpId -> string

  end  (* of Signature OPSYMB *)
  ;


