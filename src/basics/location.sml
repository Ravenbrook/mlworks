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

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
