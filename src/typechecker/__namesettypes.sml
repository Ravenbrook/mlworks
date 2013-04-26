(* datatype declaration for nameset *)
(* removed from basistypes *)
(*
$Log: __namesettypes.sml,v $
Revision 1.1  1993/03/18 14:57:05  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/_hashset";
require "../utils/__crash";
require "../utils/__lists";
require "__datatypes";
require "__namehash";
require "__types";
require "__strnames";
require "_namesettypes";

structure NamesetTypes_ =
  NamesetTypes(structure TynameSet = HashSet(structure Crash = Crash_
                                             structure Lists = Lists_
                                             type element = Datatypes_.Tyname
                                             val eq = Types_.tyname_eq
                                             val hash = NameHash_.tyname_hash
                                               )
               structure StrnameSet = HashSet(structure Crash = Crash_
                                              structure Lists = Lists_
                                              type element = Datatypes_.Strname
                                              val eq = Strnames_.strname_eq
                                              val hash = NameHash_.strname_hash
                                                ))
