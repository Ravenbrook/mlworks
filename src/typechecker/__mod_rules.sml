(* __mod_rules the structure *)
(*
$Log: __mod_rules.sml,v $
Revision 1.21  1995/04/05 14:51:52  matthew
Removing timer structure

Revision 1.20  1995/02/07  16:11:19  matthew
Removing debug stuff

Revision 1.19  1993/05/10  16:14:05  matthew
 Added TypeDebugger structure

Revision 1.18  1993/02/08  19:22:48  matthew
Changes for BASISTYPES signature.  Added new structures.

Revision 1.17  1993/01/21  11:38:37  matthew
Rationalised parameter

Revision 1.16  1992/12/08  18:18:49  jont
Removed a number of duplicated signatures and structures

Revision 1.15  1992/11/04  17:59:54  matthew
Changed Error structure to Info

Revision 1.14  1992/09/04  09:04:32  clive
Anel's changes for encapsulating assemblies

Revision 1.13  1992/09/04  09:04:32  richard
Installed central error reporting mechanism.

Revision 1.12  1992/08/12  11:26:13  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.11  1992/08/04  13:31:48  jont
Anel's changes to use NewMap instead of Map

Revision 1.9  1992/06/30  10:30:05  jont
Changed to imperative implementation of namesets with hashing

Revision 1.8  1992/04/22  12:05:50  jont
Added newsigma parameter

Revision 1.7  1992/04/15  12:44:10  jont
Added timer structure to functor parameter

Revision 1.6  1992/01/27  17:56:48  jont
Added ty_debug parameter

Revision 1.5  1992/01/10  20:37:53  jont
Added integer structure for debugging purposes

Revision 1.4  1991/11/20  11:11:31  richard
Added dependency on new Strenv module.

Revision 1.3  91/11/19  19:15:26  jont
Added crash parameter

Revision 1.2  91/06/27  17:02:37  colin
changed to handle Interface annotations in signature expressions

Revision 1.1  91/06/07  11:16:34  colin
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
require "../utils/__print";
require "../utils/__crash";
require "../basics/__identprint";
require "../main/__info";
require "../typechecker/__types";
require "../typechecker/__scheme";
require "../typechecker/__valenv";
require "../typechecker/__tyenv";
require "../typechecker/__strenv";
require "../typechecker/__environment";
require "../typechecker/__strnames";
require "../typechecker/__core_rules";
require "../typechecker/__realise";
require "../typechecker/__sharetypes";
require "../typechecker/__share";
require "../typechecker/__basis";
require "../typechecker/__sigma";
require "../typechecker/__nameset";
require "../typechecker/__type_debugger";
require "../typechecker/_mod_rules";

structure Module_rules_ = Module_rules(
  structure Lists      = Lists_
  structure Print      = Print_
  structure Crash      = Crash_
  structure IdentPrint = IdentPrint_
  structure Types      = Types_
  structure Scheme     = Scheme_
  structure Valenv     = Valenv_
  structure Tyenv      = Tyenv_
  structure Strenv     = Strenv_
  structure Env        = Environment_
  structure Strnames   = Strnames_
  structure Core_rules = Core_rules_
  structure Realise    = Realise_
  structure Sharetypes = Sharetypes_
  structure Share      = Share_
  structure Basis      = Basis_
  structure Sigma      = Sigma_
  structure Nameset    = Nameset_
  structure Info       = Info_
  structure TypeDebugger = TypeDebugger_);
