(*
SIG is not well-formed.

Result: FAIL

$Log: well_formed1.sml,v $
Revision 1.2  1996/04/01 12:19:23  matthew
updating

 * Revision 1.1  1993/01/20  17:38:00  daveb
 * Initial revision
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure S = struct end;

signature SIG = 
  sig
    structure B : sig end
    type t
    structure A : sig val x:t end
    sharing A = S
  end
