(* _mod_rules the functor *)
(*
$Log: _mod_rules.sml,v $
Revision 1.121  1998/12/14 15:52:49  mitchell
[Bug #190495]
Check for equality violations in "where type"s

 * Revision 1.120  1998/02/19  16:50:47  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.119  1997/05/19  12:49:39  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.118  1997/04/08  14:49:55  andreww
 * [Bug #2033]
 * ordering type sharing constraints in structure sharing
 * to maintain correct dependency info between types.
 *
 * Revision 1.117  1996/11/04  17:23:51  andreww
 * [Bug #1712]
 * Where type instantiation shouldn't maximise equality.
 *
 * Revision 1.116  1996/10/29  17:48:36  andreww
 * [Bug #1708]
 * changing the syntax of datatype replication.
 *
 * Revision 1.115  1996/10/29  13:32:36  io
 * moving String from toplevel
 *
 * Revision 1.113  1996/10/04  17:59:16  andreww
 * [Bug #1592]
 * threading location into Absyn.LOCALexp.
 *
 * Revision 1.112  1996/10/04  11:04:22  matthew
 * [Bug #1622]
 * Make certain identifiers unspecifiable
 *
 * Revision 1.111  1996/09/23  11:00:59  andreww
 * [Bug #1589]
 * Where types to be elaborated only in the basis not the basis plus env.
 *
 * Revision 1.110  1996/09/20  10:10:15  andreww
 * [Bug #1577]
 * Adding typechecking rules for datatype replication.
 *
 * Revision 1.109  1996/08/06  11:32:58  andreww
 * [Bug #1521]
 * Propagating changes made to _test.sml that require the
 * use_value_polymorphism flag to be passed.
 *
 * Revision 1.108  1996/07/03  15:52:30  jont
 * Change check for free imperative type variables to return
 * the full type as well as the type variable
 *
 * Revision 1.107  1996/07/02  14:43:01  daveb
 * Made the error message for free imperative type variables at top level
 * depend on the old_definition option.
 *
 * Revision 1.106  1996/06/04  11:21:10  jont
 * Improve error messages for unbound tycons in sharing equations
 *
 * Revision 1.105  1996/05/24  12:12:07  matthew
 * lookupTyCon can also raise Strid exception
 *
 * Revision 1.104  1996/05/20  15:32:51  matthew
 * Fixing problem with lookupTycon
 *
 * Revision 1.103  1996/04/30  16:05:57  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.102  1996/04/03  13:16:05  matthew
 * Changing interface to sharing
 *
 * Revision 1.101  1996/03/26  16:30:47  matthew
 * New language features
 *
 * Revision 1.100  1996/03/19  16:02:06  matthew
 * Adding use_value_polymorphism option
 *
 * Revision 1.99  1996/01/16  12:37:45  daveb
 * Added location information to Absyn.SIGNATUREtopdec.
 *
Revision 1.98  1995/12/27  11:55:28  jont
Removing Option in favour of MLWorks.Option

Revision 1.97  1995/12/18  12:25:34  matthew
Changed interface to Basis.close

Revision 1.96  1995/12/05  13:50:15  jont
Add calls to discover exact location of free imperative type variable errors

Revision 1.95  1995/10/30  10:39:18  jont
Use modified form of expand_str to avoid full cost when
gathering strs. We only want the structure name in this case.

Revision 1.94  1995/09/11  15:57:14  matthew
Attempting to improve some error behaviour

Revision 1.93  1995/08/31  11:25:20  jont
Reinstate unbound strid in openspec error
The parser cannot catch some of these

Revision 1.92  1995/05/02  11:16:11  matthew
Removing debug_polyvariables option

Revision 1.91  1995/04/06  10:01:10  matthew
How much structure expansion is done is determined by whether we are doing
separate compilation

Revision 1.90  1995/02/13  11:42:50  matthew
Debugger changes

Revision 1.89  1995/02/07  16:42:24  matthew
Removing debug stuff

Revision 1.88  1994/09/22  13:15:07  matthew
Tidying up

Revision 1.87  1994/06/10  16:52:17  jont
Fix spelling of contructor to constructor

Revision 1.86  1994/05/11  14:37:52  daveb
Added call to Valenv.resolve_overloads, and location argument to
Scheme.instantiate.  Also added two sharing type equations.

Revision 1.85  1994/04/28  11:28:07  jont
Fix unbound type constructors in specifications problems

Revision 1.84  1994/04/13  13:48:09  jont
Remove Bind handler

Revision 1.83  1994/02/28  06:28:02  nosa
Debugger structure and structure recording for Modules Debugger.

Revision 1.82  1994/02/08  12:10:59  nickh
yes
Found a way to generate some 'impossible' type errors.

Revision 1.81  1993/12/16  13:06:16  matthew
Added level field to Basis.
Renamed Basis.level to Basis.context_level

Revision 1.80  1993/12/03  15:42:21  nickh
fixup various error messages, inexhaustive bindings, etc.

Revision 1.79  1993/12/01  14:00:43  nickh
Marked certain error messages as "impossible".

Revision 1.78  1993/11/30  11:53:58  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.77  1993/09/27  11:05:23  jont
Merging in bug fixes

Revision 1.76  1993/09/16  14:44:31  nosa
Instances in schemes for polymorphic debugger.

Revision 1.75.1.2  1993/09/23  15:35:18  jont
Modified equality_principal to recalculate equality attributes of all
flexible type constructors in the nameset which have non-empty
constructor environments
See the defn page 36 for what's supposed to happen

Revision 1.75.1.1  1993/07/30  11:19:12  jont
Fork for bug fixing

Revision 1.75  1993/07/30  11:19:12  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger;
structure Option.

Revision 1.74  1993/07/12  16:26:46  jont
Merged in changes from 1.72.1.1


Revision 1.73  1993/07/02  15:55:13  daveb
Removed exception environments.
Added field to some topdecs to indicate when signature matching is required
to match an exception against a value specification.

Revision 1.72.1.1  1993/07/09  16:47:34  jont
Fixed problem whereby erroneous signatures were being realised and
causing compiler faults

Revision 1.72  1993/06/25  19:28:51  jont
Various improvements, particularly to do with signatures embedded in structures

Revision 1.71  1993/06/02  18:21:41  jont
Changed type of check_topdec to take assemblies, thus making it functional
Removed all use of per functor application refs
Avoided calculating assemblies during/for structure elaboration

Revision 1.70  1993/06/01  13:45:22  jont
Fixed functor topdecs so that they know about the existing structure assemblies

Revision 1.69  1993/05/28  14:03:39  jont
Cleaned up after assembly changes

Revision 1.68  1993/05/27  12:24:13  jont
Revised way of using assemblies such that structure assemblies are constructed
from the incremental basis rather than on the fly. Fixes a number of
problems with incorrect shadowing

Revision 1.66  1993/05/25  10:36:05  matthew
Replaced abstraction variable name with do_abstraction, so NJ can compile it.

Revision 1.65  1993/05/24  17:27:28  matthew
Added code for abstractions.
Added newAssemblies for INCLUDEspecs

Revision 1.64  1993/05/20  17:20:05  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.63  1993/05/19  16:51:10  matthew
uses test implementation of nameset_diff

Revision 1.62  1993/05/17  14:33:55  daveb
nj_local_open compatibility option has changed to nj_signatures.

Revision 1.61  1993/05/11  12:07:04  matthew
Added (commented out) call to print type bindings of variables

Revision 1.60  1993/05/05  15:46:36  matthew
Restrict nameset of signature to names not in the basis
Add functor parameter nameset to basis nameset

Revision 1.59  1993/04/14  15:42:45  matthew
Changed default for print_times to false

Revision 1.58  1993/04/13  14:39:10  matthew
Simplified interface to Sigma.*names_of* functions
Rewrote circularity test to use assemblies
Rewrote well formed test to recurse properly

Revision 1.57  1993/04/05  15:02:21  jont
Added option for New Jersey compatible open specifications. Fixed poor
implementation in SEQUENCEspecs and SEQUENCEstrdecs

Revision 1.56  1993/03/17  19:03:51  matthew
NamesetType changes

Revision 1.55  1993/03/10  15:32:55  matthew
Options changes

Revision 1.54  1993/03/09  11:57:55  matthew
Options & Info changes

Revision 1.53  1993/02/22  13:40:35  matthew
Much fiddling.
Changed error handling behaviour
removed some silly bits to do with assemblies and namesets
removed most debug statements

Revision 1.52  1993/02/09  14:45:28  matthew
Changes to use BASISTYPES signature.
Removed some of the sillier bits to do with assemblies
Changes to nameset used in functor result signature

Revision 1.51  1993/02/05  15:09:33  matthew
Extensive changes:
Fixed bug with include
COPYSTR representation
Changed many functions to use Lists.reducel
Made many errors recoverable
General tidying up of code

Revision 1.50  1992/12/22  16:59:20  jont
Anel's last changes

Revision 1.49  1992/12/18  16:18:40  matthew
Propagating options to signature matching error messages.

Revision 1.48  1992/12/08  20:06:02  jont
Removed a number of duplicated signatures and structures

Revision 1.47  1992/12/07  11:13:26  matthew
Changed error messages.

Revision 1.46  1992/12/04  19:31:53  matthew
Error message revisions.

Revision 1.45  1992/12/03  18:46:33  matthew
Changes to error messages.

Revision 1.44  1992/12/03  13:24:05  jont
Modified tyenv for efficiency

Revision 1.43  1992/12/02  13:51:58  jont
Modified to remove redundant info signatures

Revision 1.42  1992/11/26  19:06:43  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.41  1992/11/04  18:02:44  matthew
Changed Error structure to Info

Revision 1.40  1992/10/15  15:55:13  clive
Anel's changes for encapsulating assemblies

Revision 1.39  1992/10/14  12:06:29  richard
Added location information to the `require' topdec.

Revision 1.38  1992/09/08  17:54:07  matthew
Added locations to errors

Revision 1.37  1992/09/08  13:07:59  jont
Removed has_a_new_name, no longer needed

Revision 1.36  1992/09/04  10:03:16  richard
Installed central error reporting mechanism.

Revision 1.35  1992/08/27  20:20:40  davidt
Yet more changes to get structure copying working better.

Revision 1.34  1992/08/27  14:30:32  jont
fixed bug in type_explicit.

Revision 1.33  1992/08/26  13:19:53  davidt
Made some changes to the NewMap signature.

Revision 1.32  1992/08/13  15:27:33  davidt
Removed redundant arguments to Assemblies.newAssemblies.

Revision 1.31  1992/08/12  13:11:19  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.30  1992/08/11  11:25:51  matthew
removed type_eq_matters from calls to sigmatch

Revision 1.29  1992/08/04  15:02:51  jont
Anel's changes to use NewMap instead of Map

Revision 1.27  1992/07/27  14:00:42  jont
Removed previous incorrect fix to do with subAssemblies

Revision 1.26  1992/07/17  15:14:35  jont
Fixed bug whereby structure a = a caused subassemblies

Revision 1.25  1992/07/15  15:19:18  jont
Changed exptyStrAssembly to be a function, in case we want an imperative
implementation ever

Revision 1.24  1992/07/02  16:20:36  jont
Added timing of unionTypeAssemblies. Made all timings able to be
turned off

Revision 1.23  1992/06/30  10:30:18  jont
Changed to imperative implementation of namesets with hashing

Revision 1.21  1992/05/19  14:51:46  clive
Adjusted to give better error position reporting now marks have been added

Revision 1.20  1992/05/18  10:24:34  jont
Removed incorrect whitespace from middle of nameset.empty_nameset.
Goodness knows why NJ allows this, I wish they didn't

Revision 1.19  1992/05/07  14:10:02  jont
Anel's fixes. Also included new version of nameset based on hashsets

Revision 1.18  1992/04/27  13:24:47  jont
Added second implementation of sigma for test purposes

Revision 1.15  1992/04/16  16:14:43  jont
Various improvements. Added timing functions

Revision 1.13  1992/04/13  14:36:45  clive
First version of the profiler

Revision 1.12  1992/03/23  19:29:33  jont
Reinstated the code to determine constructor environments for METATYNAMEs

Revision 1.11  1992/01/27  20:14:04  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.10  1992/01/27  12:55:29  jont
Updated to create empty valenv in METATYNAMEs

Revision 1.9  1992/01/22  15:42:25  jont
Stopped signatures and functors being duplicated from previous bases

Revision 1.8  1992/01/08  19:56:42  colin
added reset_assemblies

Revision 1.7  1991/11/20  10:28:32  richard
Moved the empty structure environment from Env to Strenv.

Revision 1.6  91/11/19  19:21:20  jont
Fixed inexhaustive matches

Revision 1.5  91/07/11  14:18:04  colin
Added exception Check_topdec - raised if any errors happened during
type checking in check_topdec

Revision 1.4  91/06/27  17:17:24  colin
changed to handle Interface annotations in signature expressions

Revision 1.3  91/06/27  09:12:24  nickh
Added null check on REQUIREtopdec.

Revision 1.2  91/06/17  17:14:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing of circular data structures

Revision 1.1  91/06/07  11:36:39  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/lists";
require "../utils/print";
require "../utils/crash";
require "../basics/identprint";
require "../typechecker/types";
require "../typechecker/scheme";
require "../typechecker/valenv";
require "../typechecker/tyenv";
require "../typechecker/strenv";
require "../typechecker/environment";
require "../typechecker/strnames";
require "../typechecker/core_rules";
require "../typechecker/sharetypes";
require "../typechecker/share";
require "../typechecker/nameset";
require "../typechecker/sigma";
require "../typechecker/realise";
require "../typechecker/basis";
require "../typechecker/type_debugger";

require "../typechecker/mod_rules";

functor Module_rules (
  structure Lists      : LISTS
  structure Print      : PRINT
  structure Crash      : CRASH
  structure IdentPrint : IDENTPRINT
  structure Types      : TYPES
  structure Scheme     : SCHEME
  structure Valenv     : VALENV
  structure Tyenv      : TYENV
  structure Strenv     : STRENV
  structure Env        : ENVIRONMENT
  structure Strnames   : STRNAMES
  structure Core_rules : CORE_RULES
  structure Realise    : REALISE
  structure Basis      : BASIS
  structure Sigma      : SIGMA
  structure Sharetypes : SHARETYPES
  structure Share      : SHARE
  structure Nameset    : NAMESET
  structure TypeDebugger : TYPE_DEBUGGER

  sharing Core_rules.Basistypes = Realise.BasisTypes =
    Sigma.BasisTypes = Basis.BasisTypes = Sharetypes.Assemblies.Basistypes

  sharing Core_rules.Absyn = TypeDebugger.Absyn
  sharing Core_rules.Info = Realise.Info
  sharing Realise.Options = Types.Options = IdentPrint.Options = Core_rules.Options =
    TypeDebugger.Options = Sigma.Options = Nameset.Options

  sharing Core_rules.Info.Location = IdentPrint.Ident.Location

  sharing Strnames.Datatypes = Tyenv.Datatypes = Nameset.Datatypes =
    Valenv.Datatypes = Scheme.Datatypes = Types.Datatypes = Strenv.Datatypes =
    Env.Datatypes = Basis.BasisTypes.Datatypes = Core_rules.Absyn.Datatypes
  sharing Share.Assemblies = Sharetypes.Assemblies
  sharing IdentPrint.Ident = Types.Datatypes.Ident

  sharing type Nameset.Nameset = Basis.BasisTypes.Nameset =
    Sharetypes.NamesetTypes.Nameset
  sharing type Core_rules.Absyn.DebuggerStr = Strnames.Datatypes.DebuggerStr
  sharing type Basis.options = Core_rules.Options.options
  sharing type Valenv.Options  = Realise.Options.options
  sharing type Valenv.ErrorInfo  = Realise.Info.options = Basis.error_info
  sharing type IdentPrint.Options.print_options = Basis.print_options
    ) : MODULE_RULES =

  struct
    structure Absyn = Core_rules.Absyn
    structure BasisTypes = Basis.BasisTypes
    structure Assemblies = Sharetypes.Assemblies
    structure Info = Core_rules.Info
    structure Location = Info.Location
    structure Set = BasisTypes.Set
    structure Datatypes = Types.Datatypes
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure Options = Core_rules.Options
    structure Basis = Basis


    datatype assembly =
      ASSEMBLY of (Assemblies.StrAssembly * Assemblies.TypeAssembly)
    | BASIS of BasisTypes.Basis

    val do_debug = false

    open Datatypes

    (* These exceptions signal failure of signature elaboration *)
    exception WellFormed of BasisTypes.Sigma
    exception TypeExplicit of BasisTypes.Sigma
    exception RespectEquality of BasisTypes.Sigma

    fun eq_scheme (_, s) = Scheme.equalityp s

    (* eager andalso *)
    fun aswell (a,b) = a andalso b

    fun fresh_tyvar(acontext, eq, imp) =
      METATYVAR (ref (Basis.context_level acontext,NULLTYPE,NO_INSTANCE), eq, imp)

    fun make_dummy_structures () =
      let
	val str = STR (STRNAME (Types.make_stamp ()),ref NONE,Env.empty_env)
      in
        (str,str)
      end

    fun set_intref (Absyn.OLDsigexp (_,intref,_),str) = intref := SOME str
      | set_intref (Absyn.NEWsigexp(_,intref),str) = intref := SOME str
      | set_intref (Absyn.WHEREsigexp (sigexp,_),str) = set_intref (sigexp,str)

    (* Structure and Type assemblies *)

    (* During elaboration of signatures these assemblies are updated;*)
    (* if shadowing occur new assemblies are built which are unioned *)
    (* with the above. After elaborating each topdec str_ass and ty_ass *)
    (* are assigned to sigstr_ass and sigty_ass respectively. *)
    (* This is all a bit out of date now *)
    (* Assemblies are built after elaboration of strdec topdecs *)
    (* Work is still in progress on the signature stuff *)
    (* Work is also in progress to try to make this stuff functional *)

    val empty_str_ass = Assemblies.empty_strassembly()
    val empty_ty_ass = Assemblies.empty_tyassembly

    (* ****** Structure Expressions ****** *)

    fun copystr_crash s = Crash.impossible ("Unexpanded structure in " ^ s)

    fun circularp (strname,strname',strass) =
      let
        fun offspring name = Assemblies.findStrOffspring (name,strass)
        fun checkok (strname,stroffspring) =
          let
	    val os_map = Assemblies.getStrOffspringMap stroffspring
          in
            NewMap.forall
            (fn (_,(subname,_)) =>
             (not (Strnames.strname_eq (strname,subname))
              andalso
              checkok (strname,offspring subname)))
            os_map
          end
      in
        not (checkok (strname,offspring strname'))
        orelse
        not (checkok (strname',offspring strname))
      end

    fun make_completion_env (basis,sigstr,strstr) =
      let
	val ENV (sE,tE,vE) = Basis.env_of_context (Basis.basis_to_context basis)
      in
	ENV(Strenv.add_to_se(Ident.STRID (Symbol.find_symbol "_sig"),
			     sigstr,
			     Strenv.add_to_se(Ident.STRID(Symbol.find_symbol "_str"),
					      strstr,
					      sE)),
	    tE,vE)
      end

    val generate_moduler_debug = false
    fun get_env_or_crash (_,STR (_,_,e)) = e
      | get_env_or_crash (error,_) = Crash.impossible error

    fun get_name_and_env (_,STR (m,_,e)) = (m,e)
      | get_name_and_env (error,_) = Crash.impossible error

    fun has_unbounds_te(TE amap) =
      NewMap.exists
      (fn (_, tystr) => has_unbounds_tystr tystr)
      amap

    and has_unbounds_ve(VE(_, amap)) =
      NewMap.exists
      (fn (_, scheme) => has_unbounds_scheme scheme)
      amap

    and has_unbounds_tystr(TYSTR(tyfun, valenv)) =
      Types.tyfun_has_unbound_tyvars tyfun orelse has_unbounds_ve valenv

    and has_unbounds_scheme(SCHEME(_, (ty, _))) = Types.type_has_unbound_tyvars ty
      | has_unbounds_scheme(UNBOUND_SCHEME(ty, _)) = Types.type_has_unbound_tyvars ty
      | has_unbounds_scheme(OVERLOADED_SCHEME _) = false

    val verboten_identifieren = 
      map 
      Symbol.find_symbol
      ["true","false","it","nil","::","ref"]

    fun check_topdec error_info(options as
				Options.OPTIONS
				{print_options,
				 compat_options=Options.COMPATOPTIONS{nj_signatures, 
                                                                      old_definition,...},
				 ...}, is_separate, topdec, basis, assembly) =
      let
        val use_value_polymorphism = not old_definition
	fun error_wrap error_info =
	  Info.wrap error_info
	  (Info.FATAL, Info.RECOVERABLE, Info.ADVICE, Location.UNKNOWN)
	val sigstr_ass = ref(Assemblies.empty_strassembly())
	val sigty_ass = ref Assemblies.empty_tyassembly
	val report_error = Info.error error_info
	val check_type = Core_rules.check_type error_info
	val check_dec = Core_rules.check_dec (error_info,options)
	val sigmatch = Realise.sigmatch (error_info,options)

        fun check_valid_ok (valid,location) =
          let
            fun valid_symbol v =
              case v of
                Ident.VAR s => s
              | Ident.CON s => s
              | Ident.EXCON s => s
              | Ident.TYCON' s => s
            val name = valid_symbol valid
          in
            if Lists.member (name,verboten_identifieren)
              then
                report_error (Info.RECOVERABLE, 
                              location,
                              "Trying to specify a reserved name: " ^ 
                              Symbol.symbol_name name)
            else
              ()
          end

	(* *** rule 53 *** *)

	fun check_strexp (Absyn.NEWstrexp strdec,basis) =
	  let
	    val strname = STRNAME (Types.make_stamp ())
	    val env = check_strdec (strdec,basis)
	    val str = STR (strname,ref NONE,env)
	    val exp_str = Env.expand_str str
	  in
	    (str,exp_str)
	  end

	  (* *** rule 54 *** *)

	  | check_strexp (Absyn.OLDstrexp (lstrid,location,interface),basis) =
	    (let
	       val str = Basis.lookup_longstrid (lstrid,basis)
	       val exp_str = Env.expand_str str
               val _ =
                 case interface of
                   SOME(interface) =>
                     interface := SOME(exp_str)
                 | _ => ()
	     in
	       (str,exp_str)
	     end
	   handle Basis.LookupStrId strid =>
	     (report_error (Info.RECOVERABLE, location,
                            IdentPrint.strid_unbound_strid_message (strid,lstrid,print_options));
	      make_dummy_structures ())) (* structure doesn't exist, so there you go *)

	  (* *** rule 55 *** *)

	  | check_strexp (Absyn.APPstrexp (funid,strexp,coerce_ref,location,
                                           debugger_str),basis) =
	    (let
	       val (str,exp_str) = check_strexp (strexp,basis)
	       val phi = Basis.lookup_funid (funid,basis)

             (****
              We have to copy both the body and the argument of the functor
              before we match the argument signature to the actual argument.
              This is necessary because sharing between the argument and result
              specified in the declaration of the functor is represented by the
              occurrence of the same name in both the body and the argument.
              This repeated occurrence is preserved by the realisation map,
              yielding sharing between the argument structure and the result
              structure of the functor application.
              ****)

              (* If we are doing separate compilation then expand the
                 copied structures *)
	       val BasisTypes.PHI (newnames,(newstr'',
                                             BasisTypes.SIGMA (newnames',
                                                               newstr'))) =
                 Sigma.phi_copy (phi,is_separate) (Basis.basis_level basis)

	       val exp_newstr' = Env.expand_str newstr' (* necessary *)
	       val exp_newstr'' = Env.expand_str newstr'' (* necessary *)
	       val sigma = BasisTypes.SIGMA(Nameset.union(newnames,newnames'),
                                            exp_newstr'')
	       val completion_env = make_completion_env(basis,exp_newstr'',
                                                        exp_str)
	       val (realise, do_coerce, debugger_str') =
		 (sigmatch (location,
			    completion_env,
			    Basis.context_level(Basis.basis_to_context basis),
			    sigma,
			    exp_str))
               val _ =
                 case debugger_str of
                   SOME(debugger_str) => debugger_str := debugger_str'
                 | _ => ()
	     in
	       if realise then ()
	       else
		 report_error
                 (Info.RECOVERABLE, location,
                  concat ["Argument signature of ", 
                                  IdentPrint.printFunId funid,
                                  " does not match the actual argument"]);
		 if do_coerce then coerce_ref := true else ();
		   (newstr',exp_newstr') 
                                 (* Approximately correct in error case *)
	     end
           handle Basis.LookupFunId =>
             (report_error(Info.RECOVERABLE,
                           location,
                           "impossible type error 6: unbound functor " ^ 
                           IdentPrint.printFunId funid);
              make_dummy_structures()))

	  (* *** rule 56 *** *)

	  | check_strexp (Absyn.LOCALstrexp (strdec,strexp),basis) =
	    let
	      val new_env = check_strdec (strdec,basis)
	    in
	      check_strexp (strexp,Basis.basis_plus_env (basis,new_env))
	    end

          | check_strexp (Absyn.CONSTRAINTstrexp (strexp,sigexp,abs,
                                                  coerce_ref,location),
                          basis) =
            let
              val (str,exp_str) = check_strexp (strexp,basis)
	      val (str_ass, ty_ass) =
		Assemblies.new_assemblies_from_basis_inc_sig basis
	      (* Here we want to stop after signature elaboration 
                 on any error *)
	      val _ = (sigstr_ass := str_ass;
		       sigty_ass := ty_ass)
	      val (sigma,_) =
		error_wrap
		error_info
		(fn options =>
		 fn (sigexp,basis,location) =>
		 (check_sigexp_closed (sigexp,basis,location))
		 handle WellFormed sigma =>
		   (report_error
		    (Info.RECOVERABLE, location,
		     "Constraining signature is not well-formed");
		    (sigma,sigma))
		      | TypeExplicit sigma =>
			  (report_error
			   (Info.RECOVERABLE, location,
			    "Constraining signature is not type-explicit");
			   (sigma,sigma))
		      | RespectEquality sigma =>
			  (report_error
			   (Info.RECOVERABLE, location,
 		           "Constraining signature does not respect equality");
			   (sigma,sigma)))
		(sigexp,basis,location)

	      val sigma' as BasisTypes.SIGMA (names',str') = 
                                 Sigma.sig_copy (sigma,is_separate)
                                                (Basis.basis_level basis)
	      val exp_str' = Env.expand_str str'
	      val exp_sigma' = BasisTypes.SIGMA(names',exp_str')
	      val completion_env = make_completion_env (basis,exp_str',exp_str)
	      val (realise, do_coerce, debugger_str') =
	        sigmatch (location,completion_env,
			  Basis.context_level (Basis.basis_to_context basis),
			  exp_sigma',exp_str)
(*
              val _ =
                (case debugger_str of
                   SOME(debugger_str) => debugger_str := debugger_str'
                 | _ => ();
		     case debugger_str'' of
		       SOME(debugger_str'') =>
			 debugger_str'' := SOME(str')
		     | _ => ())
*)
	    in
	      if realise then ()
              else
		report_error
                (Info.RECOVERABLE, location,
                 concat ["Structure does not match signature"]);
 		if do_coerce then coerce_ref := true else ();
		  if abs then
		    let val BasisTypes.SIGMA(_,abs_str) =
		      Sigma.abstract_sigma sigma 
                                          (Basis.basis_level basis)
		    in 
                      (abs_str,Env.expand_str abs_str)
		    end
		  else
		    (str',Env.expand_str str')
	    end
              

	  (* ****** Structure-level Declarations ****** *)

	  (* *** rule 57 *** *)

        and check_strdec (Absyn.DECstrdec dec,basis) =
	  let val env = check_dec (dec,Basis.basis_to_context basis)
	  in
	    Valenv.resolve_overloads
	    error_info
	    (env, options);
            env
	  end

	  (* *** rule 58 *** *)

	  | check_strdec (Absyn.STRUCTUREstrdec strbindlist,basis) =
	    Env.SE_in_env (check_strbinds (strbindlist, basis,false))

	  (* *** Abstractions *** *)

	  | check_strdec (Absyn.ABSTRACTIONstrdec strbindlist,basis) =
	    Env.SE_in_env (check_strbinds (strbindlist, basis,true))

	  (* *** rule 59 *** *)

	  | check_strdec (Absyn.LOCALstrdec (strdec1,strdec2),basis) =
	    let
              val new_env = check_strdec (strdec1,basis)
	    in
	      check_strdec (strdec2, Basis.basis_plus_env (basis,new_env))
	    end

	  (* *** rules 60 and 61 *** *)

	  | check_strdec (Absyn.SEQUENCEstrdec strdeclist,basis) =
	    let
	      fun check_one ((basis,env),strdec) =
		let
		  val env' = check_strdec(strdec, basis)
		  val new_env = Env.env_plus_env(env, env')
		  val new_basis = Basis.basis_plus_env(basis, env')
		in
		  (new_basis, new_env)
		end
	      val (_,env) = Lists.reducel check_one ((basis,Env.empty_env),strdeclist)
	    in
	      env
	    end

        (* *** Structure Bindings *** *)

        (* *** rule 62 *** *)

        (* This function should be made tail recursive with reducel *)
	and check_strbinds ([],basis,do_abstraction) =
	  Strenv.empty_strenv

	  | check_strbinds ((strid,NONE,strexp,coerce_ref,_,_,
                             debugger_str)::strbinds,
			    basis as BasisTypes.BASIS (_,_,_,_,ENV (se,_,_)),
			    do_abstraction) =
	    let
	      val (str,strexp') = check_strexp (strexp,basis)
	      val (m,env) = get_name_and_env ("check_strexp",strexp')
		
	      (* we always generate new names for structures so dont need
		 to extend the basis nameset *)
	      val se' =
		check_strbinds (strbinds,basis,do_abstraction)
	    in
              (case debugger_str of
                 SOME(debugger_str) =>
                   debugger_str := SOME(str)
               | _ => ();
		   Strenv.add_to_se (strid,str,se'))
	    end

	  | check_strbinds ((strid,SOME (sigexp,abs),strexp,
                             coerce_ref,location,debugger_str,debugger_str'')::
			    strbinds,
			    basis,
			    do_abstraction) =
	    let
              val _ =
                if generate_moduler_debug then
                  print("\n STRBIND "^ Ident.Location.to_string location)
                else ()
	      val (str,exp_str) = check_strexp (strexp,basis)
	      (* This is a diabolical case. We need assemblies here *)
	      (* We even need the signature part, in case we're in a functor *)
	      val (str_ass, ty_ass) =
		Assemblies.new_assemblies_from_basis_inc_sig basis
	      (* Here we want to stop after signature elaboration
                 on any error *)
	      val _ = (sigstr_ass := str_ass;
		       sigty_ass := ty_ass)
	      val (sigma,_) =
		error_wrap
		error_info
		(fn options =>
		 fn (sigexp,basis,location) =>
		 (check_sigexp_closed (sigexp,basis,location))
		 handle WellFormed sigma =>
		   (report_error
		    (Info.RECOVERABLE, location,
		     "Constraining signature is not well-formed");
		    (sigma,sigma))
		      | TypeExplicit sigma =>
			  (report_error
			   (Info.RECOVERABLE, location,
			    "Constraining signature is not type-explicit");
			   (sigma,sigma))
		      | RespectEquality sigma =>
			  (report_error
			   (Info.RECOVERABLE, location,
			   "Constraining signature does not respect equality");
			   (sigma,sigma)))
		(sigexp,basis,location)

	      val sigma' as BasisTypes.SIGMA (names',str') = 
                                  Sigma.sig_copy (sigma,is_separate)
                                                 (Basis.basis_level basis)
	      val exp_str' = Env.expand_str str'
	      val exp_sigma' = BasisTypes.SIGMA(names',exp_str')
	      (* This recursion is in the wrong place *)
	      val se' = check_strbinds (strbinds,basis, do_abstraction)
	      val completion_env = make_completion_env (basis,exp_str',exp_str)
	
	      val (realise, do_coerce, debugger_str') =
	        sigmatch (location,completion_env,
			  Basis.context_level (Basis.basis_to_context basis),
			  exp_sigma',exp_str)
              val _ =
                (case debugger_str of
                   SOME(debugger_str) => debugger_str := debugger_str'
                 | _ => ();
		     case debugger_str'' of
		       SOME(debugger_str'') =>
			 debugger_str'' := SOME(str')
		     | _ => ())
	    in
	      if realise then ()
              else
		report_error
                (Info.RECOVERABLE, location,
                 concat ["Structure ",IdentPrint.printStrId strid,
                          " does not match signature"]);
		if do_coerce then coerce_ref := true else ();
		  if do_abstraction then
		    let val BasisTypes.SIGMA(_,abs_str) =
		      Sigma.abstract_sigma sigma 
                                           (Basis.basis_level basis)
		    in Strenv.add_to_se (strid,abs_str,se')
		    end
		  else
		    Strenv.add_to_se (strid,str',se')
	    end

        (* *** Signature Expressions *** *)

	(* *** rule 63 *** *)

	and check_sigexp_open (Absyn.NEWsigexp (spec,_),basis) =
	  let
	    val m = METASTRNAME (ref (NULLNAME (Types.make_stamp ())))
	    val (env, _) = check_spec (spec,basis)
	    val str = STR(m,ref NONE,env)
	    val exp_str = Env.expand_str str
	    val ENV (se,te,_) = get_env_or_crash ("expand_str",exp_str)
	    val type_offspring =
	      Assemblies.collectTypeOffspring (te,Assemblies.findTypeOffspring(m,!sigstr_ass))
	  in
	    sigstr_ass :=
	    Assemblies.add_to_StrAssembly
	    (m,
	     Assemblies.collectStrOffspring (se,Assemblies.findStrOffspring(m,!sigstr_ass)),
	     type_offspring,!sigstr_ass);
	    (str,exp_str)
	  end

        (* *** rule 64 *** *)

	  | check_sigexp_open (Absyn.OLDsigexp (sigid,_,location),basis) =
	    (let
	      val sigma = Basis.lookup_sigid (sigid,basis)

             (****
              It is necessary to copy the signature because sharing is done
              destructively.
              ****)
	      val BasisTypes.SIGMA (names',str') = 
                Sigma.sig_copy (sigma,is_separate) 
                               (Basis.basis_level basis)

	      val exp_str' = Env.expand_str str'
                          (* Only necessary for interpreter compilation *)

	      val (m,env) = get_name_and_env ("expand_str",exp_str')
	
	      val (sigstr_ass',sigty_ass') = Assemblies.newAssemblies (m,env)

	    (* put the old (uncopied) structure in the interface slot *)
	    in
	      (sigstr_ass := Assemblies.unionStrAssembly(!sigstr_ass,
                                                         sigstr_ass');
	       sigty_ass := Assemblies.unionTypeAssembly(!sigty_ass,
                                                         sigty_ass');
	       (str',exp_str'))
	    end
	  handle Basis.LookupSigId =>
	    (report_error (Info.RECOVERABLE, location,
			   "impossible type error 7: unbound signature "^
                           IdentPrint.printSigId sigid);
	     make_dummy_structures()))

          | check_sigexp_open (Absyn.WHEREsigexp (sigexp,typbinds),basis) =
            let
              val (str,exp_str) = check_sigexp_open (sigexp,basis)
              val env = case exp_str 
                          of STR (_,_,env) => env 
                           | _ => copystr_crash "WHEREsigexp copystr"
              fun check_one (tyvarlist,tycon,ty,location) =
                let
                  val context = Basis.basis_to_context basis
                  val atype = check_type (ty,context)
                  val tyfun = Types.make_tyfun (tyvarlist,atype)
                in
                  (tycon,tyfun,atype,location)
                end
              val tysubs = map check_one typbinds
              fun apply_tysub (longtycon,tyfun,ty,location) =
                let
                  val Datatypes.TYSTR (tyfun',valenv) = Env.lookup_longtycon (longtycon,env)
                in
                  if Types.equalityp tyfun'
                  andalso not (Types.equalityp tyfun)
                  then report_error
                        (Info.RECOVERABLE, location,
                         "The type " ^ (Types.print_type options ty) ^
                         " does not admit equality.\n")
                  else ();
                  if Types.null_tyfunp tyfun'
                    then
                      if Types.tyfun_eq (tyfun,tyfun') then
                        report_error
                        (Info.RECOVERABLE, location,
                         "circular where type")
                      else
                        case Types.meta_tyname tyfun' of
                          METATYNAME (tyfunref,s,i,b1,ve,b2) =>
                            tyfunref := tyfun
                        | _ => Crash.impossible "apply_tysub"
                  else 
                    report_error 
                    (Info.RECOVERABLE, location,
                     "where type not with flexible type")
                end
              handle Basis.LookupTyCon tycon =>
                report_error
                (Info.RECOVERABLE, location,
                 "where type: " ^ IdentPrint.unbound_longtycon_message (tycon,longtycon))
                   | Basis.LookupStrId strid =>
                       (report_error
                        (Info.RECOVERABLE, location,
                         "where type: " ^ IdentPrint.tycon_unbound_strid_message (strid,longtycon)))
            in
              Lists.iterate apply_tysub tysubs;
              (str,exp_str)
            end
                 
      (* *** rule 65 *** *)

	and check_sigexp_closed (sigexp,basis,location) =
	  let
	    val BasisTypes.BASIS(_,basis_names,_,_,_) = basis

	    val (str,exp_str) = check_sigexp_open(sigexp,basis)

	    val nameset = Sigma.new_names_of exp_str

	    val real_nameset = Nameset.diff(nameset,basis_names)

	    val sigma = BasisTypes.SIGMA(real_nameset,str)
	    val exp_sigma = BasisTypes.SIGMA(real_nameset, exp_str)

	    fun tystr_respect_equality (_, TYSTR (tyfun,VE (_,amap))) =
	      let
		fun eq_scheme (valid, s) =
		  Scheme.equalityp s orelse
		  (report_error
		   (Info.RECOVERABLE, location,
		    Types.print_type options
		    (#1(Types.argres 
                        (#1(Scheme.instantiate 
                            (1,s,location,false))))) ^
		    " does not admit equality: constructor is " ^
		    IdentPrint.printValId print_options valid);
		   false)
	      in
		if Types.equalityp tyfun then
		  (NewMap.forall eq_scheme amap)
		else true
	      end

	    fun se_respect_equality(_, str) =
	      let fun get_env (STR(_,_,env)) = env
		    | get_env (COPYSTR ((smap,tmap),str')) =
		      copystr_crash "se_respect_equality"
	      in
		env_respect_equality (get_env str)
	      end

	    and env_respect_equality (env as ENV (se as SE amap,
						  te as TE amap',_)) =
	      Env.empty_envp env orelse
	      aswell(NewMap.forall se_respect_equality amap,
		     NewMap.forall tystr_respect_equality amap')

	    fun respect_equality (BasisTypes.SIGMA (names,STR (_,_,env))) =
	      env_respect_equality env
	      | respect_equality _ = copystr_crash "respect_equality"

	    fun max_eq_pred (_, TYSTR (atyfun,VE (_,amap))) =
	      if (Types.equalityp atyfun) andalso 
                  not (NewMap.forall eq_scheme amap)
		then Types.make_false atyfun
	      else
		true

	    fun se_equality_principal (_,STR (_,_,env)) =
	      env_equality_principal env
	      | se_equality_principal _ = copystr_crash "se_equality_principal"

                (* note: although signatures should be equality principal
                   in both old and new definitions, the new definition
                   should not maximise equality, especially after Where
                   type instantiation. *)

	    and env_equality_principal (ENV (SE amap,TE amap',_)) =
	       if old_definition then NewMap.forall max_eq_pred amap' 
                 andalso NewMap.forall se_equality_principal amap
               else true


	    fun equality_principal 
                       (sigma as BasisTypes.SIGMA (names,STR(_,_,env))) =
	      let
		val tynames = Nameset.tynames_of_nameset names
		val _ = Lists.iterate
		  (fn tyname =>
		   let
		     val tyfun = ETA_TYFUN tyname
		   in
		     if Types.null_tyfunp tyfun andalso
		       not(Valenv.empty_valenvp
			   (#1(Assemblies.lookupTyfun(tyfun, !sigty_ass))))
                       andalso old_definition
		       then
			 Types.make_true tyname else ()
		   end)
		  tynames
	      in
		while not (env_equality_principal env) do ();
		  sigma
	      end

	      | equality_principal _ = copystr_crash "equality_principal"

	    (* this should probably report errors as it goes *)
	    fun well_formed (BasisTypes.SIGMA (names,STR (_,_,env))) =
	      let
		fun check_env (ENV (SE amap,_,_)) =
		  NewMap.forall check_one amap
		and check_one (strid,STR(m,_,env)) =
		  if
		    (* it is a local name *)
		    Nameset.member_of_strnames (m,names)
		    then
		      (* so check recursively *)
		      check_env env
		  else
		    (* check all substructures are non-local *)
		    Nameset.emptyp
		    (Nameset.intersection (names,
					   Sigma.names_of_env env))
		  | check_one _ = copystr_crash "check"
	      in
		check_env env
	      end
	      | well_formed _ = copystr_crash "well_formed"

	    fun te_type_explicit (names,[],name_copies) = name_copies
	      | te_type_explicit (names,(tycon,TYSTR(tyfun,_))::tycons,
				  name_copies) =
		if Types.null_tyfunp tyfun then
		  let
		    val type_name = Types.name tyfun
		    val name_copies' =
		      te_type_explicit (names,tycons,name_copies)
		  in
		    if Nameset.member_of_tynames (type_name, names) then
		      type_name:: name_copies'
		    else name_copies
		  end
		else te_type_explicit (names,tycons,name_copies)

	    fun se_type_explicit (names,[],name_copies) = name_copies
	      | se_type_explicit (names,(_,STR(_,_,env))::stridenvs,name_copies) =
		se_type_explicit (names,stridenvs,env_type_explicit (names,env,name_copies))
	      | se_type_explicit _ = copystr_crash "se_type_explicit"

	    and env_type_explicit (names,ENV (SE amap,TE amap',_),
				   name_copies) =
	      let
		val strid_str_list = NewMap.to_list amap
		val tycon_tystr_list = NewMap.to_list amap'
		val name_copies' = te_type_explicit (names,tycon_tystr_list,
						     name_copies)
	      in
		se_type_explicit (names,strid_str_list,name_copies')
	      end

	    fun type_explicit (BasisTypes.SIGMA (names,STR (_,_,env))) =
              let
                val name_copies = env_type_explicit (names,env,[])
              in
                Nameset.nameset_eq
                (Nameset.tynames_in_nameset((Nameset.tynames_of_nameset names),Nameset.empty_nameset ()),
                 Nameset.tynames_in_nameset(name_copies,Nameset.empty_nameset ()))
              end
	      | type_explicit _ = copystr_crash "type_explicit"
	  in
	    (* Only the last check ("equality principal") modifies the structure, and *)
	    (* then it is through modifications of tynames *)
            ignore
	    (if not (respect_equality exp_sigma)
	       then raise RespectEquality sigma
	     else ();
	     if not (type_explicit exp_sigma)
	       then raise TypeExplicit sigma
	     else ();
	     if not (well_formed exp_sigma)
	       then raise WellFormed sigma
	     else ();
          (* This should work by side-effecting the names in the sigma and the *)
          (* expanded sigma *)
	     equality_principal exp_sigma);
	    set_intref(sigexp,str);
	    (sigma,exp_sigma)
	  end

    (* *** Signature Declarations *** *)

    (* *** rules 66, 67 and 68 are parsed away *** *)

    (* *** Signature Bindings *** *)

    (* *** rule 69 *** *)

	and check_sigbind (Absyn.SIGBIND [],basis,sigenv, _) = sigenv

	  | check_sigbind (Absyn.SIGBIND ((sigid,sigexp,location)::sigbinds),basis,
			   sigenv, ass as (str_ass, ty_ass)) =
	    let
	      val _ = sigstr_ass := str_ass
	      val _ = sigty_ass := ty_ass
	      val (sigma as BasisTypes.SIGMA (names,str),BasisTypes.SIGMA(_,exp_str)) =
		(check_sigexp_closed (sigexp,basis,location))
		handle
		WellFormed sigma =>
		  (report_error
		   (Info.RECOVERABLE, location,
		    "Signature " ^ IdentPrint.printSigId sigid ^
		    " is not well-formed");
		   (sigma,sigma))
	      | TypeExplicit sigma =>
		  (report_error
		   (Info.RECOVERABLE, location,
		    "Signature "  ^ IdentPrint.printSigId sigid ^
		    " is not type-explicit");
		   (sigma,sigma))
	      | RespectEquality sigma =>
		  (report_error
		   (Info.RECOVERABLE, location,
		    "Signature "  ^ IdentPrint.printSigId sigid ^
		    " does not respect equality");
		   (sigma,sigma))
	    in
	      Basis.add_to_sigenv(sigid,BasisTypes.SIGMA(names,str),
				  check_sigbind(Absyn.SIGBIND sigbinds,
						basis,sigenv, ass))
	    end

    (* *** Specifications *** *)

    (* *** rule 70 *** *)

	and check_spec (Absyn.VALspec (valdesclist,location),basis) =
	  let
	    val context = Basis.basis_to_context basis
	    val new_ve = check_valdesc (valdesclist,context,location)
	    val new_env =
	      Env.VE_in_env (Basis.close 
                             (error_info,options,location)
                             (Basis.context_level context,new_ve,[],Set.empty_set,false))
	  in
	    (new_env, new_env)
	  end

      (* *** rule 71 *** *)

	  | check_spec (Absyn.TYPEspec typedesclist,basis) =
	    let
	      val new_te = check_typdesc (typedesclist,
					  Basis.basis_to_context basis,
					  false)
	      val new_env = Env.TE_in_env new_te
	    in
	      (new_env, new_env)
	    end

      (* *** rule 72 *** *)
      (* the type functions are constructed to admit equality in
       check_typdesc *)

	  | check_spec (Absyn.EQTYPEspec typedesclist,basis) =
	    let
	      val new_te = check_typdesc (typedesclist,
					  Basis.basis_to_context basis,
					  true)
	      val new_env = Env.TE_in_env new_te
	    in
	      (new_env, new_env)
	    end

      (* *** rule 73 *** *)

	  | check_spec (Absyn.DATATYPEspec datdesclist,
			basis as BasisTypes.BASIS (_,_,_,_,ENV (_,te,_))) =
	    let
	      fun make_dummy_te ([],te) = te
		| make_dummy_te ((tyvars,tycon,condescs)::datadescs,te) =
		  make_dummy_te (datadescs,
				 Tyenv.add_to_te
				 (te,tycon,
				  TYSTR
				  (Types.make_eta_tyfun
				   (METATYNAME (ref (NULL_TYFUN
						     (Types.make_stamp(),(ref(TYFUN(NULLTYPE,0))))),
						IdentPrint.printTyCon
						tycon,
						length tyvars,
						ref true,
						ref empty_valenv,
						ref false)),
				   empty_valenv)))

	      val new_context =
		Basis.context_plus_te (Basis.basis_to_context basis,
				       make_dummy_te (datdesclist,te))
	      val (new_ve,new_te) =
		check_datdesc (datdesclist,new_context,(empty_valenv,
							Tyenv.empty_tyenv))

	      (* can we use the similar function above instead of this? *)
	      fun max_eq (TE amap) =
		while
		  not (NewMap.forall
		       (fn (_, TYSTR (atyfun,VE (_,amap')))
			=>
			  if Types.equalityp atyfun then
			    NewMap.forall eq_scheme amap' orelse
			    Types.make_false atyfun
			  else
			    true)
		       amap)
		  do
		  ()
	      val _ = max_eq new_te

	      val new_env =
		if has_unbounds_te new_te orelse has_unbounds_ve new_ve then
		  Env.empty_env
		else
		  Env.VE_TE_in_env(new_ve,new_te)
	    in
	      (new_env, new_env)
	    end


       (* *** rule 72 of SML'96 definition *** *)


	  | check_spec (Absyn.DATATYPEreplSpec (location,tycon, longtycon,
                                                associatedConstructors),
			basis as BasisTypes.BASIS (_,_,_,_,
                                                   ENV (_,te as TE amap,_))) =

	    (let
              val tyStr as Datatypes.TYSTR(tyFun,valEnv) =
                Basis.lookup_longtycon(longtycon,Basis.basis_to_context basis)
              (* Basis exceptions handled at end of rule *)
                
                        
              fun valenvToConstructorList (Datatypes.VE(_,amap)) =
                map (fn (valid,Datatypes.SCHEME(_,(ty,_))) => 
                                    (valid,SOME ty,Location.UNKNOWN)
                      | (valid,Datatypes.UNBOUND_SCHEME(ty,_)) => 
                                    (valid, NONE,Location.UNKNOWN)
                      | _ => Crash.impossible 
                          "mod_rules:constructors with overloaded typescheme")
                    (Datatypes.NewMap.to_list_ordered amap)
                
              
              val _ = associatedConstructors := 
                                 SOME (valenvToConstructorList valEnv)

                 (* record the list of constructors associated with this 
                    datastructure for future reference (i.e., lambda
                    toplevel printing) *)

              val new_te = Tyenv.add_to_te(Tyenv.empty_tyenv,tycon,tyStr)
              val new_env = ENV(Strenv.empty_strenv,new_te,valEnv)
            in
              (new_env,new_env)
            end
          handle Basis.LookupTyCon tycon =>
            (report_error 
             (Info.RECOVERABLE, location,
              "The type constructor "^(IdentPrint.printTyCon tycon)
              ^" on the right hand side of the datatype replication\
               \ does not exist.");(Env.empty_env,Env.empty_env))
            
               | Basis.LookupStrId strId =>
                   (report_error
                    (Info.RECOVERABLE, location,
                     "Structure "^ (IdentPrint.printStrId strId)
                     ^" does not exist.");(Env.empty_env,Env.empty_env)))
               
               


      (* *** rule 74 *** *)

	  | check_spec (Absyn.EXCEPTIONspec exdesclist,basis) =
	    let
	      val ve = check_exdesc(exdesclist,Basis.basis_to_context basis)
	      val new_env = Env.VE_in_env ve
	    in
	      (new_env, new_env)
	    end

      (* *** rule 75 *** *)

	  | check_spec (Absyn.STRUCTUREspec strdesclist,basis) =
	    let
	      val new_env = Env.SE_in_env(check_strdesc (strdesclist,basis))
	    in
	      (new_env, new_env)
	    end

      (* *** rule 76 *** *)

	  | check_spec (Absyn.SHARINGspec (spec,shareqlist),basis) =
	    let
	      val (env,exp_env) = check_spec (spec,basis)
              val new_basis = Basis.basis_plus_env (basis,env)
              val _ = check_shareq (shareqlist,exp_env,basis,new_basis)
	    in
              (env,exp_env)
	    end

  (* Note: the above check_shareq clause takes both bases because it
     has to account for the different conception of sharing between the two
     definitions.  In the old definition, a sharing constraint was simply
     another spec, sequentially composed after the specs that were being
     shared.  Hence the basis would be updated by the first spec before
     the sharing was elaborated.  In the new definition, the sharing
     constraint is a spec *modifier*, and so the basis is not updated
     until after the spec (and then elsewhere).   This makes a difference
     because type names in the new definition can only be shared if they
     don't already occur in the basis.  See sec G.3 of revised defn.
     This fixes bug 1620. See the function check_shareq. *)



      (* *** rule 77 *** *)

	  | check_spec (Absyn.LOCALspec (spec1,spec2),basis) =
	    let
	      val (new_result, _) = check_spec (spec1,basis)
	    in
	      check_spec (spec2,Basis.basis_plus_env (basis, new_result))
	    end

      (* *** rule 78 *** *)


	  | check_spec (Absyn.OPENspec(longstridlist,location),basis) =
	    let
	      fun do_one (env,longstrid) =
		let
		  val newenv =
		    get_env_or_crash
		    ("resolve_top_level",
		     Env.resolve_top_level(Basis.lookup_longstrid (longstrid, basis)))
		in
		  Env.env_plus_env (env,newenv)
		end
	      handle Basis.LookupStrId strid =>
		(report_error
		 (Info.RECOVERABLE, location,
		  IdentPrint.strid_unbound_strid_message(strid, longstrid, print_options));
		 env)
	      val new_env = Lists.reducel do_one (Env.empty_env,longstridlist)
	    in
	      (* Fix here for NJ weird open *)
	      (if nj_signatures then Env.empty_env else new_env, new_env)
	    end

      (* *** rule 79 *** *)

	  | check_spec (Absyn.INCLUDEspec (sigexp,location),basis) =
	    let
	      fun new_instances (STR (strname, mlvalue, ENV (strenv, tyenv, VE (n,map)))) =
		let
		  fun new_instance (SCHEME (n, (ty, SOME (sch,_)))) =
		    SCHEME (n, (ty, SOME (sch, ref NONE)))
		    | new_instance (UNBOUND_SCHEME (ty,SOME (sch,_))) =
		      UNBOUND_SCHEME (ty, SOME (sch, ref NONE))
		    | new_instance scheme = scheme
		in
		  STR(strname, mlvalue, ENV (strenv, tyenv,
					     VE (n, NewMap.map (fn (_,tysch) => new_instance tysch) map)))
		end
		| new_instances (COPYSTR((strmap,tynmap),str)) =
		  COPYSTR((strmap,tynmap),new_instances str)

	      fun do_one sigexp =
		let
		  val (BasisTypes.SIGMA (names,str),_) = 
                         check_sigexp_closed (sigexp, basis, location)
		  val str = new_instances str
		  val (_,new_strnames,new_tynames) =
		    Nameset.new_names_from_scratch names
                                       (Basis.basis_level basis)
		  val str' =
		    Env.resolve_top_level (COPYSTR((new_strnames,new_tynames),
                                                   str))
		  val env1 = get_env_or_crash ("resolve_top_level",str')
		  val (m,exp_env) = get_name_and_env("expand_str",
						     Env.expand_str str')
		  val (sigstr_ass',sigty_ass') = 
                                 Assemblies.newAssemblies (m,exp_env)
		in
		  sigstr_ass := Assemblies.unionStrAssembly
                                                 (!sigstr_ass,sigstr_ass');
		  sigty_ass := Assemblies.unionTypeAssembly
                                                 (!sigty_ass,sigty_ass');
		  env1
		end
	      val new_env = do_one sigexp
	    in
	      (new_env, new_env)
	    end


      (* *** rules 80 and 81 *** *)

	  | check_spec (Absyn.SEQUENCEspec [],basis) =
	    (Env.empty_env, Env.empty_env)

	  | check_spec (Absyn.SEQUENCEspec speclist,basis) =
	    let
	      fun do_one ((result, env, basis),spec) =
		let
		  val (result', env') = check_spec(spec,basis)
		  val new_result = Env.env_plus_env(result, result')
		  (* What we'll return *)
		  val new_basis = Basis.basis_plus_env(basis, env')
		  (* What we carry on elaborating in *)
		  val new_env = Env.env_plus_env(env, env')
		in
		  (new_result, new_env, new_basis)
		end
	      val (new_result, new_env, _) =
		Lists.reducel do_one ((Env.empty_env, Env.empty_env, basis), speclist)
	    in
	      (new_result, new_env)
	    end

	(* *** Value Descriptions *** *)

	(* *** rule 82 *** *)

	and check_valdesc (l,context,location) =
	  let
	    fun do_one ((ve,context),(valid,ty,tyvarset)) =
	      let
		val tyvars_scoped_here = Set.setdiff (tyvarset,Basis.get_tyvarset context)
		val new_context = Basis.context_plus_tyvarset (context, tyvars_scoped_here)
		val atype = check_type (ty,new_context)
		val instance = NONE
		val ascheme = Scheme.make_scheme ([],(atype,instance))
	      in
                check_valid_ok (valid,location);
		(Valenv.add_to_ve (valid,ascheme,ve), new_context)
	      end
	    val (new_ve,_) = Lists.reducel do_one ((empty_valenv,context),l)
	  in
	    new_ve
	  end

    (* *** Type Descriptions *** *)

    (* *** rule 83 *** *)

	and check_typdesc (l,context,eq) =
	  let
	    fun do_one (te,(tyvarlist,tycon)) =
	      let
		val tyfun =
		  Types.make_eta_tyfun
		  (METATYNAME (ref (NULL_TYFUN(Types.make_stamp(),(ref(TYFUN(NULLTYPE,0))))),
			       IdentPrint.printTyCon tycon,
			       length tyvarlist,
			       ref eq,
			       ref empty_valenv,
			       ref false))
	      in
		Tyenv.add_to_te (te,tycon,TYSTR (tyfun,empty_valenv))
	      end

	  in
	    Lists.reducel do_one (Tyenv.empty_tyenv,l)
	  end

    (* *** Datatype Descriptions *** *)

    (* *** rule 84 *** *)

	and check_datdesc ([],_,(ve,te)) = (ve,te)

	  | check_datdesc ((tyvarlist,tycon,condescs)::datdescs,
			   context,
			   (ve,te)) =
	    let
	      val new_context = Basis.context_plus_tyvarlist (context,tyvarlist)
	      val TYSTR (tyfun,_) = Basis.lookup_tycon (tycon,new_context)
		handle Basis.LookupTyCon tycon =>
		  Crash.impossible ("Unbound type constructor in check_datdesc "
				    ^ IdentPrint.printTyCon tycon)
	      val tyvartypes = (map (fn x => check_type (Absyn.TYVARty x,new_context)) tyvarlist)
	    in
	      check_datdesc (datdescs,new_context,
			     check_condesc (condescs,
					    tycon,
					    tyfun,
					    Types.apply (tyfun,tyvartypes),
					    tyvartypes,
					    new_context,
					    empty_valenv,
					    (ve,te)))
	    end

    (* *** rule 85 *** *)

	and check_condesc ([],tycon,tyfun,tycon_type,tyvartypes,
			   acontext,conenv,(ve,te)) =
	  (sigty_ass := Assemblies.add_to_TypeAssembly (tyfun,conenv,1,!sigty_ass);
	   let
	     val valenv_ref = case tycon_type of
	       CONSTYPE(_, METATYNAME{5=valenv_ref, ...}) => valenv_ref
	     | _ => Crash.impossible"bad tycon_type in signature"
	   in
	     (valenv_ref := conenv;
	      (ve,(Tyenv.add_to_te (te, tycon,TYSTR (tyfun,conenv)))))
	   end)

	  | check_condesc ((valid,NONE,location)::condescs,
			   tycon,tyfun,tycon_type,tyvartypes,
			   acontext,conenv,(ve,te)) =
	    let
	      val tyscheme =
		Scheme.make_scheme (tyvartypes,(tycon_type,NONE))
	      val new_ve = Valenv.add_to_ve (valid,tyscheme,ve)
	      val new_conenv = Valenv.add_to_ve (valid,tyscheme,conenv)
	    in
              check_valid_ok (valid,location);
	      check_condesc (condescs,tycon,tyfun,tycon_type,tyvartypes,
			     acontext,new_conenv,(new_ve,te))
	    end

	  | check_condesc ((valid,SOME aty,location)::condescs,
			   tycon,tyfun,tycon_type,tyvartypes,
			   acontext,conenv,(ve,te)) =
	    let
	      val atype = check_type (aty,acontext)
	      val tyscheme = Scheme.make_scheme
		(tyvartypes,(FUNTYPE (atype,tycon_type),NONE))
	      val new_ve = Valenv.add_to_ve (valid,tyscheme,ve)
	      val new_conenv = Valenv.add_to_ve (valid,tyscheme,conenv)
	    in
              check_valid_ok (valid,location);
	      check_condesc (condescs,tycon,tyfun,tycon_type,tyvartypes,
			     acontext,new_conenv,(new_ve,te))
	    end

    (* *** Exception Descriptions *** *)

    (* *** rule 86 *** *)

	and check_exdesc (exdescs,context) =
	  let
	    fun do_one (ve, (excon,NONE,location)) =
              (check_valid_ok (excon,location);
               Valenv.add_to_ve (excon,Scheme.make_scheme ([],(Types.exn_type,
                                                               NONE)),ve))
	      | do_one (ve, (excon,SOME aty,location)) =
		let
		  val atype =
		    if Absyn.has_tyvar (aty) then
		      (report_error
		       (Info.RECOVERABLE, location,
			concat ["Exception description of ",
				 IdentPrint.printValId print_options excon,
				 " contains a type variable"]);
		       fresh_tyvar (context, false, false))
		    else
		      check_type (aty,context)
		in
                  check_valid_ok (excon,location);
		  if Types.type_has_unbound_tyvars atype then
		    ve
		  else
		    Valenv.add_to_ve (excon,
				      Scheme.make_scheme([],(FUNTYPE (atype,Types.exn_type),
							     NONE)),
				      ve)
		end
	  in
	    Lists.reducel do_one (empty_valenv,exdescs)
	  end

    (* *** Structure Descriptions *** *)

    (* *** rule 87 *** *)

	and check_strdesc (strdescs, basis) =
	  let
	    fun do_one (se,(strid,sigexp)) =
	      let
		val (str,_) = check_sigexp_open (sigexp,basis)
	      in
		Strenv.add_to_se (strid,str,se)
	      end
	  in
	    Lists.reducel do_one (Strenv.empty_strenv,strdescs)
	  end

    (* *** Sharing Equations *** *)

    (* *** rule 88 *** *)

    (* The syntax does not allow sharing of fewer than two structures *)
    (* or two types. *)

	and check_shareq (l,env,basis,new_basis) =
	  let
	    fun do_one (Absyn.STRUCTUREshareq stridlist,location) =
              if old_definition then check_str_share (stridlist,new_basis,
                                                      location)
              else new_check_str_share (stridlist,basis,new_basis,location)
	      | do_one (Absyn.TYPEshareq tyconlist,location) =
		check_type_share (tyconlist,env,
                                  if old_definition then new_basis
                                    else basis,location)

                (* see comment on rule 76 *)

	  in
	    Lists.iterate do_one l
	  end





	and check_str_share (sharelist,
                             basis as BasisTypes.BASIS(_,nameset,_,_,env),
                             location) =
	  let
	    fun do_two ((lstrid,STR(m,_,_)),(lstrid',STR(m',_,_))) =
	      if circularp (m,m',!sigstr_ass)
		then
		  report_error
		  (Info.RECOVERABLE, location,
		   concat ["Sharing ",
                           IdentPrint.printLongStrId lstrid,
                           " and ",
                           IdentPrint.printLongStrId lstrid',
                           " creates a cycle"])
	      else
		(let
		   val (share_successful,sigstr_ass',sigty_ass') =
		     Share.share_str (m,m',!sigstr_ass,!sigty_ass,nameset)
		 in
		   if share_successful
		     then (sigstr_ass := sigstr_ass';
			   sigty_ass := sigty_ass')
		   else
		     () (* do we need to print a message here? *)
		 end
	       handle Share.ShareError s =>
		 report_error
		 (Info.RECOVERABLE, location,
		  concat ["Failed to share structures ",
			   IdentPrint.printLongStrId lstrid, " and ",
			   IdentPrint.printLongStrId lstrid', ":\n  ", s]))
              | do_two _ = ()

	    fun get_structure_name_from_str((smap, _), str as STR(m, r, e)) =
	      STR(Strnames.strname_copy(m, smap), r, e)
	      | get_structure_name_from_str(maps, COPYSTR(maps', str)) =
		get_structure_name_from_str(Env.compose_maps(maps', maps), str)

	    val get_structure_name_from_str =
	      fn (str as STR _) => str
	       | COPYSTR arg => get_structure_name_from_str arg

	    fun gather_strs ([],acc) = rev acc
	      | gather_strs (lstrid::l,acc) =
		(let
	       (* nice if env was expanded *)
(* This is unnecessary. All we want is the structure name
               val str = Env.expand_str (Env.lookup_longstrid (lstrid,env))
*)
	       val str = get_structure_name_from_str
                                  (Env.lookup_longstrid(lstrid, env))
		 in
		   gather_strs(l,(lstrid,str)::acc)
		 end
	       handle Env.LookupStrId strid =>
		 (report_error
		  (Info.RECOVERABLE, location,
		   IdentPrint.strid_unbound_strid_message
                                        (strid,lstrid,print_options));
		  gather_strs (l,acc)))

	    fun aux (s::(l as s'::_)) = (do_two (s,s');aux l)
	      | aux _ = ()
	  in
	    aux (gather_strs (sharelist,[]))
	  end

           (* note, in the following, we have to look the structure ids
              up in the new basis, and then do the type constructor
              sharing in the old basis. *)


	and new_check_str_share (sharelist,old_basis,new_basis,location) =
	  let
	    val BasisTypes.BASIS(_,old_basis_names,_,_,old_env) = old_basis
	    val BasisTypes.BASIS(_,new_basis_names,_,_,new_env) = new_basis
	    fun gather_strs ([],acc) = rev acc
	      | gather_strs (lstrid::l,acc) =
		(let
                  (* We only really need the type and structure 
                     parts expanded here.  Look up strid in new env *)
                  val str = Env.expand_str(Env.lookup_longstrid 
                                              (lstrid,new_env))
                in
                  gather_strs(l,(lstrid,str)::acc)
                end
                handle Env.LookupStrId strid =>
                  (report_error
                   (Info.RECOVERABLE, location,
                    IdentPrint.strid_unbound_strid_message
                                           (strid,lstrid,print_options));
                   gather_strs (l,acc)))
            fun print_path ([],acc) = concat acc
              | print_path (s::rest,acc) = 
                     print_path (rest,IdentPrint.printStrId s :: "." :: acc)

                     (* the following local references are used to
                      * compute the fixpoint of our sharing checker.
                      * It stores the list of tycons for which
                      * type sharing has failed.  However, since
                      * failures may be due to the fact that
                      * the tycons are built out of others which
                      * haven't yet been shared, we must keep them
                      * ready to try again.  When the fixpoint has
                      * been reached (i.e., !old_share_failures =
                      * !share_failures) then we have finished.
                      *)

            val old_share_failures = ref []
            val share_failures = ref []
            val failure_reasons = ref []

            fun share_tystr (strid1, strid2, path, tycon,TYSTR (tyfun,_),
                             TYSTR (tyfun',_)) =
	      let
                   (* check type names occur in old basis *)

		val (share_successful,sigty_ass') =
		  Sharetypes.share_tyfun (old_definition,tyfun, tyfun',
					  !sigty_ass, old_basis_names)
                   handle Sharetypes.ShareError s =>
                     (share_failures:= tycon::(!share_failures);
                      failure_reasons:= s::(!failure_reasons);
                      (false,!sigty_ass))
	      in
		if share_successful
		  then sigty_ass := sigty_ass'
		else
		  ();
                true
	      end

            fun share_tyenvs (strid,strid',path,TE tymap,TE tymap') =
              (old_share_failures:=[];
               let
                 fun findFixpoint () =
                   (share_failures:=[];
                    failure_reasons:=[];
                    let val answer = 
                      NewMap.forall
                      (fn (tycon,tystr) =>
                       case NewMap.tryApply'(tymap',tycon) of
                         SOME tystr' =>
                           share_tystr (strid,strid',path,tycon,tystr,tystr')
                       | _ => true)
                      tymap
                   in
                     if !old_share_failures = !share_failures
                       then (* finished *)
                         if !share_failures=[]
                           then answer
                         else 
                           let
                             fun makeE([],[]) = ""
                               | makeE([h1],[h2]) =
                                  (IdentPrint.printTyCon h1)^": "^h2^"}"
                               | makeE(h1::t1,h2::t2) =
                                  (IdentPrint.printTyCon h1)^": "^h2^"\n    "^
                                  (makeE(t1,t2))
                               | makeE _ = Crash.impossible "makeE"

                             fun makeErrorMesg() =
                               if Lists.length (!share_failures)=1
                                 then 
                                   "Failed to share type "^
                                   print_path(path,[])^
                                   IdentPrint.printTyCon 
                                         (Lists.hd(!share_failures))^
                                   " because "^(Lists.hd(!failure_reasons))
                               else
                                   "Failed to share types "^
                                   print_path(path,[])^"\n   {"^
                                   makeE(!share_failures,!failure_reasons)
                           in
                             (report_error
                              (Info.RECOVERABLE, location,
                               concat(
                               [makeErrorMesg(),
                                "\n in structures ", 
                                IdentPrint.printLongStrId strid, " and ", 
                                IdentPrint.printLongStrId strid', "."]));
                              false)
                           end
                     else (old_share_failures:= !share_failures;
                           findFixpoint ())
                   end)
               in
                 findFixpoint ()
               end)

            fun share_str (strid',
                           strid,
                           path,
                           STR (m,_,ENV (strenv,tyenv,_)),
                           STR (m',_,ENV (strenv',tyenv',_))) =
              share_strenvs (strid,strid',path,strenv,strenv') andalso
              share_tyenvs (strid,strid',path,tyenv,tyenv')
              | share_str _ =
                Crash.impossible "COPYSTR in share_str"
            and share_strenvs (strid1,strid2,path,SE strmap,SE strmap') =
              NewMap.forall 
              (fn (strid,str) =>
               case NewMap.tryApply'(strmap',strid) of
                 SOME str' => share_str (strid1,strid2,strid::path,str,str')
               | _ => true)
              strmap

            fun do_two ((lstrid,str),(lstrid',str')) =
              share_str (lstrid,lstrid',[],str,str')
            (* This is unpleasantly n squared *)
            (* A better way could be found no doubt *)
	    fun aux (s::rest) = 
              (Lists.iterate (fn s' => do_two (s,s')) rest;
               aux rest)
	      | aux [] = ()
	  in
	    aux (gather_strs (sharelist,[]))
	  end

    (* *** rule 89 *** *)

	and check_type_share (sharelist,env,basis,location) =
	  let
	    val BasisTypes.BASIS(_,basis_names,_,_,_) = basis

	    fun do_two ((ltycon,tyfun),(ltycon',tyfun')) =
	      let
		val (share_successful,sigty_ass') =
		  Sharetypes.share_tyfun (old_definition,tyfun, tyfun',
					  !sigty_ass, basis_names)
		  handle Sharetypes.ShareError s =>
		    (report_error
		     (Info.RECOVERABLE, location,
		      concat
		      ["Failed to share types ",
		       IdentPrint.printLongTyCon ltycon, " and ",
		       IdentPrint.printLongTyCon ltycon', ": ", s]);
		     (false,!sigty_ass))
	      in
		if share_successful
		  then sigty_ass := sigty_ass'
		else
		  ()
	      end

            val context =
              if old_definition then Basis.basis_to_context basis
              else Basis.env_to_context env
	    val (unbound_strid, unbound_tycon) =
	      if old_definition then
		(IdentPrint.tycon_unbound_strid_message,
		 IdentPrint.unbound_longtycon_message)
	      else
		(IdentPrint.tycon_unbound_flex_strid_message,
		 IdentPrint.unbound_flex_longtycon_message)
	    fun gather_tyfuns ([],acc) = rev acc
	      | gather_tyfuns (ltycon::l,acc) =
		(let
		   val TYSTR (tyfun,_) =
		     Basis.lookup_longtycon (ltycon,context)
		 in
		   gather_tyfuns(l,(ltycon,tyfun)::acc)
		 end
		   handle Basis.LookupTyCon tycon =>
		     (report_error
		      (Info.RECOVERABLE, location,
		       unbound_tycon(tycon,ltycon));
		      gather_tyfuns (l,acc))
			| Basis.LookupStrId strid =>
			    (report_error
			     (Info.RECOVERABLE, location,
			      unbound_strid(strid,ltycon));
			     gather_tyfuns (l,acc)))


	    fun aux (s::(l as s'::_)) = (do_two (s,s');aux l)
	      | aux _ = ()
	  in
	    aux (gather_tyfuns (sharelist,[]))
	  end

    (* *** rule 90 *** *)

    (* *** Functor Declarations *** *)
    (* *** rules 96, 97 and 98 are parsed away *** *)

    (* *** Functor Bindings *** *)
    (* *** rule 99 *** *)

      fun check_funbind (Absyn.FUNBIND [],basis,funenv, _) = funenv

	| check_funbind (Absyn.FUNBIND
			 ((funid,strid,sigexp,strexp,NONE,_,
			   coerce_ref,location,_,debugger_str):: funbinds),
			 basis as BasisTypes.BASIS (_,nameset,_,_,_),funenv,
			 ass as (str_ass, ty_ass))=
	  let
	    val _ = sigstr_ass := str_ass
	    val _ = sigty_ass := ty_ass
	    val (BasisTypes.SIGMA (names,str),BasisTypes.SIGMA (_,exp_str)) =
	      (check_sigexp_closed (sigexp,basis,location))
	      handle WellFormed sigma =>
		(report_error
		 (Info.RECOVERABLE, location,
		  "Argument signature is not well-formed");
		 (sigma,sigma))
		   | TypeExplicit sigma =>
		       (report_error
			(Info.RECOVERABLE, location,
			 "Argument signature is not type-explicit");
			(sigma,sigma))
		   | RespectEquality sigma =>
		       (report_error
			(Info.RECOVERABLE, location,
			 "Argument signature does not respect equality");
			(sigma,sigma))
	    val _ = sigstr_ass := empty_str_ass
	    val _ = sigty_ass := empty_ty_ass
	    val new_basis =
	      Basis.basis_plus_names
	      (Basis.basis_plus_env (basis,
				     ENV (Strenv.add_to_se
					  (strid,exp_str,Strenv.empty_strenv),
					  Tyenv.empty_tyenv,
					  empty_valenv)),
	       names)
	    val (str',exp_str') = check_strexp (strexp,new_basis)
	    val names' =
	      Nameset.diff (Sigma.names_of exp_str',
			    Nameset.union (nameset,names))
	    val phi = BasisTypes.PHI (names,(str,
                                             BasisTypes.SIGMA (names',str')))
            val _ =
              case debugger_str of
                SOME(debugger_str) =>
                  debugger_str := SOME(exp_str)
              | _ => ()
	  in
            (let
	       val env' = get_env_or_crash ("exp_str'",exp_str')
	     in
               if Info.< (Info.NONSTANDARD, Info.worst_error (error_info))
                 then ()
               else
                 case Env.no_imptyvars env' of
                   NONE => ()
                 | SOME(ty, atype) =>
                     let
                       val loc = Absyn.check_strexp_for_free_imp(strexp, ty)
                       val location= case loc of
                         NONE =>
			   location
                       | SOME loc => loc
		       val atype_string = Types.print_type options atype
		       val ty_string = Types.print_type options ty
                     in
                       report_error(Info.RECOVERABLE, location,
                                    "Free type variable " ^ ty_string ^ 
                                    " in " ^ ty_string ^ " in functor body")
                     end
	     end;
	   Basis.add_to_funenv (funid,BasisTypes.PHI 
                                (names,(str,
                                        BasisTypes.SIGMA(names',str'))),
				check_funbind (Absyn.FUNBIND funbinds,basis,
					       funenv, ass)))
	  end

	| check_funbind (Absyn.FUNBIND ((funid,strid,sigexp,strexp,
					 SOME (sigexp',abs),_,
					 coerce_ref,location,debugger_str,
                                         debugger_str') :: funbinds),
			 basis as BasisTypes.BASIS (_,nameset,_,_,_),funenv,
			 ass as (str_ass, ty_ass))=
	  let
            val _ =
                if generate_moduler_debug then
                  print("\n FUNBIND " ^ Ident.Location.to_string location)
                else ()
	    val _ = sigstr_ass := str_ass
	    val _ = sigty_ass := ty_ass
	    val (sigma as BasisTypes.SIGMA (names,str),
                          BasisTypes.SIGMA (_,exp_str)) =
	      (check_sigexp_closed (sigexp,basis,location))
	       handle WellFormed sigma =>
		 (report_error
		  (Info.RECOVERABLE, location,
		   "Argument signature is not well-formed");
		  (sigma,sigma))
		    | TypeExplicit sigma =>
			(report_error
			 (Info.RECOVERABLE, location,
			  "Argument signature is not type-explicit");
			 (sigma,sigma))
		    | RespectEquality sigma =>
			(report_error
			 (Info.RECOVERABLE, location,
			  "Argument signature does not respect equality");
			 (sigma,sigma))
	
	    val new_basis =
              Basis.basis_plus_names
			  (Basis.basis_plus_env (basis,
						 ENV(Strenv.add_to_se
						     (strid,exp_str,
						      Strenv.empty_strenv),
						     Tyenv.empty_tyenv,
						     empty_valenv)),
			  names)

	    (* Check result structure *)
	    val (str',exp_str') = check_strexp(strexp,new_basis)

	    (* Check result signature *)
	    (* This fails, don't try sigmatch *)
	    val (sigma',_) =
	      error_wrap
	      error_info
	      (fn options =>
	       fn (sigexp,basis,location) =>
	       let
		 val ans =
                   (check_sigexp_closed (sigexp',new_basis,location))
			   handle WellFormed sigma =>
			     (report_error
			      (Info.RECOVERABLE, location,
			       "Constraining signature is not well-formed");
			      (sigma,sigma))
				| TypeExplicit sigma =>
				    (report_error
				     (Info.RECOVERABLE, location,
				      "Constraining signature is not type-explicit");
				     (sigma,sigma))
				| RespectEquality sigma =>
				    (report_error
				     (Info.RECOVERABLE, location,
				      "Constraining signature does not respect equality");
				     (sigma,sigma))
		 val _ = sigstr_ass := empty_str_ass
		 val _ = sigty_ass := empty_ty_ass
	       in
		 ans
	       end
	      )
	      (sigexp,basis,location)


	    val sigma'' as BasisTypes.SIGMA (names'',str'') = 
                            Sigma.sig_copy (sigma',is_separate) 
                                           (Basis.basis_level new_basis)

	    val exp_str'' = Env.expand_str str'' (* necessary *)
	    val completion_env = make_completion_env (new_basis,exp_str'',
                                                      exp_str')
	    val (realise, do_coerce, debugger_str'') =
              sigmatch (location,completion_env,
                        Basis.context_level (Basis.basis_to_context basis),
                        BasisTypes.SIGMA(names'',exp_str''),
                        exp_str')
            val _ =
              case (debugger_str,debugger_str') of
                (SOME(debugger_str),
                 SOME(debugger_str')) =>
                  (debugger_str := debugger_str'';
                   debugger_str' := SOME(exp_str))
              | _ => ()
            val _ =
              if realise then ()
              else
                report_error
                (Info.RECOVERABLE, location,
                 concat ["Functor body ", IdentPrint.printFunId funid,
                          " does not match result signature"])
            val names' =
              Nameset.diff (Sigma.names_of exp_str'',
                            Nameset.union (nameset,names))
            val phi = BasisTypes.PHI(names,(str,BasisTypes.SIGMA (names',str'')))
          in
            if do_coerce then coerce_ref := true else ();
              set_intref (sigexp',str'');
              Basis.add_to_funenv
              (funid,BasisTypes.PHI (names,(str,
                                            BasisTypes.SIGMA(names',str''))),
               check_funbind (Absyn.FUNBIND funbinds,
                              basis,funenv, ass))
          end

      fun check_sigdec ([],basis, sigenv, _) = sigenv

	| check_sigdec (sigbind::sigbindlist, basis, sigenv, ass) =
	  let
	    val new_sigenv = check_sigbind (sigbind,basis,sigenv, ass)
	    val new_basis = Basis.basis_plus_sigenv (basis,new_sigenv)
	  in
	    check_sigdec(sigbindlist, new_basis,
			 Basis.sigenv_plus_sigenv (new_sigenv, sigenv), ass)
	  end
	
      fun check_fundec([],basis, funenv, _) = funenv
	| check_fundec(funbind::funbindlist, basis, funenv, ass) =
	  let
	    val new_funenv = check_funbind(funbind,basis,funenv, ass)
	    val new_basis = Basis.basis_plus_funenv (basis,new_funenv)
	  in
	    check_fundec (funbindlist,new_basis,
			  Basis.funenv_plus_funenv (new_funenv, funenv), ass)
	  end

      (* *** rule 100 *** *)

      fun check_topdec (Absyn.STRDECtopdec (strdec,location),basis as BasisTypes.BASIS (_,nameset,_,_,_)) =
	let
	  val new_env = check_strdec (strdec,basis)
          val exp_new_env = Env.expand_env new_env (* Be nice not to have to expand this *)
          val final_env = if is_separate then exp_new_env else new_env
	  val basis_inc = Basis.env_in_basis final_env (* HACK for encapsulator here *)
	in
          (* This expands out any COPYSTRs *)
          case (Env.no_imptyvars exp_new_env) of (* get something expanded from check_strdec? *)
	    NONE =>
              (* So does names_of -- so use an expanded environment *)
	      Basis.basis_plus_names(basis_inc, Sigma.names_of_env exp_new_env)
	  | SOME(ty, atype) =>
	      (if Info.< (Info.NONSTANDARD, Info.worst_error (error_info))
                 then ()
               else
                 let
                   val loc = Absyn.check_strdec_for_free_imp(strdec, ty)
                   val location= case loc of
                     NONE =>
		       location
                   | SOME loc => loc
		   val atype_string = Types.print_type options atype
		   val ty_string = Types.print_type options ty
                 in
		   if old_definition then
                     report_error
                       (Info.RECOVERABLE, location,
                        "Free imperative type variable " ^ ty_string ^ " in " ^ atype_string ^ " at top level")
		   else
                     report_error
                       (Info.RECOVERABLE, location,
                        "Free type variable " ^ ty_string ^ " in " ^ atype_string ^ " at top level")
                 end;
              basis)
	end

	(* *** rule 101 *** *)

	| check_topdec (Absyn.SIGNATUREtopdec (sigbindlist, _), basis) =
	  let
	    val ass = case assembly of
	      ASSEMBLY assembly => assembly
	    | BASIS b => Assemblies.new_assemblies_from_basis b
	
	    val new_sigenv =
	      check_sigdec (sigbindlist,basis, Basis.empty_sigenv, ass)
	  in
            (sigstr_ass := Assemblies.empty_strassembly();
	    sigty_ass := Assemblies.empty_tyassembly;
	    (* Avoid hanging on to large unnecessary data structures *)

	    (* It is not necessary to check for the presence of free imperative
            type variables because they have all been caught by previous
	    checks. According to Mads Tofte the side condition in rule 101
	    is there for cosmetic reasons only. *)

	    Basis.sigenv_in_basis new_sigenv)
	  end

	(* *** rule 102 *** *)

	| check_topdec (Absyn.FUNCTORtopdec (funbindlist,location),basis) =
	  let
	    val ass = case assembly of
	      ASSEMBLY assembly => assembly
	    | BASIS b => Assemblies.new_assemblies_from_basis b
	    val new_funenv = check_fundec(funbindlist,basis, Basis.empty_funenv, ass)
	  in
	    Basis.funenv_in_basis new_funenv
	  end
	| check_topdec (Absyn.REQUIREtopdec (s, _),basis) = basis

      in
(*
      TypeDebugger.print_vartypes
      print_options
      (TypeDebugger.gather_vartypes topdec);
*)
	check_topdec (topdec,basis)
      end
  end
