(*
The second include completely hides the earlier include.

Result: OK
 
$Log: include.sml,v $
Revision 1.3  1996/05/23 12:27:14  matthew
UPdating

 * Revision 1.2  1996/03/26  12:18:59  matthew
 * Updating
 *
Revision 1.1  1993/01/21  11:16:40  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

signature S =
sig
  type t
  val x: t
end;

signature SIG = 
sig
  include S
  include S
end
