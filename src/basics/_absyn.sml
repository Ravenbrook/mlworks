(* _absyn.sml the functor *)
(*
$Log: _absyn.sml,v $
Revision 1.51  1997/05/01 12:24:09  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.50  1996/10/28  17:26:08  andreww
 * [Bug #1708]
 * changing syntax of datatype replication.
 *
 * Revision 1.49  1996/10/04  17:57:52  andreww
 * [Bug #1592]
 * threading location argument to local declaration expression
 * syntax.
 * /
 *
 * Revision 1.48  1996/10/04  10:55:51  matthew
 * [Bug #1622]
 * Adding some locations
 *
 * Revision 1.47  1996/09/18  11:54:17  andreww
 * [Bug #1577]
 * Adding production for datatype replication.
 *
 * Revision 1.46  1996/03/29  12:09:37  matthew
 * Adding WHEREsigxp properly
 *
 * Revision 1.45  1996/03/26  15:06:51  matthew
 * Adding explicit tyvars field to VALdec
 *
 * Revision 1.44  1996/03/18  16:50:04  matthew
 * New language definition
 *
 * Revision 1.43  1996/01/16  12:21:40  daveb
 * Added location information to SIGNATUREtopdec.
 *
Revision 1.42  1995/12/27  12:37:35  jont
Removing Option in favour of MLWorks.Option

Revision 1.41  1995/12/05  12:21:04  jont
Add functions to check strdecs and strexps for the location of
free imperative type variable errors

Revision 1.40  1995/11/22  09:26:58  daveb
Changed REQUIREtopdec to take a string instead of a module_id.

Revision 1.39  1995/09/05  14:08:05  daveb
Added types for different lengths of words, ints and reals.

Revision 1.38  1995/08/31  13:13:32  jont
Add location info to wild pats for use in redundancy warnings

Revision 1.37  1995/01/17  13:34:02  matthew
Renaming debugger_env to runtime_env

Revision 1.36  1994/09/14  11:41:07  matthew
Abstraction of debug information

Revision 1.35  1994/02/28  05:52:34  nosa
Type function, debugger structure, and structure recording for Modules Debugger.

Revision 1.34  1993/12/03  16:36:45  nickh
Added location information to COERCEexp.

Revision 1.33  1993/11/25  09:31:43  matthew
Added fixity annotations to APPexps and APPpats

Revision 1.32  1993/09/03  10:19:13  nosa
Runtime-instance in VALpats and LAYEREDpats and Compilation-instance
in VALexps for polymorphic debugger.

Revision 1.31  1993/08/12  14:56:00  daveb
Require declarations now take moduleids instead of strings.

Revision 1.30  1993/08/06  13:14:07  matthew
Added location information to matches

Revision 1.29  1993/07/09  11:52:27  nosa
structure Option.

Revision 1.28  1993/07/02  15:59:56  daveb
Added field to some topdecs to indicate when signature matching is required
to match an exception against a value specification.

Revision 1.27  1993/05/20  12:14:39  matthew
Added abstractions

Revision 1.26  1993/05/18  18:38:35  jont
Removed integer parameter

Revision 1.25  1993/04/06  11:52:27  matthew
Added MLVALUEexp.  This is just used internally and has no concrete syntax currently

Revision 1.24  1993/03/09  12:54:49  matthew
Removed Datatypes substructure and replaced with Ident substructure
and Type and Structure types.

Revision 1.23  1993/02/16  17:44:26  matthew
Added dynamic and coerce abstract syntax

Revision 1.22  1993/02/08  15:37:49  matthew
Removed nameset structure and ref nameset from FunBind (which wasn't used)

Revision 1.21  1993/02/03  17:48:15  matthew
Rationalised functor parameter

Revision 1.20  1992/12/17  17:33:09  matthew
> Changed int and real scons to carry a location around

Revision 1.19  1992/12/08  14:48:38  jont
Removed a number of duplicated signatures and structures

Revision 1.18  1992/10/14  12:06:37  richard
Added location information to the `require' topdec.

Revision 1.17  1992/10/09  13:38:49  clive
Tynames now have a slot recording their definition point

Revision 1.16  1992/09/08  15:32:19  matthew
Added locations to some datatypes.

Revision 1.15  1992/09/04  08:26:07  richard
Installed central error reporting mechanism.

Revision 1.14  1992/09/02  14:09:23  richard
Insalled central error reporting mechanism.

Revision 1.13  1992/08/12  12:18:18  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.12  1992/08/04  12:20:24  jont
Tidied up functor argument to reducing number of parameters and sharing

Revision 1.11  1992/06/29  10:54:38  clive
Added a slot to appexp for debugging type information for function call type

Revision 1.10  1992/06/15  09:31:03  clive
Added debug info to handlers

Revision 1.9  1992/06/11  08:25:29  clive
Added some maarks for typechecker error messages

Revision 1.8  1992/05/19  17:37:39  clive
Added marks for better error reporting

Revision 1.7  1992/04/13  15:50:28  clive
First version of the profiler

Revision 1.6  1991/11/22  17:11:14  jont
Removed opens

Revision 1.5  91/11/21  15:56:00  jont
Added copyright message

Revision 1.4  91/06/27  13:40:50  colin
added Interface annotation for signature expressions

Revision 1.3  91/06/27  09:04:14  nickh
Added REQUIREtopdec of string.

Revision 1.2  91/06/19  18:38:00  colin
Added a type ref to HANDLEexp for ten15 code generator

Revision 1.1  91/06/07  10:54:42  colin
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

require "../utils/set";
require "../utils/lists";
require "../typechecker/types";
require "../debugger/runtime_env";
require "absyn";

functor Absyn (
  structure Types : TYPES
  structure Set : SET
  structure Lists : LISTS
  structure RuntimeEnv : RUNTIMEENV

  sharing type RuntimeEnv.Type = Types.Datatypes.Type

) : ABSYN =
  struct
    structure Datatypes = Types.Datatypes
    structure Set = Set
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure Location = Ident.Location

    type Type = Datatypes.Type
    type Tyfun = Datatypes.Tyfun
    type Instance = Datatypes.Instance
    type DebuggerStr = Datatypes.DebuggerStr
    type Structure = Datatypes.Structure
    type RuntimeInfo = RuntimeEnv.RuntimeInfo
    type InstanceInfo = Datatypes.InstanceInfo
    
    type options = Types.Options.options
  val print_type = Types.print_type

  val nullType = Datatypes.NULLTYPE
  val nullTyfun = Datatypes.TYFUN(nullType,0)
  val nullDebuggerStr = Datatypes.EMPTY_DSTR
  val nullRuntimeInfo = RuntimeEnv.RUNTIMEINFO (NONE,nil)
  val nullInstanceInfo = Datatypes.ZERO

  datatype Exp =
    SCONexp of Ident.SCon * Type ref | 
    VALexp of Ident.LongValId * Type ref * Ident.Location.T
               * (InstanceInfo * Instance ref option) ref |
    RECORDexp of (Ident.Lab * Exp) list|
    LOCALexp of Dec * Exp * Location.T |
    APPexp of Exp * Exp * Location.T * Datatypes.Type ref * bool |
    TYPEDexp of Exp * Ty * Location.T |
    HANDLEexp of Exp * Datatypes.Type ref * (Pat * Exp * Ident.Location.T) list * Location.T * string |
    RAISEexp of Exp * Location.T  |
    FNexp of (Pat * Exp * Ident.Location.T) list * Type ref * string * Ident.Location.T |
    DYNAMICexp of (Exp * Ident.TyVar Set.Set * (Type * int * Ident.TyVar Set.Set) ref) |
    COERCEexp of (Exp * Ty * Type ref * Ident.Location.T) |
    MLVALUEexp of MLWorks.Internal.Value.T



  and Dec = 
	  (* the two lists in VALdec list the bindings before and after
	   the first occurence of rec. tyvarset is used to hold
	   information about tyvars scoped at this particular value
	   declaration (see 4.6 in The Definition *)

     VALdec of (Pat * Exp * Location.T) list *  (Pat * Exp * Location.T) list *
     Ident.TyVar Set.Set * Ident.TyVar list |
     TYPEdec of (Ident.TyVar list * Ident.TyCon * Ty * Tyfun ref option) list |
     DATATYPEdec of Location.T *
                    (Ident.TyVar list * Ident.TyCon *
		     Datatypes.Type ref * Tyfun ref option * 
		     ((Ident.ValId * Datatypes.Type ref) *
		      Ty option) list) list |
     DATATYPErepl of Ident.Location.T *
                     (Ident.TyCon * Ident.LongTyCon) *
                      Datatypes.Valenv option ref|
     ABSTYPEdec of Location.T *
                   (Ident.TyVar list * Ident.TyCon *
		    Datatypes.Type ref * Tyfun ref option * 
		    ((Ident.ValId * Datatypes.Type ref) *
		     Ty option) list) list * Dec |
     EXCEPTIONdec of ExBind list|
     LOCALdec of Dec * Dec |
     OPENdec of Ident.LongStrId list * Ident.Location.T |
     SEQUENCEdec of Dec list

  and ExBind = 
    NEWexbind of ((Ident.ValId * Datatypes.Type ref) * Ty option * Location.T * string) |
    OLDexbind of ((Ident.ValId * Datatypes.Type ref) *
		  Ident.LongValId * Location.T * string)

  and Pat =
    WILDpat of Ident.Location.T |
    SCONpat of Ident.SCon * Type ref |
    VALpat of (Ident.LongValId * (Datatypes.Type ref * RuntimeInfo ref))
    * Ident.Location.T |
    RECORDpat of (Ident.Lab * Pat) list * bool * Datatypes.Type ref |
    APPpat of (Ident.LongValId * Datatypes.Type ref) * Pat * Location.T * bool |
    TYPEDpat of Pat * Ty  * Location.T |
    LAYEREDpat of (Ident.ValId * (Datatypes.Type ref * RuntimeInfo ref)) * Pat

  and Ty =
    TYVARty of Ident.TyVar |
    RECORDty of (Ident.Lab * Ty) list |
    APPty of Ty list * Ident.LongTyCon * Location.T |
    FNty of Ty * Ty

  (* The following datatypes are for the modules syntax classes *)

  datatype StrExp =
    NEWstrexp of StrDec |
    OLDstrexp of Ident.LongStrId * Ident.Location.T * Structure option ref option |
    APPstrexp of Ident.FunId * StrExp * bool ref * Location.T * DebuggerStr ref option |
    CONSTRAINTstrexp of StrExp * SigExp * bool * bool ref * Location.T |
    LOCALstrexp of StrDec * StrExp

  and StrDec =
    DECstrdec of Dec |
    STRUCTUREstrdec of
      (Ident.StrId * (SigExp * bool) option * StrExp * bool ref 
       * Ident.Location.T * DebuggerStr ref option * Structure option ref option) list
      |
    ABSTRACTIONstrdec of
      (Ident.StrId * (SigExp * bool) option * StrExp * bool ref 
       * Ident.Location.T * DebuggerStr ref option * Structure option ref option) list |
    LOCALstrdec of StrDec * StrDec |
    SEQUENCEstrdec of StrDec list

  and SigExp =
    NEWsigexp of Spec * Datatypes.Structure option ref | 
    OLDsigexp of Ident.SigId * Datatypes.Structure option ref * Location.T |
    WHEREsigexp of (SigExp * (Ident.TyVar list * Ident.LongTyCon * Ty * Location.T) list)

  and Spec =
    VALspec of (Ident.ValId * Ty * Ident.TyVar Set.Set) list * Location.T |
    TYPEspec of (Ident.TyVar list * Ident.TyCon) list |
    EQTYPEspec of (Ident.TyVar list * Ident.TyCon) list |
    DATATYPEspec of (Ident.TyVar list * Ident.TyCon *
		     (Ident.ValId * Ty option * Location.T) list) list |
    DATATYPEreplSpec of Ident.Location.T * Ident.TyCon * Ident.LongTyCon * 
                       (Ident.ValId * Type option * Location.T) list option ref |
    EXCEPTIONspec of (Ident.ValId * Ty option * Location.T) list |
    STRUCTUREspec of (Ident.StrId * SigExp) list |
    SHARINGspec of Spec * (SharEq * Location.T) list |
    LOCALspec of Spec * Spec |
    OPENspec of Ident.LongStrId list * Location.T |
    INCLUDEspec of SigExp * Location.T |
    SEQUENCEspec of Spec list

  and SharEq =
    STRUCTUREshareq of Ident.LongStrId list |
    TYPEshareq of Ident.LongTyCon list

  datatype SigBind = SIGBIND of (Ident.SigId * SigExp * Location.T) list
             
  datatype FunBind = 
    FUNBIND of (Ident.FunId * Ident.StrId * SigExp * StrExp * (SigExp * bool) option *
		string * bool ref * Ident.Location.T * DebuggerStr ref option * Structure option ref option) list 

  datatype TopDec =
    STRDECtopdec of StrDec * Location.T |
    SIGNATUREtopdec of SigBind list * Location.T |
    FUNCTORtopdec of FunBind list * Location.T |
    REQUIREtopdec of string * Location.T

  val empty_tyvarset = Set.empty_set

(*
  fun expansivep (VALexp _) = false
    | expansivep (FNexp _) = false
    | expansivep (TYPEDexp (e,_,_)) = expansivep e
    | expansivep _ = true
*)

  fun expansive_op (Ident.LONGVALID (Ident.NOPATH,Ident.CON s)) =
    Symbol.symbol_name s = "ref"
    | expansive_op (Ident.LONGVALID (_,Ident.CON s)) = false
    | expansive_op (Ident.LONGVALID (_,Ident.EXCON s)) = false
    | expansive_op _ = true

  fun expansivep (SCONexp _) = false
    | expansivep (VALexp _) = false
    | expansivep (RECORDexp labexplist) =
      Lists.exists (fn (lab,exp) => expansivep exp) labexplist
    | expansivep (APPexp (VALexp (v,_,_,_),exp2,_,_,_)) = 
      expansive_op v orelse expansivep exp2
    | expansivep (TYPEDexp (e,_,_)) = expansivep e
    | expansivep (HANDLEexp (exp,_,_,_,_)) =
      expansivep exp
    | expansivep (FNexp _) = false
    | expansivep _ = true

  fun has_tyvar (TYVARty _) = true
    | has_tyvar (RECORDty lab_tylist) = 
      let 
	fun collect ([]) = false
	  | collect ((_,ty)::lab_tylist) = 
	    has_tyvar (ty) orelse collect (lab_tylist)
      in
	collect (lab_tylist)
      end
    | has_tyvar (APPty (tylist,_,_)) = 
      let
	fun collect ([]) = false
	  | collect (ty::tylist) = 	has_tyvar (ty) orelse collect (tylist)
      in
	collect (tylist)
      end
    | has_tyvar (FNty (ty,ty')) = has_tyvar (ty) orelse has_tyvar (ty')

  fun check_ty(ty, ty', loc) =
    (* See if ty = ty' or ty occurs in ty' *)
    if Types.type_occurs(ty', ty) then
      SOME loc
    else
      NONE

  fun get_loc_from_pat(WILDpat loc) = SOME loc
    | get_loc_from_pat(SCONpat _) = NONE
    | get_loc_from_pat(VALpat(_, loc)) = SOME loc
    | get_loc_from_pat(RECORDpat(lab_pat_list, _, _)) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, (_, pat)) => get_loc_from_pat pat)
      (NONE, lab_pat_list)
    | get_loc_from_pat(APPpat(_, _, loc, _)) =
      SOME loc
    | get_loc_from_pat(TYPEDpat(_, _, loc)) =
      SOME loc
    | get_loc_from_pat(LAYEREDpat(_, pat)) =
      get_loc_from_pat pat

  fun check_pat_for_free_imp(WILDpat _, _, _) = NONE
    | check_pat_for_free_imp(SCONpat _, _, _) = NONE
    | check_pat_for_free_imp(VALpat((_, (ref ty', _)), loc), ty, _) =
      check_ty(ty', ty, loc)
    | check_pat_for_free_imp(RECORDpat(lab_pat_list, _, _), ty, loc') =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, (_, pat)) => check_pat_for_free_imp(pat, ty, loc'))
      (NONE, lab_pat_list)
    | check_pat_for_free_imp(APPpat(_, pat, _, _), ty, loc) =
      check_pat_for_free_imp(pat, ty, loc)
    | check_pat_for_free_imp(TYPEDpat(pat, _, _), ty, loc) =
      check_pat_for_free_imp(pat, ty, loc)
    | check_pat_for_free_imp(LAYEREDpat((_, (ref ty', _)), pat), ty, loc) =
      if Types.type_occurs(ty, ty') then
	case get_loc_from_pat pat of
	  (* Use this location if no other available *)
	  NONE => SOME loc
	| x => x
      else
	NONE

  fun check_exbind_for_free_imp(NEWexbind((_, ref ty'), _, loc, _), ty) =
    check_ty(ty, ty', loc)
    | check_exbind_for_free_imp(OLDexbind((_, ref ty'), _, loc, _), ty) =
      check_ty(ty, ty', loc)

  fun check_dec_for_free_imp(VALdec(dec_list1, dec_list2,_,_), ty) =
    let
      fun check_pat_exp(loc as SOME _, _) =
	loc
	| check_pat_exp(_, (pat, exp, loc)) =
	  case check_pat_for_free_imp(pat, ty, loc) of
	    NONE =>
	      check_exp_for_free_imp(exp, ty)
	  | x => x
    in
      case Lists.reducel
	check_pat_exp
	(NONE, dec_list1) of
	NONE => Lists.reducel
	  check_pat_exp
	  (NONE, dec_list2)
      | x => x
    end
    | check_dec_for_free_imp(TYPEdec _, _) = NONE
    | check_dec_for_free_imp(DATATYPEdec _, _) = NONE
    | check_dec_for_free_imp(DATATYPErepl _, _) = NONE
    | check_dec_for_free_imp(ABSTYPEdec _, _) = NONE
    | check_dec_for_free_imp(EXCEPTIONdec e_list, ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, e_bind) => check_exbind_for_free_imp(e_bind, ty))
      (NONE, e_list)
    | check_dec_for_free_imp(LOCALdec(dec, dec'), ty) =
      (case check_dec_for_free_imp(dec, ty) of
	 loc as SOME _ => loc
       | _ => check_dec_for_free_imp(dec', ty))
    | check_dec_for_free_imp(OPENdec _, _) = NONE
    | check_dec_for_free_imp(SEQUENCEdec dec_list, ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, dec) =>
	check_dec_for_free_imp(dec, ty))
      (NONE, dec_list)

  and check_exp_for_free_imp(SCONexp _, ty) = NONE
    | check_exp_for_free_imp(VALexp _, ty) = NONE
    | check_exp_for_free_imp(RECORDexp lab_exp_list, ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, (_, exp)) =>
	check_exp_for_free_imp(exp, ty))
      (NONE, lab_exp_list)
    | check_exp_for_free_imp(LOCALexp(dec, exp,_), ty) =
      (case check_dec_for_free_imp(dec, ty) of
	 NONE =>
	   check_exp_for_free_imp(exp, ty)
       | x => x)
    | check_exp_for_free_imp(APPexp(exp1, exp2, _, _, _), ty) =
      (case check_exp_for_free_imp(exp1, ty) of
	 NONE =>
	   check_exp_for_free_imp(exp2, ty)
       | x => x)
    | check_exp_for_free_imp(TYPEDexp(exp, _, _), ty) =
      check_exp_for_free_imp(exp, ty)
    | check_exp_for_free_imp(HANDLEexp(exp, _, pe_list, _, _), ty)=
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, (_, exp, _)) =>
	check_exp_for_free_imp(exp, ty))
      (NONE, pe_list)
    | check_exp_for_free_imp(RAISEexp(exp, _), ty) =
      check_exp_for_free_imp(exp, ty)
    | check_exp_for_free_imp(FNexp(pe_list, _, _, _), ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, (_, exp, _)) =>
	check_exp_for_free_imp(exp, ty))
      (NONE, pe_list)
    | check_exp_for_free_imp(DYNAMICexp(exp, _, _), ty) =
      check_exp_for_free_imp(exp, ty)
    | check_exp_for_free_imp(COERCEexp(exp, _, _, _), ty) =
      check_exp_for_free_imp(exp, ty)
    | check_exp_for_free_imp(MLVALUEexp _, ty) = NONE

  fun check_strexp_for_free_imp(NEWstrexp strdec, ty) =
    check_strdec_for_free_imp(strdec, ty)
    | check_strexp_for_free_imp(OLDstrexp _, ty) =
      NONE
    | check_strexp_for_free_imp(APPstrexp _, ty) =
      NONE
    | check_strexp_for_free_imp(LOCALstrexp(strdec, strexp), ty) =
      (case check_strdec_for_free_imp(strdec, ty) of
         NONE =>
           check_strexp_for_free_imp(strexp, ty)
       | x => x)
    | check_strexp_for_free_imp(CONSTRAINTstrexp (strexp,_,_,_,_),ty) =
      check_strexp_for_free_imp (strexp,ty)

  and check_strdec_for_free_imp(DECstrdec dec, ty) =
    check_dec_for_free_imp(dec, ty)
    | check_strdec_for_free_imp(STRUCTUREstrdec e_list, ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, (_, _, strexp, _, _, _, _)) =>
	check_strexp_for_free_imp(strexp, ty))
      (NONE, e_list)
    | check_strdec_for_free_imp(ABSTRACTIONstrdec abs_list, ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, {3=strexp, ...}) => check_strexp_for_free_imp(strexp, ty))
      (NONE, abs_list)
    | check_strdec_for_free_imp(LOCALstrdec(strdec1, strdec2), ty) =
      (case check_strdec_for_free_imp(strdec1, ty) of
	 NONE => check_strdec_for_free_imp(strdec2, ty)
       | x => x)
    | check_strdec_for_free_imp(SEQUENCEstrdec s_list, ty) =
      Lists.reducel
      (fn (loc as SOME _, _) => loc
    | (_, strdec) => check_strdec_for_free_imp(strdec, ty))
      (NONE, s_list)

end
