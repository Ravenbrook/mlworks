(*
Result: FAIL
 
$Log: unboundstrid3.sml,v $
Revision 1.1  1994/02/08 11:57:23  johnk
new file


To test the typechecker's test for structure existence, we need to
sneak nonexistent structures past the parser.

Copyright (c) 1994 Harlequin Ltd.
*)

signature G =
  sig
    structure EMPTY : sig end
  end;

structure A:G = struct end
structure B: sig
	       open A.EMPTY
	     end
	   = struct end;
	   
