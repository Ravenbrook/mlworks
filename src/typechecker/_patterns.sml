(* _patterns.sml the functor *)
(*
$Log: _patterns.sml,v $
Revision 1.44  1996/10/29 13:44:06  io
[Bug #1614]
basifying String

 * Revision 1.43  1996/04/30  15:51:04  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.42  1995/12/27  12:38:53  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.41  1995/09/08  15:43:09  daveb
Added new types for different sizes of ints, words and reals.

Revision 1.40  1995/08/31  13:41:11  jont
Add location info to wild pats

Revision 1.39  1995/06/09  10:16:21  daveb
Removed quotes around reconstructed source in error messagess.

Revision 1.38  1995/05/02  10:59:23  matthew
Removing polyvariable debugging

Revision 1.37  1995/02/13  11:46:28  matthew
Debugger changes

Revision 1.36  1995/02/06  14:57:45  matthew
Removing debug stuff

Revision 1.35  1995/01/04  12:23:48  matthew
Renaming debugger_env to runtime_env

Revision 1.34  1994/09/22  16:06:26  matthew
Abstraction of debug information

Revision 1.33  1994/05/04  16:42:41  daveb
Added location argument to lookup_val.

Revision 1.32  1994/02/22  01:58:23  nosa
Type function spills for Modules Debugger.

Revision 1.31  1994/02/08  12:01:23  nickh
Found a way to generate some 'impossible' type errors.

Revision 1.30  1993/12/16  11:39:23  matthew
Renamed Basis.level to Basis.context_level

Revision 1.29  1993/12/02  17:36:56  nickh
Removed old debugging code, fixup a couple of error messages.

Revision 1.28  1993/11/30  14:48:50  nickh
Marked certain error messages as "impossible".

Revision 1.27  1993/11/25  12:14:58  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.26  1993/11/25  09:36:42  matthew
Added absyn annotations

Revision 1.25  1993/09/17  10:14:58  nosa
Compilation-instance recording in VALpats and LAYEREDpats
for polymorphic debugger.

Revision 1.24  1993/08/09  16:31:40  jont
Added context printing for unification errors

Revision 1.23  1993/03/10  15:25:20  matthew
Options changes

Revision 1.22  1993/03/09  11:43:11  matthew
Options & Info changes

Revision 1.21  1993/03/02  15:46:01  matthew
empty_rec_type to empty_rectype

Revision 1.20  1993/02/22  15:17:12  matthew
Changed Completion interface

Revision 1.19  1993/02/08  18:47:43  matthew
Changes for BASISTYPES signature

Revision 1.18  1993/02/04  16:51:37  matthew
Sharing changes

Revision 1.17  1992/12/22  15:51:42  jont
Anel's last changes

Revision 1.16  1992/12/10  19:00:46  matthew
Neatened up error messages so types align.

Revision 1.15  1992/12/04  13:40:54  matthew
Error message revision

Revision 1.14  1992/12/02  16:49:12  jont
Error message improvements

Revision 1.13  1992/11/26  17:29:36  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.12  1992/11/05  09:52:25  matthew
Changed Error structure to Info

Revision 1.11  1992/09/08  17:22:55  matthew
Added locations to errors.

Revision 1.10  1992/09/04  09:31:09  richard
Installed central error reporting mechanism.

Revision 1.9  1992/08/12  10:38:33  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.8  1992/08/04  12:23:38  jont
Anel's changes to use NewMap instead of Map

Revision 1.7  1992/07/22  12:30:47  jont
Removed references to Lists.foldl and Lists.foldr

Revision 1.6  1992/06/15  10:35:56  clive
Added the printing of the name of the relevant identifier in a couple of error messages

Revision 1.5  1992/04/07  14:53:43  jont
Removed on the fly calculation of valenv for METATYNAMEs. This is
now done properly during signature elaboration in _mod_rules,
and encoded in the .mo files

Revision 1.4  1992/01/27  20:01:36  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.3  1992/01/27  11:03:33  jont
Updated to calculate the valenv for METATYNAMES in VALpat and APPpat

Revision 1.2  1991/11/21  19:04:15  jont
Added copyright message. Fixed a sharing constraint appearing before
the structure it referenced

Revision 1.1  91/06/07  11:36:52  colin
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

require "../utils/print";
require "../utils/lists";
require "../utils/crash";
require "../basics/identprint";
require "../typechecker/basis";
require "../typechecker/types";
require "../typechecker/tyenv";
require "../typechecker/environment";
require "../typechecker/scheme";
require "../typechecker/valenv";
require "../typechecker/type_exp";
require "../typechecker/completion";
require "../typechecker/control_unify";
require "../typechecker/context_print";
require "../debugger/runtime_env";

require "../typechecker/patterns";

functor Patterns(
  structure IdentPrint : IDENTPRINT
  structure Types : TYPES
  structure Basis : BASIS
  structure Tyenv : TYENV
  structure Env : ENVIRONMENT
  structure Scheme : SCHEME
  structure Valenv : VALENV
  structure Type_exp : TYPE_EXP
  structure Completion : COMPLETION
  structure Control_Unify : CONTROL_UNIFY
  structure Context_Print : CONTEXT_PRINT
  structure Print : PRINT
  structure Lists : LISTS
  structure Crash : CRASH
  structure RuntimeEnv : RUNTIMEENV

  sharing Control_Unify.Info = Type_exp.Info
  sharing Control_Unify.BasisTypes = Basis.BasisTypes = Type_exp.BasisTypes
  sharing Types.Datatypes = Scheme.Datatypes = Valenv.Datatypes =
    Completion.Datatypes = Env.Datatypes = Tyenv.Datatypes = Basis.BasisTypes.Datatypes
  sharing Types.Datatypes.Ident = IdentPrint.Ident
  sharing Completion.Options = IdentPrint.Options = Types.Options = Control_Unify.Options
  sharing Context_Print.Absyn = Type_exp.Absyn
  sharing Completion.Options = Context_Print.Options
  sharing type Type_exp.Absyn.RuntimeInfo = RuntimeEnv.RuntimeInfo
  sharing type Types.Datatypes.Type = RuntimeEnv.Type
  sharing type Types.Datatypes.Instance = Type_exp.Absyn.Instance = RuntimeEnv.Instance
    ) : PATTERNS =
  
  struct
    structure Absyn = Type_exp.Absyn
    structure BasisTypes = Basis.BasisTypes
    structure Info = Type_exp.Info
    structure Options = Completion.Options
    structure Datatypes = Types.Datatypes

    open Datatypes

    (***** Generate a fresh type variable *****)

    fun fresh_tyvar acontext =
      METATYVAR (ref (Basis.context_level acontext, NULLTYPE,NO_INSTANCE), false, false)

    (***** Inject a type into a typescheme *****)

    fun in_scheme atype =
      Scheme.make_scheme ([], atype)

    (***** Find the local context in a pattern *****)

    local
      (***** Add together two environments (infix operator) *****)
      
      infix &&

      fun ve1 && ve2 = Valenv.ve_plus_ve (ve1, ve2)

      fun singleVE (valid, ts) =
	Valenv.add_to_ve (valid, ts, empty_valenv)
    in
      fun pat_context (Absyn.WILDpat _) = empty_valenv
	| pat_context (Absyn.SCONpat _) = empty_valenv
	| pat_context (Absyn.VALpat ((Ident.LONGVALID (_, valid), (ref ty,_)),_)) =
	  singleVE (valid, UNBOUND_SCHEME (ty,NONE))
	| pat_context (Absyn.RECORDpat (fields, _, _)) =
	  Lists.reducel
	  (fn (res, (_, pat)) => pat_context pat && res)
	  (empty_valenv, fields)
	| pat_context (Absyn.APPpat ((Ident.LONGVALID (_,valid),ref ty),pat,_,_)) =
	  singleVE (valid, UNBOUND_SCHEME (ty,NONE)) && pat_context pat
	| pat_context (Absyn.TYPEDpat (pat, _,_)) =	pat_context pat
	| pat_context (Absyn.LAYEREDpat ((valid, (ref ty,_)), pat)) =
	  singleVE (valid, UNBOUND_SCHEME (ty,NONE)) && pat_context pat
    end

  (* location information *)

    fun near (opts, pat) =
      Datatypes.Err_String
      (concat ["\nNear: ", Context_Print.pat_to_string opts pat])

    fun check_pat 
      (error_info,options as Options.OPTIONS{print_options,
            compiler_options = Options.COMPILEROPTIONS{generate_moduler,...},...}) args =
      let
        val report_error = Info.error error_info
        fun report_strid_error (location,print_options,strid,lvalid) =
          report_error
          (Info.RECOVERABLE, 
           location,
           IdentPrint.valid_unbound_strid_message (strid,lvalid,print_options))

        val check_type = Type_exp.check_type error_info
        val unify = Control_Unify.unify (error_info,options)

    (***** rule 33 *****)
	
    fun check_pat (Absyn.WILDpat _, acontext) =
	(empty_valenv, fresh_tyvar acontext, [])

      (***** rule 34 *****)
    
      | check_pat (Absyn.SCONpat (scon, type_ref), acontext) =
	let
	  val ty = Types.type_of scon
	in
	  type_ref := ty;
	  (empty_valenv, ty, [])
	end
	   
      (***** rule 35 *****)
      
      | check_pat (Absyn.VALpat ((Ident.LONGVALID (_, aval as (Ident.VAR _)),
				 (stuff as (type_ref,info_ref))),_),
		   acontext) =
	let 
	  val new_ty = fresh_tyvar acontext
          val instance' = ref NO_INSTANCE
          val instance = NONE
	in
	  type_ref := new_ty;
          info_ref := RuntimeEnv.RUNTIMEINFO (SOME instance',nil);
	  (Valenv.add_to_ve (aval, in_scheme (new_ty,instance), empty_valenv),
	   new_ty, [stuff])
	end
	 
      (***** rule 36 *****)

      | check_pat (Absyn.VALpat ((lvalid as Ident.LONGVALID (_,Ident.CON _), (type_ref,info_ref)),
                                 location),
		   acontext) =
	let fun error_return () = 
	  let 
            val alpha = fresh_tyvar acontext
	  in 
            (type_ref := alpha; 
             (empty_valenv, alpha, []))
	  end 
	in
	  let 
	    val atype =
	      #1(Basis.lookup_val (lvalid, acontext, location, generate_moduler))
	  in
	    if Types.cons_typep atype then
	      (type_ref := atype;
	       (empty_valenv, atype, []))
	    else
	      (report_error
	       (Info.RECOVERABLE, location,
		concat ["Value constructor ",
			 IdentPrint.printLongValId print_options lvalid,
			 " used without argument in pattern"]);
	       error_return())
	  end
	handle Basis.LookupValId valid =>
	  (report_error (Info.RECOVERABLE, location,
                         IdentPrint.unbound_longvalid_message (valid,lvalid,"constructor",print_options));
           error_return ())
          | Basis.LookupStrId strid =>
              (report_strid_error (location,print_options,strid,lvalid);
               error_return ())
	end
       
      (***** rule 37 *****)

      | check_pat (Absyn.VALpat ((lvalid as Ident.LONGVALID (_,Ident.EXCON _), (type_ref,_)),location),
		   acontext) =

	let
	  val atype =
	    #1(Basis.lookup_val (lvalid, acontext, location, generate_moduler))
	    handle Basis.LookupValId valid =>
              (report_error
	       (Info.RECOVERABLE, location,
                IdentPrint.unbound_longvalid_message (valid,lvalid,"exception",print_options));
	       Types.exn_type)
                 | Basis.LookupStrId strid =>
                     (report_strid_error (location,print_options,strid,lvalid);
                      Types.exn_type)
	in
	  if Types.type_eq (atype, Types.exn_type, true, true) 
            then
              (type_ref := atype;
               (empty_valenv, atype, []))
	  else
            (report_error
	     (Info.RECOVERABLE, location,
	      concat ["Exception constructor ",
		       IdentPrint.printLongValId print_options lvalid,
		       " used without argument in pattern"]); 
             type_ref := Types.exn_type;
             (empty_valenv, Types.exn_type, []))
	end

      (***** rules 38, 40 and 41 *****)

      | check_pat (Absyn.RECORDpat (apatrowlist, flexp, type_ref), acontext) =

	let 
	  fun check_pat_row ([], acontext) = 
	      (empty_valenv, Types.empty_rectype, [])
	    | check_pat_row ((alab, apat) :: patrowlist, acontext) = 
	      let 
		val (ve1, atype1, pat_ty) = check_pat (apat, acontext)
		val (ve2, atype2, pat_tys) = check_pat_row (patrowlist, acontext)
	      in
		(Valenv.ve_plus_ve (ve1, ve2),
		 Types.add_to_rectype (alab, atype1, atype2),
                 pat_ty@pat_tys)
	      end

	  val (new_ve, arectype, pat_tys) = check_pat_row (apatrowlist, acontext)
	in
	  (new_ve,
	   if flexp then
	     let
	       val metarectype = 
		 METARECTYPE (ref (Basis.context_level acontext,
				   true, arectype, false, false))
	     in
	       type_ref := metarectype;
	       metarectype
	     end
	   else
	     (type_ref := arectype;
	      arectype),
             pat_tys)
	end

      (***** rules 39 and 42 are parsed away *****)
      
      (***** rules 43 and 44 *****)
     
      | check_pat (fun_arg as Absyn.APPpat ((lvalid,type_ref), apat,location,_), acontext) =

	let
	  exception unsplit
	  val (new_ve, atype2, pat_ty2) = check_pat (apat, acontext)
	in
	  let
	    fun split (FUNTYPE (arg, res)) = (arg, res)
	      | split (_) = raise unsplit

	    val (arg, res) =
	      split (#1(Basis.lookup_val (lvalid, acontext, location, generate_moduler)))
	      handle Basis.LookupValId valid =>
                (report_error
                 (Info.RECOVERABLE, location,
                  IdentPrint.unbound_longvalid_message (valid,lvalid,"constructor",print_options));
		 (fresh_tyvar acontext, fresh_tyvar acontext))
          | Basis.LookupStrId strid =>
              (report_strid_error (location,print_options,strid,lvalid);
               (fresh_tyvar acontext, fresh_tyvar acontext))

	    val result_type = 
	      unify
	      {
	       first = arg, second = atype2, result = res,
	       context = acontext,
               error = fn () =>
               (location,
                [Datatypes.Err_String "Constructor applied to argument of wrong type",
		 near (print_options, fun_arg),
		 Datatypes.Err_String "\n  Required argument type: ",
		 Datatypes.Err_Type arg,
		 Datatypes.Err_String "\n  Actual argument type:   ",
		 Datatypes.Err_Type atype2],
                res)
	      }
	  in
	    type_ref := FUNTYPE (arg, result_type);
	    (new_ve, result_type, pat_ty2)
	  end
	  handle unsplit =>
            (report_error
             (Info.RECOVERABLE, location,
	      concat ["Nullary value constructor ",
		       IdentPrint.printLongValId print_options lvalid,
		       " applied to argument in pattern"]);
	     (new_ve, fresh_tyvar acontext, []))
	end
	   
      (***** rule 45 *****)
     
      | check_pat (arg as Absyn.TYPEDpat (apat, aty,location), acontext) =

	let 
	  val (new_ve, atype, pat_type) = check_pat (apat, acontext)
	  val ty_exp_ty = check_type (aty, acontext)
	in
	  (new_ve,
	   (unify
	    {
	     first = atype, second = ty_exp_ty, result = atype,
	     context = acontext,
             error = fn () =>
               (location,
		[Datatypes.Err_String "Types of pattern and constraint do not agree",
		 near (print_options,arg),
		 Datatypes.Err_String "\n  Pattern type:    ",
		 Datatypes.Err_Type atype,
		 Datatypes.Err_String "\n  Constraint type: ",
		 Datatypes.Err_Type ty_exp_ty],
                ty_exp_ty)
            }),
           pat_type)
	end

      (***** rule 46 *****)

      | check_pat (Absyn.LAYEREDpat ((avar, stuff as (type_ref,info_ref)), apat), acontext) =

	let
	  val (new_ve, pat_type, pat_type') = check_pat (apat, acontext)
          val instance' = ref(NO_INSTANCE)
          val instance = NONE
	in
	  type_ref := pat_type;
          info_ref := RuntimeEnv.RUNTIMEINFO (SOME (instance'),nil);
	  (Valenv.add_to_ve (avar, in_scheme (pat_type,instance), new_ve),
	   pat_type,
           pat_type'@[stuff])
	end
      | check_pat _ = Crash.impossible "TYCON':check_pat:patterns"
      in
        check_pat args
      end
  end
