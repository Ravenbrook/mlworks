(*
This is an odd one - there's nothing in the semantics
that checks whether the two datatypes are specified in
the same top-level signature or whether they have different
identifiers (it's not possible to re-name datatypes).

Result: OK

$Log: share2.sml,v $
Revision 1.4  1996/05/23 12:28:02  matthew
UPdating

 * Revision 1.3  1996/03/26  15:01:27  matthew
 * Updating for new definition
 *
 * Revision 1.2  1993/01/20  16:53:01  daveb
 * Added header.
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

signature SIG = 
  sig
    datatype t = T of int -> real
    datatype u = T of int -> int
    sharing type t = u 
  end

