(*
Sharing error: cyclic.

Result: FAIL

$Log: share9.sml,v $
Revision 1.3  1996/04/01 12:18:14  matthew
updating

 * Revision 1.2  1993/01/20  16:56:23  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

signature SIG = 
  sig
    structure A : sig structure B : sig end end
    sharing A = A.B
  end
