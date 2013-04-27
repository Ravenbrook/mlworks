(* __debugger_types the structure *)
(*
$Log: __debugger_types.sml,v $
Revision 1.13  1996/10/30 19:23:01  io
[Bug #1614]
removing Lists

 * Revision 1.12  1995/01/04  12:30:40  matthew
 * Renaming debugger_env to runtime_env
 *
Revision 1.11  1994/09/13  10:07:18  matthew
Abstraction of debug information

Revision 1.10  1993/12/09  19:26:41  jont
Added copyright message

Revision 1.9  1993/07/08  14:46:05  nosa
Debugger Environments for local and closure variable inspection
in the debugger.

Revision 1.8  1993/05/18  13:42:39  jont
Removed integer parameter

Revision 1.7  1993/03/10  16:22:00  matthew
Signature revisions

Revision 1.6  1992/11/26  15:17:54  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.5  1992/07/20  13:24:20  clive
More work on the debugger

Revision 1.4  1992/07/07  09:49:38  clive
Changes when implementing call point annotation

Revision 1.3  1992/06/30  09:35:35  clive
Minor changes

Revision 1.2  1992/06/30  09:35:35  clive
I forget the Integer structure argument

Revision 1.1  1992/06/29  11:08:49  clive
Initial revision

 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../typechecker/__types";
require "../utils/__crash";
require "../basics/__identprint";
require "__runtime_env";
require "_debugger_types";

structure Debugger_Types_ =
  Debugger_Types(
    structure Types = Types_
    structure Crash = Crash_
    structure IdentPrint = IdentPrint_
    structure RuntimeEnv = RuntimeEnv_
  )

