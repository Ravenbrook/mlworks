(* __basistypes.sml the structure *)
(* This structure contains datatype declarations used for typechecker bases *)
(*
$Log: __basistypes.sml,v $
Revision 1.4  1993/03/17 18:15:57  matthew
 Removed Tynameset and StrnameSet parameters

Revision 1.3  1993/03/04  10:35:38  matthew
Removed Info structure

Revision 1.2  1993/02/26  11:56:28  jont
Modified not to require _nameset

Revision 1.1  1993/02/09  18:32:54  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__set";
require "__datatypes";
require "__namesettypes";
require "_basistypes";


structure BasisTypes_ =
  BasisTypes
  ( structure Datatypes = Datatypes_
    structure NamesetTypes = NamesetTypes_
    structure Set       = Set_
      )
