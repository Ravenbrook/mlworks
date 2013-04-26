(* _basistypes.sml the functor *)
(* This file contains datatype declarations used for typechecker bases *)
(* Definitions moved here from _basis.sml,_sigma.sml,_phi.sml,_sigenv.sml,_funenv.sml *)
(* and _tyvarenv.sml *)
(*
$Log: _basistypes.sml,v $
Revision 1.6  1996/10/04 09:41:53  andreww
[Bug #1592]
Adding nameset to contexts.

 * Revision 1.5  1996/02/23  17:07:11  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.4  1993/12/15  13:16:27  matthew
 * Added level field to Basis.
 *
Revision 1.3  1993/03/17  18:19:37  matthew
added NamesetTypes structure

Revision 1.2  1993/03/09  12:58:43  matthew
Added Info structure

Revision 1.1  1993/02/09  18:32:31  matthew
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

require "../typechecker/datatypes";
require "../utils/set";
require "namesettypes";
require "basistypes";

functor BasisTypes
  ( structure Datatypes : DATATYPES
    structure Set : SET
    structure NamesetTypes : NAMESETTYPES
      ) : BASISTYPES =
  struct
    structure Datatypes = Datatypes

    structure Set = Set

    type Nameset = NamesetTypes.Nameset

    datatype Sigma = SIGMA of (Nameset * Datatypes.Structure)

    datatype Sigenv = SIGENV of (Datatypes.Ident.SigId, Sigma) Datatypes.NewMap.map

    datatype Phi = PHI of (Nameset * (Datatypes.Structure * Sigma))

    datatype Funenv = FUNENV of (Datatypes.Ident.FunId, Phi) Datatypes.NewMap.map

    datatype Tyvarenv = TYVARENV of (Datatypes.Ident.TyVar,Datatypes.Type) Datatypes.NewMap.map

    datatype Context = CONTEXT of (int * 
                                   Datatypes.Ident.TyVar Set.Set * 
                                   Datatypes.Env * Tyvarenv)

    (* Need a level slot here, just like Contexts *)
    datatype Basis = BASIS of (int * Nameset * Funenv * Sigenv * Datatypes.Env)

  end

