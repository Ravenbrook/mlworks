(*
A value binding that doesn't bind any variables, nested.

Unlike the case of a wildcard, we should issue a warning in this case.

Result: WARNING
 
$Log: valbind5.sml,v $
Revision 1.3  1996/03/21 17:24:51  matthew
Changing to use value polymorphism

Revision 1.2  1993/01/22  17:00:30  daveb
Changed "we do issue a warning" to "we should issue a warning".

Revision 1.1  1993/01/20  15:20:00  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

let
  val nil = []
in
  ()
end
