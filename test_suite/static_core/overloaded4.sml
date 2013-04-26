(*
Overloaded operators must be resolved even if they aren't in the result type.

Result: OK
 
$Log: overloaded4.sml,v $
Revision 1.1  1994/05/12 15:29:30  daveb
new file


Copyright (c) 1994 Harlequin Ltd.
*)

let
  fun f 0 = ()
  |   f n = f (n-1)
in
  f 2
end;
