(*
The basis does not cover the result of elaborating SIG.
SIG "adds more structure" to S.

Result: FAIL
 
$Log: cover.sml,v $
Revision 1.3  1996/04/01 11:52:09  matthew
updating

 * Revision 1.2  1993/01/20  16:29:59  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

signature SIG = 
  sig
    structure A : sig type t end
    sharing S = A
  end
