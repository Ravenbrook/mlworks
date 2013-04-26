(*
Result: OK
 
$Log: real.sml,v $
Revision 1.5  1996/11/05 13:53:00  andreww
[Bug #1711]
real no longer an eqtype

 * Revision 1.4  1994/06/10  10:28:43  jont
 * Changed to make a significant test (ie no loss of precision)
 *
Revision 1.3  1994/04/27  13:12:30  jont
Fix to be a real test

Revision 1.2  1993/01/21  11:58:15  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun exp2' 0 = 1.0 | exp2' n = 2.0 * exp2' (n - 1);
val b' = exp2' 50 = exp2' 50 + 1.0;
