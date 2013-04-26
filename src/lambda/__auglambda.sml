(* __auglambda.sml the structure *)
(*
$Log: __auglambda.sml,v $
Revision 1.10  1996/11/19 11:13:39  matthew
Removing Lists structure

 * Revision 1.9  1996/10/04  13:01:00  matthew
 * Removing redundant LambdaSub
 *
 * Revision 1.8  1995/02/09  15:57:41  matthew
 * Removing structure Types
 *
Revision 1.7  1995/01/13  17:18:26  matthew
Rationalizing debugger

Revision 1.6  1993/04/29  10:27:27  matthew
Renamed Debugger_Type_Utilities to DebuggerTypeUtilities

Revision 1.5  1992/08/04  14:15:48  davidt
Removed redundant structure arguments.

Revision 1.4  1992/07/06  16:14:58  clive
Generation of function call point debug information

Revision 1.3  1992/06/29  09:30:47  clive
Added type annotation information at applications

Revision 1.2  1992/06/11  09:13:18  clive
Added types to the fnexp of the lambda tree for the debugger to use

Revision 1.1  1992/05/05  12:47:10  jont
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

require "../utils/__crash";
require "../lambda/__lambdatypes";
require "../main/__pervasives";
require "../debugger/__debugger_utilities";
require "_auglambda";

structure AugLambda_ = AugLambda(
  structure Crash = Crash_
  structure LambdaTypes = LambdaTypes_
  structure Pervasives = Pervasives_
  structure DebuggerUtilities = DebuggerUtilities_
)

