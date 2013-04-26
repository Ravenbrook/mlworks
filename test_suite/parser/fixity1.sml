(*

Result: OK
 
$Log: fixity1.sml,v $
Revision 1.2  1993/01/19 15:52:51  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure S = 
  struct
    fun f (a,b) = a andalso b
    infix f
    val y = true f false
    nonfix f
    val y = f (true, true)
    infix f
  end

val x = S.f (false,true)
