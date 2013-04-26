(*
 *
 * $Log: maybe.sig,v $
 * Revision 1.2  1998/06/08 17:27:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
maybe.sml

A standard ML implementation of the Maybe Monad as given by Phil Wadler. 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/07/90
Glasgow University and Rutherford Appleton Laboratory.

*)


infix eachM
infix propM
infix backM;

signature MAYBE =
  sig
  datatype 'a Maybe = OK of 'a | Error of string
  
  val returnM  : 'a -> 'a Maybe
  val eachM    : 'a Maybe * ('a -> 'b) -> 'b Maybe
  val propM    : 'a Maybe * ('a -> 'b Maybe) -> 'b Maybe
  val errM     : 'a Maybe
  val errorM   : string -> 'a Maybe
  val changeM  : string -> 'a Maybe -> 'a Maybe
  val giveM    : 'a -> 'a Maybe -> 'a
  val givefM   : (unit -> 'a) -> 'a Maybe -> 'a
  val backM    : 'a Maybe * (unit -> 'a Maybe) -> 'a Maybe
  val nextM   : 'a Maybe -> ('a -> 'b Maybe) -> (string -> 'b Maybe) -> 'b Maybe
  val guardM   : bool -> (unit -> 'a Maybe) -> string -> 'a Maybe 
  val filterM : ('a -> bool) -> 'a Maybe -> string -> 'a Maybe
  val existsM : 'a Maybe -> bool
  
  end (* of signature MAYBE *)
  ;
