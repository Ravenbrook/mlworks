(*
Result: FAIL
 
$Log: open.sml,v $
Revision 1.1  1994/02/08 11:52:02  johnk
new file


To test the typechecker's structure-existence test, we need to sneak
nonexistent structures past the parser.

Copyright (c) 1994 Harlequin Ltd.
*)

signature G =
  sig
    structure EMPTY : sig end
  end;

structure A:G = struct end
structure B =
  struct
    open A.EMPTY
  end;
