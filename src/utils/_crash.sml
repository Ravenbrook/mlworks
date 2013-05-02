(* _crash.sml the functor *)
(*
$Log: _crash.sml,v $
Revision 1.6  1996/03/15 14:38:27  daveb
Fixed use of Info.default_options.

 * Revision 1.5  1992/11/25  20:12:08  daveb
 * Changes to make show_id_class and show_eq_info part of Info structure
 * instead of references.
 *
Revision 1.4  1992/11/17  16:52:20  matthew
Changed Error structure to Info

Revision 1.3  1992/09/04  08:33:49  richard
Installed central error reporting mechanism.

Revision 1.2  1991/11/21  17:00:38  jont
Added copyright message

Revision 1.1  91/06/07  15:56:34  colin
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

require "../main/info";
require "crash";

functor Crash (structure Info : INFO) : CRASH =
  struct
    exception Impossible of string      (* shouldn't ever be reached *)

    fun impossible message =
      Info.default_error'
        (Info.FAULT, Info.Location.UNKNOWN, message)

    fun unimplemented message =
      Info.default_error'
	( Info.FAULT,
	  Info.Location.UNKNOWN,
	  "Unimplemented facility: " ^ message
	)
  end;
