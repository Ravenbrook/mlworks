(*
withtype declarations can't be recursive

Result: FAIL
 
$Log: withtype2.sml,v $
Revision 1.1  1993/07/28 13:40:14  matthew
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

datatype Foo = 
    A of int
  | B of Z 
  | C of Z
  | D of Y
withtype Z = Foo * Foo 
and Y = Z list;
