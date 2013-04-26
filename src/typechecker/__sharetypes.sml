(* __sharetypes.sml the structure *)
(*
$Log: __sharetypes.sml,v $
Revision 1.5  1995/02/02 13:54:24  matthew
Removing debug stuff

Revision 1.4  1993/05/20  16:32:40  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.3  1992/01/27  18:17:52  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:40:45  jont
Added copyright message

Revision 1.1  91/06/07  11:22:51  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__print";
require "../typechecker/__datatypes";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__assemblies";
require "../typechecker/__nameset";
require "../typechecker/__namesettypes";
require "../typechecker/_sharetypes";

structure Sharetypes_ = Sharetypes(
  structure Print = Print_
  structure Datatypes = Datatypes_
  structure Types = Types_
  structure Conenv = Valenv_
  structure Assemblies = Assemblies_
  structure Nameset = Nameset_
  structure NamesetTypes = NamesetTypes_
);
