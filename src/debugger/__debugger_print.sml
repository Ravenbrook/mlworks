(* __debugger_print.sml the structure *)
(*
$Log: __debugger_print.sml,v $
Revision 1.5  1995/01/18 11:01:39  matthew
Renaming debugger_env to runtime_env

# Revision 1.4  1994/09/13  16:23:32  matthew
# Abstraction of debug information
#
# Revision 1.3  1994/06/09  15:47:56  nickh
# New runtime directory structure.
#
# Revision 1.2  1993/09/07  08:53:44  nosa
# structure Tags.
#
# Revision 1.1  1993/07/30  15:48:33  nosa
# Initial revision
#

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

require "../utils/__crash";
require "../utils/__lists";
require "../main/__options";
require "../typechecker/__types";
require "../rts/gen/__tags";
require "__runtime_env";
require "__debugger_utilities";
require "_debugger_print";

structure DebuggerPrint_ = DebuggerPrint(structure Crash = Crash_
                                         structure Lists = Lists_
                                         structure Options = Options_
                                         structure Types = Types_
                                         structure Tags = Tags_
                                         structure RuntimeEnv = RuntimeEnv_
                                         structure DebuggerUtilities = DebuggerUtilities_
                                           );
