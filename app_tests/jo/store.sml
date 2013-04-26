(*
 *
 * $Log: store.sml,v $
 * Revision 1.2  1998/06/08 13:16:43  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	    Jo: A Concurrent Constraint Programming Language
		      (Programming for the 1990s)

			    Andrew Wilson

		  An implementation of a code memory
			  (using a 2-3 tree)

		       2nd Nov and 17th Nov 1990

		Modified 17th December to store lists of items


			    the signature

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.

****************************************************************************)

	
signature STORE =
sig
  type 'a store
  exception NotFound of string
 
  val newStore: unit -> 'a store
  val store: string * 'a * 'a store -> 'a store
  val retrieve: string * 'a store -> 'a list

  val retrieveAll: 'a store -> 'a list list
  val wipe: string * 'a store -> 'a store
end;
