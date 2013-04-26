(*
$Log: lexrules.sml,v $
Revision 1.11  1995/03/17 14:38:46  matthew
Using ints as char representation

Revision 1.10  1993/03/29  12:47:58  daveb
Replaced lexers for strings and comments with simple functions.
Removed check_end_state, since EOFs are now annotated by LexerState.
Added InBuffer to arguments of functions in rules.

Revision 1.9  1993/03/18  17:27:54  daveb
Action functions now take an options parameter.

Revision 1.8  1992/12/08  15:13:18  matthew
Hack to handle unclosed comments and strings

Revision 1.7  1992/11/05  15:27:03  matthew
Changed Error structure to Info

Revision 1.6  1992/09/04  08:41:20  richard
Installed central error reporting mechanism.

Revision 1.5  1992/08/31  16:58:33  richard
Replaced LexBasics error handler with Error.

Revision 1.4  1992/08/15  14:30:30  davidt
Removed the self reference and changed the type of rules to
accept functions with argument type int list instead of string.

Revision 1.3  1992/08/05  14:42:04  jont
Removed some structures and sharing

Revision 1.2  1992/02/03  12:47:15  jont
Changed type of result to be an eqtype

Revision 1.1  1991/09/06  16:49:34  nickh
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
require "inbuffer";
require "regexp";

signature LEXRULES = 
  sig
    structure RegExp : REGEXP
    structure Info : INFO
    structure InBuffer : INBUFFER

    type options
    eqtype Result

    val eof : Result
    val read_comment: InBuffer.InBuffer * int -> Result
    val continue_string:
      Info.Location.T * InBuffer.InBuffer * Info.options * int list -> Result
    val rules :
      (RegExp.RegExp *
       ((Info.Location.T * InBuffer.InBuffer *
	 int list * (Info.options * options)) -> Result)
      ) list
  end
