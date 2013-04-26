(* __control_unify.sml the structure *)
(*
$Log: __control_unify.sml,v $
Revision 1.11  1996/04/15 12:01:23  matthew
Adding Types structure

 * Revision 1.10  1993/12/16  17:42:16  matthew
 * Added Lists structure.
 *
Revision 1.9  1993/03/04  11:03:59  matthew
Added Info structure

Revision 1.8  1993/02/22  15:00:26  matthew
Removed Types structure

Revision 1.7  1992/11/26  17:20:20  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.6  1992/11/04  18:00:12  matthew
Changed Error structure to Info

Revision 1.5  1992/09/02  16:38:09  richard
Installed central error reporting mechanism.

Revision 1.4  1992/08/13  16:51:44  jont
changed identprint to __identprint

Revision 1.3  1992/08/12  10:25:51  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.2  1991/11/21  16:38:23  jont
Added copyright message

Revision 1.1  91/06/07  11:11:18  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../typechecker/_control_unify";
require "../utils/__crash";
require "../utils/__lists";
require "../basics/__identprint";
require "../typechecker/__types";
require "../typechecker/__unify";
require "../typechecker/__completion";
require "__basis";
require "../main/__info";

structure Control_Unify_ = Control_Unify(
  structure Crash         = Crash_
  structure Lists         = Lists_
  structure IdentPrint    = IdentPrint_
  structure Types         = Types_
  structure Unify         = Unify_
  structure Completion    = Completion_
  structure Basis         = Basis_
  structure Info          = Info_)
 
