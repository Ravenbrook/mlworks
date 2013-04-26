(*
Test lambda optimiser integer size limits

Result: OK
 
$Log: raise1.sml,v $
Revision 1.1  1993/07/14 11:46:56  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

val x = 285610000 val y = (x+x) handle Sum => 1
