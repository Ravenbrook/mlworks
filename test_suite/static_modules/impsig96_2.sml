(*
Test that signature matching can't generalize free type variables
Result: FAIL
 
$Log: impsig96_2.sml,v $
Revision 1.1  1996/10/07 11:24:34  andreww
new unit
new test.

 * Revision 1.1  1994/07/01  15:15:27  jont
 * new file
 *

Copyright (c) 1994 Harlequin Ltd.
*)

signature SIG =
  sig
    val x : 'a list ref
  end;

structure S : SIG =
  struct
    val x = ref []
  end



