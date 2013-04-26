(*
Like local_datatypes4.sml, but this checks that the type name from
the foreign structure can "escape" in patterns.

Result: OK

$Log: local_datatypes5.sml,v $
Revision 1.1  1996/10/04 18:36:23  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)


structure A =
  struct
    structure B = 
      struct
        datatype t = b
      end;
    structure C =
      struct
        datatype tt = e of B.t
        fun f var  = e var
      end;
  end;
