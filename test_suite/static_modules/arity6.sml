(*
Result: FAIL
 
$Log: arity6.sml,v $
Revision 1.1  1994/05/04 16:03:35  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

signature SIG = sig type 'a T end;

structure S : SIG =
  struct
    type T = int
  end;
