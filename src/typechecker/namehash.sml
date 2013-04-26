(* namehash.sml the signature *)
(*
$Log: namehash.sml,v $
Revision 1.3  1993/03/02 14:20:06  matthew
DataTypes to Datatypes

Revision 1.2  1992/06/26  15:23:43  jont
Changed to imperative implementation of namesets with hashing

Revision 1.1  1992/04/21  13:47:50  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)
require "../typechecker/datatypes";

signature NAMEHASH =
  sig
    structure Datatypes : DATATYPES

    val strname_hash : Datatypes.Strname -> int
    val tyname_hash : Datatypes.Tyname -> int
    val type_hash : Datatypes.Type -> int
    val tyfun_hash : Datatypes.Tyfun -> int
  end








