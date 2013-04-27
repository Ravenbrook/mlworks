(* _core_rules.sml the functor *)
(*
$Log: _core_rules.sml,v $
Revision 1.91  1998/02/19 16:49:55  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.90  1997/05/01  13:19:43  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.89  1996/10/29  17:47:54  andreww
 * [Bug #1708]
 * changing the syntax of datatype replication.
 *
 * Revision 1.88  1996/10/12  14:05:18  io
 * moving String from toplevel
 *
 * Revision 1.87  1996/10/04  16:27:05  andreww
 * [Bug #1592]
 * hidden type declarations shouldn't escape.
 *
 * Revision 1.86  1996/09/20  16:05:27  andreww
 * [Bug #1588]
 * Adding the "it" identifier to the list of proscribed identifiers
 * when in SML'96 mode.
 *
 * Revision 1.84  1996/08/06  11:28:06  andreww
 * [Bug #1521]
 * propagating changes made to _types.sml
 *
 * Revision 1.82  1996/06/04  15:48:46  jont
 * Add checks to ensure datatypes and exceptions don't rebind true, false, nil, :: or ref
 *
 * Revision 1.81  1996/04/30  15:56:41  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.80  1996/03/25  11:08:25  matthew
 * Extra field in VALdec
 *
 * Revision 1.79  1996/03/19  16:01:41  matthew
 * Added value_polymorphism option
 *
 * Revision 1.78  1996/03/08  12:04:50  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.77  1996/02/22  13:09:12  jont
 * Replacing Map with NewMap
 *
 * Revision 1.76  1995/12/27  11:47:22  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.75  1995/12/18  12:23:35  matthew
Changed interface to Basis.close

Revision 1.74  1995/09/19  15:14:19  matthew
Changing order of typechecking functions and arguments

Revision 1.73  1995/09/08  15:42:56  daveb
Added types for different lengths of words, ints and reals.

Revision 1.72  1995/08/29  14:58:01  jont
Reinstate error messages for unbound strid in open.
Some of these cannot be caught by the parser.

Revision 1.71  1995/06/09  10:16:05  daveb
Removed quotes around reconstructed source in error messagess.

Revision 1.70  1995/05/30  10:45:08  jont
Fix bug 940
Also fix bug provoked by fun f(x, y) = if x = x then x y else y,
which doesn't give source reference

Revision 1.69  1995/03/29  16:04:42  jont
Fix problems with result types from functors which instantaite to functions

Revision 1.67  1995/02/07  12:16:07  matthew
Removing debug stuff

Revision 1.66  1995/01/17  13:44:04  matthew
Rationalizing debugger

Revision 1.65  1994/09/22  16:03:17  matthew
Abstraction of debug information

Revision 1.64  1994/05/11  14:25:29  daveb
Datatypes.META_OVERLOADED has extra arguments, Basis.lookup_val takes an
extra location argument, and Basis.UnresolvedVar has been removed.

Revision 1.63  1994/02/24  12:04:49  nosa
Type function and TYNAME valenv recording for Modules Debugger.

Revision 1.62  1994/02/08  12:10:17  nickh
Found a way to generate some 'impossible' type errors.

Revision 1.61  1993/12/17  12:54:02  matthew
Added name of relevant function in recursive function binding error.

Revision 1.60  1993/12/16  12:29:01  matthew
Renamed Basis.level to Basis.context_level

Revision 1.59  1993/12/03  16:39:31  nickh
Remove old debugging code, fixup a couple of error messages, and
a few inexhaustive bindings.

Revision 1.58  1993/11/30  14:43:49  nickh
Marked certain error messages as "impossible".

Revision 1.57  1993/11/26  17:47:31  matthew
Return augmented environment rather than empty environment after a "cannot
generalize" error.

Revision 1.56  1993/11/25  12:07:31  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.55  1993/11/24  17:39:21  matthew
Added absyn annotations

Revision 1.54  1993/10/04  16:33:41  daveb
Merged in bug fix.

Revision 1.53  1993/09/30  09:22:49  daveb
Fixed broken rcsmerge.

Revision 1.52  1993/09/29  17:01:59  daveb
Merged in bug fix.

Revision 1.51  1993/09/22  14:10:22  nosa
Runtime-instance recording in VALexps for polymorphic debugger.

Revision 1.50.1.3  1993/10/04  16:17:53  daveb
Fixed silly bug in the handling of errors in if, while, etc.

Revision 1.50.1.2  1993/09/29  15:31:08  daveb
Added code to print better error messages for if, case, andalso and orelse.

Revision 1.50.1.1  1993/08/10  14:00:10  jont
Fork for bug fixing

Revision 1.50  1993/08/10  14:00:10  matthew
Added location information to matches

Revision 1.49  1993/08/10  09:53:46  jont
Added context printing for unification errors

Revision 1.48  1993/07/30  15:49:43  matthew
Added some simple and hacky stuff for treating if and while errors specially

Revision 1.47  1993/07/09  13:17:27  nosa
structure Option.

Revision 1.46  1993/06/30  15:52:23  daveb
Removed exception environments.

Revision 1.45  1993/06/04  09:26:09  matthew
Changed equality type as function error message

Revision 1.44  1993/05/28  13:54:04  jont
Cleaned up after assembly changes

Revision 1.43  1993/05/25  17:46:22  jont
Revised way of using assemblies such that structure assemblies are constructed
from the incremental basis rather than on the fly. Fixes a number of
problems with incorrect shadowing

Revision 1.42  1993/05/25  15:14:19  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.41  1993/04/08  08:41:42  matthew
Changed treatment of Dynamic values

Revision 1.40  1993/03/31  13:54:23  daveb
Improved error message for rule 27a (val rec ...).

Revision 1.39  1993/03/10  14:45:46  matthew
Options change

Revision 1.38  1993/03/09  11:51:06  matthew
Options & Info changes

Revision 1.37  1993/03/02  15:55:18  matthew
empty_rec_type to empty_rectype

Revision 1.36  1993/02/23  12:22:42  matthew
Changed "free type variables in value declaration" message

Revision 1.35  1993/02/22  15:58:59  matthew
Changed Completion interface
Added DYNAMICexp and COERCEexp handling

Revision 1.34  1993/02/08  19:04:30  matthew
Changes for BASISTYPES signature

Revision 1.33  1993/01/28  10:19:56  matthew
Streamlined some functions
Changed for COPYSTR's

Revision 1.32  1992/12/10  18:59:48  matthew
Neatened up error messages so types align.

Revision 1.31  1992/12/08  15:41:26  jont
Removed a number of duplicated signatures and structures

Revision 1.30  1992/12/04  15:43:27  matthew
Error message revision

Revision 1.29  1992/12/03  13:22:17  jont
Modified tyenv for efficiency

Revision 1.28  1992/12/02  17:03:09  jont
Error message improvements

Revision 1.27  1992/12/01  18:34:43  matthew
Changed handling of overloaded variable errors.

Revision 1.26  1992/11/26  19:34:00  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.25  1992/11/04  18:06:21  matthew
Changed Error structure to Info

Revision 1.24  1992/10/12  11:30:32  clive
Tynames now have a slot recording their definition point

Revision 1.23  1992/09/08  15:11:02  matthew
Changed some Errors to Crashes.

Revision 1.22  1992/09/04  09:31:11  richard
Installed central error reporting mechanism.

Revision 1.21  1992/08/26  13:12:08  davidt
Made some changes to the NewMap signature.

Revision 1.20  1992/08/12  11:01:10  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.19  1992/08/06  15:24:18  jont
Anel's changes to use NewMap instead of Map

Revision 1.17  1992/06/29  10:57:45  clive
Appexp are annotated with their types

Revision 1.16  1992/06/15  09:45:07  clive
Added debug info to handlers so need to ignore this extra slot

Revision 1.15  1992/06/11  08:31:02  clive
Added some marks for error messages

Revision 1.14  1992/05/19  13:22:02  clive
Adjusted to give better error position reporting now marks have been added

Revision 1.13  1992/04/15  16:31:18  jont
Made a number of efficiency improvements

Revision 1.12  1992/04/15  11:37:58  jont
Made some efficiency improvements

Revision 1.11  1992/04/13  16:05:02  clive
First version of the profiler

Revision 1.10  1992/04/07  14:49:07  jont
Removed on the fly calculation of valenv for METATYNAMEs. This is
now done properly during signature elaboration in _mod_rules,
and encoded in the .mo files

Revision 1.9  1992/04/06  13:33:18  jont
Fixed bug in rule 15 whereby wrong context was supplied to
subsequent matches. Fixed spurious error messages in rule 10 by
supplying a return value of alpha for the failure case

Revision 1.8  1992/01/27  20:00:38  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.7  1992/01/27  11:02:46  jont
Updated to calculate the valenv for METATYNAMES in VALpat and APPpat

Revision 1.6  1992/01/07  16:22:20  colin
Removed last argument to calls to make_tyname

Revision 1.5  1991/11/21  16:44:59  jont
Added copyright message

Revision 1.4  91/11/19  18:12:42  jont
Fixed inexhaustive matches

Revision 1.3  91/06/19  17:38:00  colin
Updated to set extra type ref field in HANDLEexp to type of handler body

Revision 1.2  91/06/17  17:11:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing of circular data structures.

Revision 1.1  91/06/07  11:35:10  colin
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

require "^.basis.__string";
require "../utils/print";
require "../utils/lists";
require "../utils/crash";
require "../basics/identprint";
require "../typechecker/types";
require "../typechecker/scheme";
require "../typechecker/valenv";
require "../typechecker/tyenv";
require "../typechecker/strenv";
require "../typechecker/environment";
require "../typechecker/type_exp";
require "../typechecker/patterns";
require "../typechecker/control_unify";
require "../typechecker/completion";
require "../typechecker/basis";
require "../typechecker/context_print";

require "../typechecker/core_rules";

functor Core_rules(
  structure Print : PRINT
  structure Lists : LISTS
  structure Crash : CRASH
  structure IdentPrint : IDENTPRINT
  structure Types         : TYPES
  structure Scheme        : SCHEME
  structure Valenv        : VALENV
  structure Tyenv         : TYENV
  structure Strenv        : STRENV
  structure Env           : ENVIRONMENT
  structure Type_exp      : TYPE_EXP
  structure Patterns      : PATTERNS
  structure Basis         : BASIS
  structure Control_Unify : CONTROL_UNIFY
  structure Completion : COMPLETION
  structure Context_Print : CONTEXT_PRINT

  sharing Type_exp.BasisTypes = Patterns.BasisTypes = Control_Unify.BasisTypes =
          Basis.BasisTypes
  sharing Completion.Options = IdentPrint.Options = Patterns.Options =
    Scheme.Options = Control_Unify.Options = Context_Print.Options
  sharing Type_exp.Info = Patterns.Info = Control_Unify.Info
  sharing Basis.BasisTypes.Datatypes =
          Env.Datatypes =
	  Tyenv.Datatypes =
	  Types.Datatypes =
	  Completion.Datatypes =
	  Valenv.Datatypes =
	  Scheme.Datatypes =
          Type_exp.Absyn.Datatypes =
	  Strenv.Datatypes
  sharing IdentPrint.Ident.Location = Type_exp.Info.Location
  sharing Type_exp.Absyn = Patterns.Absyn = Context_Print.Absyn
  sharing Basis.BasisTypes.Set = Scheme.Set
  sharing IdentPrint.Ident = Types.Datatypes.Ident
  sharing type Patterns.Info.options = Basis.error_info
  sharing type Basis.print_options = IdentPrint.Options.print_options
  sharing type Basis.options = Scheme.Options.options = Types.Options.options
  sharing type Type_exp.Absyn.InstanceInfo = Basis.BasisTypes.Datatypes.InstanceInfo
  sharing type Type_exp.Absyn.Instance = Basis.BasisTypes.Datatypes.Instance
  sharing type Type_exp.Absyn.Tyfun = Basis.BasisTypes.Datatypes.Tyfun
    
) : CORE_RULES =
  struct
    structure Datatypes = Types.Datatypes
    structure Basistypes = Basis.BasisTypes
    structure Absyn = Patterns.Absyn
    structure Info = Patterns.Info
    structure Options = IdentPrint.Options
    structure Location = Absyn.Ident.Location
    structure Symbol = Absyn.Ident.Symbol
    structure Set = Basistypes.Set

    open Datatypes

    fun eq_scheme (_, s) = Scheme.equalityp s

    fun fresh_tyvar(acontext, eq, imp) =
      METATYVAR (ref (Basis.context_level acontext,NULLTYPE,NO_INSTANCE), eq, imp)

    (*****
    Printing out of debugging information.
    *****)

    fun get_option (_, SOME x) = x
      | get_option (error, _) = Crash.impossible error

    val bad_valids = ["true", "false", "it", "::", "nil", "ref"]

    val bad_valids_table = NewMap.from_list' Symbol.symbol_lt
      (map (fn s => (Symbol.find_symbol s, true)) bad_valids)



    fun check_dec
      (param as (error_info,options as Options.OPTIONS
                 {print_options,
                  compiler_options = Options.COMPILEROPTIONS{generate_moduler,
                                                             ...},
                  compat_options = Options.COMPATOPTIONS {old_definition,...},
                  ...})) args =
      let 
        val use_value_polymorphism = not old_definition
        val report_error  = Info.error error_info


        (* the following function is used to construct error messages
         concerning hidden type names that escape (forbidden in
         SML'96).  See rules 15 and 16, and rule 27 *)
                                 

        fun checkEscapingNames (location, escapingNames, message) =
          let
            fun printNames [] = ""
              | printNames [m,n] = (Types.print_name options m)^" and "^
                (Types.print_name options n)
              | printNames (h::t) = (Types.print_name options h) ^", "^
                (printNames t)
          in
            case (Lists.rev_remove_dups escapingNames)
              of [] => ()
               | [name] => report_error (Info.RECOVERABLE, location,
                                         "The hidden type name "^
                                         (Types.print_name options name)^
                                         " escapes "^message)
               | names => report_error (Info.RECOVERABLE, location,
                                    "The hidden type names "^
                                    (printNames names)^
                                    " escape "^message)
                   
          end
        

	fun check_valid(valid, location) =
	  if old_definition then
	    ()
	  else
	    let
	      val sym = case valid of
		Ident.VAR sy => sy
	      | Ident.CON sy => sy
	      | Ident.EXCON sy => sy
	      | Ident.TYCON' sy => sy
	    in
	      case NewMap.tryApply'(bad_valids_table, sym) of
		NONE => ()
	      | _ => report_error(Info.RECOVERABLE, 
				  location,
				  "Attempt to rebind fixed value constructor: " ^
				  IdentPrint.printValId print_options valid)
	    end

        fun report_strid_error (location,print_options,strid,lvalid) =
          report_error
          (Info.RECOVERABLE, 
           location,
           IdentPrint.valid_unbound_strid_message (strid,lvalid,print_options))

        val unify = Control_Unify.unify param

        val check_pat = Patterns.check_pat param
        val check_type = Type_exp.check_type error_info

        local
          val types : (Datatypes.Type ref * Absyn.RuntimeInfo ref) list ref = ref []
          val tyfuns : Datatypes.Tyfun ref list ref = ref []
          val ves : (Datatypes.Valenv ref * Datatypes.Valenv ref) list ref = ref []
          val tys1 : ((int * Datatypes.Type * Datatypes.Instance) ref
                      * (int * Datatypes.Type * Datatypes.Instance) ref) list ref = ref []
          val tys2 : (Datatypes.Type ref * Datatypes.Type ref) list ref = ref []
          val tys3 : ((int * bool * Type * bool * bool) ref
                      * (int * bool * Type * bool * bool) ref) list ref = ref []
          val tfs : (Datatypes.Tyfun ref * Datatypes.Tyfun ref) list ref = ref []

        in
          fun copy_type(Datatypes.CONSTYPE(tys,tyn)) =
                Datatypes.CONSTYPE(Lists.reducel
                                   (fn (tys,ty)=>copy_type(ty)::tys) (nil, tys),
                                   copy_tyname tyn)
              | copy_type (Datatypes.FUNTYPE(ty1,ty2)) = Datatypes.FUNTYPE(copy_type ty1,copy_type ty2)
              | copy_type (Datatypes.RECTYPE map) =
                    Datatypes.RECTYPE(NewMap.map (fn (_, ty) => copy_type ty) map)
              | copy_type (tyv as Datatypes.METATYVAR(ty1 as ref(n,ty,i),b1,b2)) =
                (Datatypes.METATYVAR(Lists.assoc(ty1,!tys1),b1,b2)
                 handle Lists.Assoc => 
                   (tys1 := (ty1,ty1)::(!tys1);
                    ty1 := (n,copy_type ty,i);
                    tyv))
              | copy_type (ovty as Datatypes.META_OVERLOADED(ty1 as ref(ty),tv,valid,loc)) =
                (Datatypes.META_OVERLOADED(Lists.assoc(ty1,!tys2),tv,valid,loc)
                 handle Lists.Assoc =>
                     (tys2 := (ty1,ty1)::(!tys2);
                      ty1 := copy_type ty;
                      ovty))
              | copy_type (tyv as Datatypes.TYVAR(ty1 as ref(n,ty,i),id)) =
                (Datatypes.TYVAR(Lists.assoc(ty1,!tys1),id)
                 handle Lists.Assoc =>
                   (tys1 := (ty1,ty1)::(!tys1);
                    ty1 := (n,copy_type ty,i);
                    tyv))
              | copy_type (recty as Datatypes.METARECTYPE(ty1 as ref(n,b1,ty,b2,b3))) =
                (Datatypes.METARECTYPE(Lists.assoc(ty1,!tys3))
                 handle Lists.Assoc =>
                   (tys3 := (ty1,ty1)::(!tys3);
                    ty1 := (n,b1,copy_type ty,b2,b3);
                    recty))
              | copy_type ty = ty
            and copy_typescheme (Datatypes.SCHEME(n,(ty,i))) = Datatypes.SCHEME(n,(copy_type ty,i))
              | copy_typescheme (Datatypes.UNBOUND_SCHEME(ty,i)) = Datatypes.UNBOUND_SCHEME(copy_type ty,i)
              | copy_typescheme sch = sch
            and copy_tyname
                  (m as Datatypes.METATYNAME(tf as ref(Datatypes.NULL_TYFUN(_)),name,n,b,
                                             ve' as ref(Datatypes.VE(n',ve)),abs)) =
                     (Datatypes.METATYNAME(tf,name,n,b,Lists.assoc(ve',!ves),abs)
                      handle Lists.Assoc =>
                        let
                          val map =
                           (ves := (ve',ve')::(!ves);
                            NewMap.fold (fn (map,valid,sch) => NewMap.define(map,valid,copy_typescheme sch))
                            (NewMap.empty (Ident.valid_lt, Ident.valid_eq), ve))
                        in
                          (ve' := Datatypes.VE(n',map);
                           Datatypes.METATYNAME(tf,name,n,b,ve',abs))
                        end)
              | copy_tyname (Datatypes.METATYNAME(tf as ref(Datatypes.ETA_TYFUN(tyn)),name,n,b,
                                                          ve' as ref(Datatypes.VE(n',ve)),abs)) =
                     let
                       val (tf1,tf_encountered) =
                         (Lists.assoc(tf,!tfs),true)
                         handle Lists.Assoc =>
                           (tf,false)
                       val (ve'',ve_encountered) =
                         (Lists.assoc(ve',!ves),true)
                         handle Lists.Assoc =>
                           (ve',false)
                       val _ =
                         if tf_encountered then ()
                         else
                           tfs := (tf,tf1)::(!tfs)
                       val _ =
                         if ve_encountered then ()
                         else
                           ves := (ve',ve'')::(!ves)
                       val _ =
                         if tf_encountered then ()
                         else
                           tf1 := Datatypes.ETA_TYFUN(copy_tyname tyn)
                       val _ =
                         if ve_encountered then ()
                         else
                            ve'' := Datatypes.VE(n',
                                                 NewMap.fold (fn (map,valid,sch) =>NewMap.define(map,valid,copy_typescheme sch))
                               (NewMap.empty (Ident.valid_lt, Ident.valid_eq), ve))
                     in
                       Datatypes.METATYNAME(tf1,name,n,b,ve'',abs)
                     end
              | copy_tyname (Datatypes.METATYNAME(tf as ref(Datatypes.TYFUN(ty,n)),name,n',b,
                                                          ve' as ref(Datatypes.VE(n'',ve)),abs)) =
                     let
                       val (tf1,tf_encountered) =
                         (Lists.assoc(tf,!tfs),true)
                         handle Lists.Assoc =>
                           (tf,false)
                       val (ve'',ve_encountered) =
                         (Lists.assoc(ve',!ves),true)
                         handle Lists.Assoc =>
                           (ve',false)
                       val _ =
                         if tf_encountered then ()
                         else
                           tfs := (tf,tf1)::(!tfs)
                       val _ =
                         if ve_encountered then ()
                         else
                           ves := (ve',ve'')::(!ves)
                       val _ =
                         if tf_encountered then ()
                         else
                           tf1 := Datatypes.TYFUN(copy_type ty,n)
                       val _ =
                         if ve_encountered then ()
                         else
                            ve'' := Datatypes.VE(n'',
                                                 NewMap.fold (fn (map,valid,sch) =>NewMap.define(map,valid,copy_typescheme sch))
                               (NewMap.empty (Ident.valid_lt, Ident.valid_eq), ve))
                     in
                       Datatypes.METATYNAME(tf1,name,n',b,ve'',abs)
                     end
              | copy_tyname (Datatypes.TYNAME(id,s,n,b,ve1 as ref(Datatypes.VE(n1,ve2)),s',abs,ve3,lev)) =
                          let
                            val (ve',ve,n') = (ve1,ve2,n1)
                          in
                     (Datatypes.TYNAME(id,s,n,b,ve',s',abs,
                                       Lists.assoc(ve',!ves),lev)
                      handle Lists.Assoc =>
                        let
                          val ve'' = ref(Datatypes.VE(n',NewMap.empty (Ident.valid_lt, Ident.valid_eq)))
                          val map =
                            (ves := (ve',ve'')::(!ves);
                             NewMap.fold (fn (map,valid,sch) =>
                                            NewMap.define(map,valid,copy_typescheme sch))
                             (NewMap.empty (Ident.valid_lt, Ident.valid_eq), ve))
                        in
                          (ve'' := Datatypes.VE(n',map);
                           Datatypes.TYNAME(id,s,n,b,ve',s',abs,ve'',lev))
                       end)
                          end
          local
            val dummy_false = ref(false)
            val dummy_ve = ref(Datatypes.empty_valenv)
            val dummy_tf = ref(Datatypes.TYFUN(Datatypes.NULLTYPE,0))
          in
            fun copy_tyfun tyf =
              (dummy_tf := tyf;
               case copy_tyname(Datatypes.METATYNAME(dummy_tf,"",0,
                                                     dummy_false,dummy_ve,
                                                     dummy_false)) of
                 Datatypes.METATYNAME(ref(tf),_,_,_,_,_) => tf
               | _ =>
                   Crash.impossible "copy_tyfun:generate_moduler:core_rules")
          end
          val copy_tynames =
            if generate_moduler then
              fn _ =>
              (Lists.iterate
               (fn (tyref,_) => tyref := copy_type (!tyref))
                (!types);
               Lists.iterate
               (fn tf => tf := copy_tyfun (!tf)) 
               (!tyfuns))
            else
                fn _ => ()
          val tyfun_types =
            fn tyfun => tyfuns := tyfun::(!tyfuns)
          val pat_types =
            if generate_moduler then
              fn pat_type => types := pat_type @ (!types)
            else
              fn _ => ()
        end

	fun get_data (Absyn.FNexp(_,_,data,_)) = data
	|   get_data _ = ""

	val is_if_exp = String.isPrefix "<if>"
	val is_case_exp = String.isPrefix "<case>"
	val is_andalso_exp = String.isPrefix "<andalso>"
	val is_orelse_exp = String.isPrefix "<orelse>"
	val is_while_exp = String.isPrefix "While statement"


	(* context information for type errors : *)

	fun near exp =
	  concat ["Near: ", 
                          Context_Print.exp_to_string print_options exp]

	fun err_string_exp exp =
	  Datatypes.Err_String (Context_Print.exp_to_string print_options exp)

	fun err_string_pat pat =
	  Datatypes.Err_String (Context_Print.pat_to_string print_options pat)

	fun err_string_dec dec =
	  Datatypes.Err_String (Context_Print.dec_to_string print_options dec)

        (***** rule 1 *****)
        
	(* The third argument is used to pass the argument expression of
	   a function to the code that checks that function, for use in
	   error messages. *)

        fun check_exp (Absyn.SCONexp (scon, type_ref), _, _) =
	  let
	    val ty = Types.type_of scon
	  in
            type_ref := ty;
	    ty
	  end
      
          (***** rule 2,3,4 *****)      
        
  | check_exp (Absyn.VALexp (lvalid,type_ref,location,instance), acontext, _) =
             let
               val (atype,instance') =
		 Basis.lookup_val
		   (lvalid, acontext, location, generate_moduler)
                 handle Basis.LookupValId valid =>
                   (report_error
                    (Info.RECOVERABLE, 
                     location,
                     IdentPrint.unbound_longvalid_message (valid,lvalid,"value",print_options));
                    (fresh_tyvar (acontext, false, false),(ZERO,NONE)))
                      | Basis.LookupStrId strid =>
                          (report_strid_error (location,print_options,strid,lvalid);
                           (fresh_tyvar (acontext, false, false),(ZERO,NONE)))
             in
               (type_ref := atype;
                instance := instance';
                atype)
             end
	
      (***** rule 5 *****)

      | check_exp (Absyn.RECORDexp arecordlist, acontext, _) =
	 let
	   fun check_rec ([], rectype) = rectype
	     | check_rec ((alab, anexp)::t, rectype) =
	       let
		 val exptype = check_exp (anexp, acontext, NONE)
	       in
		 check_rec (t, Types.add_to_rectype (alab, exptype, rectype))
	       end
	 in
	   check_rec (arecordlist, Types.empty_rectype)
	 end
  
      (***** rule 6 *****)
  
      | check_exp(Absyn.LOCALexp (dec, exp, location), acontext, _) =
        let
          val env = check_dec (dec,acontext)
          val new_context = Basis.context_plus_env (acontext,env)
          val atype = check_exp (exp, new_context,
                                 NONE)

            (* the following line checks that no hidden type names
               escape the let binding.  This is disallowed in SML '96 *)

          val _ = if old_definition then ()
                  else checkEscapingNames 
                    (location,Basis.tynamesNotIn (atype,acontext),
                     "the local scope.")
         in
           atype
        end

        
          
	
      (* ****** Expressions ****** *)
	
      (***** rule 10 *****)

      | check_exp (arg_exp as Absyn.APPexp (exp1, exp2,location,argument_type,_), acontext, _) =
	 let 
	   val tyexp1 = check_exp (exp1, acontext, SOME exp2)
	   val tyexp2 = check_exp (exp2, acontext, NONE)

           val _ = argument_type := tyexp2

	   fun check_fun (FUNTYPE (arg,res),atype) = 
	     unify
	     {
	      first = arg, second = atype, result = res,
	      context = acontext,
              error = fn () =>
              (location,
	       let val near_string = Datatypes.Err_String (near arg_exp)
	       in
		 if is_if_exp (get_data exp1) then
		   [Datatypes.Err_String "Argument to 'if' must be of type bool\n",
		    near_string,
                    Datatypes.Err_String "\n  Argument type: ",
                    Datatypes.Err_Type atype]
		 else if is_case_exp (get_data exp1) then
		   [Datatypes.Err_String
		    "Pattern in 'case' has different type from choice expression\n",
		    near_string,
		    Datatypes.Err_String "\n  Required argument type: ",
		    Datatypes.Err_Type atype,
		    Datatypes.Err_String "\n  Actual argument type:   ",
		    Datatypes.Err_Type arg]
		 else if is_andalso_exp (get_data exp1) then
		   [Datatypes.Err_String "First argument of 'andalso' is not boolean\n",
		    near_string,
		    Datatypes.Err_String "\n  Actual argument type: ",
		    Datatypes.Err_Type atype]
		 else if is_orelse_exp (get_data exp1) then
		   [Datatypes.Err_String "First argument of 'orelse' is not boolean\n",
		    near_string,
		    Datatypes.Err_String "\n  Actual argument type: ",
		    Datatypes.Err_Type atype]
		 else
		   [Datatypes.Err_String "Function applied to argument of wrong type\n",
		    near_string,
		    Datatypes.Err_String "\n  Required argument type: ",
		    Datatypes.Err_Type arg,
		    Datatypes.Err_String "\n  Actual argument type:   ",
		    Datatypes.Err_Type atype]
	       end,
	       fresh_tyvar (acontext, false, false))
	      }
	     | check_fun (t as (METATYVAR
				(ref (_,NULLTYPE,_),eq,imp)),atype) =
	       if eq then
                 (report_error
                  (Info.RECOVERABLE, location,
		   concat ["Attempt to apply value of equality type as a function\n",
			    near arg_exp,
			    "\n  Applied type: ",
			    Completion.print_type
                                   (options,
                                    Basis.env_of_context acontext,t)]);
                  fresh_tyvar (acontext, false, false))
	       else
		 let
		   val newmeta = fresh_tyvar(acontext, false, imp)
		 in
		   unify
		   {
		    first = t, second = FUNTYPE (atype, newmeta),
		    result = newmeta, context = acontext,
                    error = fn () =>
                      (location, 
                       [Datatypes.Err_String "Circularity in function application\n",
			Datatypes.Err_String (near arg_exp),
			Datatypes.Err_String "\n  Required argument type: ",
			Datatypes.Err_Type t,
			Datatypes.Err_String "\n  Actual argument type:   ",
			Datatypes.Err_Type (FUNTYPE(atype, newmeta))],
                       fresh_tyvar (acontext, false, false))
                   }
		 end
	     | check_fun (METATYVAR (ref (_,t,_),eq,imp), atype) =
	       check_fun (t, atype)
	     | check_fun(t as CONSTYPE (tylist,METATYNAME{1=ref(NULL_TYFUN _), ...}), _) =
               (report_error
                (Info.RECOVERABLE, location,
		 concat ["Attempt to apply non-function type\n",
			  near arg_exp,
			  "\n  Applied type:",
			  Completion.print_type
                                 (options,
                                  Basis.env_of_context acontext,t)]);
		fresh_tyvar (acontext, false, false))
	     | check_fun(CONSTYPE (tylist,METATYNAME{1=ref tyfun, ...}), atype) =
	       check_fun(Types.apply(tyfun, tylist), atype)
	     | check_fun (t, _) =
               (report_error
                (Info.RECOVERABLE, location,
		 concat ["Attempt to apply non-function type\n",
			  near arg_exp,
			  "\n  Applied type:",
			  Completion.print_type
                                 (options,
                                  Basis.env_of_context acontext,t)]);
		fresh_tyvar (acontext, false, false))
	 in
           check_fun (tyexp1, tyexp2)
	end
      
      (***** rule 11 *****)

      | check_exp (arg_exp as Absyn.TYPEDexp (exp, ty,location), acontext, _) =
	 let 
	   val exp_ty  = check_exp (exp, acontext, NONE)
	   val ty_exp_ty = check_type (ty, acontext)
	 in
	   unify
	   {
	    first = exp_ty, second = ty_exp_ty, result = ty_exp_ty,
	    context = acontext,
            error = fn () =>
              (location,
	       [Datatypes.Err_String "Types of expression and constraint do not agree\n",
		Datatypes.Err_String (near arg_exp),
		Datatypes.Err_String "\n  Expression type: ",
		Datatypes.Err_Type   exp_ty,
		Datatypes.Err_String "\n  Constraint type: ",
		Datatypes.Err_Type   ty_exp_ty],
               ty_exp_ty)
           }
	 end
      
      
      (***** rule 12 *****)
    
    
      | check_exp (arg_exp as Absyn.HANDLEexp (exp,type_ref,match,location,_), acontext, _) =
	 let 
	   val exp_ty = check_exp (exp, acontext, NONE)
	     
	   val _ = type_ref := exp_ty

	   fun check_fun (FUNTYPE (arg, res)) = (arg, res)
	     | check_fun (METATYVAR (ref (_, t,_), eq, imp)) = check_fun t
	     | check_fun (_) =
               (report_error
                (* don't think this can happen *)
                (Info.RECOVERABLE, location, "impossible type error 2: Illegal match in ");
                (fresh_tyvar (acontext, false, false), fresh_tyvar (acontext, false, false)))
	       
	   val (arg, res) =
	     check_fun (check_match (match, acontext, "", NONE, location))
	     
	   val ? = unify
	     {
	      first = arg, second = Types.exn_type, result = Types.exn_type,
	      context = acontext,
              error = fn () =>
                (location,
		 [Datatypes.Err_String "Match in handler should have argument type exn\n",
		  Datatypes.Err_String (near arg_exp),
		  Datatypes.Err_String "\n  Match type: ",
		  Datatypes.Err_Type arg],
                 Types.exn_type)
             }
	 in
	   unify
	   {
	    first = res, second = exp_ty, result = res, context = acontext,
            error = fn () =>
              (location,
	       [Datatypes.Err_String "Handler disagrees with expression\n",
		Datatypes.Err_String (near arg_exp),
		Datatypes.Err_String "\n  Handler type:    ",
		Datatypes.Err_Type res,
		Datatypes.Err_String "\n  Expression type: ",
		Datatypes.Err_Type exp_ty],
               res)
	    }
	 end
       
      (***** rule 13 *****)          
    
      | check_exp (arg_exp as Absyn.RAISEexp (exp,location), acontext, _) =
	 let
	   val exp_ty = check_exp (exp, acontext, NONE)
	 in
	   unify
	   {
	    first = exp_ty, second = Types.exn_type,
	    result = fresh_tyvar(acontext, false, false),
	    context = acontext,
            error = fn () =>
              (location,
               [Datatypes.Err_String "Expression raised is not an exception\n",
		Datatypes.Err_String (near arg_exp),
		Datatypes.Err_String "\n  Expression type: ",
		Datatypes.Err_Type (exp_ty)],
               fresh_tyvar (acontext, false, false))
	    }
	 end
	
      (***** rule 14 *****)
	  
      | check_exp (Absyn.FNexp (amatch,type_ref,data,location), acontext, argexp) =
	 let 
	   val atype = check_match (amatch, acontext, data, argexp, location)
	   val _ = type_ref := atype
	 in
	   atype
	 end

      | check_exp (Absyn.DYNAMICexp (exp,explicit_tyvars,info_ref), acontext, _) =
        let
          val level = Basis.context_level acontext
	 val tyvars_scoped_here = 
           Set.setdiff (explicit_tyvars, Basis.get_tyvarset acontext)
          val atype = check_exp(exp,acontext,NONE)
        in
          (* the closure is done in the lambda translator *)
          info_ref := (atype,level,tyvars_scoped_here);
          Types.dynamic_type
        end
	
      | check_exp (arg_exp as Absyn.COERCEexp (exp,atype,tyref, location),
		   acontext, _) =
        let
          val exp_ty = check_exp(exp,acontext,NONE)
          val coerce_ty = check_type(atype,acontext)
        in
          ignore(
            unify {first = exp_ty,
                   second = Types.dynamic_type,
                   result = Types.dynamic_type,
                   context = acontext,
                   error = fn () =>
                   (location,
                    [Datatypes.Err_String "Expression coerced is not dynamic\n",
  		     Datatypes.Err_String (near arg_exp),
		     Datatypes.Err_String "\n  Expression type: ",
		     Datatypes.Err_Type exp_ty],
                    fresh_tyvar (acontext, false, false))
                   });
          tyref := coerce_ty;
          coerce_ty
        end

      (* MLVALUEexp's are just used internally, so this won't happen yet *)
      | check_exp (Absyn.MLVALUEexp mlvalue, acontext,_) =
        Types.ml_value_type

    (***** rules 15 and 16 *****)
	
    (* data - string from enclosing function (or empty string)
     * argexp - argument of enclosing function (option)
     * lastpat - pattern of previous branch (option)
     *)
    and check_match (matches, acontext, data, argexp, location) =
       check_rules
         (matches, acontext, fresh_tyvar(acontext, false, false),
	  NONE, data, argexp, location)
      
    and check_rules ([], _, atype, _, _, _, _) = atype
      | check_rules ((apat, anexp, matchloc) :: rules,
		     acontext, atype, lastpat, data, argexp, location) =
        let 
          val (new_ve, pat_ty, pat_type) = check_pat (apat, acontext)
          val new_context = Basis.context_plus_ve (acontext, new_ve)
          val exp_ty = check_exp (anexp, new_context, NONE)

            (* the following line checks the extra side condition on the
               matching rule in the revised definition.  It ensures that
               no hidden type names escape. *)


          val _ = if old_definition then () 
                  else checkEscapingNames(location,
                                Basis.valEnvTynamesNotIn (new_ve,acontext),
                                          "in the match.")


          val ftype = FUNTYPE (pat_ty, exp_ty)
	     
          val res =
            unify
            {first = atype, second = ftype, result = atype,
             context = acontext,
             error = fn () =>
             (matchloc,
              if is_if_exp data then
		let val (_, then_ty) = Types.argres atype
		    val argexp' = get_option ("argexp", argexp)
		in
		  [Datatypes.Err_String "Branches of 'if' have incompatible types:\n",
		   Datatypes.Err_String "Near: if ",
		   err_string_exp argexp',
		   Datatypes.Err_String " then ... else ...\n  'then' case: ",
		   Datatypes.Err_Type then_ty,
		   Datatypes.Err_String "\n  'else' case: ",
		   Datatypes.Err_Type exp_ty]
		end
              else if is_case_exp data then
		let val argexp' = get_option("argexp", argexp)
		    val lastpat' = get_option("lastpat", lastpat)
		in
                  [Datatypes.Err_String "Branches of 'case' have incompatible types:\n",
		   Datatypes.Err_String "Near: case ",
		   err_string_exp argexp',
		   Datatypes.Err_String " of ... ",
		   err_string_pat lastpat',
		   Datatypes.Err_String " => ... | ",
		   err_string_pat apat,
		   Datatypes.Err_String " => ...\n  Expected type: ",
		   Datatypes.Err_Type atype,
		   Datatypes.Err_String "\n  Rule type:     ",
		   Datatypes.Err_Type ftype]
		end
	      else if is_andalso_exp data then
		[Datatypes.Err_String "Second argument of 'andalso' is not boolean:\n",
		 Datatypes.Err_String "Near: ... andalso ",
		 err_string_exp anexp,
		 Datatypes.Err_String "\n  Actual argument type: ",
		 Datatypes.Err_Type exp_ty]
	      else if is_orelse_exp data then
		[Datatypes.Err_String "Second argument of 'orelse' is not boolean:\n",
		 Datatypes.Err_String "Near: ... orelse ",
		 err_string_exp anexp,
		 Datatypes.Err_String "\n  Actual argument type: ",
		 Datatypes.Err_Type exp_ty]
	      else
		[Datatypes.Err_String "Type disagreement between match rules\n",
		 Datatypes.Err_String "Near: ",
		 err_string_pat apat,
		 Datatypes.Err_String " => ...\n  Expected type: ",
                 Datatypes.Err_Type atype,
		 Datatypes.Err_String "\n  Rule type:     ",
		 Datatypes.Err_Type ftype],
              atype)}
	 in
           (pat_types pat_type;
            check_rules
            (rules, acontext, res, SOME apat, data, argexp, location))
	 end
       
    (* ****** Declarations ****** *)
  
    (***** rule 17 *****)
    and check_dec (Absyn.VALdec (avalbindlist1,
				 avalbindlist2,
				 inner_unguarded_tyvars,
                                 explicit_tyvars),
		   acontext) =
       let 
         (* Need to do something with the explicit tyvars here *)
	 val tyvars_scoped_here = 
           Set.union (Set.setdiff (inner_unguarded_tyvars,
                                   Basis.get_tyvarset acontext),
                      Set.list_to_set (explicit_tyvars))
	   
	 val new_context = 
           Basis.context_plus_tyvarset (acontext, tyvars_scoped_here)

	 val (expansive_vars, new_VE) =
	   check_valbind (avalbindlist1,
                          avalbindlist2,
                          new_context,
			  empty_valenv,
                          [])

         val location =
           (case (avalbindlist1,avalbindlist2) of
              ((_,_,location)::_,_) => location
            | (_,(_,_,location)::_) => location
            | _ => Crash.impossible "Empty valbind list")

	 val VE' = 	
           Basis.close (error_info,options,location)
                       (Basis.context_level acontext,
                        new_VE,expansive_vars,
                        tyvars_scoped_here,true)
	 val foo = 
           Set.intersection
           (tyvars_scoped_here,
            Set.list_to_set (Valenv.tyvars VE'))
       in
	 if Set.empty_setp (foo)
	   then ()
	 else
           (report_error
            (Info.RECOVERABLE, location,
	     concat ["Explicit type ",
                      (if (Lists.length (Set.set_to_list foo)) = 1
                         then "variable "
                       else "variables "),
                       Set.set_print (foo, IdentPrint.printTyVar),
                       " cannot be generalized in value declaration"]));
          ENV (Strenv.empty_strenv,
                Tyenv.empty_tyenv,
                VE')
       end

      (***** rule 18 *****)

      | check_dec (Absyn.TYPEdec atypbind,acontext) =
	ENV (Strenv.empty_strenv,
             check_typbind (atypbind,acontext),
             empty_valenv)
	   
      (***** rule 18 of SML'96 definition ****)

      | check_dec (Absyn.DATATYPErepl (location,(tycon,longtycon),
                                       associatedValEnv),
                   context)=
        (let
          val tyStr as Datatypes.TYSTR(tyFun,valEnv) 
            = Basis.lookup_longtycon(longtycon,context)
          (* Basis exceptions handled at end of rule *)
            
          val _ = associatedValEnv := SOME valEnv  
          
          (* record the list of constructors associated with this 
             datastructure for future reference (i.e., lambda
             code generation) *)

          val new_te = Tyenv.add_to_te(Tyenv.empty_tyenv,tycon,tyStr)
        in
          ENV(Strenv.empty_strenv,new_te,valEnv)
        end
      handle Basis.LookupTyCon tycon =>
        (report_error 
         (Info.RECOVERABLE, location,
          "The type constructor "^(IdentPrint.printTyCon tycon)
          ^" on the right hand side of the datatype replication\
           \ does not exist.");Env.empty_env)
        
           | Basis.LookupStrId strId =>
               (report_error
                (Info.RECOVERABLE, location,
                 "Structure "^ (IdentPrint.printStrId strId)
                 ^" does not exist.");Env.empty_env))
           
           
      (***** rule 19 *****)

      | check_dec (Absyn.DATATYPEdec (location,datbindlist),
		   context as Basistypes.CONTEXT (level,tyvarset,
                                                  ENV(se,te,ve),_)) =
	 let
           val dummy_tycons = map (fn (tyvars,tycon,_,_,_) => 
                                               (tyvars,tycon)) datbindlist
	   val new_context = Basis.context_for_datbind 
                           (context,Location.to_string location,dummy_tycons)

	   val (new_ve,new_te) = check_datbind (datbindlist,
                                                location,
						new_context,
						(empty_valenv,
                                                 Tyenv.empty_tyenv))

	   fun max_eq_pred (_, TYSTR (atyfun,VE (_,amap))) =
  	     if Types.equalityp atyfun then
	       NewMap.forall eq_scheme amap orelse 
	       Types.make_false atyfun
	     else
	       true

	   fun max_eq (TE amap) =
	     while not (NewMap.forall max_eq_pred amap) do ()
	 in
	   (max_eq (new_te);
	    ENV (Strenv.empty_strenv,new_te,new_ve))
	 end
      
      (***** rule 20 *****)

      | check_dec (Absyn.ABSTYPEdec (location,adatbindlist, dec), acontext) =
	 let
	   val new_env as (ENV (_,te,_)) =
	     check_dec (Absyn.DATATYPEdec (location,adatbindlist), acontext)
	 in
	   Env.abs (te, check_dec (dec, Basis.context_plus_env (acontext, 
                                                                new_env)))
	 end
      
      (***** rule 21 *****)

      | check_dec (Absyn.EXCEPTIONdec anexbindlist, acontext) =
	 let
	   val newve = check_exconbind (anexbindlist, acontext)
	 in
	   ENV (Strenv.empty_strenv, Tyenv.empty_tyenv, newve)
	 end
	
      (***** rule 22 *****)

      | check_dec (Absyn.LOCALdec (dec1,dec2),acontext) =
	 let
	   val env = check_dec (dec1, acontext)
	 in
           check_dec (dec2, Basis.context_plus_env (acontext, env))
	 end

      (***** rule 23 *****)

      | check_dec (Absyn.OPENdec (strids,location), acontext) =
	 let
	   val Basistypes.CONTEXT(_, _, E, _) = acontext
	     
	   fun collect_envs(env,lstrid) =
	     let
	       val new_env =
		 case Env.resolve_top_level (Env.lookup_longstrid (lstrid, E))
		   of (STR (_,_,x)) => x
		 | _ => Crash.impossible "lookup strid for open"
	     in
	       Env.env_plus_env(env, new_env)
	     end
             (* This should be handled in the parser *)
             (* except when the error is a semantic one *)
             (* eg a structure which fails to match its constraining signature *)
	     handle Env.LookupStrId strid =>
	       (report_error
		(Info.RECOVERABLE, location,
		 IdentPrint.strid_unbound_strid_message (strid,lstrid,print_options));
                env)
	 in
	   Lists.reducel collect_envs(Env.empty_env,strids)
	 end

      (***** rule 24 and 25 *****)

      | check_dec ((Absyn.SEQUENCEdec declist), context) =
	 let 
           fun check_one ((env,context),dec) =
             let
               val new_env = check_dec (dec,context)
               val new_context = Basis.context_plus_env(context,new_env)
             in
               (Env.env_plus_env (env,new_env),
                new_context)
             end
           val (new_env,_) = Lists.reducel check_one 
                                           ((Env.empty_env,context),declist)
         in
           new_env
	 end

      (***** rule 26 *****)

      (* check_valbind returns ve and list of vars "in" expansive exp. *)

  
    and check_valbind([],recvalbinds,acontext,ve,exp_vars) =
       check_recvalbind (recvalbinds,acontext,ve,exp_vars,[])

      | check_valbind ((apat,anexp,location)::valbinds,
		       recvalbinds,acontext,ve,exp_vars) =
	 let 
	   val (newve, aty, pat_type) = check_pat (apat, acontext)
	   val atype = check_exp (anexp, acontext, NONE)
	 in
	   ignore(unify
	   {
	    first = aty, second = atype, result = aty,
	    context = acontext,
            error = fn () =>
              (location,
	       [Datatypes.Err_String "Pattern and expression types do not agree\n",
		Datatypes.Err_String "Near: ",
		err_string_dec (apat, anexp),
		Datatypes.Err_String "\n  Pattern type:    ",
		Datatypes.Err_Type aty,
		Datatypes.Err_String "\n  Expression type: ",
		Datatypes.Err_Type atype],
               aty)
	    });

           pat_types pat_type;
	   
	   check_valbind (valbinds, recvalbinds, acontext,
			  Valenv.ve_plus_ve (ve, newve),
			  if Absyn.expansivep anexp then 
			    exp_vars @ Valenv.ve_domain newve
			  else exp_vars)
	 end
	    
      (***** rule 27 *****)
	    
    and check_recvalbind ((apat,anexp,location)::recvalbind,acontext,ve,
			   expansive_vars,ty_exp) =
       let
	 val (newve, aty, pat_type) = check_pat (apat, acontext)

         (* the following line checks the extra side condition on the
            rec binding rule in the revised definition.  It ensures that
            hidden type names don't escape through recursive binding.
            see appendix G.7 for more detail. *)

         val _ = if old_definition then ()
                 else checkEscapingNames(location,
                                 Basis.valEnvTynamesNotIn (newve,acontext),
                                         "In the recursive binding.")

       in
	 check_recvalbind (recvalbind,acontext,
			   Valenv.ve_plus_ve (ve, newve),
			   if Absyn.expansivep anexp
			     then 
			       expansive_vars @ (Valenv.ve_domain newve)
			   else expansive_vars,
			     ((aty,pat_type,anexp,location,apat)::ty_exp))
       end
    
      | check_recvalbind ([], acontext, ve, expansive_vars, ty_exp) = 
	 let 
	   val new_context = Basis.context_plus_ve (acontext,ve)
	     
	   fun f (atype, pat_type, anexp,location,apat) = 
	     let
               fun extract_fnname (Absyn.VALpat ((lvalid,_),_)) =
                            IdentPrint.printLongValId print_options lvalid
                 | extract_fnname (Absyn.TYPEDpat (pat,_,_)) = 
                            extract_fnname pat
                 | extract_fnname (Absyn.LAYEREDpat ((valid,_),_)) =
                            IdentPrint.printValId print_options valid
                 | extract_fnname _ = "_"
	       val atype' = check_exp (anexp, new_context, NONE)
	       val ? = 
		 unify
		 {
		  first = atype, second = atype', result = atype,
		  context = acontext,
                  error = fn () =>
                    (location,
		     [Datatypes.Err_String 
                         "Type mismatch in recursive value binding for ",
                      Datatypes.Err_String (extract_fnname apat),
                      Datatypes.Err_String "\n",
		      Datatypes.Err_String (near anexp),
		      Datatypes.Err_String "\n  Pattern type:    ",
		      Datatypes.Err_Type atype,
		      Datatypes.Err_String "\n  Expression type: ",
		      Datatypes.Err_Type atype'],
                     atype)
		  }
	     in
	       pat_types pat_type
	     end
	   
	   val _ = Lists.iterate f ty_exp
	 in
	   (expansive_vars, ve)
	 end

      (***** rule 28 *****)

    and check_typbind ([],acontext) = Tyenv.empty_tyenv

      | check_typbind ((tyvarseq,tycon,ty,tyfun)::typbinds,acontext) =
	 let
	   val tyenv = Basis.te_of_context acontext 
	 in
	   Tyenv.add_to_te(check_typbind (typbinds,acontext),
			   tycon,TYSTR
			   (let
                             val tyfun' = Types.make_tyfun(tyvarseq,check_type (ty,acontext))
                           in
                              (case tyfun of
                                 SOME (tyfun) =>
                                   (tyfun := tyfun';
                                    tyfun_types tyfun)
                               | _ => ();
                               tyfun')
                           end,
                         empty_valenv))
	 end
      (***** rule 29 *****)

    and check_datbind ([],_,_,(ve,te)) = (ve,te)
	   
      | check_datbind ((tyvarlist,tycon,type_ref,tyfun_ref,conbind)::datbinds,
                       location,
                       acontext,
		       (ve,te)) =
	 let
	   val new_context = Basis.context_plus_tyvarlist (acontext,tyvarlist)
	     
	   val TYSTR (tyfun, _) = Basis.lookup_tycon (tycon, new_context)
	     handle Basis.LookupTyCon tycon =>
               Crash.impossible "Garbled context in check_datbind 1"
                  | Basis.LookupStrId _ =>
                      Crash.impossible "Garbled context in check_datbind 2"

           val _ =
             case tyfun_ref of
               SOME (tyfun_ref) =>
                 (tyfun_ref := tyfun;
                  tyfun_types tyfun_ref)
             | _ => () 
	       
	   val tyvartypes =
	     (map
	      (fn x => check_type (Absyn.TYVARty x,new_context))
	      tyvarlist) 

	   val (new_ve,new_te,new_type) = check_conbind (conbind,
							 location,
							 tycon,
							 tyfun,
							 Types.apply
							 (tyfun,tyvartypes),
							 tyvartypes,
							 new_context,
							 empty_valenv,
							 (ve,te))
	   val _ = type_ref := new_type
	 in
	   check_datbind (datbinds,location,acontext,(new_ve,new_te))
	 end
       
      (***** rule 30 *****)

    and check_conbind ([],		   
		       location,
		       tycon,
		       tyfun,
		       tycon_type,
		       tyvartypes,
		       acontext,
		       conenv,
		       (ve,te)) = 
       let
	 val (tyvarlist, tyname, valenv_ref) = case tycon_type of
	   CONSTYPE (tyvarlist,tyname as TYNAME {5 = valenv_ref,...}) =>
	     (tyvarlist, tyname, valenv_ref)
	 | _ => Crash.impossible"bad tycon_type"

	 val metatyvarlist = 
	   let
	     fun subst [] = []
	       | subst (TYVAR (ref (level,_,_),_)::tyvars) =
		 METATYVAR (ref (level,NULLTYPE,NO_INSTANCE),
                            false,false)::(subst tyvars)
	       | subst _ = Crash.impossible"subst bad parameters"
	   in
	     subst tyvarlist
	   end
	 
	 val newtype = CONSTYPE (metatyvarlist,tyname)
	   
       in
	 valenv_ref := conenv;
	 (Valenv.ve_plus_ve (conenv,ve),
	  Tyenv.add_to_te (te, tycon, TYSTR (tyfun, conenv)),newtype)
       end

      | check_conbind (((valid,type_ref),NONE)::conbinds,
		       location,
		       tycon,
		       tyfun,
		       tycon_type,
		       tyvartypes,
		       acontext,
		       conenv,
		       (ve,te)) =
	 let
	   val _ = check_valid(valid, location)
	   val tyscheme = Scheme.make_scheme (tyvartypes,(tycon_type,
                                                          NONE))
	   val new_conenv = Valenv.add_to_ve (valid,tyscheme,conenv)
	 in
	   type_ref := tycon_type;
	   check_conbind
	   (conbinds, location, tycon, tyfun, tycon_type, tyvartypes,
	    acontext, new_conenv, (ve,te))
	 end
  
      | check_conbind (((valid,type_ref),SOME aty)::conbinds,
		       location,
		       tycon,
		       tyfun,
		       tycon_type,
		       tyvartypes,
		       acontext,
		       conenv,
		       (ve,te)) =
	 let 
	   val _ = check_valid(valid, location)
	   val atype = check_type (aty,acontext) 
	   val tyscheme = Scheme.make_scheme (tyvartypes,
					      (FUNTYPE (atype,tycon_type),
                                               NONE))
	   val new_conenv = Valenv.add_to_ve (valid,tyscheme,conenv)
	 in
	   type_ref := FUNTYPE (atype,tycon_type);
	   check_conbind
	   (conbinds, location, tycon, tyfun, tycon_type, tyvartypes,
	    acontext, new_conenv, (ve,te))
	 end

    (* ****** Exception Bindings ****** *)
    (***** rule 31 *****)

    and check_exconbind ([],_) = empty_valenv
      | check_exconbind ((Absyn.NEWexbind ((anexcon,type_ref),
					   SOME aty,location,_))::restbinds,
			 acontext) =
	 let
	   val _ = check_valid(anexcon, location)
	   val atype = check_type (aty, acontext)
	     
	   val ftype =
	     if use_value_polymorphism orelse (Types.imperativep atype) then 
	       FUNTYPE (atype, Types.exn_type)
	     else
	       let
		 val imp = fresh_tyvar (acontext, Types.type_equalityp atype,
                                        false)
	       in
                 report_error
                 (Info.RECOVERABLE, location,
                  concat ["Exception binding contains applicative type variable",
                           "\n  Type domain of exception constructor ",
			   IdentPrint.printValId print_options anexcon,
			   ": ",
                           Completion.print_type
                              (options,
                                Basis.env_of_context acontext,atype)]);
                 FUNTYPE(imp, Types.exn_type)
	       end
	 in
	   type_ref := ftype;
	   Valenv.add_to_ve
	   (anexcon, Scheme.make_scheme ([], (ftype,NONE)),
	    check_exconbind(restbinds, acontext))
	 end
       
      (***** rule 31 *****)

      | check_exconbind ((Absyn.NEWexbind ((anexcon,type_ref),
					   NONE,location,_))::restbinds,
			 acontext) = 
	(check_valid(anexcon, location);
	 type_ref := Types.exn_type;
	  Valenv.add_to_ve
	  (anexcon, Scheme.make_scheme ([],(Types.exn_type,NONE)),
	   check_exconbind(restbinds,acontext)))
	 
      (***** rule 32 *****)	  

      | check_exconbind (Absyn.OLDexbind  
                         ((anewexcon,type_ref), lvalid,location,_)
			 ::restbinds,acontext) =
	 let 
	   val _ = check_valid(anewexcon, location)
	   val atype =
	     #1(Basis.lookup_val (lvalid, acontext, location, generate_moduler))
             (* Need to handle LookupStrid *)
	     handle Basis.LookupValId valid =>
               (report_error
                (Info.RECOVERABLE, 
                 location,
                 IdentPrint.unbound_longvalid_message (valid,lvalid,"exception",print_options));
                Types.exn_type)
               | Basis.LookupStrId strid =>
               (report_strid_error (location,print_options,strid,lvalid);
                Types.exn_type)
	 in
	   type_ref := atype;
	   
	   Valenv.add_to_ve
	   (anewexcon, Scheme.make_scheme ([], (atype,NONE)),
	    check_exconbind(restbinds, acontext))
	 end
        val result = check_dec args
      in
        (copy_tynames();
         result)
      end

    val check_type = Type_exp.check_type
  end;
