(*
 *
 * $Log: sagent.sig,v $
 * Revision 1.2  1998/06/11 13:02:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature SAGENT =
sig
   structure T : STEST
   structure Act : SACTION


   datatype agent = Nil
     		  | Prefix of Act.action * agent
		  | Abs of T.N.name * agent
		  | Conc of T.N.name * agent
		  | Test of T.test * agent
		  | Cond of T.test * agent * agent
                  | Sum of agent list
                  | Parallel of agent list
		  | Nu of T.N.name * agent
                  | AgentRef of string
		  | Applic of agent * T.N.name

   exception WrongArgs of string


   val mkstr : agent -> string
   val eq : agent * agent -> bool

end
