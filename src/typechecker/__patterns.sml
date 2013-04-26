(* __patterns.sml the structure *)
(*
$Log: __patterns.sml,v $
Revision 1.13  1995/02/02 13:48:00  matthew
Removing debug stuff

Revision 1.12  1995/01/04  12:24:35  matthew
Renaming debugger_env to runtime_env

Revision 1.11  1994/09/14  11:35:14  matthew
Added RuntimeEnv

Revision 1.10  1993/12/03  12:58:22  nosa
Structure Crash.

Revision 1.9  1993/08/09  16:06:46  jont
Added context printing for unification errors

Revision 1.8  1993/02/08  18:41:28  matthew
Changes for BASISTYPES signature

Revision 1.7  1993/02/04  16:46:18  matthew
Removed Basis parameter

Revision 1.6  1992/09/02  18:18:01  richard
Installed central error reporting mechanism.

Revision 1.5  1992/08/12  10:42:46  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.4  1992/01/27  18:05:37  jont
Added ty_debug parameter

Revision 1.3  1992/01/25  01:33:30  jont
Updated to calculate the valenv for METATYNAMES in VALpat and APPpat

Revision 1.2  1991/11/21  16:40:10  jont
Added copyright message

Revision 1.1  91/06/07  11:17:50  colin
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

require "../utils/__print";
require "../utils/__lists";
require "../utils/__crash";
require "../basics/__identprint";
require "../typechecker/__tyenv";
require "../typechecker/__environment";
require "../typechecker/__type_exp";
require "../typechecker/__control_unify";
require "../typechecker/__types";
require "../typechecker/__scheme";
require "../typechecker/__valenv";
require "../typechecker/__completion";
require "../typechecker/__basis";
require "../typechecker/__context_print";
require "../debugger/__runtime_env";

require "../typechecker/_patterns";

structure Patterns_ = Patterns(
  structure Print         = Print_
  structure Lists         = Lists_
  structure Crash         = Crash_
  structure IdentPrint    = IdentPrint_
  structure Tyenv         = Tyenv_
  structure Env           = Environment_
  structure Type_exp      = Type_exp_
  structure Control_Unify = Control_Unify_
  structure Types         = Types_
  structure Scheme        = Scheme_
  structure Valenv        = Valenv_
  structure Basis         = Basis_
  structure Completion    = Completion_
  structure Context_Print = Context_Print_
  structure RuntimeEnv    = RuntimeEnv_
    );
