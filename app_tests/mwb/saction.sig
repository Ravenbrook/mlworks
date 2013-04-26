(*
 *
 * $Log: saction.sig,v $
 * Revision 1.2  1998/06/11 13:02:04  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature SACTION =
sig
    structure N : SNAME

    datatype action = Tau
      		 | Input of N.name
		 | Output of N.name

    val mkstr : action -> string
    val eq : action * action -> bool

end
