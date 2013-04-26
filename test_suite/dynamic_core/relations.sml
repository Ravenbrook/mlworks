(*

Result: OK
 
$Log: relations.sml,v $
Revision 1.1  1993/08/23 16:07:19  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

fun foo n = if n = 1 then 1 else if n mod 2 = 0 then foo(n div 2) else foo(n*3+1)
val y = 1 > foo 27
