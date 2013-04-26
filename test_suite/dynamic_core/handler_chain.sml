(*

Result: OK
 
$Log: handler_chain.sml,v $
Revision 1.4  1997/05/28 12:12:40  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/01  17:16:26  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1993/07/12  14:15:45  jont
 * Changed so as not to enter the debugger
 *
Revision 1.1  1993/04/30  12:52:13  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

exception exn1 and exn2;
fun bar _ = (print"Raising\n";raise exn1);
fun make_list(n, result) = if n <= 0 then result else make_list(n-1, n :: result);
fun foo [] = bar() | foo(x :: xs) = (x :: foo xs) handle exn2 => [x];
(foo(make_list(20000, []))) handle exn1 => [];
