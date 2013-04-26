(* _type_exp.sml the functor *)
(*
$Log: _type_exp.sml,v $
Revision 1.26  1999/02/02 16:01:49  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.25  1996/11/06  11:33:37  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.24  1996/10/28  17:38:53  io
 * moving String from toplevel
 *
 * Revision 1.23  1996/04/30  15:33:36  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.22  1996/04/29  14:03:11  matthew
 * Removing MLWorks.Integer.
 *
 * Revision 1.21  1995/02/07  16:08:50  matthew
 * Changes to lookup exceptions
 *
Revision 1.20  1993/12/16  11:39:54  matthew
Renamed Basis.level to Basis.context_level

Revision 1.19  1993/12/08  11:08:04  nickh
Suppress error message with unknown location; bugfix 355.

Revision 1.18  1993/08/16  10:54:13  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.17  1993/05/18  18:15:41  jont
Removed integer parameter

Revision 1.16  1993/03/09  13:05:13  matthew
Options & Info changes
Absyn changes

Revision 1.14  1993/02/22  12:52:54  matthew
Changed arity error message
Removed debug statements.

Revision 1.13  1993/02/08  18:27:45  matthew
Changes for BASISTYPES signature

Revision 1.12  1992/12/04  12:10:20  matthew
Error message revision

Revision 1.11  1992/12/03  10:18:06  daveb
Added Integer parameter to functor.

Revision 1.10  1992/12/02  16:46:13  jont
Error message improvements

Revision 1.9  1992/11/04  17:42:34  matthew
Changed Error structure to Info

Revision 1.8  1992/09/08  17:24:42  matthew
Added locations to error messages.

Revision 1.7  1992/09/04  14:20:29  richard
Installed central error reporting mechanism.

Revision 1.6  1992/08/11  18:52:17  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/08/05  12:26:32  jont
Anel's changes to use NewMap instead of Map

Revision 1.4  1992/04/14  15:13:12  jont
Some improvements from Anel

Revision 1.3  1992/01/27  20:16:03  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.2  1991/11/21  16:48:11  jont
Added copyright message

Revision 1.1  91/06/07  11:39:05  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basis/__int";

require "../basics/absyn";
require "../main/info";
require "../basics/identprint";
require "../typechecker/types";
require "../typechecker/basis";

require "../typechecker/type_exp";

functor Type_exp(
  structure IdentPrint: IDENTPRINT
  structure Absyn     : ABSYN
  structure Types     : TYPES
  structure Basis     : BASIS
  structure Info      : INFO
 
  sharing Types.Datatypes = Basis.BasisTypes.Datatypes
  sharing Absyn.Set = Basis.BasisTypes.Set
  sharing Absyn.Ident.Location = Info.Location
  sharing IdentPrint.Ident = Types.Datatypes.Ident = Absyn.Ident

  sharing type Absyn.Type = Types.Datatypes.Type
  sharing type Absyn.Structure = Types.Datatypes.Structure
) : TYPE_EXP =
  
  struct
    structure Datatypes = Types.Datatypes
    structure Absyn     = Absyn
    structure BasisTypes = Basis.BasisTypes
    structure Info = Info

    open Datatypes

    fun fresh_tyvar(acontext, eq, imp) =
      METATYVAR (ref (Basis.context_level acontext,NULLTYPE,NO_INSTANCE), eq, imp)


    fun check_type options args = 
      let 
        fun report_error args = Info.error options args
        

    (* ****** Type Expressions ****** *)
    
    (* rules 47, 48, 49, 50 *)

    (****
     If there is no type for the tyvar a new one is created with level ~1 
     thus it will never be closed over;  therefore escaping at top level.
     ****)

    fun check_type (Absyn.TYVARty tyvar,context) =
      (Basis.lookup_tyvar (tyvar,context)
       handle Basis.LookupTyvar => 
         TYVAR (ref (~1,NULLTYPE,NO_INSTANCE),tyvar))
      
      | check_type (Absyn.RECORDty (alab_ty_list),acontext) = 
        let 
          fun tyrowlist ([],context) = Types.empty_rectype
            | tyrowlist ((lab,ty)::rest,context) =
              Types.add_to_rectype (lab,check_type (ty,context),
                                    tyrowlist (rest,context))
        in
          tyrowlist (alab_ty_list,acontext) 
        end

      | check_type (Absyn.APPty (tylist,ltycon,location),acontext) =
        (let 
          val TYSTR (atyfun,x) =
            Basis.lookup_longtycon (ltycon,acontext)
          fun make_type_list [] = []
            | make_type_list (h::t) =
              check_type (h,acontext)::(make_type_list t)
        in
          if Types.arity (atyfun) = length (tylist) then
            Types.apply (atyfun,make_type_list tylist)
          else
            (report_error
             (Info.RECOVERABLE, location, 
              concat ["Wrong number of arguments to type constructor ",
                       IdentPrint.printLongTyCon ltycon,
                       ": ",
                       Int.toString(Types.arity atyfun),
                       " required, ",
                       Int.toString(length tylist),
                       " supplied"]);
             fresh_tyvar (acontext, false, false))
        end
        handle Basis.LookupTyCon tycon =>
	  (* if we hit an unbound tycon, we should usually report it.
	   * The exception is in the withtype derived forms, when
	   * we've substituted into the body of a datatype. We should
	   * not report tycons in the substitution, because they don't
	   * correspond to user code. The error will be reported later
	   * when we check the typedec.	 We mark these cases (when
	   * parsing the derived form) with an UNKNOWN location. *)
          (case location of
             Info.Location.UNKNOWN => ()
           | l => 
               report_error
               (Info.RECOVERABLE, l,
                IdentPrint.unbound_longtycon_message (tycon,ltycon));
           fresh_tyvar (acontext, false, false))
             | Basis.LookupStrId strid =>
                 (case location of
                    Info.Location.UNKNOWN => ()
                  | l => 
                      report_error
                      (Info.RECOVERABLE, l,
                       IdentPrint.tycon_unbound_strid_message (strid,ltycon));
                      fresh_tyvar (acontext, false, false)))
                 

      | check_type (Absyn.FNty (ty,ty'),acontext) =
        FUNTYPE (check_type (ty,acontext),check_type (ty',acontext))
      in
        check_type args
      end
  end;
