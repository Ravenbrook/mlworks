(*
Here a local type is used to share a type between signatures.

Result: OK
 
$Log: include3.sml,v $
Revision 1.3  1996/05/23 12:27:40  matthew
UPdating

 * Revision 1.2  1996/03/26  12:19:54  matthew
 * Updating
 *
Revision 1.1  1993/01/21  11:24:02  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

signature S =
sig
  type t
  val x: t
end;

signature T =
sig
  type t
  val y: t
end;

signature SIG = 
sig
  local
    type t'
  in
    include S
    sharing type t = t'
    include T
    sharing type t = t'
  end
end
