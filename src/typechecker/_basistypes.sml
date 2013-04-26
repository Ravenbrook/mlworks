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


Copyright (c) 1993 Harlequin Ltd.
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

