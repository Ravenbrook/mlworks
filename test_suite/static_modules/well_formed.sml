(*
SIG is not well-formed.

Result: FAIL

$Log: well_formed.sml,v $
Revision 1.3  1996/04/01 12:18:50  matthew
updating

 * Revision 1.2  1993/01/20  17:08:30  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure S = struct end;

signature SIG = 
  sig
    type t
    structure A : sig val x:t end
    sharing A = S
  end

