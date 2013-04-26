(* debugger_print.sml the signature *)
(*
$Log: debugger_print.sml,v $
Revision 1.8  1995/03/07 15:04:10  matthew
Making debugger platform independent

# Revision 1.6  1995/01/20  12:07:11  matthew
# Renaming debugger_env to runtime_env
#
# Revision 1.5  1994/09/13  16:22:04  matthew
# Abstraction of debug information
#
# Revision 1.4  1993/08/16  13:02:13  nosa
# print_env now takes parent-frames for polymorphic debugger.
#
# Revision 1.3  1993/08/05  16:24:41  nosa
# print_env now returns list used in inspector invocation in debugger-window.
#
# Revision 1.2  1993/08/04  09:53:29  nosa
# Changed type of print_env.
#
# Revision 1.1  1993/07/30  15:45:32  nosa
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

require "../main/options";
require "runtime_env";

signature DEBUGGER_PRINT =
  sig

    structure RuntimeEnv : RUNTIMEENV
    structure Options : OPTIONS

    val print_env : 
      ((MLWorks.Internal.Value.Frame.frame * RuntimeEnv.RuntimeEnv * RuntimeEnv.Type)
       * ((RuntimeEnv.Type * MLWorks.Internal.Value.T) -> string)
       * Options.options * bool 
      * (MLWorks.Internal.Value.Frame.frame * RuntimeEnv.RuntimeEnv * RuntimeEnv.Type) list) -> 
      string * 
      (string * (RuntimeEnv.Type * MLWorks.Internal.Value.ml_value * string)) list


  end
