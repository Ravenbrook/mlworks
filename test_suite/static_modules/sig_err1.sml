(*
The constraining signature has an unbound type constructor name

Result: FAIL
 
$Log: sig_err1.sml,v $
Revision 1.1  1993/07/08 19:26:15  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


functor f () : sig datatype a = A of t end =
  struct
    type t = int
    datatype a = A of t
  end
