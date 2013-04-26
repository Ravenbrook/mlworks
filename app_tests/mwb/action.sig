(*
 *
 * $Log: action.sig,v $
 * Revision 1.2  1998/06/11 13:13:36  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature ACTION =
sig
    structure N : NAME

    type action

    val hashval : action -> int

    val is_tau : action -> bool
    val is_input : action -> bool
    val is_output : action -> bool
    val mk_tau : unit -> action
    val mk_input : N.name -> action
    val mk_output : N.name -> action
    val name : action -> N.name

    val mkstr : action -> string
    val makstr : action * (string list) -> string
    val eq : action * action -> bool
    val free_names : action * int -> N.name list
    val names : action -> N.name list
    val substitute : N.name * N.name * action -> action


    val beta_reduce : action -> (N.name list * int) -> action
end
