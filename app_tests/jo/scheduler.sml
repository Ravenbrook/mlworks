(*
 *
 * $Log: scheduler.sml,v $
 * Revision 1.2  1998/06/08 13:16:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*		Jo: A Concurrent Constraint Programming Language
			(Programming for the 1990s)

			     Andrew Wilson


			   Scheduler for Baby-Jo

			    19th November 1990

                              the signature

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.
*)



signature SCHEDULER =
sig
  type object
  type constraint
  type agent
  type clause
  type context
  type condition
  type word

   (****************** PROCESS types **********************************)

  datatype process = 
	alternative of bool ref		(* ensure only one branch done*)
		     * int ref		(* ensure at least one branch done*)
		     * agent
		     * context
		     * bool ref		(* traced? *)

      | guarded of condition * context * agent * bool ref
      | selection of condition * context * agent * bool ref

      | altGuard of bool ref * int ref * condition * context * agent
		   * bool ref

      | arithWait of object * object list ref * constraint * context
		    * bool ref

      | exec of agent * context * bool ref

      | procAlt of   string * bool ref * int ref * object list
		    * object list * int * agent * context * bool ref

      | procGuard of string * bool ref * int ref * object list
		    * object ref list * object list * object ref list
		    * int * context * agent * bool ref

  val processToWords: process -> word list



   (***************** SCHEDULER manipulation functions *******************)
  exception QueueEmpty

  val take: unit -> process
  val give: process -> unit
  val wipeSchedule: unit -> unit
  val suspend: process * int -> int
  val awake: int -> unit
  val suspended: unit -> process list list
  val deSuspend: unit -> unit
end;
