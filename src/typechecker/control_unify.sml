(* control_unify.sml the signature *)
(*
$Log: control_unify.sml,v $
Revision 1.10  1993/11/24 15:53:41  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.9  1993/03/10  15:20:41  matthew
Options changes

Revision 1.8  1993/03/04  11:05:34  matthew
Options & Info changes

Revision 1.7  1993/02/08  14:59:29  matthew
Removed open Datatypes
Changes for BASISTYPES signature

Revision 1.6  1992/11/04  17:22:00  matthew
Changed Error structure to Info

Revision 1.5  1992/09/04  09:54:41  richard
Installed central error reporting mechanism.

Revision 1.4  1992/08/11  18:55:34  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:50:48  jont
Added copyright message

Revision 1.2  91/11/19  12:18:45  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:53  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:42:46  colin
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

(* This module provides a front-end for the type-unifier (unify.sml).
It allows one to specify the a result which should be returned if the
unification succeeds, and outputs sophisticated error messages if it
fails. *)

require "basistypes";
require "../main/info";
require "../main/options";

(****
 In this version of control_unify all calls to the type_debugger 
 has been replaced with calls the the error handling structure.
****)

signature CONTROL_UNIFY = 
  sig
    structure BasisTypes : BASISTYPES
    structure Info : INFO
    structure Options : OPTIONS

    val unify :
      (Info.options * Options.options) ->
      {
       first		: BasisTypes.Datatypes.Type,
       second		: BasisTypes.Datatypes.Type,
       result		: BasisTypes.Datatypes.Type,
       context		: BasisTypes.Context,
       error		: unit ->
                           Info.Location.T *
                           BasisTypes.Datatypes.type_error_atom list *
                           BasisTypes.Datatypes.Type
      }
      -> BasisTypes.Datatypes.Type
  end
