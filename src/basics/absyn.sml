(* absyn.sml the signature *)
(*
$Log: absyn.sml,v $
Revision 1.51  1997/05/01 12:25:23  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.50  1996/10/28  17:28:04  andreww
 * [Bug #1708]
 * changing syntax of datatype replication.
 *
 * Revision 1.49  1996/10/04  17:56:20  andreww
 * [Bug #1592]
 * threading location argument to local declaration expression
 * syntax.
 * /
 *

 * Revision 1.48  1996/10/04  10:55:22  matthew
 * [Bug #1622]
 * Adding some locations
 *
 * Revision 1.47  1996/09/30  12:37:53  matthew
 * Removing require of module_id
 *
 * Revision 1.46  1996/09/18  11:53:39  andreww
 * [Bug #1577]
 * Adding production for datatype replication.
 *
 * Revision 1.45  1996/03/29  12:09:29  matthew
 * Adding WHEREsigxp properly
 *
 * Revision 1.44  1996/03/26  16:23:48  matthew
 * Adding explicit tyvars field to VALdec
 *
 * Revision 1.43  1996/01/16  12:21:29  daveb
 * Added location information to SIGNATUREtopdec.
 *
Revision 1.42  1995/12/27  10:39:13  jont
Removing Option in favour of MLWorks.Option

Revision 1.41  1995/12/05  12:21:16  jont
Add functions to check strdecs and strexps for the location of
free imperative type variable errors

Revision 1.40  1995/11/22  09:09:04  daveb
Changed REQUIREtopdec to take a string instead of a module_id.

Revision 1.39  1995/09/05  14:13:26  daveb
Added types for different lengths of words, ints and reals.

Revision 1.38  1995/08/31  13:13:07  jont
Add location info to wild pats for use in redundancy warnings

Revision 1.37  1995/01/17  12:51:10  matthew
Rationalizing debugger

Revision 1.36  1994/09/14  11:41:26  matthew
Abstraction of debug information

Revision 1.35  1994/02/28  05:52:22  nosa
Type function, debugger structure, and structure recording for Modules Debugger.

Revision 1.34  1993/12/03  16:36:08  nickh
Added location information to COERCEexp.

Revision 1.33  1993/11/25  09:31:30  matthew
Added fixity annotations to APPexps and APPpats

Revision 1.32  1993/09/03  10:20:01  nosa
Runtime-instance in VALpats and LAYEREDpats and Compilation-instance
in VALexps for polymorphic debugger.

Revision 1.31  1993/08/12  14:55:33  daveb
Require declarations now take moduleids instead of strings.

Revision 1.30  1993/08/06  13:13:28  matthew
Added location information to matches

Revision 1.29  1993/07/09  11:52:53  nosa
structure Option.

Revision 1.28  1993/07/02  16:03:13  daveb
Added field to some topdecs to indicate when signature matching is required
to match an exception against a value specification.

Revision 1.27  1993/05/20  11:59:22  matthew
Added code for abstractions.

Revision 1.26  1993/04/06  11:52:45  matthew
Added MLVALUEexp.  Just used internally for now.

Revision 1.25  1993/03/09  11:17:15  matthew
> Removed Datatypes substructure and replaced with Ident substructure
 and Type and Structure types.

Revision 1.24  1993/02/16  17:44:10  matthew
Added syntax for dynamic and coerce expressions

Revision 1.23  1993/02/08  15:36:41  matthew
Removed nameset structure and ref nameset from FunBind (which wasn't used)

Revision 1.22  1993/01/25  18:28:40  matthew
Changed Interface ref to Str ref in sigexps

Revision 1.21  1992/12/17  17:00:23  matthew
> Changed int and real scons to carry a location around

Revision 1.20  1992/12/08  15:15:30  jont
Removed a number of duplicated signatures and structures

Revision 1.19  1992/10/14  12:06:39  richard
Added location information to the `require' topdec.

Revision 1.18  1992/10/09  13:38:55  clive
Tynames now have a slot recording their definition point

Revision 1.17  1992/09/08  15:14:44  matthew
Added locations to some datatypes.

Revision 1.16  1992/09/04  08:26:08  richard
Installed central error reporting mechanism.

Revision 1.15  1992/08/14  11:00:14  matthew
Really added the function this time.

Revision 1.14  1992/08/04  11:42:57  matthew
Added Source_marks_to_tuple function

Revision 1.13  1992/08/04  11:42:57  davidt
Changed cut down signatures to full versions.

Revision 1.12  1992/06/29  10:54:24  clive
Added a slot to appexp for debugging type information for function call type

Revision 1.11  1992/06/15  09:30:45  clive
Added debug info to handlers

Revision 1.10  1992/06/11  08:24:31  clive
Added some maarks for typechecker error messages

Revision 1.9  1992/05/19  15:15:09  clive
Added marks for better error reporting

Revision 1.8  1992/04/13  15:50:14  clive
First version of the profiler

Revision 1.7  1992/02/04  11:53:10  jont
Removed a couple of irrelevant requires

Revision 1.6  1991/11/22  17:08:42  jont
Removed opens

Revision 1.5  91/11/21  15:57:54  jont
Added copyright message

Revision 1.4  91/06/27  13:39:59  colin
added Interface annotation for signature expressions

Revision 1.3  91/06/27  09:04:02  nickh
Added REQUIREtopdec of string.

Revision 1.2  91/06/19  18:38:00  colin
Added a type ref to HANDLEexp for ten15 code generator

Revision 1.1  91/06/07  10:55:59  colin
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

require "ident";
require "../typechecker/datatypes";

signature ABSYN =
sig

  structure Set : sig type ''a Set val empty_set : ''a Set end
  structure Ident : IDENT
  structure Datatypes : DATATYPES

  type Type 
  type Tyfun 
  type Instance
  type DebuggerStr
  type Structure
  type RuntimeInfo
  type InstanceInfo

  type options             (* this is included for Printing datatype
                              replications only *)
  val print_type: options -> Type -> string

  val nullType : Type
  val nullTyfun : Tyfun
  val nullDebuggerStr : DebuggerStr
  val nullRuntimeInfo : RuntimeInfo
  val nullInstanceInfo : InstanceInfo

  datatype Exp =
    SCONexp of Ident.SCon * Type ref | 
    VALexp of Ident.LongValId * Type ref * Ident.Location.T * (InstanceInfo * Instance ref option) ref |
    RECORDexp of (Ident.Lab * Exp) list|
    LOCALexp of Dec * Exp * Ident.Location.T |
    APPexp of Exp * Exp * Ident.Location.T * Type ref * bool |
    TYPEDexp of Exp * Ty * Ident.Location.T |
    HANDLEexp of Exp * Type ref * (Pat * Exp * Ident.Location.T) list * Ident.Location.T * string |
    RAISEexp of Exp * Ident.Location.T  |
    FNexp of (Pat * Exp * Ident.Location.T) list * Type ref * string * Ident.Location.T |
    DYNAMICexp of (Exp * Ident.TyVar Set.Set * (Type * int * Ident.TyVar Set.Set) ref) |
    COERCEexp of (Exp * Ty * Type ref * Ident.Location.T) |
    MLVALUEexp of MLWorks.Internal.Value.T

  and Dec = 
	  (* the two lists in VALdec list the bindings before and after
	   the first occurence of rec. tyvarset is used to hold
	   information about tyvars scoped at this particular value
	   declaration (see 4.6 in The Definition *)

     VALdec of (Pat * Exp * Ident.Location.T) list *  (Pat * Exp * Ident.Location.T) list *
     Ident.TyVar Set.Set * Ident.TyVar list |
     TYPEdec of (Ident.TyVar list * Ident.TyCon * Ty * Tyfun ref option) list |
     DATATYPEdec of Ident.Location.T *
                    (Ident.TyVar list * Ident.TyCon *
		     Type ref * Tyfun ref option * 
		     ((Ident.ValId * Type ref) *
		      Ty option) list) list |
     DATATYPErepl of Ident.Location.T *
                     (Ident.TyCon * Ident.LongTyCon) *
                      Datatypes.Valenv option ref|
     ABSTYPEdec of Ident.Location.T *
                   (Ident.TyVar list * Ident.TyCon *
		    Type ref * Tyfun ref option * 
		    ((Ident.ValId * Type ref) *
		     Ty option) list) list * Dec |
     EXCEPTIONdec of ExBind list|
     LOCALdec of Dec * Dec |
     OPENdec of Ident.LongStrId list * Ident.Location.T |
     SEQUENCEdec of Dec list

  and ExBind = 
    NEWexbind of ((Ident.ValId * Type ref) * Ty option * Ident.Location.T * string) |
    OLDexbind of ((Ident.ValId * Type ref) *
		  Ident.LongValId * Ident.Location.T * string)

  and Pat =
    WILDpat of Ident.Location.T |
    SCONpat of Ident.SCon * Type ref |
    VALpat of (Ident.LongValId * (Type ref * RuntimeInfo ref))
    * Ident.Location.T |
    RECORDpat of (Ident.Lab * Pat) list * bool * Type ref |
    APPpat of (Ident.LongValId * Type ref) * Pat * Ident.Location.T * bool |
    TYPEDpat of Pat * Ty  * Ident.Location.T |
    LAYEREDpat of (Ident.ValId * (Type ref * RuntimeInfo ref)) * Pat

  and Ty =
    TYVARty of Ident.TyVar |
    RECORDty of (Ident.Lab * Ty) list |
    APPty of Ty list * Ident.LongTyCon * Ident.Location.T |
    FNty of Ty * Ty

  (* The following datatypes are for the modules syntax classes *)
  (* APPstrexp, STRUCTUREstrdec,  ABSTRACTIONstrdec and FUNBIND each have
     a bool ref argument, which is for the type checker to mark signature
     matches that require some extra work in the lambda translator
     (when EXCONs are matched against value specifications). *)

  datatype StrExp =
    NEWstrexp of StrDec |
    OLDstrexp of Ident.LongStrId * Ident.Location.T * Structure option ref option |
    APPstrexp of Ident.FunId * StrExp * bool ref * Ident.Location.T * DebuggerStr ref option |
    CONSTRAINTstrexp of StrExp * SigExp * bool * bool ref * Ident.Location.T |
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
    NEWsigexp of Spec * Structure option ref  | 
    OLDsigexp of Ident.SigId * Structure option ref * Ident.Location.T  |
    WHEREsigexp of (SigExp * (Ident.TyVar list * Ident.LongTyCon * Ty * Ident.Location.T) list)

  and Spec =
    VALspec of (Ident.ValId * Ty * Ident.TyVar Set.Set) list * Ident.Location.T |
    TYPEspec of (Ident.TyVar list * Ident.TyCon) list |
    EQTYPEspec of (Ident.TyVar list * Ident.TyCon) list |
    DATATYPEspec of (Ident.TyVar list * Ident.TyCon *
		     (Ident.ValId * Ty option * Ident.Location.T) list) list |
    DATATYPEreplSpec of Ident.Location.T * Ident.TyCon * Ident.LongTyCon * 
                        (Ident.ValId * Type option * Ident.Location.T) list option ref |
    EXCEPTIONspec of (Ident.ValId * Ty option * Ident.Location.T) list |
    STRUCTUREspec of (Ident.StrId * SigExp) list |
    SHARINGspec of Spec * (SharEq * Ident.Location.T) list |
    LOCALspec of Spec * Spec |
    OPENspec of Ident.LongStrId list * Ident.Location.T |
    INCLUDEspec of SigExp * Ident.Location.T |
    SEQUENCEspec of Spec list

  and SharEq =
    STRUCTUREshareq of Ident.LongStrId list |
    TYPEshareq of Ident.LongTyCon list

  datatype SigBind = SIGBIND of (Ident.SigId * SigExp * Ident.Location.T) list
           
  datatype FunBind = 
    FUNBIND of (Ident.FunId * Ident.StrId * SigExp * StrExp * (SigExp * bool) option *
		string * bool ref * Ident.Location.T * DebuggerStr ref option * Structure option ref option) list 

  datatype TopDec =
    STRDECtopdec of StrDec * Ident.Location.T |
    SIGNATUREtopdec of SigBind list * Ident.Location.T |
    FUNCTORtopdec of FunBind list * Ident.Location.T |
    REQUIREtopdec of string * Ident.Location.T

  val empty_tyvarset : Ident.TyVar Set.Set

  val expansivep : Exp -> bool
  val has_tyvar : Ty -> bool

  val check_strexp_for_free_imp :
    StrExp * Type -> Ident.Location.T option
  val check_strdec_for_free_imp :
    StrDec * Type -> Ident.Location.T option
end
