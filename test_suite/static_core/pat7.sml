(*
Result: FAIL
 
$Log: pat7.sml,v $
Revision 1.1  1994/02/08 11:55:49  johnk
new file


To test the typechecker's pattern-checking tests for constructor
existence, we need to sneak nonexistent constructors past the parser.

Copyright (c) 1994 Harlequin Ltd.
*)

signature G =
  sig
    datatype t = CON of int
  end;

structure A:G = struct end
structure B =
  struct
    fun f (A.CON 3) = 3
  end;
