(*
Result: FAIL

$Log: transitive_sharing.sml,v $
Revision 1.1  1996/04/03 09:30:49  matthew
new unit
Test for transitive structure sharing

Copyright (c) 1996 Harlequin Ltd.
*)

signature FOO = sig type t end;
signature EMPTY = sig end;

structure Foo : 
  sig 
    structure F1 : FOO
    structure F2 : EMPTY
    structure F3 : FOO 
    sharing F1 = F2 = F3
  end =
  struct
    structure F1 = struct type t = int end
    structure F2 = struct end
    structure F3 = struct type t = real end
  end
