(*
Checks that hidden type names can escape locals in core rules.

Result: OK

$Log: local_datatypes19.sml,v $
Revision 1.1  1996/10/04 18:38:44  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

let
  local
    datatype e=x
  in
    datatype t = b of e
   end
in
1
end
