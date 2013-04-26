(*
Result: FAIL
 
$Log: quantify.sml,v $
Revision 1.1  1994/06/17 17:08:55  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

signature SIG =
  sig
    type ('a, 'b) foo
    val x : ('_a, '_b) foo ref
  end;
structure S : SIG =
  struct
    datatype ('a, 'b) foo = A
    val x = ref A
  end;
