(*
 *
 * $Log: error.sml,v $
 * Revision 1.2  1998/06/08 17:32:12  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

 Provides routines for error handling 
 
 very naive at the moment.

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/07/90
Glasgow University and Rutherford Appleton Laboratory.

*)


signature ERROR = 
  sig 
	exception MERILL_ERROR of string
	val error_message : string -> unit
	val warning_message : string -> unit
	val system_error : string -> unit
	val error_and_wait : string -> unit
	val error_flush : string -> unit
	val setErrorFlag : unit -> unit
	val unsetErrorFlag : unit -> unit
	val isErrorFlag : unit -> bool
  end ; (* of signature ERROR *)


structure Error:ERROR = 
struct

val ErrorFlag = ref false 		(* true if error has been reported but not acknowledged *)
fun setErrorFlag () = ErrorFlag := true
fun unsetErrorFlag () = ErrorFlag := false
fun isErrorFlag () = !ErrorFlag

exception MERILL_ERROR of string

fun error_message s = (setErrorFlag () ; CommonIO.write_terminal ("\nERROR: "^s^"\n"))

fun warning_message s = CommonIO.write_terminal ("\nWARNING: "^s^"\n") 

fun system_error s = CommonIO.write_terminal ("\n SYSTEM ERROR: "^s^"\n")

fun error_and_wait s = (error_message s ; Interface.wait_on_user () ; unsetErrorFlag ())

fun error_flush s = (error_message s; flush_input ())

end (* of structure Error *) ;
