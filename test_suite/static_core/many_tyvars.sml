(*
Multiple type variables being generalized

Result: FAIL
 
$Log: many_tyvars.sml,v $
Revision 1.1  1993/12/01 17:36:35  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

val x = (ref [], ref []) : '_a list ref * '_b list ref;
