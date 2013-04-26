(*
Realisation error: struct ... end expressions are generative.

Result: FAIL

$Log: realise_err4.sml,v $
Revision 1.3  1996/04/01 12:16:25  matthew
updating

 * Revision 1.2  1993/01/20  16:39:31  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure A =
  struct
  end;

signature SIG = 
  sig
    structure B : sig end
    sharing A = B
  end;

structure C : SIG = 
  struct
    structure B = struct end
  end


