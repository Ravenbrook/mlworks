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


Copyright (c) 1993 Harlequin Ltd.
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

