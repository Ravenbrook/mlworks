(*
$Log: inbuffer.sml,v $
Revision 1.12  1994/03/08 14:42:00  daveb
Added getLastLinePos, to support better locations for erroneous newlines
in strings.

Revision 1.11  1993/04/01  09:39:15  daveb
Added a boolean eof parameter to mkLineInBuffer, for use with the
incremental parser.

Revision 1.10  1992/12/21  11:06:58  matthew
Change to allow token streams to be created with a given initial line number.

Revision 1.9  1992/11/19  14:33:12  matthew
Added flush_to_nl

Revision 1.8  1992/11/09  18:35:26  daveb
Added clear_eof function.

Revision 1.7  1992/10/14  11:21:46  richard
Added line number to token stream input functions.

Revision 1.6  1992/08/18  15:06:06  davidt
Removed the forget and flush functions which are now redundant.

Revision 1.5  1992/08/14  20:06:01  davidt
Function getchar now returns an int.

Revision 1.4  1992/08/14  17:37:56  jont
Removed all currying from inbuffer

Revision 1.3  1992/05/19  17:04:18  clive
Fixed line position output from lexer

Revision 1.2  1992/03/23  13:34:38  matthew
Added line numbering.

Revision 1.1  1991/09/06  16:49:14  nickh
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
signature INBUFFER =
  sig
    type InBuffer

    exception Eof
    exception Position

    type StateEncapsulation

    val mkInBuffer : (int -> string) -> InBuffer
    val mkLineInBuffer : ((int -> string) * int * bool) -> InBuffer
    val getpos : InBuffer -> StateEncapsulation
    val position : (InBuffer * StateEncapsulation) -> unit
    val eof : InBuffer -> bool
    val clear_eof : InBuffer -> unit
    val getchar : InBuffer -> int
    val getlinenum : InBuffer -> int
    val getlinepos : InBuffer -> int
    val getlastlinepos : InBuffer -> int
    val flush_to_nl : InBuffer -> unit
  end
