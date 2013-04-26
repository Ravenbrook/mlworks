(* environprint.sml the signature *)
(*
$Log: environprint.sml,v $
Revision 1.10  1997/05/22 13:13:46  jont
[Bug #30090]
Replace MLWorks.IO with TextIO where applicable

 * Revision 1.9  1996/04/30  16:13:56  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.8  1993/03/04  12:38:25  matthew
 * Options & Info changes
 *
Revision 1.7  1993/02/01  16:42:31  matthew
Added extra sharing

Revision 1.6  1993/01/05  16:31:32  jont
 Added functions to print directly to a supplied stream

Revision 1.5  1992/11/26  20:35:04  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.4  1991/07/19  16:43:08  davida
New version using custom pretty-printer

Revision 1.3  91/07/12  16:58:30  jont
Added top level environment printing functions

Revision 1.2  91/06/11  16:54:48  jont
Abstracted out the types from the functions

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

require "^.basis.__text_io";

require "environtypes";
require "../main/options";

signature ENVIRONPRINT = sig
  structure EnvironTypes : ENVIRONTYPES
  structure Options : OPTIONS

  val stringenv: Options.print_options -> EnvironTypes.Env -> string
  val stringtopenv: Options.print_options -> EnvironTypes.Top_Env -> string
  val printenv: Options.print_options -> EnvironTypes.Env -> TextIO.outstream -> unit
  val printtopenv: Options.print_options -> EnvironTypes.Top_Env -> TextIO.outstream -> unit
end
