(*
 *
 * $Log: name.sig,v $
 * Revision 1.2  1998/06/11 12:56:02  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature NAME =
sig
    type name

    val mkname : string * int -> name
    val eq     : name * name -> bool
    val curry_eq : name -> name -> bool	(* #### *)
    val le     : name * name -> bool
    val mkstr  : name -> string
    val makstr  : name * (string list) -> string
    val pretty_name : name -> string

    val substitute : name * name * name -> name
    val newNameNotin : name list -> name
	val next : name list -> name	(* #### *)
    val n_newNamesNotin : int * (name list) -> name list

    val fill : name list -> name list

    val beta_reduce : name -> (name list * int) -> name
    val zerop : name -> bool
    val pred : name -> name
    val increment : name * int -> name
    val is_free : name * int -> bool
    val free : name * int -> name
    val Zero : name

    val code : name -> int
end
