(*
Covering error.

Result: FAIL

$Log: cover1.sml,v $
Revision 1.3  1996/04/01 11:52:27  matthew
updating

 * Revision 1.2  1993/01/20  17:01:22  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure S = struct end
structure R = struct end;

signature SIG = 
  sig
    structure A: sig structure B: sig end end
    sharing A = S and A.B = R
  end
