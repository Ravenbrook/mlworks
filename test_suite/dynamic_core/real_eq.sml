(*
At one time polymorphic equality on reals always returned false (bug 649).

Result: OK
 
$Log: real_eq.sml,v $
Revision 1.2  1996/11/01 11:32:51  andreww
[Bug #1711]
real is not an equality type in SML'96.

 * Revision 1.1  1994/06/22  14:15:27  nickh
 * new file
 *
Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun apply f = f (0.0,0.0);

val x =  map apply [op =,fn _ => true,fn _ => false, op =];

