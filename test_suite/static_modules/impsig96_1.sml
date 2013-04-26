(*
Test that signature matching can instantiate free type variables
Result: OK
 
$Log: impsig96_1.sml,v $
Revision 1.1  1996/10/07 11:23:33  andreww
new unit
new test.

 * Revision 1.1  1994/07/01  15:15:27  jont
 * new file
 *

Copyright (c) 1994 Harlequin Ltd.
*)

signature SIG =
  sig
    val x : int list ref
  end;

structure S : SIG =
  struct
    val x = ref []
  end



