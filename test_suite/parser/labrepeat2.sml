(*
Repeated labels are not allowed in records.

Result: FAIL
 
$Log: labrepeat2.sml,v $
Revision 1.2  1993/01/19 16:16:15  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype ('a,'b,'c) t = T of {1 : 'a, 1 : 'b, 2 : 'c}
