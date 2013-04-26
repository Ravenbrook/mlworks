(*
$Log: _realise.sml,v $
Revision 1.61  1996/10/29 13:50:31  io
[Bug #1614]
basifying String

 * Revision 1.60  1996/10/25  12:35:45  jont
 * Fix problem with compiler looping
 *
 * Revision 1.59  1996/06/04  11:45:53  jont
 * Remove the esoteric type sharing violation 2 message
 *
 * Revision 1.58  1996/05/24  11:51:32  matthew
 * Attempting to fix problem with where type
 *
 * Revision 1.57  1996/04/30  15:58:30  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.56  1996/03/28  10:17:19  matthew
 * Language revisions
 *
 * Revision 1.55  1995/12/27  11:50:25  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.54  1995/09/06  13:02:28  jont
Improved error reporting for missing values, types, substructures
during signature matching

Revision 1.53  1995/06/15  10:30:15  jont
Only report constructors different when the domains differ

Revision 1.52  1995/06/01  12:04:18  matthew
Fixing silent error for inconsistent valenvs

Revision 1.51  1995/04/28  16:36:48  daveb
Fixed bug in tystr_realise - it was testing for equality before
checking that the tyfun was in the nameset, which led to an error
message about equality instead of type sharing.

Revision 1.50  1995/03/24  15:17:27  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.49  1995/02/06  11:50:24  matthew
Rationalizations

Revision 1.48  1995/01/30  11:50:03  matthew
Rationalizing debugger

Revision 1.47  1994/10/13  11:01:14  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.46  1994/05/04  16:05:39  jont
Fix make_eta_tyfun to preserve arity

Revision 1.45  1994/04/13  13:47:27  jont
Remove Bind handler

Revision 1.44  1994/02/28  09:00:38  nosa
Debugger structures for Modules Debugger.

Revision 1.43  1994/01/05  15:03:06  matthew
Greater care over the set of free names -- ensure functor parameters
don't get overwritten.
Check freeness of tynames before overwriting also

Revision 1.42  1993/12/02  17:31:39  nickh
Fixup some error messages and inexhaustive bindings.

Revision 1.41  1993/12/01  13:58:23  nickh
Marked certain error messages as "impossible".

Revision 1.40  1993/11/30  11:44:55  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.39  1993/09/22  13:06:46  nosa
Signature and structure instances linking for polymorphic debugger.

Revision 1.38  1993/07/30  14:44:14  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger;
new compiler option debug_variables.

Revision 1.37  1993/07/07  15:24:41  daveb
Removed exception environments.
ve_ran_enriches now checks that the constructor status of valids matches
appropriately.  It returns a bool to indicate when _lambda has to coerce
exceptions to values.

Revision 1.36  1993/04/01  16:55:51  jont
Allowed overloadin on strings to be controlled by an option

Revision 1.35  1993/03/17  18:55:26  matthew
Nameset signature changes

Revision 1.34  1993/03/10  14:45:10  matthew
Options changes

Revision 1.33  1993/03/04  11:53:27  matthew
Options & Info changes

Revision 1.32  1993/02/23  12:04:16  matthew
More on maximising number of errors reported in one go

Revision 1.31  1993/02/22  10:34:06  matthew
 Moved all realise and enrich code here from various places.
Fixed error reporting so it tries to report more than one
error at once.

Revision 1.30  1993/02/08  19:09:57  matthew
Changes for BASISTYPES signature

Revision 1.29  1993/02/01  14:58:09  matthew
COPYSTR changes
Changes to error messages.

Revision 1.28  1993/01/06  12:34:58  jont
Anel's last changes

Revision 1.27  1992/12/18  16:13:24  matthew
Propagating options to signature matching error messages.

Revision 1.26  1992/12/07  11:23:11  matthew
Changed error messages.

Revision 1.25  1992/12/04  20:07:36  matthew
Error message revisions.

Revision 1.24  1992/12/03  13:33:13  jont
Replaced some NewMap.fold calls with NewMap.forall

Revision 1.23  1992/11/26  19:53:33  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.22  1992/11/25  16:56:22  jont
Minor improvements to str_realise to strip the first strname before matching

Revision 1.21  1992/11/25  12:59:57  matthew
Really changed the error messages this time.

Revision 1.20  1992/11/23  12:22:19  matthew
Improved error messages.

Revision 1.19  1992/11/23  12:22:19  jont
Small improvements in tystr_realise

Revision 1.18  1992/10/12  11:32:13  clive
Tynames now have a slot recording their definition point

Revision 1.17  1992/09/08  13:44:16  jont
Modified the realisation of tynames

Revision 1.16  1992/08/27  14:59:35  davidt
Added Anel's changes.

Revision 1.15  1992/08/18  15:55:14  jont
Removed irrelevant handlers and new exceptions

Revision 1.14  1992/08/12  11:15:08  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.13  1992/08/11  11:24:17  matthew
removed type_eq_matters

Revision 1.12  1992/08/10  17:05:46  jont
Fix for equality type problem

Revision 1.11  1992/08/04  13:27:03  jont
Anel's changes to use NewMap instead of Map

Revision 1.10  1992/05/05  14:09:27  jont
Anel's fixes.

Revision 1.9  1992/04/27  11:43:28  jont
Added extra parameter to indicate when equality attributes of
types matter.

Revision 1.8  1992/03/16  11:30:35  jont
Added require "ty_debug"

Revision 1.7  1992/02/03  12:08:27  jont
Added type name to an error message

Revision 1.6  1992/01/27  20:14:29  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.5  1992/01/24  16:56:50  jont
Updated to allow valenv in METATYNAME

Revision 1.4  1991/11/19  19:12:06  jont
Fixed inexhaustive matches

Revision 1.3  91/07/16  17:21:20  colin
Modified tystr_realise to use Valenv.ve_domain to extract domain of valenvs

Revision 1.2  91/06/17  18:55:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing circular data structures.

Revision 1.1  91/06/07  11:37:16  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/print";
require "../utils/crash";
require "../utils/lists";
require "../main/info";
require "../basics/identprint";
require "strnames";
require "types";
require "tyenv";
require "strenv";
require "environment";
require "sigma";
require "scheme";
require "valenv";
require "nameset";
require "realise";

functor Realise (
  include
  sig               
  structure Print     : PRINT
  structure Crash     : CRASH
  structure Lists     : LISTS
  structure IdentPrint : IDENTPRINT
  structure Strnames  : STRNAMES
  structure Types     : TYPES
  structure Tyenv     : TYENV
  structure Strenv    : STRENV
  structure Env       : ENVIRONMENT
  structure Sigma     : SIGMA
  structure Scheme    : SCHEME
  structure Valenv    : VALENV
  structure Nameset   : NAMESET
  structure Info      : INFO
  sharing Sigma.Options = Nameset.Options = IdentPrint.Options = Scheme.Options

  sharing Sigma.BasisTypes.Datatypes = Strnames.Datatypes
    = Types.Datatypes = Tyenv.Datatypes = Env.Datatypes = Scheme.Datatypes
    = Strenv.Datatypes = Valenv.Datatypes = Nameset.Datatypes
  sharing Types.Datatypes.Ident = IdentPrint.Ident
  sharing type Sigma.BasisTypes.Nameset = Nameset.Nameset
  end  where type Types.Datatypes.Stamp = int
    ) : REALISE =
  

  struct
    structure BasisTypes = Sigma.BasisTypes
    structure Info = Info
    structure Options = Scheme.Options
    structure Datatypes = BasisTypes.Datatypes

    open Datatypes

    fun string_strids strids =
      concat (map (fn s => IdentPrint.printStrId s ^ ".")(rev strids))

    fun string_strids' [] = ""
      | string_strids' (a::b) = string_strids b ^ IdentPrint.printStrId a

    (* eager andalso *)
    fun aswell (x,y) = x andalso y
          
    (* Don't use NewMap.forall this stops evaluating as soon as false is returned *)
    fun eforall pred map =
      NewMap.fold (fn (b,x,y) => aswell (pred(x,y),b)) (true,map)

    val dummy_tf = ~3
    val generate_moduler_debug = false

    fun get_name_and_env (_,STR(m,_,e)) = (m,e)
      | get_name_and_env (error,_) = Crash.impossible error
      
    fun sigmatch
      (error_info,
       options as Options.OPTIONS{print_options,
                                  compiler_options = Options.COMPILEROPTIONS{generate_moduler, ...}, ...})
      (location,completion_env,level,sigma as BasisTypes.SIGMA (names,str),str') =

      let
(*
        val _ = output (std_out, "Sigmatch:\n")
        val _ = output (std_out,Env.string_str str')
        val _ = output (std_out,Sigma.string_sigma Options.default_print_options sigma)
*)

        val nameset_ref = ref (Nameset.simple_copy names)

        fun remove_strname strname =
          nameset_ref := Nameset.remove_strname (strname,!nameset_ref)

        fun remove_tyname tyname =
          nameset_ref := Nameset.remove_tyname (tyname,!nameset_ref)

        fun error message_list =
          Info.error error_info (Info.RECOVERABLE,location,concat message_list)

        (* Realisation is managed by references in tynames and strnames.  
         In order to do this all type names and structure names generated
         during signature elaboration are flexible, containing
         uninstantiated references to type functions and structure names,
         respectively.  These references are destructively modified
         during realisation.  Because a single signature may have many
         structures as instances a copy is made of a signature before it
         is matched against a structure.  This is done in the function from 
         where Realise.sigmatch is called. *)

        (****
         The domain of amap is a subset of the domain of amap' and for every 
         element in the domain of amap the scheme corresponding to it in amap'
         must generalise the scheme corresponding to it in amap, and if valid
	 is a constructor in amap than it must be a constructor in amap'.
         ****)
          
        fun ve_ran_enriches(level,ve as VE (_,amap),ve' as VE (_,amap'), strids) =
          let
            fun ran_enriches(valid, scheme) =
              let
	        (* Use polymorphic equality, so that constructor status is compared. *)
                (* This might not work -- MLA *)
                (* Look it up *)
		val (entry, need_coerce) =
		  case NewMap.tryApply'Eq(amap', valid) of
		    NONE =>
		      (* Second chance if we're dealing with a valspec.
                       It can be matched by a constructor in the structure. *)
		      (case valid of
			 IdentPrint.Ident.VAR _ =>
			   (NewMap.tryApply' (amap', valid), true)
		       | _ => (NONE, false))
		  | entry => (entry, false)

                (* link signature and structure instances of identifiers;
                   compute integer-instance to be eventually passed round at runtime 
                   for the polymorphic debugger *)

                fun fetch_instance1 (SCHEME(_,(_,SOME(instance,_)))) = 
                    SOME instance
                  | fetch_instance1 (UNBOUND_SCHEME(_,SOME(instance,_))) = 
                    SOME instance
                  | fetch_instance1 _ = NONE

                fun fetch_instance2 (SCHEME(_,(_,SOME(_,instance')))) = 
                    SOME instance'
                  | fetch_instance2 (UNBOUND_SCHEME(_,SOME(_,instance'))) = 
                    SOME instance'
                  | fetch_instance2 _ = NONE

                fun make_instance_info (NO_INSTANCE) = ZERO
                  | make_instance_info (INSTANCE(instances)) = ONE (length instances)
                  | make_instance_info _ = Crash.impossible "make_instance_info:instantiate:realise"

              in
                case entry of
                  SOME scheme' => 
                    (* We have found a scheme *)
                    let
                      val scheme_generalises = 
                        (Scheme.scheme_generalises options (valid,completion_env,level,scheme,scheme')
                         handle Scheme.EnrichError s => (error [s];false),
                         need_coerce)

                      val instance_index = 
                        case fetch_instance1 scheme' of
                          SOME (ref (INSTANCE ((ref(_,_,instances))::_))) => 
                            (case instances of
                               INSTANCE (instances) => SOME (length instances)
                             | _ => NONE)
                        | _ => NONE
                      val _ =
                        case (fetch_instance2 scheme, fetch_instance2 scheme') of
                          (SOME instance, SOME instance') => 
                            (* Side effect the second instance ref in the signature scheme *)
                            (* The idea seems to be that this tells how to get to the actual structure *)
                            (* despite the signature constraint *)
                            instance :=  
                            (case !instance' of 
                               NONE =>
                                 (case fetch_instance1 scheme' of
                                    SOME (ref (INSTANCE ((ref (_,_,instances))::_))) => 
                                      (* Make a SIGNATURE_INSTANCE *)
                                      SOME (ref (SIGNATURE_INSTANCE (make_instance_info instances)))
                                  | SOME (ref(NO_INSTANCE)) =>  
                                      SOME (ref (NO_INSTANCE))
                                  | _ => 
                                      Crash.impossible "1:instance:ran_enriches:realise")
                             | SOME (ref (instance' as SIGNATURE_INSTANCE _)) => 
                                 SOME (ref instance')
                             | SOME (ref NO_INSTANCE) =>  
                                 SOME (ref NO_INSTANCE)
                             | _ => 
                                 Crash.impossible "2:instance:ran_enriches:realise")
                        | _ => ()
                    in
                      (scheme_generalises, instance_index)
                    end
                | NONE =>
                    (error [case valid of
			      IdentPrint.Ident.EXCON _ => "Missing exception "
			    | _ => "Missing value ",
                            IdentPrint.printValId print_options valid,
                            " in structure ",
			    string_strids' strids];
                     ((false, false), NONE))
              end

	    fun accumulator ((res,coerce,debugger_str), valid, scheme) =
	      let val ((res', coerce'), instance) = ran_enriches (valid, scheme)
	      in (res andalso res',
		  coerce orelse coerce',
                  NewMap.define(debugger_str,valid,instance))
	      end
          in
	    NewMap.fold accumulator ((true, false, NewMap.empty (Ident.valid_lt, Ident.valid_eq)), amap)
          end
        
        exception TyfunError
        exception TypeDiffer

        (****
         Enrichment test for type structures.  See p. 34 of The Definition.
         ****)

        fun tystr_enriches (tycon,TYSTR (tyfun,conenv),TYSTR (tyfun',conenv')) = 
          if Types.tyfun_eq (tyfun,tyfun') 
            then
              if Valenv.empty_valenvp conenv orelse Valenv.valenv_eq(conenv,conenv') 
                then true
              else
		(if Valenv.dom_valenv_eq(conenv,conenv') then
		   () (* Don't report this error if domains the same *)
		 else
		   let
		     fun string_conenv (VE (_,amap)) =
		       let 
			 fun print_spaces (res, n) =
			   if n = 0 then concat(" " :: res)
			   else print_spaces (" " :: res, n-1)
		       in
			 NewMap.string (IdentPrint.printValId print_options) (fn _ => "")
			 {start = "", domSep = "", itemSep = ", ", finish = ""}
			 (NewMap.map (fn (id,sch)=>sch) amap)
		       end
		   in
		     error ["Type ", IdentPrint.printTyCon tycon,  " has different constructors in structure and signature:\n",
			    "  Structure: ", string_conenv conenv', "\n",
			    "  Signature: ", string_conenv conenv]
		   end;
		   false)
          else raise TyfunError

        (****
         Enrichment test for type environments.
         ****)
       
        fun te_ran_enriches(TE amap,TE amap', strids) =
          let 
            fun ran_enriches(tycon,tystr) =
              (let
                val tystr' = NewMap.apply'(amap', tycon)
              in
                (tystr_enriches (tycon,tystr,tystr'))
                handle TypeDiffer => false
              end
              (* these may happen if realisation has failed, so just return false *)
              handle NewMap.Undefined => false (* Crash.impossible "Missing type in enrich" *)
                   | TyfunError => false (* Crash.impossible "Type clash in enrich" *))
                       
          in
            eforall ran_enriches amap
          end
        
        (****
         Enrichment test for environments. (See p. 34 of The Definition)
         ****)

        fun env_enriches (level,
                          ENV (se as SE se_map,te,ve),
                          ENV (se' as SE se_map',te',ve'), 
                          DSTR(debugger_str1,debugger_str2,_),
			  strids) = 
	  let
	    val (res1, coerce1, debugger_str1) =
	      se_ran_enriches (level,se,se',debugger_str1, strids)
	    val res2 = te_ran_enriches (te,te', strids)
            val (res3, coerce3, debugger_str) =
	      ve_ran_enriches(level,ve,ve', strids)
	  in
	    (res1 andalso res2 andalso res3, coerce1 orelse coerce3,
             DSTR(debugger_str1,debugger_str2,debugger_str))
	  end
          | env_enriches _ = Crash.impossible "EMPTY_DSTR:env_enriches:realise"

        and str_enriches (level,str,str',debugger_str, strids) =
          let
            val (strname,env) = get_name_and_env ("str_enriches1",str)
	    val (strname',env') = get_name_and_env ("str_enriches2",str')
          in
            (* does this need an error message? *)
            if Strnames.strname_eq (strname,strname') then
              env_enriches (level,env,env',debugger_str, strids)
	    else
	      (false, false, debugger_str)
          end
        
        and se_ran_enriches (level,SE amap,SE amap',debugger_str, strids) = 
          let 
            fun ran_enriches(strid, str) =
              case (NewMap.tryApply'(amap', strid),
                    NewMap.tryApply'(debugger_str, strid)) of
                (SOME str',SOME debugger_str) => 
                  str_enriches (level,str,str',debugger_str, strid :: strids)
              (* this may happen if realisation has failed, so just return false *)
              | (_,_) => (false, false, Datatypes.EMPTY_DSTR)


            fun accumulator ((res,coerce,debugger_str), valid, scheme) =
              let val (res', coerce',debugger_str') = ran_enriches (valid, scheme)
              in (res andalso res',
                  coerce orelse coerce',
                  NewMap.define(debugger_str,valid,debugger_str'))
              end
          in
            NewMap.fold accumulator ((true, false, NewMap.empty (Ident.strid_lt, Ident.strid_eq)), amap)
          end
        
         (* Returns false if and only if the final case fails. This used
         to be raise TyfunEq *)

        fun make_eta_tyfun(tyfun as TYFUN(CONSTYPE(types, tyname), i)) =
          if Types.tyname_arity tyname = i andalso Types.check_debruijns(types, 0) 
            then ETA_TYFUN (tyname)
          else tyfun
          | make_eta_tyfun tyfun = tyfun

        fun tystr_realise (TYSTR (tyfun,ve as VE (_,amap)),
                           TYSTR (tyfun',ve' as VE (_,amap')),
                           tycon,
                           strids) =
        let
          fun fetch_nulltyfun(tyf as ref(NULL_TYFUN _)) = tyf
            | fetch_nulltyfun(ref(ETA_TYFUN(METATYNAME{1=tyfun, ...}))) =
              fetch_nulltyfun tyfun
            | fetch_nulltyfun _ = Crash.impossible "fetch_nulltyfun:realise"
          val tyfun = make_eta_tyfun tyfun
          val tyfun' = make_eta_tyfun tyfun'
        in
          (case Types.tyfun_eq (tyfun, tyfun') of
             true => (true,
                      if Types.null_tyfunp tyfun' then ~2
                      else
                        if generate_moduler then Types.update_tyfun_instantiations tyfun'
                        else 0)
           | false => 
          (if Types.null_tyfunp tyfun then
             let
               val tyname = Types.meta_tyname tyfun
               val (t, eq, name) = case tyname of
                 METATYNAME (t,name,_,ref eq, _, _) => (t, eq, name)
               | _ => Crash.impossible"bad Types.meta_tyname tyfun"
               (* record implementation of type function for debugger *)
               val (ntf,id) = 
		 let
		   val ntf = 
		     case fetch_nulltyfun(t) of
		       tf as ref(NULL_TYFUN(id,tyf)) => 
			 ((if generate_moduler then ()
			   else ()(*tyf := tyfun'*);
			     (* Above removed because it generates circular tyfuns *)
			     (* This is a bug in the debugger which needs fixing *)
			     if generate_moduler then Types.update_tyfun_instantiations tyfun'
			     else 0),id)
		     | _ => (dummy_tf, 0) (* Highly dubious!! *) (* Uses Stamp.Stamp = int sharing *)
		 in
		   ntf
		 end

             in
               if Nameset.member_of_tynames (tyname,!nameset_ref) then
                 if Types.arity tyfun = Types.arity tyfun' then
                   if (Types.equalityp tyfun' orelse not eq) then
                     (t := tyfun';
                      if Types.null_tyfunp tyfun' andalso
                        Nameset.member_of_tynames
			  (Types.meta_tyname tyfun',!nameset_ref)
                        then remove_tyname tyname
                      else ();
                        (true,ntf))
                   else
                     (error ["Type ",
                             string_strids strids,
                             IdentPrint.printTyCon tycon,
                             " in structure does not admit equality"];
                     t := tyfun';
                     (false,ntf))
                 else
                   (error ["Number of parameters of type constructor ",
                           string_strids strids,
                           IdentPrint.printTyCon tycon,
                           " differ in signature and structure"];
(*
		   output(std_out, "tyfun = " ^ Types.string_tyfun tyfun ^
			  "\ntyfun' = " ^ Types.string_tyfun tyfun' ^ "\n");
*)
		   t := tyfun';
                   (false,ntf))
               else
                 (error ["Type sharing violation for ",
                         string_strids strids,
                         IdentPrint.printTyCon tycon];
                  (false,ntf))
             end
           else
              (true,dummy_tf)))
        end
         
        and se_realise (SE amap,se',strids) =
          let
            fun strname_map(strid,str) =
              case Strenv.lookup (strid,se') of 
                SOME str' => str_realise(str,str',strid::strids)
              | _ => 
                  (error ["Missing substructure ",
                          IdentPrint.printStrId strid,
			  " in structure ",
                          string_strids' strids];
                   (false, Datatypes.EMPTY_DSTR))
            val strname_map = NewMap.map strname_map amap
            val debugger_str = NewMap.map (fn (_,(_,str))=>str) strname_map
          in
            (NewMap.fold (fn (b',_,(b,_)) => b' andalso b) (true,strname_map), debugger_str)
          end

        and te_realise (TE amap,te',strids) =
          let 
            fun tyname_map(tycon, sig_tystr) =
              let
                val str_tystr = Tyenv.lookup (te', tycon)
              in
                tystr_realise (sig_tystr,str_tystr, tycon,strids)
              end
            handle Tyenv.LookupTyCon _ =>
              (error ["Missing type constructor ",
                      IdentPrint.printTyCon tycon,
		      " in structure ",
                      string_strids' strids];
               (false,dummy_tf))
            val tyname_map = NewMap.map tyname_map amap
            val debugger_str = NewMap.map (fn (_,(_,n))=>n) tyname_map
          in
            (NewMap.fold (fn (b',_,(b,_)) => b' andalso b) (true,tyname_map), debugger_str)
          end

        and env_realise (ENV (se,te,_),ENV (se',te',_),strids) =
          let
            val (se_realise, debugger_str') = se_realise (se,se',strids)
            val (te_realise, debugger_str) = te_realise (te,te',strids)
          in
            (se_realise andalso te_realise,
             DSTR(debugger_str',debugger_str,
                NewMap.empty (Ident.valid_lt, Ident.valid_eq)))
          end
 
        and str_realise (str1,str2,strids) =
          let
            (* These structures should be fully expanded already *)
            (* So a Bind exn should be impossible *)
	    val (name,env) = get_name_and_env ("str_realise1",str1)
            val (name',env') = get_name_and_env ("str_realise2",str2)
            val name = Strnames.strip name
          in
            case name of
              METASTRNAME r =>
                if
                  Strnames.uninstantiated name' andalso 
                  Strnames.metastrname_eq (name,name')
                  then
                    env_realise (env,env',strids)
                else
                  let
                    val result = 
                      let
                        val (env_realise, debugger_str) = env_realise (env,env',strids)
                      in
                        if env_realise then
                          if Nameset.member_of_strnames (name,!nameset_ref)
                            then
                              (true, debugger_str) 
                          else
                            (error["Structure sharing violation for ",
                                   (case strids of
                                      [] => "impossible type error 13: top level structure"
                                    | _ => string_strids' strids)];
                            (false, debugger_str))
                        else
                          (* error will already be reported by env_realise *)
                          (false, debugger_str)
                      end
                  in
                    if Nameset.member_of_strnames (name',!nameset_ref)
                      then
                        (r := name';
                         result)
                    else
                      (r := name';
                       remove_strname name;
                       result)
                  end
            | _ =>
                if Strnames.strname_eq (name,name') then
                  env_realise (env,env',strids)
                else 
                  (error["Structure sharing violation for ",
                         (case strids of
                            [] => "impossible type error 14: top level structure"
                          | _ => string_strids' strids)];
                  (false,Datatypes.EMPTY_DSTR))
          end

        fun tystr_check (TYSTR (tyfun,ve as VE (_,amap)),
                         TYSTR (tyfun',ve' as VE (_,amap')),
                         tycon,
                         strids) =
          let
            val tyfun = make_eta_tyfun tyfun
            val tyfun' = make_eta_tyfun tyfun'
          in
            if Types.tyfun_eq (tyfun, tyfun')
              then true
            else
              (error ["Type sharing violation for ",
                      string_strids strids,
                      IdentPrint.printTyCon tycon(*,
                      "<", Types.string_tyfun tyfun, ",",Types.string_tyfun tyfun',">"*)];
               false)
          end
         
        and se_check (SE amap,se',strids) =
          let
            fun check (b,strid,str) =
              case Strenv.lookup (strid,se') of 
                SOME str' => str_check(str,str',strid::strids) andalso b
              | _ => b
          in
            NewMap.fold check (true,amap)
          end

        and te_check (TE amap,te',strids) =
          let 
            fun check_tyname (tycon, sig_tystr) =
              let
                val str_tystr = Tyenv.lookup (te', tycon)
              in
                tystr_check (sig_tystr,str_tystr, tycon,strids)
              end
            handle Tyenv.LookupTyCon _ => true
            val check_result = NewMap.map check_tyname amap
          in
            NewMap.fold (fn (b',_,b) => b' andalso b) (true,check_result)
          end

        and env_check (ENV (se,te,_),ENV (se',te',_),strids) =
          let
            val se_check = se_check (se,se',strids)
            val te_check = te_check (te,te',strids)
          in
            se_check andalso te_check
          end
 
        and str_check (str1,str2,strids) =
          let
	    val (name,env) = get_name_and_env ("str_check1",str1)
            val (name',env') = get_name_and_env ("str_check2",str2)
          in
            env_check (env,env',strids)
          end

	(* str_realise must be called before str_enriches *)
	val (res1, debugger_str) = str_realise (str,str',[])
	val res2 = str_check (str,str',[])
	val (res3, coerce, debugger_str) =
	  str_enriches (level,str,str',debugger_str, [])
      in
        (res1 andalso res2 andalso res3, coerce, debugger_str)
      end
  end




