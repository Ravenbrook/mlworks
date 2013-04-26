(*
Explicit type variables must be generalised at their scoping declarations.

Result: OK
 
$Log: tyvarscope.sml,v $
Revision 1.4  1996/05/23 12:21:18  matthew
Shell.Options change

 * Revision 1.3  1996/03/26  14:04:42  matthew
 * Updating
 *
Revision 1.2  1993/01/20  13:04:39  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


Shell.Options.set (Shell.Options.Language.oldDefinition,true);

val x = (let val Id1 : 'a -> 'a = fn z => z in Id1 Id1 end,
         let val Id2 : 'a -> 'a = fn z => z in Id2 Id2 end)
