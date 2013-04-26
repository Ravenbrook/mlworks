(*
Test that signature matching doesn't instantiate imperative type variables
Result: FAIL
 
$Log: impsig90_1.sml,v $
Revision 1.1  1996/10/07 11:21:06  andreww
new unit
new test

 * Revision 1.1  1994/07/01  15:15:27  jont
 * new file
 *

Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

signature SIG =
  sig
    val x : int list ref
  end;

structure S : SIG =
  struct
    val x = ref []
  end



