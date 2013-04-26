(*
The constraining signature has an unbound type constructor name

Result: FAIL
 
$Log: sig_err2.sml,v $
Revision 1.1  1993/07/12 12:16:47  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


functor f (S: sig datatype a = A of t end) =
  struct
  end
