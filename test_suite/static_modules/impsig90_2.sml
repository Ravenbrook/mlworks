(*
Test that signature matching doesn't instantiate imperative type variables
Result: FAIL
 
$Log: impsig90_2.sml,v $
Revision 1.1  1996/10/07 11:21:32  andreww
new unit
new test.

 * Revision 1.1  1994/07/01  15:21:57  jont
 * new file
 *

Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

signature SIG =
  sig
    val x : '_a list ref
  end;

structure S : SIG =
  struct
    val x = ref []
  end
