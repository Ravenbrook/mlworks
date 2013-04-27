(* __absyn.sml the structure *)
(*
$Log: __absyn.sml,v $
Revision 1.15  1995/12/05 12:08:46  jont
Add Types and Lists to functor parameters

Revision 1.14  1995/11/22  09:16:00  daveb
Removed ModuleId parameter.

Revision 1.13  1995/01/04  12:20:41  matthew
Renaming debugger_env to runtime_env

Revision 1.12  1994/09/13  10:13:54  matthew
Abstraction of debug information

Revision 1.11  1993/07/30  14:43:20  daveb
Removed Option parameter, added ModuleId parameter.

Revision 1.10  1993/06/01  08:34:52  nosa
structure Option.

Revision 1.9  1993/05/18  18:42:40  jont
Removed integer parameter

Revision 1.8  1993/02/08  15:38:33  matthew
Removed nameset structure and ref nameset from FunBind (which wasn't used)

Revision 1.7  1993/02/03  17:48:54  matthew
Rationalised functor parameter

Revision 1.6  1992/12/17  17:33:36  matthew
> Changed int and real scons to carry a location around

Revision 1.5  1992/09/04  08:26:04  richard
Installed central error reporting mechanism.

Revision 1.4  1992/05/19  09:36:53  clive
Added marks for better error reporting

Revision 1.3  1991/11/21  15:52:25  jont
Added copyright message

Revision 1.2  91/06/27  13:42:00  colin
added Interface annotation for signature expressions

Revision 1.1  91/06/07  10:49:28  colin
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

require "../typechecker/__types";
require "../debugger/__runtime_env";
require "../utils/__set";
require "../utils/__lists";
require "_absyn";

structure Absyn_ =
  Absyn (structure Types = Types_
         structure RuntimeEnv = RuntimeEnv_
	 structure Set = Set_
	 structure Lists = Lists_);

