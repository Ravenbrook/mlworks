(*
Result: OK

$Log: local_datatypes10.sml,v $
Revision 1.1  1996/10/04 18:37:21  andreww
new unit
new test


Copyright (c) 1996 Harlequin Ltd.
*)


structure A =
  struct
    structure B = 
      struct
        datatype t = b
      end;
    datatype tt = e of B.t
    fun f var  = e var
  end;
