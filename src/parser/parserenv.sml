(* parserenv.sml the signature *)
(*
$Log: parserenv.sml,v $
Revision 1.14  1997/05/01 12:52:08  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.13  1996/10/25  13:22:05  andreww
 * [Bug #1686]
 * adding type constructor environment to parser environment (to
 * ensure replicated datatype constructors are seen as constructors)
 *
 * Revision 1.12  1996/03/19  14:26:46  matthew
 * Adding unique_augment_pE
 *
 * Revision 1.11  1996/02/23  16:54:45  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.10  1995/04/12  13:08:06  matthew
 * Adding exception raising long valid lookup
 *
Revision 1.9  1995/02/06  13:00:27  matthew
Improving lookup error messages

Revision 1.8  1994/10/13  09:18:00  matthew
Added option-returning tryLookupValid

Revision 1.7  1993/04/26  16:10:28  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.6  1992/08/26  13:02:32  matthew
Changed error parameter to addValid etc.

Revision 1.5  1992/08/18  17:40:39  davidt
Removed Symbol structure from result and changed everything to use NewMap.

Revision 1.4  1991/12/17  15:54:46  jont
Added addFixity for updating a fixity env for the benefit of the
encapsulator

Revision 1.3  91/11/21  16:37:24  jont
Added copyright message

Revision 1.2  91/11/19  12:21:19  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:35  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  16:18:22  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/map";
require "../basics/ident";

(* The parser must keep an environment, of the fixity and identifier
class of identifiers, in order to (a) parse expressions according to
the proper precedence and associativity of infixed operators, and (b)
enforce the first two syntactic restrictions in section 2.9 of the
Definition. (for instance, the first specifies "No pattern may contain
the same var twice". In order for the parser to check this, it must
distinguish between vars and cons.

This module defines datastructures for these environments, and
functions for manipulating them. The function names, and the sources,
are self-explanatory. *)

signature PARSERENV =
  sig
    structure Map   : MAP
    structure Ident : IDENT

    (* pFE is fixity environment *)
    (* pVE is valid environment  *)
    (* pTE is tycon environment: used to store pVE of datatype decs
           (so that they can be copied when parsing replicated datatypes)*)
    (* pSE is structure environment *)
    (* pE is parser environment *)
    (* pB is parser basis *)

    datatype Fixity = LEFT of int | RIGHT of int | NONFIX

    datatype 
      pFE = FE of (Ident.Symbol.Symbol,Fixity) Map.map
    and
      pVE = VE of (Ident.Symbol.Symbol,Ident.ValId) Map.map
    and 
      pTE = TE of (Ident.TyCon,pVE) Map.map
    and
      pSE = SE of (Ident.StrId,pE) Map.map
    and
      pE = E of (pFE * pVE * pTE * pSE)

    datatype
      pF = F of (Ident.FunId,pE) Map.map
    and
      pG = G of (Ident.SigId,pE * Ident.TyCon list) Map.map
      
    datatype pB = B of (pF * pG * pE)

    val empty_pFE : pFE
    val empty_pVE : pVE
    val empty_pTE : pTE
    val empty_pSE : pSE
    val empty_pE  : pE

    val builtins_pE: pE

    val augment_pE  : pE * pE -> pE
    val unique_augment_pE  : ((Ident.ValId -> unit) * 
                              (Ident.StrId -> unit)) * pE * pE -> pE

    val empty_pF : pF
    val empty_pG : pG
    val empty_pB : pB

    val augment_pF : pF * pF -> pF
    val augment_pG : pG * pG -> pG
    val augment_pB : pB * pB -> pB

    val remove_str : pB * Ident.StrId -> pB

    (* the lookup functions *)

    val lookupFixity : Ident.Symbol.Symbol * pE -> Fixity

    (* lookupFixity never raises Lookup - instead it returns NONFIX *)

    exception Lookup
    exception LookupStrId of Ident.Symbol.Symbol

    (* This one raises LookupStrId if a structure isn't defined *)
    val lookupValId :
      (Ident.Symbol.Symbol list * Ident.Symbol.Symbol) * pE -> 
      Ident.ValId option

    val tryLookupValId :
      (Ident.Symbol.Symbol list * Ident.Symbol.Symbol) * pE ->
      Ident.ValId option

    val lookupTycon :  Ident.LongTyCon  * pE -> pVE option

    val lookupStrId : (Ident.Symbol.Symbol list * Ident.Symbol.Symbol) * pE
                     -> pE

    val lookupFunId : (Ident.FunId * pB) -> pE
    val lookupSigId : (Ident.SigId * pB) -> pE * Ident.TyCon list

    val make_pFE : Ident.Symbol.Symbol list * Fixity -> pFE

    val addFixity : (Ident.Symbol.Symbol * Fixity) * pFE -> pFE

    (*
     * The functions passed as the first argument to the following
     * functions are called if there already exists a mapping for that
     * identifier.
     *)

    val addValId : (Ident.Symbol.Symbol * Ident.ValId * Ident.ValId ->
                    Ident.ValId) * Ident.ValId * pVE -> pVE
    val addTyCon :  (Ident.TyCon * pVE * pVE -> pVE) *
                     Ident.TyCon * pVE * pTE -> pTE
    val addStrId : (Ident.StrId * pE * pE -> pE) * Ident.StrId * pE * pSE 
                    -> pSE
    val addFunId : (Ident.FunId * pE * pE -> pE) * Ident.FunId * pE * pF -> pF
    val addSigId : (Ident.SigId * (pE * Ident.TyCon list) * 
                    (pE * Ident.TyCon list) -> 
                    (pE * Ident.TyCon list)) * Ident.SigId * pE * 
                    Ident.TyCon list * pG -> pG
  end;
