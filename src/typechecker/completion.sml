(* completion.sml the signature *)
(*
$Log: completion.sml,v $
Revision 1.10  1996/08/05 13:37:33  andreww
[Bug #1521]
Propagating changes to _types.sml

 * Revision 1.9  1995/04/11  09:54:33  matthew
 * Adding cached completion functions
 *
Revision 1.8  1994/06/17  13:55:08  daveb
Removed complete_tycons and print_name.  Nothing uses them.

Revision 1.7  1993/11/24  15:43:19  nickh
Added function to report a type error as a list of types and strings.
Also changed the treatment of unbound type variables in completion;
they need to test equal on separate calls to print_type_with_seen_tyvars,
so we need to retain the ref cell.

Revision 1.6  1993/03/04  10:16:57  matthew
Options & Info changes

Revision 1.5  1993/02/22  15:04:50  matthew
Uncurried print_type, added print_name

Revision 1.4  1993/02/01  14:20:58  matthew
Added sharing

Revision 1.3  1992/11/24  17:02:59  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.2  1991/11/21  16:50:17  jont
Added copyright message

Revision 1.1  91/06/07  11:42:27  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "../typechecker/datatypes";
require "../main/options";

(**** Long type constructor name completion ****)

signature COMPLETION =
sig
  structure Datatypes : DATATYPES
  structure Options : OPTIONS

  type Cache

  val empty_cache : unit -> Cache
  val print_type : (Options.options * Datatypes.Env * Datatypes.Type) -> string
  val cached_print_type : 
    (Options.options * Datatypes.Env * Datatypes.Type * Cache)
      -> (string * Cache)

  val report_type_error :
    (Options.options * Datatypes.Env * Datatypes.type_error_atom list) 
    -> string

end;
