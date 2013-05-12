(* __mir_utils.sml the structure *)
(*
$Log: __mir_utils.sml,v $
Revision 1.9  1995/09/04 14:00:20  daveb
Added BigNum32 parameter.

Revision 1.8  1995/03/17  19:51:58  daveb
Removed unused parameters.

Revision 1.7  1995/02/07  17:07:34  matthew
Removing unused LambdaSub

Revision 1.6  1993/07/20  13:55:00  jont
Added BigNum parameter

Revision 1.5  1993/05/18  14:15:15  jont
Removed Integer parameter

Revision 1.4  1992/08/19  18:08:05  davidt
Took out redundant structure arguments.

Revision 1.3  1992/08/07  18:00:06  davidt
String structure is now pervasive.

Revision 1.2  1992/05/08  17:11:56  jont
Added auglambda

Revision 1.1  1992/04/07  17:08:30  jont
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

require "../utils/_diagnostic";
require "../utils/__sexpr";
require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/__bignum";
require "../main/__pervasives";
require "../main/__library";
require "../typechecker/__types";
require "__mirregisters";
require "__mir_env";
require "_mir_utils";

structure Mir_Utils_ = Mir_Utils(
  structure Diagnostic =
    Diagnostic(structure Text = Text_)
  structure Sexpr = Sexpr_
  structure Lists = Lists_
  structure Crash = Crash_
  structure BigNum = BigNum_
  structure BigNum32 = BigNum32_
  structure Pervasives = Pervasives_
  structure Library = Library_
  structure Types = Types_
  structure MirRegisters = MirRegisters_
  structure Mir_Env = Mir_Env_
);
