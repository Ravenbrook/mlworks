(*

Result: FAIL
 
$Log: fixity3.sml,v $
Revision 1.2  1993/01/19 16:07:44  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun f (a,b) = a andalso b

fun g () = 
  let
    infix f
  in
    true f false
  end

val x = true f true
