(* __lambdaprint.sml the structure *)
(*
$Log: __lambdaprint.sml,v $
Revision 1.11  1995/02/13 12:31:39  matthew
Changes to Debugger_Types

Revision 1.10  1993/05/18  15:50:10  jont
Removed integer parameter

Revision 1.9  1992/07/20  13:40:05  clive
Changed to depend on debugger_types and not types

Revision 1.8  1992/06/11  08:42:19  clive
Needed to add type annotation to Fnexps

Revision 1.7  1992/03/23  11:11:16  jont
Added Integer parameter to the functor application

Revision 1.6  1991/08/23  17:05:53  davida
_Removed_ code to print names of builtins from
initial environment in main/primitives -
Jon decided he'd do it instead!!

Revision 1.5  91/08/22  15:18:55  davida
Added code to print names of builtins from
initial environment in main/primitives.

Revision 1.4  91/07/19  16:45:15  davida
New version using custom pretty-printer

Revision 1.3  91/06/26  16:30:20  jont
Added Lists structure to parameter list

Revision 1.2  91/06/12  19:27:00  jont
Reflect split of lambda into lamdatypes and lambda

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

require "_lambdaprint";
require "../utils/__lists";
require "../basics/__identprint";
require "../debugger/__debugger_types";
require "__pretty";
require "__lambdatypes";

structure LambdaPrint_ = LambdaPrint (
  structure Lists = Lists_
  structure Pretty = Pretty_
  structure IdentPrint = IdentPrint_
  structure DebuggerTypes = Debugger_Types_
  structure LambdaTypes = LambdaTypes_);
   

