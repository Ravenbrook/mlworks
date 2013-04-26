(*

Result: OK
 
$Log: two_handlers.sml,v $
Revision 1.1  1993/05/05 15:21:17  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

exception exn1 and exn2;
fun f x = raise exn1;
fun g x =
  let
    val y = (f x) handle exn2 => 0
  in
    y
  end
handle exn1 => 1;
g 0;
