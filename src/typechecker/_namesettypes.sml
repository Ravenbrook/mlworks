(* datatype declaration for nameset *)
(* removed from basistypes *)
(*
$Log: _namesettypes.sml,v $
Revision 1.1  1993/03/18 14:56:49  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/hashset";
require "namesettypes";


functor NamesetTypes (structure TynameSet : HASHSET
                      structure StrnameSet : HASHSET) : NAMESETTYPES =
  struct
    structure TynameSet = TynameSet
    structure StrnameSet = StrnameSet

    (****
     Nameset is one of the semantic objects for the Modules.  In this
     structure the type and the operations on it are defined.
     ****)

    (****
     Nameset is one of the semantic objects for the Modules.  In this
     structure the type and the operations on it are defined.
     ****)

    datatype Nameset =  NAMESET of (TynameSet.HashSet * StrnameSet.HashSet)
  end

                        
