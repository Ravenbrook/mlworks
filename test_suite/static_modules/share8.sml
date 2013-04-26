(*
Sharing error: struct ... end expressions are generative.

Result: FAIL

$Log: share8.sml,v $
Revision 1.3  1996/04/01 12:18:07  matthew
updating

 * Revision 1.2  1993/01/20  16:56:00  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure A = struct end
structure B = struct end;

signature SIG = 
  sig
    sharing A = B 
  end

