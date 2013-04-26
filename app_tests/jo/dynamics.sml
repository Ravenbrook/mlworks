(*
 *
 * $Log: dynamics.sml,v $
 * Revision 1.2  1998/06/08 13:13:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	     Jo 90: A Concurrent Constraint Programming Language
		      (Programming for the 1990s)

			    Andrew Wilson
		           9th January 1991

		    Run-time Support for variables
                             the signature

Version of July 1996, modified to use the Harlequin MLWorks separate
compilation system.
*)





signature DYNAMICS =
sig
  type object		(* carried over from CODE *)
  type constraint
  type agent
  type word

   (**************** CONTEXT manipulation functions *********************)

  type context
  val resetUnknownsCounter: unit -> unit

  val nullCntxt: unit -> context
  val index: context * int -> (int ref * bool ref * object ref)
  val setx: context * int * (int ref * bool ref * object ref) -> unit
  val valOf: context * int -> object ref
  val suspensionNumber: context * int -> int ref
  val traceStatus: context * int -> bool ref
  
  val buildCntxt: object ref list * int * context * bool ref -> context


   (*************** DYNAMIC VARIABLE VALUES **************************)

  val makePtr: object * context -> object
  val stripPtr: object -> object

  val instantiate: object * context -> object
  val instList: object list * context -> object list
  val instRefList: object ref list * context -> object list

  val instPARAMS: object * object list * object ref list -> object
  val instPList: object list * object list * object ref list -> object list

  val instantiateConstraint: constraint * context 
			   * object list * object ref list -> constraint

  val instantiateAgent: agent * context 
		      * object list * object ref list -> agent


	(********** SETTING VALUES TO REFERENCED VARIABLES *****)

  val setVal: object ref * object * bool ref * context -> unit 


	(********** DYNAMIC SUSPENSION CONDITIONS ************)

  datatype condition = varsEq of bool * object list * object ref list
		     | waitFixed of object list * constraint
		     | allButOneFixed of object list * constraint
		     | oneOf of object list * bool ref * constraint
		     | rangeNarrowed of object * constraint

    val conditionToWords: condition * context 
		       * object list * object ref list -> word list

    val negate: condition -> condition




	  (********* CONSTRAINT EVALUATION RESULTS ************)

    datatype answer = yes | no | maybe of condition
    val isYes: answer -> bool

end;







