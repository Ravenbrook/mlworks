(* patterns.sml the signature *)
(*
$Log: patterns.sml,v $
Revision 1.11  1994/09/14 12:15:52  matthew
Abstraction of debug information

Revision 1.10  1994/02/17  16:25:31  nosa
return variable pattern types for Modules Debugger.

Revision 1.9  1993/03/10  15:22:53  matthew
Options changes

Revision 1.8  1993/03/09  13:03:10  matthew
Options & Info changes
Absyn changes

Revision 1.7  1993/02/08  15:05:54  matthew
Changes for BASISTYPES signature

Revision 1.6  1993/02/01  16:17:30  matthew
Added sharing

Revision 1.5  1992/11/04  17:26:37  matthew
Changed Error structure to Info

Revision 1.4  1992/08/12  10:29:20  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:52:55  jont
Added copyright message

Revision 1.2  91/11/19  12:19:04  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:59  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:44:33  colin
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

(* This module provides a function check_pat which typechecks patterns
in the abstract syntax, as per rules 33-46 in the Definition. The
implementation is clearly laid out according to the rules. *)

require "../typechecker/basistypes";
require "../basics/absyn";
require "../main/info";
require "../main/options";

signature PATTERNS =
  sig
    structure BasisTypes : BASISTYPES
    structure Absyn : ABSYN
    structure Info : INFO
    structure Options : OPTIONS

    sharing Absyn.Ident.Location = Info.Location
    sharing Absyn.Ident = BasisTypes.Datatypes.Ident
    sharing type Absyn.Type = BasisTypes.Datatypes.Type
    sharing type Absyn.Structure = BasisTypes.Datatypes.Structure

    val pat_context :
      Absyn.Pat -> BasisTypes.Datatypes.Valenv

    val check_pat :
      (Info.options * Options.options) ->
      Absyn.Pat * BasisTypes.Context ->
      (BasisTypes.Datatypes.Valenv * BasisTypes.Datatypes.Type * (BasisTypes.Datatypes.Type ref * Absyn.RuntimeInfo ref) list)
  end
  
