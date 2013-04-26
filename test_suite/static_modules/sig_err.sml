(*
The constraining signature has an unbound type constructor name

Result: FAIL
 
$Log: sig_err.sml,v $
Revision 1.1  1993/07/08 19:25:07  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


structure S : sig datatype a = A of t end =
  struct
    type t = int
    datatype a = A of t
  end
