(*
 *
 * $Log: flags.sml,v $
 * Revision 1.2  1998/06/11 13:12:08  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Defines global variables that affect observable behaviour *)
structure Flags =
struct
   (* Tracing detail *)
   val tracelevel = ref 0

   (* Is tracing on? *)
   fun trace () = (!tracelevel) > 0

   (* interactive input? *)
   val interactive = ref true

   (* want (expensive) rewrite of agents? *)
   val rewrite = ref false

   (* Is space REALLY really important? *)
   val space_over_speed = ref false
end
