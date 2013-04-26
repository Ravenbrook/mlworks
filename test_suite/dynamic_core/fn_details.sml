(*

Result: OK
 
$Log: fn_details.sml,v $
Revision 1.3  1996/08/02 13:39:19  jont
Do this test with generateDebugInfo set true

 * Revision 1.2  1996/02/23  16:28:03  daveb
 * Converted Shell structure to new capitalisation convention.
 *
Revision 1.1  1993/11/23  20:26:15  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.ValuePrinter.showFnDetails,true);
Shell.Options.set (Shell.Options.Compiler.generateDebugInfo,true);

fun foo x = bar x and bar x = foo x;
