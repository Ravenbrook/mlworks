(* editor.sml the signature *)
(*
$Log: editor.sml,v $
Revision 1.11  1997/05/01 12:29:05  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.10  1995/10/20  09:51:31  daveb
 * Added show_location.
 *
Revision 1.9  1995/10/02  10:36:36  daveb
Removed next_error.

Revision 1.8  1995/01/13  14:33:20  daveb
Replaced Option structure with references to MLWorks.Option.

Revision 1.7  1994/07/29  16:16:22  daveb
Moved preferences out of Options structure.

Revision 1.6  1993/08/25  14:21:38  matthew
Return quit function from edit function

Revision 1.5  1993/07/08  15:02:56  nosa
Changed Option.T to Option.opt.

Revision 1.4  1993/06/04  14:12:05  daveb
Removed filename component of error result for edit functions.

Revision 1.3  1993/04/14  15:24:38  jont
Added next_error and no_more_errors

Revision 1.2  1993/04/08  12:31:53  jont
Added options parameter

Revision 1.1  1993/03/10  17:21:27  jont
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

require "../basics/location";

signature EDITOR =
  sig
    structure Location : LOCATION
    type preferences

    val show_location :
      preferences
      -> string * Location.T
      -> (string option * (unit->unit))

    val edit_from_location :
      preferences
      -> string * Location.T
      -> (string option * (unit->unit))

    val edit :
      preferences
      -> string * int
      -> (string option * (unit->unit))
  end;
