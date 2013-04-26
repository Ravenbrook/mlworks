(*
The sharing constraint means that SIG is type-explicit, despite
the binding of y to x.

Result: OK
 
$Log: include2.sml,v $
Revision 1.4  1996/05/23 12:27:31  matthew
UPdating

 * Revision 1.3  1996/03/26  12:19:38  matthew
 * Updating
 *
Revision 1.2  1993/01/22  11:11:30  matthew
Fixed tyo.

Revision 1.1  1993/01/21  11:20:31  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

signature S =
sig
  type t
end;

signature SIG = 
sig
  include S
  sharing type t = int
  val y : t
  include S
end
