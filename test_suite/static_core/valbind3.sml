(*
An inexhaustive value binding, nested.

Result: WARNING.
 
$Log: valbind3.sml,v $
Revision 1.2  1993/09/28 12:51:14  daveb
Merged in bug fix.

Revision 1.1.1.2  1993/09/28  12:50:00  daveb
Changed result status: we now believe that a warning should be generated.

Revision 1.1.1.1  1993/01/20  15:18:16  jont
Fork for bug fixing

Revision 1.1  1993/01/20  15:18:16  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

let
  val [x] = [2]
in
  x
end
