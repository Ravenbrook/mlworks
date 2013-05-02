(* basistypes.sml the signature *)
(* This file contains datatype declarations used for typechecker bases *)
(* Definitions moved here from basis.sml,sigma.sml,phi.sml,sigenv.sml,funenv.sml *)
(* and tyvarenv.sml *)
(*
$Log: basistypes.sml,v $
Revision 1.6  1996/10/04 09:42:07  andreww
[Bug #1592]
Adding nameset to contexts.

 * Revision 1.5  1996/02/23  17:03:46  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.4  1993/12/15  13:15:49  matthew
 * Added level field to Basis.
 *
Revision 1.3  1993/03/17  18:20:21  matthew
Nameset signature changes

Revision 1.2  1993/03/09  12:58:31  matthew
Str to Structure
Options & Info changes

Revision 1.1  1993/02/09  18:32:26  matthew
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

signature BASISTYPES =
  sig
    structure Datatypes : DATATYPES
    structure Set : SET
      
    (****
     Nameset is one of the semantic objects for the Modules.  In this
     structure the type and the operations on it are defined.
     ****)

    type Nameset

    datatype Sigma = SIGMA of (Nameset * Datatypes.Structure)

    datatype Sigenv = SIGENV of (Datatypes.Ident.SigId, Sigma) Datatypes.NewMap.map

    datatype Phi = PHI of (Nameset * (Datatypes.Structure * Sigma))

    datatype Funenv = FUNENV of (Datatypes.Ident.FunId, Phi) Datatypes.NewMap.map

    datatype Tyvarenv = TYVARENV of (Datatypes.Ident.TyVar,Datatypes.Type) Datatypes.NewMap.map

    datatype Context = CONTEXT of (int * 
                                   Datatypes.Ident.TyVar Set.Set * 
                                   Datatypes.Env * Tyvarenv)

    (* Need a level slot here just like in Contexts *)
    datatype Basis = BASIS of (int * Nameset * Funenv * Sigenv * Datatypes.Env)

  end

