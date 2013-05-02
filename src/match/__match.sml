(* __match.sml the structure *)
(*
$Log: __match.sml,v $
Revision 1.14  1995/12/27 15:53:23  jont
Remove __option

Revision 1.13  1995/07/19  15:33:43  jont
Add scons structure for scon_eqval

Revision 1.12  1995/02/07  14:14:53  matthew
Renaming Type_Utils

Revision 1.11  1994/09/13  13:47:54  matthew
Abstraction of debug information

Revision 1.10  1993/05/28  10:23:55  nosa
structure Option.

Revision 1.9  1993/05/18  17:06:35  jont
Removed integer parameter

Revision 1.8  1992/11/04  14:53:45  jont
Changes to allow IntNewMap to be used on MatchVar

Revision 1.7  1992/08/19  16:08:10  davidt
Took out various redundant structure arguments.

Revision 1.6  1992/03/23  11:38:37  jont
Added requires for __ident and __identprint

Revision 1.5  1992/01/23  14:05:23  jont
Added type_utils parameter

Revision 1.4  1992/01/22  19:44:45  jont
Added Crash parameter

Revision 1.3  1991/11/27  12:58:26  jont
Changed name of Match_utils to Match_Utils

Revision 1.2  91/11/21  16:32:48  jont
Added copyright message

Revision 1.1  91/06/07  11:05:59  colin
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

require "../utils/__lists";
require "../utils/__crash";
require "../utils/_counter";
require "../basics/__scons";
require "../basics/__identprint";
require "../basics/__absynprint";
require "../typechecker/__types";
require "__type_utils";

require "_match";

structure Match_ = Match (
  structure Lists = Lists_
  structure Crash = Crash_
  structure MVCounter = Counter()
  structure Scons = Scons_
  structure IdentPrint = IdentPrint_
  structure AbsynPrint = AbsynPrint_
  structure Types = Types_
  structure TypeUtils = TypeUtils_
)

