(*
 *
 * $Log: sname.sig,v $
 * Revision 1.2  1998/06/11 12:59:02  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature SNAME =
sig
    type name

    val mkname : string -> name
    val mkstr  : name -> string
    val eq     : name * name -> bool
    val le     : name * name -> bool

end
