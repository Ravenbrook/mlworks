(*
A value binding that doesn't bind any variables, nested.

According to the definition, the compiler should issue a
warning.  But we believe that the programmer clearly knows
what he or she is doing in cases like this.

Result: OK, WARNING, INTERPRETATION
 
$Log: valbind1.sml,v $
Revision 1.1  1993/01/20 15:15:57  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

let
  val _ = []
in
  ()
end
