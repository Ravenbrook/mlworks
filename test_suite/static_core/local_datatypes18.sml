(*
checks that the local datatypes can't escape.

Result: FAIL

$Log: local_datatypes18.sml,v $
Revision 1.1  1996/10/04 17:34:58  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

let
  local
    datatype e=x
  in
    datatype t = b of e
  end;
  
  fun f var = b var
in
  f
end
