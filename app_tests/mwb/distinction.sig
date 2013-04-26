(*
 *
 * $Log: distinction.sig,v $
 * Revision 1.2  1998/06/11 13:39:02  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature DISTINCTION =
sig
    structure T : TEST

    type distinction

    val EMPTY    : distinction
    val mkstr    : distinction -> string
    val makstr   : distinction * (string list) -> string
    val names    : distinction -> (T.N.name list)
    val le       : distinction * distinction -> bool
    val join     : distinction * distinction -> distinction
    val add_distinct : T.N.name * (T.N.name list) * distinction -> distinction
    val add_distinct_pair: (T.N.name * T.N.name) * distinction -> distinction
    val prune    : (T.N.name list) * distinction -> distinction
    val respects : T.test * distinction -> bool
    val substitute : (T.N.name * T.N.name) list * distinction -> distinction

    val increase : distinction * int -> distinction
    val add_n_distinct : int * (T.N.name list) * distinction -> distinction
    val add_distinct_names : (T.N.name list) * (T.N.name list) * distinction -> distinction
end
