(*
 *
 * $Log: system.sig,v $
 * Revision 1.2  1998/06/08 18:23:13  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

system.sig				BMM  15-11-91

The Top Level Functions Signature

*)

signature ERILSYSTEM = 
   sig
	
	type State

	val MERILL : unit ->  State
	
	val eril_restart : State -> State
	
	val save_eril_image : unit -> unit 

	val make_eril_exec : unit -> unit 

   end ; (* of signature ERILSYSTEM *)
