(*
 *
 * $Log: maybe.sml,v $
 * Revision 1.2  1998/06/08 17:28:09  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
maybe.sml

A standard ML implementation of the Maybe Monad as given by Phil Wadler.
This version has been modified to cater for an error 
message to be carried and printed out by the monad.

Care has to be taken in a non-strict language !!
Could add some strange functions to overcome this!

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     27/07/90
Glasgow University and Rutherford Appleton Laboratory.

*)

functor MaybeFUN () : MAYBE =
struct

datatype 'a Maybe = OK of 'a | Error of string

fun returnM a = OK a

fun   (OK a)  eachM f = OK (f a)
  | (Error s) eachM f = Error s

fun   (OK a)  propM f = f a
  | (Error s) propM f = Error s

val errM = Error ""
fun errorM s = Error s

fun changeM s   (OK a)  = OK a
  | changeM s (Error _) = Error s

fun giveM _   (OK b)  = b
  | giveM a (Error s) = a

fun givefM _   (OK a)  = a
  | givefM f (Error s) = (output (std_out, "\nERROR: "^s^"\n") ; f ())

fun   (OK a)  backM _ = OK a  (* not so useful for a strict language *)
  | (Error s) backM m = m ()
  
fun guardM b m s = if b then m () else errorM s

fun filterM p m s = m propM (fn x => guardM (p x) (fn () => returnM x) s)

fun existsM  (OK _ )  = true
  | existsM (Error _) = false 

fun nextM (OK a)  f  g  = f a 
  | nextM (Error s) f g = g s

end (* of functor MaybeFUN *)
;

