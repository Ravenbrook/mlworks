(* _environment.sml the functor *)
(*
$Log: _environment.sml,v $
Revision 1.46  1998/02/19 16:46:10  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.45  1997/05/19  12:41:13  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.44  1996/11/06  11:33:16  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.43  1996/10/29  13:28:25  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.42  1996/10/02  11:43:10  andreww
 * [Bug #1592]
 * Threading extra level argument through tynames.
 *
 * Revision 1.41  1996/04/30  17:41:57  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.40  1996/04/29  13:49:21  matthew
 * Integer changes
 *
 * Revision 1.39  1996/03/20  12:26:14  matthew
 * Changes to use of cast
 *
 * Revision 1.38  1996/02/26  11:50:24  jont
 * Change newhashtable to hashtable
 *
 * Revision 1.37  1995/12/04  14:21:33  jont
 * Modify no_imptyvars to return the offending tyvar if it exists
 *
Revision 1.36  1995/03/31  16:28:04  matthew
Changing tyfun_ids etc. to stamps

Revision 1.35  1995/02/07  12:05:20  matthew
Improvement to unbound long id errors

Revision 1.34  1994/12/07  11:37:45  matthew
Changing uses of cast

Revision 1.33  1994/09/22  15:51:10  matthew
Added environment lookup functions for vals  and tycons

Revision 1.32  1994/02/22  01:45:09  nosa
Extra TYNAME valenv for Modules Debugger.

Revision 1.31  1993/11/30  11:23:54  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.30  1993/06/30  15:35:32  daveb
Removed exception environments.

Revision 1.29  1993/05/21  14:38:03  matthew
> Simplified printing of envs.

Revision 1.28  1993/05/19  16:43:12  matthew
Fixed problem in compose_maps

Revision 1.27  1993/03/04  10:27:54  matthew
Options & Info changes

Revision 1.26  1993/02/19  12:44:36  matthew
Removed z from function names
Moved realisation stuff to _realise

Revision 1.25  1993/02/17  15:38:51  jont
Used tyname_copy from types

Revision 1.24  1993/02/02  18:19:34  matthew
Changed to structure representation
Experimental memoized structure functions.  These don't seem to work too
well and aren't currently used.

Revision 1.23  1992/12/18  15:55:12  matthew
Propagating options to signature matching error messages.

Revision 1.22  1992/12/04  19:39:43  matthew
Error message revisions.

Revision 1.21  1992/12/03  12:59:08  jont
Replaced some NewMap.fold calls with NewMap.forall

Revision 1.20  1992/10/30  15:50:01  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.19  1992/10/27  19:08:10  jont
Modified to use less than functions for maps

Revision 1.18  1992/10/02  16:05:57  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.17  1992/08/27  20:14:46  davidt
Yet more changes to get structure copying working better.

Revision 1.16  1992/08/26  13:13:40  davidt
Made some changes to the NewMap signature.

Revision 1.15  1992/08/18  15:36:23  jont
Removed irrelevant handlers and new exceptions

Revision 1.14  1992/08/11  18:00:59  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.13  1992/08/06  14:23:40  jont
Anel's changes to use NewMap instead of Map

Revision 1.11  1992/07/27  14:00:40  jont
Improved enrichment efficiency

Revision 1.10  1992/07/17  13:23:01  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.9  1992/05/04  22:04:54  jont
Anel's fixes

Revision 1.8  1992/04/15  13:25:03  jont
Some improvements from Anel

Revision 1.7  1992/02/11  10:04:28  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.6  1992/01/27  20:13:52  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.5  1991/11/21  16:45:24  jont
Added copyright message

Revision 1.4  91/11/13  13:50:32  richard
Used the Strenv module to get the empty structure environment
and the initial structure environment.

Revision 1.3  91/07/16  17:16:03  colin
Replaced Map.domain with Varenv.ve_domain for valenvs (ve_domain makes
everything a Ident.VAR)

Revision 1.2  91/06/17  17:13:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing of circular data structures.

Revision 1.1  91/06/07  11:36:07  colin
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

require "../basis/__int";

require "../utils/print";
require "../basics/identprint";
require "../typechecker/environment";
require "../typechecker/types";
require "../typechecker/valenv";
require "../typechecker/scheme";
require "../typechecker/strnames";
require "../typechecker/tyenv";
require "../typechecker/strenv";
require "stamp";
require "../utils/hashtable";

functor Environment(
  structure IdentPrint : IDENTPRINT
  structure Print : PRINT
  structure Types : TYPES
  structure Valenv : VALENV
  structure Scheme : TYPESCHEME
  structure Strnames : STRNAMES
  structure Tyenv : TYENV
  structure Strenv : STRENV
  structure HashTable : HASHTABLE
  structure Stamp : STAMP

  sharing Types.Datatypes = Valenv.Datatypes
    = Scheme.Datatypes = Strnames.Datatypes 
    = Tyenv.Datatypes = Strenv.Datatypes
  sharing IdentPrint.Ident = Types.Datatypes.Ident
  sharing type Types.Datatypes.Stamp = Stamp.Stamp
  sharing type Types.Datatypes.StampMap = Stamp.Map.T
    ) : ENVIRONMENT =
  struct
    structure Datatypes = Types.Datatypes

    structure Valenv = Valenv
    structure Exconenv = Valenv
    structure Ident = Datatypes.Ident

    open Datatypes
      
    exception LookupStrId of Ident.StrId
    exception EnrichError of string

    local

      fun strname_hash_fun (STRNAME id) = Stamp.stamp id
        | strname_hash_fun (METASTRNAME (ref strname)) = strname_hash_fun strname
        | strname_hash_fun (NULLNAME id) = Stamp.stamp id

      fun makememotable () =
        HashTable.new (16,Strnames.strname_eq,strname_hash_fun)

      fun lookup(strname,table) =
        case HashTable.tryLookup (table,strname) of
          SOME x => x
        | NONE => []

      fun update_table (table,strname,newentry) =
        HashTable.update (table,strname,newentry)
    in
      fun memoize_strfun (eqtest,f,str) =
        let
          val table = makememotable()
          exception NotFound
          fun f' str =
            let
              fun find [] = raise NotFound
                | find ((str',value)::l) =
                  if eqtest(str,str') then value
                  else find l
              fun get_strname (STR(strname,_,_)) = strname
                | get_strname (COPYSTR(_,str)) = get_strname str
              val strname = get_strname str
            in
              case lookup(strname,table) of
                [] =>
                  let val result = f f' str
                  in
                    update_table(table,strname,[(str,result)]);
                    result
                  end
              | entries => 
                  ((find entries)
		   handle NotFound =>
		     let
		       val result = f f' str
		     in
		       update_table(table,strname,(str,result)::entries);
		       result
		     end)
            end
        in
          f' str
        end
    end

    local
      val cast = MLWorks.Internal.Value.cast
    in
      fun struct_fast_eq (x,y) =
        ((cast x):int) = ((cast y):int)
    end
    fun struct_eq (str as STR(strname,_,ENV(SE se,TE te,ve)),
                   str' as STR(strname',_,ENV(SE se',TE te',ve'))) =
      let
        (* WARNING: this ignores constructor status *)
        val valenv_eq =
          Valenv.valenv_eq
        fun strenv_eq (se,se') =
          NewMap.eq struct_eq (se,se')
        fun tystr_eq (TYSTR (tyfun,valenv),TYSTR(tyfun',valenv')) =
          Types.tyfun_eq(tyfun,tyfun')
          andalso
          valenv_eq(valenv,valenv')
        fun tyenv_eq (te,te') =
          NewMap.eq tystr_eq (te,te')
      in
        (struct_fast_eq (str,str') (* andalso (output(std_out,"Hurray\n");true) *))
        orelse
        (Strnames.strname_eq(strname,strname')
         andalso
         valenv_eq(ve,ve')
         andalso
         tyenv_eq(te,te')
         andalso
         strenv_eq (se,se'))
      end
    | struct_eq (str as COPYSTR(maps,sstr),str' as COPYSTR(maps',sstr')) =
      let
        val smap_eq =
          Stamp.Map.eq Strnames.strname_eq
        val tmap_eq =
          Stamp.Map.eq Types.tyname_eq
        fun maps_eq((smap,tmap),(smap',tmap')) =
          smap_eq(smap,smap')
          andalso
          tmap_eq(tmap,tmap')
      in
        (struct_fast_eq (str,str')
         orelse
         (maps_eq(maps,maps')
          andalso
          struct_eq(sstr,sstr')))
      end
      | struct_eq _ = false

    fun struct_copy strcopyfun (STR(strname,r,ENV(SE se,te,ve))) =
      STR (strname,r,ENV(SE (NewMap.map (fn(_,a) => strcopyfun a) se),
                       te,ve))
      | struct_copy _ str = str

    fun compress_str str =
      let
        val result = memoize_strfun (struct_eq,struct_copy,str)
      in
        result
      end

    (****
     Functions for manipulating the environment (the semantic object).
     ****)

    val empty_env = ENV (Strenv.empty_strenv,
			 Tyenv.empty_tyenv,
			 empty_valenv)

    val initial_env = ENV (Strenv.initial_se,
			   Tyenv.initial_te,
			   Valenv.initial_ve)

    val initial_env_for_builtin_library = 
      ENV (Strenv.initial_se,
           Tyenv.initial_te_for_builtin_library,
           Valenv.initial_ve_for_builtin_library)

    fun empty_envp (ENV (se,te,ve)) = 
      (Strenv.empty_strenvp se) andalso 
      (Tyenv.empty_tyenvp te) andalso 
      (Valenv.empty_valenvp ve)

    fun env_plus_env (ENV (se,te,ve),ENV (se',te',ve')) =
      ENV (Strenv.se_plus_se (se,se'),
	   Tyenv.te_plus_te (te,te'),
	   Valenv.ve_plus_ve (ve,ve'))

    (* DOES THIS WORK? *)
    fun compose_maps ((smap1,tmap1),(smap2,tmap2)) =
      (* do *map1 then *map2, ie. apply map2 to range of map1 *)
      (* ie. *map1 is the inner map *)
      let
        val smap2 =
          Stamp.Map.map
          (fn (n1,n2) =>
           Strnames.strname_copy(n2,smap2))
          smap1
        val tmap2 =
          Stamp.Map.map
          (fn (tyfun,tyname) => Types.tyname_copy(tyname,tmap2))
          tmap1
      in
        (smap2,tmap2)
      end

    fun se_copy (SE amap,strname_copies,tyname_copies) =
      SE(NewMap.map (fn (_, str) => str_copy (str,strname_copies,tyname_copies)) amap)

    and env_copy (ENV (se,te,ve),strname_copies,tyname_copies) =
      ENV (se_copy (se,strname_copies,tyname_copies),
           Tyenv.te_copy (te,tyname_copies),
           Valenv.ve_copy (ve,tyname_copies))

    and str_copy (STR(name,r,env),strname_copies,tyname_copies) =
             STR(Strnames.strname_copy (name,strname_copies),
                 r,
                 env_copy (env,strname_copies,tyname_copies))
      | str_copy (COPYSTR(maps,str),strname_copies,tyname_copies) =
        let val (smap,tmap) = compose_maps (maps,(strname_copies,tyname_copies))
        in
          str_copy (str,smap,tmap)
        end

(*
    and str_copy (str, strname_copies, tyname_copies) =
      let
	fun copy_str copyfn (STR(name,_,ENV(se,te,ve))) =
	  STR(Strnames.strname_copy (name,strname_copies),
	      _,
	      ENV (se_copy (copyfn,se), Tyenv.te_copy (te,tyname_copies),
		   Valenv.ve_copy (ve,tyname_copies)))
          | copy_str copyfn (COPYSTR((smap,tmap),str)) =
            copyfn (str_copy (str,smap,tmap))
(*
            let val (smap,tmap) = compose_maps (maps,(strname_copies,tyname_copies))
            in
              str_copy (str,smap,tmap)
            end
*)
	and se_copy (copyfn,SE amap) =
	  SE(NewMap.map (fn (_, str) => copyfn str) amap)
        val result = memoize_strfun (struct_eq,copy_str,str)
     in
       result
     end
*)

    fun expand_str str =
      let
        fun expand (STR (strid,r,env)) =
          STR (strid,r,expand_env env)
          | expand (COPYSTR((smap,tmap),str)) =
            expand (str_copy (str,smap,tmap))
      in
        expand str
      end

    and expand_se (SE se) =
      SE (NewMap.map (fn (strid,str) => expand_str str) se)

    and expand_env (ENV(se,te,ve)) =
      ENV (expand_se se,te,ve)

    (* This should just copy out the top level of a structure.  Useful for OPEN *)

    fun resolve_top_level (str as STR _) = str
      | resolve_top_level (COPYSTR((smap,tmap),STR(name,r,ENV(se,te,ve)))) =
        let fun se_copy (SE amap) =
          SE(NewMap.map 
             (fn (_,COPYSTR(maps',str')) =>
              COPYSTR(compose_maps(maps',(smap,tmap)),str')
           | (_,str) => COPYSTR((smap,tmap),str))
             amap)
        in 
          STR(Strnames.strname_copy (name,smap),
	      r,
              ENV(se_copy se,
                  Tyenv.te_copy(te,tmap),
                  Valenv.ve_copy (ve,tmap)))
        end
      | resolve_top_level (COPYSTR (maps,str)) =
        resolve_top_level (COPYSTR (maps,resolve_top_level str))

    (****
     Implementation of the operation Abs as defined on p. 22 of The Definition.
     ****)

    fun tyname_make_abs (TYNAME (_,_,_,_,_,_,is_abs_ref,_,_)) = 
                                                      is_abs_ref := true
      | tyname_make_abs (METATYNAME (ref tyfun,_,_,_,_,is_abs_ref)) =
	(case tyfun of
           ETA_TYFUN tyname => tyname_make_abs tyname
         | NULL_TYFUN _ => is_abs_ref := true
         | TYFUN _ => ())

    fun make_abs (TYFUN (_)) = ()
      | make_abs (ETA_TYFUN (tyname)) = tyname_make_abs tyname
      | make_abs (NULL_TYFUN (_)) = ()

    fun abs (TE amap,ENV (se,te,ve)) =
      let 
        val abste =
	  TE(NewMap.fold
	     (fn (map, tycon, TYSTR (tyfun,_)) =>
	      (ignore(Types.make_false tyfun);
               make_abs tyfun;
	       NewMap.define(map, tycon, TYSTR (tyfun,empty_valenv))))
	     (NewMap.empty (Ident.tycon_lt, Ident.tycon_eq), amap))
      in
	ENV (se,Tyenv.te_plus_te (abste,te),ve)
      end
    
    fun lookup_strid (strid,ENV (se,_,_)) = 
      Strenv.lookup (strid,se)

    (* Test this with a "naive" definition *)
    fun lookup_longstrid (Ident.LONGSTRID (Ident.NOPATH,strid),ENV(se,_,_)) =
      (case Strenv.lookup(strid,se) of
         SOME str => str
       | _ => raise LookupStrId strid)
      | lookup_longstrid (Ident.LONGSTRID (Ident.PATH (sym,path),strid),ENV(se,_,_)) =
        let
          fun sort_out (STR (_,_,env)) =
            lookup_longstrid(Ident.LONGSTRID (path,strid), env)
           | sort_out (COPYSTR (maps,str)) =
             COPYSTR(maps,sort_out str)
        in
          case Strenv.lookup (Ident.STRID sym,se) of
            SOME str => sort_out str
          | _ => raise LookupStrId (Ident.STRID sym)
        end


    local
      fun lookup_str (STR (_,_,env),path,valid) =
        follow_path (path,valid,env)
        | lookup_str (COPYSTR ((smap,tmap),str),path,valid) =
          Scheme.scheme_copy (lookup_str (str,path,valid),tmap)

      and follow_path (Ident.NOPATH,valid,ENV (_,_,ve)) = Valenv.lookup (valid,ve)
        | follow_path (Ident.PATH (sym,path),valid,ENV (se,_,_)) =
          case Strenv.lookup (Ident.STRID sym,se) of
            SOME str => lookup_str (str,path,valid)
          | _ => raise LookupStrId (Ident.STRID sym)
    in
      fun lookup_longvalid (Ident.LONGVALID (path,valid),env) =
        follow_path (path,valid,env)
    end

    local
      fun lookup_str (STR (_,_,env),path,tycon) =
        follow_path (path,tycon,env)
        | lookup_str (COPYSTR ((smap,tmap),str),path,tycon) =
          Tyenv.tystr_copy (lookup_str (str,path,tycon),tmap)

      and follow_path (Ident.NOPATH,tycon,ENV (_,te,_)) = Tyenv.lookup (te,tycon)
        | follow_path (Ident.PATH (sym,path),tycon,ENV (se,_,_)) =
          (case Strenv.lookup (Ident.STRID sym,se) of
             SOME str => lookup_str (str,path,tycon)
           | _ => raise LookupStrId (Ident.STRID sym))
    in
      fun lookup_longtycon (Ident.LONGTYCON (path,tycon),env) = 
        follow_path (path,tycon,env)
    end

    fun SE_in_env se = ENV (se,Tyenv.empty_tyenv,empty_valenv)

    fun TE_in_env te = ENV (Strenv.empty_strenv,te,empty_valenv)

    fun VE_in_env ve = ENV (Strenv.empty_strenv,Tyenv.empty_tyenv,ve)

    fun VE_TE_in_env (ve,te) = ENV (Strenv.empty_strenv,te,ve)

    fun string_environment (ENV (se,te,ve)) =
      (if Strenv.empty_strenvp se 
	 then ""
       else
	 "SE\n" ^ (string_strenv se) ^ "\n") ^
	 (if Tyenv.empty_tyenvp te
	    then ""
	  else
	    "TE\n" ^ (Tyenv.string_tyenv te) ^ "\n") (* ^
	    (if Valenv.empty_valenvp ve
	       then ""
	     else
	       "VE\n" ^ (Valenv.string_valenv (0,ve)) ^ "\n") ^
	        *)
	
    and string_strenv (SE amap) = 
      let
        val strid_str_list = NewMap.to_list_ordered amap
	fun make_string (strid,str) = 
	  "structure " ^ IdentPrint.printStrId strid ^ " =\n" ^
	  string_str str ^ "\n"
      in
	concat(map make_string strid_str_list)
      end

    and string_str (STR (name,_,env)) =
      "(" ^ (Strnames.string_strname name) ^ "," ^ "\n" ^
      string_environment env ^ ")" ^ "\n"
      (* Need to string maps here also *)
      | string_str (COPYSTR ((smap,tmap),str)) = 
        let
          fun string_smap smap =
            let
              val strings =
                map (fn (strname_id,strname) =>
                     "(" ^ Stamp.string_stamp strname_id ^
                     " -> " ^  Strnames.string_strname strname ^ ")")
                (Stamp.Map.to_list smap)
            in
              concat ("{" :: strings @ ["}"])
            end
          fun string_tmap tmap =
            let
              val strings =
                map (fn (tyfun_id,tyname) =>
                     "(" ^ Int.toString (Stamp.stamp tyfun_id) ^
                     " -> " ^  Types.debug_print_name tyname ^ ")")
                (Stamp.Map.to_list tmap)
            in
              concat ("{" :: strings @ ["}"])
            end
        in
          "COPYSTR (" ^ string_tmap tmap ^ string_smap smap ^ string_str str ^ ")"
        end

    (* return true if the environment has no imperative type variables *)
    fun no_imptyvars (ENV (SE amap',_,VE (_,amap))) = 
      let 
	fun look_at_schemes(found as SOME _, _, scheme) =
	  found
	  | look_at_schemes(_, _, scheme) = Scheme.has_free_imptyvars scheme
        (* Would be nice not to copy out here *)
        fun aux (found as SOME _, _, STR(_,_,env)) = found
	  | aux (_, _, STR(_,_,env)) = no_imptyvars env
          | aux (found, x,COPYSTR((smap,tmap),str)) =
(*
            aux (found, x,str_copy(str,smap,tmap))
*)
	    aux (found, x, str) (* Ignore the copy, it's irrelevant for this *)
      in
	case NewMap.fold look_at_schemes (NONE, amap) of
	  NONE => NewMap.fold aux (NONE, amap')
	| x => x
      end

  end
