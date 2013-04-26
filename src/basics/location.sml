(* location.sml the signature *)
(*
$Log: location.sml,v $
Revision 1.6  1996/02/21 11:58:33  jont
Add file_of_location to extract the filename part of a location

 * Revision 1.5  1996/01/15  16:45:37  daveb
 * Added the extract function.
 *
Revision 1.4  1994/03/08  14:39:22  daveb
Added first_col and first_line.

Revision 1.3  1993/04/15  10:48:36  matthew
Added a function to parse a string representing a location

Revision 1.2  1993/01/14  15:29:18  jont
Added a range type to Location.T

Revision 1.1  1992/09/04  08:31:33  richard
Initial revision

Copyright (C) 1992 Harlequin Ltd
*)
signature LOCATION =
  sig
    datatype T =
      UNKNOWN |
      FILE of string |
      LINE of string * int |
      POSITION of string * int * int |
      EXTENT of {name:string, s_line:int, s_col:int, e_line:int, e_col: int}

    exception InvalidLocation
    val to_string : T -> string
    val from_string : string -> T

    val combine : T * T -> T
    val first_col : int
    val first_line : int

    val file_of_location : T -> string

    (* extract takes an EXTENT and a string, and converts the location
       information into offsets into the string.  If the location is not
       an extent, it raises InvalidLocation. *)
    val extract : T * string -> int * int
  end;
