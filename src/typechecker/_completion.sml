(* _completion.sml the functor *)
(*
$Log: _completion.sml,v $
Revision 1.42  1998/03/20 16:14:44  jont
[Bug #30090]
Remove MLWorks.IO in favour of print

 * Revision 1.41  1996/10/09  12:58:28  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.40  1996/10/02  11:42:14  andreww
 * [Bug #1592]
 * Threading extra level argument through tynames.
 *
 * Revision 1.39  1996/08/05  13:36:15  andreww
 * [Bug #1521]
 * Propagating changes to _types.sml
 *
 * Revision 1.38  1996/04/30  15:21:43  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.37  1996/02/26  11:38:56  jont
 * Change newhashtable to hashtable
 *
 * Revision 1.36  1996/02/22  11:33:13  jont
 * Replacing Map with NewMap
 *
 * Revision 1.35  1995/04/11  10:00:10  matthew
 * Adding cached completion functions
 *
Revision 1.34  1995/04/10  10:48:38  matthew
Fixing problem with tyfuns without stamps

Revision 1.33  1995/03/28  12:00:28  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.32  1995/02/07  11:06:16  matthew
Rationalizations

Revision 1.31  1995/01/11  13:59:56  jont
Modified COPYSTR case of searchSE so as to search the inner str in
the case where the requested tyname is not in the range of the copy map

Revision 1.30  1994/09/15  16:48:54  jont
Remove use of myoutput

Revision 1.29  1994/06/17  16:52:13  jont
Allow alternative printing of types to include quantifiers

Revision 1.28  1994/05/12  14:34:04  daveb
Datatypes.META_OVERLOADED has extra arguments.

Revision 1.27  1994/05/06  12:57:10  jont
Fix the type completion problems, which were due to tynames
sometimes having multiple pre-images in the copy maps.
Also removed several redundant handlers around name copying functions

Revision 1.26  1994/05/04  16:16:26  jont
Fix use of check_debruijns to be safe

Revision 1.25  1994/02/28  06:01:43  nosa
Replaced option in NULL_TYFUNs for polymorphic debugger.

Revision 1.24  1994/02/08  14:49:11  matthew
Added diagnostics.  This is not a permanent change.

Revision 1.23  1993/11/30  11:17:33  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.22  1993/11/25  09:34:55  nickh
Added function to report a type error as a list of types and strings.
Also changed the treatment of unbound type variables in completion;
they need to test equal on separate calls to print_type_with_seen_tyvars,
so we need to retain the ref cell.

Revision 1.21  1993/08/16  10:36:45  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.20  1993/07/09  12:37:50  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger.

Revision 1.19  1993/06/30  15:23:49  daveb
Removed exception environments.

Revision 1.18  1993/05/18  19:35:18  jont
Removed integer parameter

Revision 1.17  1993/04/02  16:17:37  matthew
Changed debug_print_type to print_type

Revision 1.16  1993/03/31  13:52:42  jont
Redone using hash tables instead of abusing maps. Fixed a minor potential
fault to do with not stripping TYFUN(CONSTYPE)

Revision 1.15  1993/03/04  10:17:26  matthew
Options & Info changes

Revision 1.14  1993/03/02  16:26:46  matthew
Trivia

Revision 1.13  1993/02/24  14:26:48  matthew
Fixed problem with completing tynames

Revision 1.11  1993/02/22  16:27:29  matthew
Various tidyings and mucking around.  This file needs rewriting.

Revision 1.10  1993/01/27  14:17:54  matthew
Changes for COPYSTR's
This is grossly inefficient and must be fixed.

Revision 1.9  1992/12/07  16:38:50  jont
Anel's last changes

Revision 1.8  1992/11/24  17:01:49  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.7  1992/10/09  14:38:43  clive
Tynames now have a slot recording their definition point

Revision 1.6  1992/08/11  12:00:05  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/08/04  12:21:14  jont
Anel's changes to use NewMap instead of Map

Revision 1.4  1992/07/22  12:31:06  jont
Removed references to Lists.foldl and Lists.foldr

Revision 1.3  1992/01/24  16:30:38  jont
Update to allow valenv in METATYNAME

Revision 1.2  1991/11/21  16:44:36  jont
Added copyright message

Revision 1.1  91/06/07  11:34:54  colin
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

require "../basics/identprint";
require "../utils/lists";
require "../utils/hashtable";
require "types";
require "namehash";
require "stamp";
require "completion";

(*****
Long type constructor name completion
*****)

functor Completion(
  structure Types : TYPES
  structure Lists : LISTS
  structure IdentPrint : IDENTPRINT
  structure NameHash : NAMEHASH
  structure HashTable : HASHTABLE
  structure Stamp : STAMP

  sharing NameHash.Datatypes = Types.Datatypes
  sharing IdentPrint.Ident = Types.Datatypes.Ident
  sharing type Types.Datatypes.Stamp = Stamp.Stamp
  sharing type Types.Datatypes.StampMap = Stamp.Map.T
		   ): COMPLETION =

struct
  structure Datatypes = Types.Datatypes
  structure NewMap = Datatypes.NewMap
  structure Options = Types.Options

  (* poor old NJ can't cope with some of the uses of #1, so ... *)
  fun first (a,b) = a

  (*****
  Functions for manipulating mappings.
  *****)

  open Datatypes

(*
  fun print_tyname(TYNAME{1=id, 2=s, ...}) =
    "TYNAME{id=" ^ Stamp.string_stamp id ^
    ",s=" ^ s ^ "}"
    | print_tyname(METATYNAME{1=ref tyfun, 2=s, ...}) =
      "METATYNAME{tyfun=" ^ print_tyfun tyfun ^ ",s=" ^ s ^ "}"

and print_tyfun(ETA_TYFUN tyname) =
    "ETA_TYFUN(" ^ print_tyname tyname ^ ")"
    | print_tyfun(TYFUN(ty, i)) =
      "TYFUN(" ^
      (case ty of
	 CONSTYPE(ty_list, tyname) =>
	   if Types.tyname_arity tyname = i andalso Types.check_debruijns(ty_list, 0) then
	     print_tyfun(ETA_TYFUN tyname)
	   else
	     "Complicated type"
       | _ => "Complicated type") ^ ")"
    | print_tyfun(NULL_TYFUN id) =
      "NULL_TYFUN(" ^ Stamp.string_stamp id ^ ")"
*)

  fun tyname_eq (id, TYNAME {1=id',...}) = id = id'
    | tyname_eq (id, METATYNAME {1=ref tyfun,...}) =
      tyfun_eq (id,tyfun)

  and tyfun_eq (id,TYFUN _) = false
    | tyfun_eq (id,ETA_TYFUN tyname) = tyname_eq (id,tyname)
    | tyfun_eq (id,NULL_TYFUN (id',ref tyfun)) = id = id'

  exception TyfunStamp
  fun tyname_stamp (TYNAME {1=id,...}) = id
    | tyname_stamp (METATYNAME {1=ref tyfun,...}) = tyfun_stamp tyfun

  and tyfun_stamp (TYFUN _) = raise TyfunStamp (* Crash.impossible "tyfun_stamp" *)
    | tyfun_stamp (ETA_TYFUN tyname) = tyname_stamp tyname
    | tyfun_stamp (NULL_TYFUN (id,ref tyfun)) = id

  type Cache = ((Type,Type) HashTable.HashTable *
                (Stamp.Stamp,string) HashTable.HashTable)

  local
    fun type_eq(ty1, ty2) = Types.type_eq(ty1, ty2, false, false)
  in
    fun empty_cache () = (HashTable.new(10, type_eq, NameHash.type_hash),
                          HashTable.new(10, (op =), Stamp.stamp))
  end

  (*****
  Result datatype.
  *****)

  datatype 'a result = YES of 'a | NO

  (*****
  Search an environment for a type name, returning a list of strings which
  is the path name. Returns [] if no occurrence was found in E.
  *****)

  fun searchE (ENV(strenv, tyenv, _), tyname_id) =
    case searchTE(tyenv, tyname_id) of
      YES tycon => [IdentPrint.printTyCon tycon]
    | NO => searchSE(strenv, tyname_id)

  (*****
  Search a structure environment for a type name, returning a list of
  strings which is the path name. Returns [] if no occurrence was
  found in SE.
  *****)

  and searchSE (SE mapping, tyname_id) =
    let
      fun check ([], strid, (STR(_,_,env)),tyname_id) =
	  (case searchE(env, tyname_id) of
	     [] => []
	   | namelist => (IdentPrint.printStrId strid ^ ".") :: namelist)
	| check (namelist, strid, (STR(_,_,env)), tyname_id) =
	  (case searchE(env, tyname_id) of
	     [] => namelist
	   | namelist' =>
	       let
		 val len  = length namelist
		 val len' = length namelist'
	       in
		 if len'+1 < len then
		   (IdentPrint.printStrId strid ^ ".") :: namelist'
		 (* Prefer the latter list only if it will be shorter *)
		 else
		   namelist
	       end)
        | check (namelist,strid,COPYSTR((smap,tmap),str),tyname_id) =
(* The old way of doing it
          check (namelist,strid,Env.str_copy (str,smap,tmap),tyname_id)
*)
          let
            val result =
              Stamp.Map.fold
              (fn (result, tyfun_id, tyname') =>
	       if tyname_eq(tyname_id, tyname') then
		 tyfun_id :: result
	       else
		 result)
              ([], tmap)
          in
	    (* this stuff may be bogus *)
            case result of
              [] => check(namelist, strid, str, tyname_id)
            | tyfun_id_list =>
                let
		  fun check_one(namelist, tyfun_id) =
		    check(namelist, strid, str, tyfun_id)

		  val new_namelist = Lists.reducel check_one (namelist, tyfun_id_list)
                in
		  new_namelist
                end
          end
    in
      NewMap.fold (fn (a,b,c) => check(a,b,c,tyname_id)) ([],mapping)
    end

  and searchTE (TE mapping, tyname_id) =
    let
      fun print (args as (_,_,TYSTR(tyfun,_))) =
        args
      fun check(NO, tycon, (TYSTR(ETA_TYFUN tyname', _))) =
	if tyname_eq(tyname_id, tyname') then
	  YES tycon
	else
	  NO
	| check(NO, tycon, (TYSTR(tyfun as TYFUN _, _))) =
	  let
	    val tyfun' = Types.tyfun_strip tyfun
	  in
	    case tyfun' of
	      ETA_TYFUN tyname' =>
		if tyname_eq(tyname_id, tyname') then
		  YES tycon
		else
		  NO
	    | _ => NO
	  end
	| check(NO, _, _) = NO
	| check(arg as YES _, _, _) = arg
    in
      NewMap.fold (check o print) (NO, mapping)
    end

  (*****
  Check if we managed to find a path, append "(hidden)" to the
  original name if we didn't.
  *****)

  fun check_tyname (env, (map1, map2), tyname, name) =
    case HashTable.tryLookup(map2, tyname) of
      SOME result => result
    | _ =>
	(case searchE(env, tyname) of
	   [] => name ^ "(hidden)"
	 | namelist => concat namelist)
  
  (*****
  This function changes the name component of each type name so that
  it contains a path to an occurrence of that type name in the supplied
  environment. The path returned is always the shortest path. Note that
  references in METATYVAR's etc are NOT updated, they are copied, otherwise
  this function could change types in the basis.
  *****)

  fun complete_tycons (env, m as (m1, _), 
                       t as METATYVAR(ref (x, ty,i), eq, imp)) =
    (case HashTable.tryLookup(m1, t) of
        SOME result => (result, m)
     | _ =>
	 (case ty of
	    NULLTYPE =>
	      (t,m)
	  | _ =>
	      let
		val (ty', m as (m1, _)) = complete_tycons (env, m, ty)
		val t' = METATYVAR(ref (x, ty',i), eq, imp)
		val _ = HashTable.update(m1, t, t')
	      in
		(t', m)
	      end))
    | complete_tycons (env, m as (m1, _),
		       t as META_OVERLOADED(ref ty,tv,valid,loc)) =
      (case HashTable.tryLookup(m1, t) of
	 SOME result => (result, m)
       | _ =>
	   let
	     val (ty', m as (m1, _)) = complete_tycons (env, m, ty)
	     val t' = META_OVERLOADED(ref ty',tv,valid,loc)
	     val _ = HashTable.update(m1, t, t')
	   in
	     (t', m)
	   end)
    | complete_tycons (env, m, ty as (TYVAR _)) = (ty, m)
    | complete_tycons (env, m, METARECTYPE (ref (level, flex, ty, eq, imp))) =
      let
	val (ty', m') = complete_tycons (env, m, ty)
      in
	(METARECTYPE(ref (level, flex, ty, eq, imp)), m')
      end
    | complete_tycons (env, m, RECTYPE fields) =
      let
	fun f((fields, m), lab, ty) =
	  let
	    val (ty', m') = complete_tycons(env, m, ty)
	  in
	    (NewMap.define'(fields, (lab, ty')), m')
	  end
	val (fields', m') = NewMap.fold f ((NewMap.empty' Ident.lab_lt, m), fields)
      in
	(RECTYPE fields', m')
      end
    | complete_tycons (env, m, FUNTYPE(ty1, ty2)) =
      let
	val (ty1', m1) = complete_tycons(env, m , ty1)
	val (ty2', m2) = complete_tycons(env, m1, ty2)
      in
	(FUNTYPE(ty1', ty2'), m2)
      end
    | complete_tycons (env, m, CONSTYPE(type_list, tyname)) =
      let
	fun f (ty, (ty_list, m1)) =
	  let
	    val (ty', m2) = complete_tycons(env, m1, ty)
	  in
	    (ty' :: ty_list, m2)
	  end

	val (tyname', m') = change_name (env, m, tyname)
	val (type_list', m'') = Lists.reducer f (type_list, ([], m'))
      in
	(CONSTYPE(type_list', tyname'), m'')
      end
    | complete_tycons (env, m, ty as (DEBRUIJN _)) = (ty, m)
    | complete_tycons (env, m, ty as NULLTYPE) = (ty, m)

  and change_name (env, m as (_, m2), tyname) =
    case tyname of
      METATYNAME(ref tyfun, name, arity, ref eq, ref valenv,ref is_abs) =>
	(let
          val stamp = tyname_stamp tyname
	  val name' = check_tyname(env, m, stamp, name)
          val tyname' = METATYNAME(ref tyfun, name', arity, ref eq, ref valenv,ref is_abs)
	  val _ = HashTable.update(m2, stamp, name')
	in
	  (tyname', m)
	end
        handle TyfunStamp => (tyname,m))

    | TYNAME(stamp, name, arity, ref eq, ref valenv,location,ref is_abs,
             ve_copy, level) =>
	let
	  val name' = check_tyname(env, m, stamp, name)
	  val tyname' = TYNAME(stamp, name', arity, ref eq, ref valenv,
                               location,ref is_abs,ve_copy,level)
	  val _ = HashTable.update(m2, stamp, name')
	in
	  (tyname', m)
	end
    
  (*****
  The top level call to complete_tycons
  *****)

  val complete_tycons =
    fn (env,cache,ty) => first(complete_tycons(env,cache, Types.simplify_type ty))

  (* Print out a type using tycon name completion *)
    
  fun print_type (options,env,ty) =
    let
      val ty' = complete_tycons (env,empty_cache (),ty)
    in
      Types.print_type options ty'
    end

  (* The cache is just side effected so we just return it *)
  fun cached_print_type (options,env,ty,cache) =
    let
      val ty' = complete_tycons (env,cache,ty)
    in
      (Types.print_type options ty',cache)
    end

  fun has_debruijns(deb_list, METATYVAR(ref(_, ty, _), _, _)) =
    has_debruijns(deb_list, ty)
    | has_debruijns(deb_list, META_OVERLOADED _) = deb_list
    | has_debruijns(deb_list, TYVAR _) = deb_list
    | has_debruijns(deb_list, METARECTYPE(ref{3= ty, ...})) =
      has_debruijns(deb_list, ty)
    | has_debruijns(deb_list, RECTYPE map) =
      NewMap.fold
      (fn (deb_list, _, ty) => has_debruijns(deb_list, ty))
      (deb_list, map)
    | has_debruijns(deb_list, FUNTYPE(ty, ty')) =
      has_debruijns(has_debruijns(deb_list, ty), ty')
    | has_debruijns(deb_list, CONSTYPE(ty_list, _)) =
      Lists.reducel has_debruijns (deb_list, ty_list)
    | has_debruijns(deb_list, DEBRUIJN deb) =
      if Lists.member (deb, deb_list) then deb_list else deb :: deb_list
    | has_debruijns(deb_list, NULLTYPE) = deb_list

  fun string_debruijn options (i, eq, imp, _) 
    = Types.string_debruijn(options,i, eq, imp)

  fun print_debs _ [] = []
    | print_debs options [a] = [string_debruijn options a]
    | print_debs options (a :: rest) = string_debruijn options a 
                               :: ", " :: print_debs options rest

  fun print_debruijns _ [] = ""
    | print_debruijns options [a] 
             = "(for all " ^ string_debruijn options a ^ ")."
    | print_debruijns options list  = "(for all " 
      ^ concat(print_debs options list) ^ ")."

  fun report_type_error (options,env,l) =
    let
      val cache = empty_cache ()
      fun f (Err_String s,tyvars) = (s,tyvars)
	| f (Err_Type t,tyvars) = 
	  Types.print_type_with_seen_tyvars
          (options,complete_tycons (env,cache,t),tyvars)
	| f (Err_Scheme t,tyvars) = 
	  let
	    val result as (str, tyvars) =
	      Types.print_type_with_seen_tyvars
              (options,complete_tycons (env,cache,t),tyvars)
	  in
	    case has_debruijns([], t) of
	      [] => result
	    | deb_list => (print_debruijns options deb_list
                           ^ str, tyvars)
	  end
	| f (Err_Reset, _) = ("",Types.no_tyvars)
      fun foldmap ([],tyvars,acc) = rev acc
	| foldmap (ty::tys,tyvars,acc) =
	  let
	    val (name,tyvars) = f(ty,tyvars)
	  in
	    foldmap (tys,tyvars,name::acc)
	  end
    in
      concat (foldmap (l,Types.no_tyvars,[]))
    end
end









