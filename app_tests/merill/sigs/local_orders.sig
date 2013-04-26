(*
 *
 * $Log: local_orders.sig,v $
 * Revision 1.2  1998/06/08 18:00:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/09/90
Glasgow University and Rutherford Appleton Laboratory.

local_order.sig

Built in strategies for locally ordering equations.

*)

signature LOCAL_ORDER = 
   sig
   	structure Order : ORDER

   	type Signature
   	type Equality

   	val as_is_ord : Signature -> Equality -> Order.ORIENTATION 
   	val manual_ord : Signature -> Equality -> Order.ORIENTATION 
   	val by_size_ord : Signature -> Equality -> Order.ORIENTATION 

	end (* of signature LOCAL_ORDER *)
	;
