(*
SIG is not type-explicit.

Result: FAIL
 
$Log: include1.sml,v $
Revision 1.3  1996/03/26 12:19:21  matthew
Updating

Revision 1.2  1993/01/22  11:10:04  matthew
Fixed typo.

Revision 1.1  1993/01/21  11:18:59  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

signature S =
sig
  type t
end;

signature SIG = 
sig
  include S
  val y : t
  include S
end
