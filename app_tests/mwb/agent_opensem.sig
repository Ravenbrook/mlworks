(*
 *
 * $Log: agent_opensem.sig,v $
 * Revision 1.2  1998/06/11 13:41:12  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature OPENSEM =
sig
    structure B : AGENT
    structure D : DISTINCTION

    exception SemanticsError of string * B.agent

    datatype commitment = Comm of B.T.test * B.Act.action * B.agent

    val c_mkstr : commitment -> string
    val cw_mkstr : commitment -> string
    val c_makstr : commitment * (string list) -> string
    val cw_makstr : commitment * (string list) -> string

    val commitments : B.agent * B.env -> commitment list

    val bisimilar : B.agent * B.agent * B.env * D.distinction -> bool
    val bisimulation : B.agent * B.agent * B.env * D.distinction -> (B.agent * B.agent * D.distinction) list

    val tauclose : B.agent * B.env -> commitment list
    val weakcomm : B.agent * B.env -> commitment list
    val cleartbls : unit -> unit
    val desctbls : unit -> unit
    val enabletbls : bool -> unit
    val enabledtbls : unit -> bool

    val weakbisimilar : B.agent * B.agent * B.env * D.distinction -> bool
    val weakbisimulation : B.agent * B.agent * B.env * D.distinction -> (B.agent * B.agent * D.distinction) list
end
	
