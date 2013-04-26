(*
op isn't allowed in signatures.

Result: FAIL

$Log: fixity13.sml,v $
Revision 1.3  1993/04/15 10:44:03  daveb
Added missing semicolon.

Revision 1.2  1993/01/19  15:57:14  daveb
Added header.

Revision 1.1  1992/11/06  15:07:31  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

infix %% ;

signature S =
sig
  datatype Foo = op %% of int
end;
