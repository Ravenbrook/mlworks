(* __core_rules.sml the structure *)
(*
$Log: __core_rules.sml,v $
Revision 1.12  1995/02/07 12:15:19  matthew
Removing debug stuff

Revision 1.11  1993/08/09  16:30:41  jont
Added context printing for unification errors

Revision 1.10  1993/06/24  12:05:22  jont
Removed unnecessary __assemblies requirement

Revision 1.9  1993/03/04  11:44:21  matthew
Pat become Patterns

Revision 1.8  1993/02/08  19:01:44  matthew
Changes for BASISTYPES signature

Revision 1.7  1992/08/12  11:04:03  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/08/06  17:24:44  jont
Anel's changes to use NewMap instead of Map

Revision 1.4  1992/01/27  17:39:18  jont
Added ty_debug parameter

Revision 1.3  1992/01/24  13:38:24  jont
Added some parameters

Revision 1.2  1991/11/21  16:38:39  jont
Added copyright message

Revision 1.1  91/06/07  11:12:16  colin
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
require "../typechecker/__types";
require "../typechecker/__scheme";
require "../typechecker/__valenv";
require "../typechecker/__tyenv";
require "../typechecker/__strenv";
require "../typechecker/__environment";
require "../typechecker/__type_exp";
require "../typechecker/__patterns";
require "../typechecker/__control_unify";
require "../typechecker/__completion";
require "../typechecker/__basis";
require "../typechecker/__context_print";
require "../typechecker/_core_rules";
  
structure Core_rules_ = Core_rules(
  structure Print          = Print_
  structure Lists          = Lists_
  structure Crash          = Crash_
  structure IdentPrint     = IdentPrint_
  structure Types          = Types_
  structure Scheme         = Scheme_
  structure Valenv         = Valenv_
  structure Tyenv          = Tyenv_
  structure Strenv         = Strenv_
  structure Env            = Environment_
  structure Type_exp       = Type_exp_
  structure Patterns       = Patterns_
  structure Control_Unify  = Control_Unify_
  structure Completion     = Completion_
  structure Basis          = Basis_
  structure Context_Print = Context_Print_
    );
