(*
Check that arrays have reference semantics with respect to equality

Result: OK
 
$Log: array_eq.sml,v $
Revision 1.2  1996/05/08 12:48:03  jont
Arrays have moved

 * Revision 1.1  1995/04/05  10:06:08  jont
 * new unit
 * No reason given
 *

Copyright (c) 1995 Harlequin Ltd.
*)

val f : int -> int = fn x => x
val a = MLWorks.Internal.Array.arrayoflist[f]
val it = a = a
