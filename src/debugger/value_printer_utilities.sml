(* value_printer_utilities.sml the signature *)
(*
$Log: value_printer_utilities.sml,v $
Revision 1.4  1993/12/09 19:27:57  jont
Added copyright message

Revision 1.3  1993/02/09  10:14:13  matthew
Typechecker structure changes

Revision 1.2  1993/02/04  17:26:02  matthew
Removed Datatypes substructure.

Revision 1.1  1992/08/13  16:41:09  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../typechecker/basistypes";

signature VALUEPRINTERUTILITIES =
  sig
    structure BasisTypes : BASISTYPES
    exception FailedToFind
    val find_tyname : BasisTypes.Basis * string -> BasisTypes.Datatypes.Tyname
  end
