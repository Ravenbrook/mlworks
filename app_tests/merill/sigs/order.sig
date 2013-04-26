(*
 *
 * $Log: order.sig,v $
 * Revision 1.2  1998/06/08 17:44:00  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

order.sig

some routines for buiding term orderings 

bmm   10 - 03 - 90
*)

signature ORDER =
   sig

	datatype ORIENTATION = UNORIENTABLE | LR | RL 
	
	val LexicoExtLeft : ('a -> 'a -> bool) -> ('a -> 'a -> bool) ->  'a list -> 'a list -> bool
	val LexicoExtRight : ('a -> 'a -> bool) -> ('a -> 'a -> bool) ->  'a list -> 'a list -> bool
	val MultiSetExt : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool

	val ordered : ('a -> 'a -> bool) -> 'a -> 'a -> bool

	val compare : ('a -> 'a -> bool) -> 'a -> 'a -> ORIENTATION
	
  end (* of signature ORDER *) 
  ;
