(*
Exceptions are generative.

Result: OK
 
$Log: exception3.sml,v $
Revision 1.3  1993/07/12 15:14:50  daveb
Added handler at top level.

Revision 1.2  1993/01/20  11:43:49  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

val x = 
  let
    exception A of int
  in
    let
      exception A of bool
    in
      raise (A true)
    end
    handle (A x) => x=1
  end
  handle _ => true

