(*
Tests sharing must share correct arity in nonlocal structure defn.
Result: FAIL
 
$Log: share20.sml,v $
Revision 1.1  1996/10/07 11:19:19  andreww
new unit
new test.

 * Revision 1.1  1994/07/01  15:15:27  jont
 * new file
 *

Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

structure S =
  struct
    datatype 'a t = T
  end;

signature SIG =
  sig
    type t
    sharing type t = S.t
  end;
