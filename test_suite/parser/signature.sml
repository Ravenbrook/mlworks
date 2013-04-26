(*
This tests opening of a previously-declared structure in a signature.

Result: OK

$Log: signature.sml,v $
Revision 1.3  1996/05/23 12:20:44  matthew
Shell.Options change

 * Revision 1.2  1996/03/26  14:59:12  matthew
 * Updating for new language definition
 *
 * Revision 1.1  1993/07/02  13:44:19  daveb
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)


Shell.Options.set (Shell.Options.Language.oldDefinition,true);

structure S = struct end;
signature FOO = sig open S end;
