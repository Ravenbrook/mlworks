(* type_exp.sml the signature *)
(*
$Log: type_exp.sml,v $
Revision 1.8  1993/03/09 12:59:27  matthew
Options & Info changes
Absyn changes

Revision 1.7  1993/02/08  18:28:44  matthew
Changes for BASISTYPES signature

Revision 1.6  1993/02/01  14:20:30  matthew
Added sharing

Revision 1.5  1992/11/04  17:39:52  matthew
Changed Error structure to Info

Revision 1.4  1992/08/11  15:40:45  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:55:35  jont
Added copyright message

Revision 1.2  91/11/19  12:19:26  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:09  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:46:23  colin
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

require "../typechecker/basistypes";
require "../basics/absyn";
require "../main/info";

(* This module provides a very simple function for checking a type
expression. It encapsulates rules 47,48,49,50 of the Definition, and
is called from core_rules, mod_rules, and patterns. *)


signature TYPE_EXP =
  sig
    structure BasisTypes : BASISTYPES  
    structure Absyn : ABSYN
    structure Info : INFO

    sharing Absyn.Set = BasisTypes.Set
    sharing Absyn.Ident.Location = Info.Location
    sharing Absyn.Ident = BasisTypes.Datatypes.Ident
    sharing type BasisTypes.Datatypes.Structure = Absyn.Structure
    sharing type BasisTypes.Datatypes.Type = Absyn.Type

    val check_type :
      Info.options ->
      Absyn.Ty * BasisTypes.Context ->
      BasisTypes.Datatypes.Type

  end;
  




