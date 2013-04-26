(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  WARNING

$Log: exception14.sml,v $
Revision 1.2  1997/06/12 12:09:08  matthew
Fixing problem with double status

 * Revision 1.1  1994/01/24  18:42:20  nosa
 * Initial revision
 *


Copyright (c) 1993 Harlequin Ltd.
*)

exception A of int;
exception B = A;
fun f (A 1) = 1
| f (B 2) = 2;
f (A 2); (* 2 *)
