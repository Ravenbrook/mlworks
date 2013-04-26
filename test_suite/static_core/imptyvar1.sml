(*
Imperative type variables may be closed over if the expression
is expansive.

Result: OK
 
$Log: imptyvar1.sml,v $
Revision 1.3  1996/05/23 12:21:04  matthew
Shell.Options change

 * Revision 1.2  1996/03/26  12:41:02  matthew
 * Updating
 *
Revision 1.1  1993/01/22  17:35:25  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

val x = [] : '_a list
