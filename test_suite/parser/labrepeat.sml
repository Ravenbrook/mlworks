(*
Repeated labels are not allowed in records.

Result: FAIL
 
$Log: labrepeat.sml,v $
Revision 1.2  1993/01/19 16:15:29  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val {1 = a, 2 = b, 1 = c} = (1,2,1);
