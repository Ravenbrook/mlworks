(* assemblies.sml the signature *)
(*
$Log: assemblies.sml,v $
Revision 1.19  1996/02/23 17:09:30  jont
newmap becomes map, NEWMAP becomes MAP

 * Revision 1.18  1995/02/07  10:36:05  matthew
 * Rationalization
 *
Revision 1.17  1993/06/25  14:08:54  jont
Various improvements, particularly to do with signatures embedded in structures

Revision 1.16  1993/06/23  14:56:04  jont
Removed subAssemblies and subTypeAssembly from the signature,
no longer needed

Revision 1.15  1993/05/28  13:32:04  jont
Cleaned up after assembly changes

Revision 1.14  1993/05/25  18:32:37  jont
Added a comment on compose_assemblies

Revision 1.13  1993/05/25  14:48:32  jont
Added a new function for combining assemblies after a topdec

Revision 1.12  1993/04/19  15:57:51  jont
Added a list to Type_Assembly function for input of assemblies

Revision 1.11  1993/03/09  13:22:30  matthew
Options & Info changes

Revision 1.10  1993/02/08  13:07:32  matthew
Removed open Datatypes

Revision 1.9  1992/10/30  14:10:09  jont
Added IntMap structure for type assemblies

Revision 1.8  1992/10/15  15:56:24  clive
Anel's changes for encapsulating assemblies

Revision 1.7  1992/08/20  17:52:54  clive
Changed hashtables to a single structure implementation

Revision 1.6  1992/08/20  17:52:54  jont
Various improvements to remove garbage, handlers etc.

Revision 1.5  1992/08/13  15:28:37  davidt
Removed redundant arguments to newAssemblies function.

Revision 1.4  1992/07/15  10:36:36  jont
Changed exptyStrAssembly to be a function, in case we want an imperative
implementation ever

Revision 1.3  1991/11/21  16:49:40  jont
Added copyright message

Revision 1.2  91/11/19  12:18:37  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:51  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:42:12  colin
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

(* Assemblies are not mentioned in the Definition except in passing,
yet they become crucial to handling the static semantics of modules
correctly. They are used especially in ensuring the correct behaviour
during shadowing. A separate document describes and justifies the use
of assemblies. This module defines the assmebly types and all
functions used with them. *)

require "../typechecker/basistypes";
require "../utils/intnewmap";

signature ASSEMBLIES = 
  sig
    structure IntMap : INTNEWMAP
    structure Basistypes : BASISTYPES

    type StrOffspring
    type TypeOffspring
    type StrAssembly 
    type TypeAssembly

    exception LookupStrname
    exception LookupStrId 
    exception LookupTyCon
    exception LookupTyfun
    exception Consistency of string

    val empty_strassembly : unit -> StrAssembly
    val empty_tyassembly : TypeAssembly

    val add_to_StrAssembly : 
      Basistypes.Datatypes.Strname * StrOffspring * TypeOffspring * StrAssembly -> 
      StrAssembly
    val add_to_TypeAssembly : Basistypes.Datatypes.Tyfun * Basistypes.Datatypes.Valenv * int * TypeAssembly ->
      TypeAssembly

    val collectStrOffspring : Basistypes.Datatypes.Strenv * StrOffspring -> StrOffspring
    val collectTypeOffspring : Basistypes.Datatypes.Tyenv * TypeOffspring -> TypeOffspring 

    val newAssemblies : Basistypes.Datatypes.Strname * Basistypes.Datatypes.Env -> StrAssembly * TypeAssembly

    val remfromStrAssembly : Basistypes.Datatypes.Strname * StrAssembly -> StrAssembly
    val remfromTypeAssembly : Basistypes.Datatypes.Tyfun * TypeAssembly -> TypeAssembly * int

    val lookupStrname : Basistypes.Datatypes.Strname * StrAssembly -> StrOffspring * TypeOffspring
    val lookupStrId : Basistypes.Datatypes.Ident.StrId * StrOffspring -> Basistypes.Datatypes.Strname * int
    val lookupTyCon : Basistypes.Datatypes.Ident.TyCon * TypeOffspring -> Basistypes.Datatypes.Tyfun * int
    val lookupTyfun : Basistypes.Datatypes.Tyfun * TypeAssembly -> Basistypes.Datatypes.Valenv * int

    val inStrOffspringDomain : Basistypes.Datatypes.Ident.StrId * StrOffspring -> bool
    val getStrIds : StrOffspring -> Basistypes.Datatypes.Ident.StrId list
    val inTypeOffspringDomain : Basistypes.Datatypes.Ident.TyCon * TypeOffspring -> bool
    val getTyCons : TypeOffspring -> Basistypes.Datatypes.Ident.TyCon list

    val findStrOffspring : Basistypes.Datatypes.Strname * StrAssembly  -> StrOffspring
    val findTypeOffspring : Basistypes.Datatypes.Strname * StrAssembly -> TypeOffspring

    val unionStrAssembly : StrAssembly * StrAssembly -> StrAssembly
    val unionTypeAssembly : TypeAssembly * TypeAssembly -> TypeAssembly

    val stringStrOffspring : StrOffspring -> string
    val stringTypeOffspring : TypeOffspring -> string
    val stringStrAssembly : StrAssembly -> string
    val stringTypeAssembly : TypeAssembly -> string

    val updateTypeAssembly : Basistypes.Datatypes.Tyenv * TypeAssembly -> TypeAssembly

    val getStrOffspringMap :
      StrOffspring ->
      (Basistypes.Datatypes.Ident.StrId, Basistypes.Datatypes.Strname * int) Basistypes.Datatypes.NewMap.map

    val getTypeOffspringMap :
      TypeOffspring -> 
      (Basistypes.Datatypes.Ident.TyCon, (Basistypes.Datatypes.Tyfun * int)) Basistypes.Datatypes.NewMap.map

    val compose_assemblies : (StrAssembly * TypeAssembly) * (StrAssembly * TypeAssembly) *
      Basistypes.Basis * Basistypes.Basis ->
      StrAssembly * TypeAssembly
      (* New assembly * old assembly * basis increment * basis *)

    val new_assemblies_from_basis : Basistypes.Basis -> StrAssembly * TypeAssembly

    val new_assemblies_from_basis_inc_sig :
      Basistypes.Basis -> StrAssembly * TypeAssembly
  end
