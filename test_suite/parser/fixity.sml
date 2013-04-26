(*

Result: FAIL
 
$Log: fixity.sml,v $
Revision 1.2  1993/01/19 15:52:28  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure S = 
  struct
    fun f (a,b) = a andalso b
    infix f
    val y = true f false
  end

val x = true S.f false
