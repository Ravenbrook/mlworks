(*
infix declarations obey scope.

Result: FAIL
 
$Log: fixity2.sml,v $
Revision 1.2  1993/01/19 16:01:22  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun f (a,b) = a andalso b

local
  infix f
in
  val y = true f false
end

val x = true f true
