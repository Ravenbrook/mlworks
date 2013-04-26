(*
Result: OK
 
$Log: arity4.sml,v $
Revision 1.1  1994/05/04 15:54:23  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

signature SIG = sig type 'a T end;

structure S : SIG =
  struct
    type 'a T = 'a list
  end;
