(*
Result: OK
 
$Log: threads2.sml,v $
Revision 1.1  1996/10/21 16:26:57  andreww
new unit
[bug 1665]


Copyright (c) 1996 Harlequin Ltd.

Checks that implementation of MLWorks.Threads.Internal.chilren 
returns a list.
*)


MLWorks.Threads.Internal.children(MLWorks.Threads.Internal.id()) = [];


