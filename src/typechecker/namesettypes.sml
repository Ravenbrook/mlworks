(* datatype declaration for nameset *)
(* removed from basistypes *)
(*
$Log: namesettypes.sml,v $
Revision 1.1  1993/03/18 14:56:31  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/hashset";

signature NAMESETTYPES =
  sig
    structure TynameSet : HASHSET
    structure StrnameSet : HASHSET
    datatype Nameset =  NAMESET of (TynameSet.HashSet * StrnameSet.HashSet)
  end

