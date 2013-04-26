(*
Result: OK
 
$Log: iterate.sml,v $
Revision 1.3  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.2  1993/01/20  12:33:13  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

fun iterate f [] = ()
  | iterate f (h :: t) = (ignore(f h); iterate f t)

