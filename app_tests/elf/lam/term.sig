(*
 *
 * $Log: term.sig,v $
 * Revision 1.2  1998/06/03 11:51:53  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Basic term representation *)

signature TERM =
sig

  datatype occurs = Maybe | Vacuous

  datatype associativity = Left | Right | None
  datatype fixity = Infix of associativity | Prefix | Postfix

  datatype term
    =  Bvar of string             (* Bound variable: name *)
    |  Evar of varbind * int * term list * (term option) ref
			          (* Logic variable: *)
				  (* name/type, stamp, depends on, bound to *)
    |  Uvar of varbind * int	  (* Parameter: name/type, stamp *)
    |  Fvar of varbind            (* Free variable: name/type *)
    |  Const of sign_entry  	  (* Constant *)
    |  Appl of term * term        (* Application *)
    |  Abst of varbind * term	  (* Abstraction *)
    |  Pi of (varbind * term) * occurs
                                  (* Pi quantification *)
    |  Type                       (* Type *)
    |  HasType of term * term     (* Explicit type annotation *)
    |  Mark of (int * int) * term (* Marked term *)
    |  Wild			  (* Omitted term *)

  and varbind = Varbind of string * term  (* Variable binder: name, type *)

  and sign_entry		  (* signature entry, compared for equality *)
    = E of
	{
        Bind : varbind,		  (* the constant and its type *)
        Full : term,		  (* syntactic expansion *)
        Defn : term option, 	  (* optional definition *)
	Dyn  : bool ref,          (* dynamic? *)
        Prog : int option ref,    (* progtable entry index *)
	Fixity : (fixity * int) option ref,  
				  (* optional fixity and precedence *)
	NamePref : string list option ref,
			          (* optional prefered names *)
	Inh  : bool list,         (* for each argument: is it inherited? *)
	Syn  : bool list          (* for each argument: is it synthesized? *)
  	} ref
    | Int of int		  (* integers *)
    | String of string		  (* strings *)
    | IntType			  (* type of integers *)
    | StringType		  (* type of strings *)

  val anonymous : string
  val make_pi : varbind * term -> term
  val make_arrow : term * term -> term
  val fixity_min : int
  val fixity_max : int

  val se_type : sign_entry -> term

  val eq_var : term * term -> bool

  val left_location : term -> int option
  val right_location : term -> int option
  val location : term -> (int * int) option

end  (* signature TERM *)
