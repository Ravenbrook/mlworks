(*
Result: FAIL
 
$Log: pat6.sml,v $
Revision 1.1  1994/02/08 11:55:48  johnk
new file


To test the typechecker's pattern-checking tests for constructor
existence, we need to sneak nonexistent constructors past the parser.

Copyright (c) 1994 Harlequin Ltd.
*)

signature G =
  sig
    exception EXN
  end;

structure A:G = struct end
structure B =
  struct
    fun f _ = 3 handle A.EXN => 4
  end;
