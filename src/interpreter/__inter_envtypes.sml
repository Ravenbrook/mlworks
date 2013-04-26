(* __inter_envtypes.sml the structure *)
(*
$Log: __inter_envtypes.sml,v $
Revision 1.5  1992/10/27 18:27:11  jont
Removed dependence on _environ

Revision 1.4  1992/10/13  12:51:57  richard
Removed redundant parameters.

Revision 1.3  1992/07/29  09:53:23  jont
Removed references to callc_codes and __callc_codes

Revision 1.2  1992/06/19  17:27:08  jont
Fixed the source errors

Revision 1.1  1992/06/18  12:11:49  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../utils/__lists";
require "../basics/__identprint";
require "../lambda/__environtypes";
require "_inter_envtypes";

structure Inter_EnvTypes_ =
  Inter_EnvTypes(structure Lists = Lists_
                 structure IdentPrint = IdentPrint_
                 structure EnvironTypes = EnvironTypes_);
