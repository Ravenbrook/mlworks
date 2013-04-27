(*
$Log: _share.sml,v $
Revision 1.25  1997/04/08 14:51:10  andreww
[Bug #2033]
making sure type dependencies are shared in correct order.

 * Revision 1.24  1996/03/28  10:20:09  matthew
 * Updating for new language revisions
 *
 * Revision 1.23  1995/02/07  15:27:31  matthew
 * Removing debug stuff
 *
Revision 1.22  1993/12/06  15:58:42  nickh
Capitalize error messages.

Revision 1.21  1993/12/01  13:57:01  nickh
Marked certain error messages as "impossible".

Revision 1.20  1993/06/25  19:27:37  jont
Some tidying up

Revision 1.19  1993/05/25  15:32:33  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.18  1993/05/24  10:29:19  matthew
Changed name to name'

Revision 1.17  1993/05/21  12:00:05  jont
Fixed up to check for illegal sharing in functor result signatures
ie trying to force extra sharing on the functor parameter

Revision 1.16  1993/05/20  16:52:58  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.15  1993/03/17  19:01:50  matthew
Nameset signature changes

Revision 1.14  1993/02/08  19:12:24  matthew
Changes for BASISTYPES signature

Revision 1.13  1992/12/22  15:55:35  jont
Anel's last changes

Revision 1.12  1992/12/07  11:13:06  matthew
Changed error messages.

Revision 1.11  1992/12/04  19:27:47  matthew
Error message revisions.

Revision 1.10  1992/12/03  17:33:48  matthew
"they" => "they have"

Revision 1.9  1992/09/08  13:53:40  jont
Removed has_a_new_name, no longer needed

Revision 1.8  1992/08/20  18:19:23  jont
Various improvements to remove garbage, handlers etc.

Revision 1.7  1992/08/12  11:09:23  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/08/06  17:38:14  jont
Anel's changes to use NewMap instead of Map

Revision 1.4  1992/04/28  15:00:11  jont
Anel's fixes

Revision 1.3  1992/01/27  20:15:02  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.2  1991/11/19  19:07:01  jont
Fixed inexhsustive matches

Revision 1.1  91/06/07  11:37:41  colin
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

require "../utils/lists";
require "../utils/print";
require "../utils/crash";
require "../basics/identprint";
require "../typechecker/valenv";
require "../typechecker/strnames";
require "../typechecker/nameset";
require "../typechecker/sharetypes";
require "../typechecker/share";

functor Share(
  structure Lists : LISTS
  structure Print : PRINT
  structure Crash : CRASH
  structure IdentPrint : IDENTPRINT
  structure Sharetypes : SHARETYPES
  structure Valenv : VALENV
  structure Strnames : STRNAMES
  structure Nameset : NAMESET
    
  sharing Sharetypes.Assemblies.Basistypes.Datatypes = Valenv.Datatypes = 
    Nameset.Datatypes = Strnames.Datatypes
  sharing IdentPrint.Ident = Valenv.Datatypes.Ident

  sharing type Sharetypes.Assemblies.Basistypes.Nameset = Nameset.Nameset

) : SHARE = 
  struct
    structure Datatypes = Valenv.Datatypes
    structure Assemblies = Sharetypes.Assemblies
    structure BasisTypes = Assemblies.Basistypes

    structure Nameset = Nameset

    (****
     This functor contains the functions to do the sharing of structures.
     ****)

    open Datatypes

    fun ordered_sublist([], _) = true
      | ordered_sublist(first as (x :: xs), y :: ys) =
	if x = y then
	  ordered_sublist(xs, ys)
	else
	  ordered_sublist(first, ys)
      | ordered_sublist _ = false
  
    exception ShareError of string

    (* Note, the following three "global references" are initialised
     * by the function "findFixedpoint" below, and updated by the
     * function "one_type_share" immediately below.  The idea is that
     * when trying to share types in structures, we keep a track of
     * those types which cannot be shared.  Perhaps one of them cannot
     * be shared because it depends on a type which will be shared later.
     * Thus, we repeat the process until !old_share_failures and
     * !share_failures are equal, in which case we know that any remaining
     * type sharing errors cannot be resolved by sharing types that may
     * occur later in the structure's type name list.
     *)

    val share_failures = ref []
    val old_share_failures = ref []
    val failure_reasons = ref []

    (****
     Handles the sharing of types present in two structures being shared.
     ****)
    
    fun one_type_share(tycon, (tyfun, _), type_offspring, ty_ass, nameset) =
      if Assemblies.inTypeOffspringDomain(tycon, type_offspring) then
	let
	  val (tyfun',_) = Assemblies.lookupTyCon (tycon, type_offspring)
	in
	  Sharetypes.share_tyfun (true,tyfun,tyfun',ty_ass, nameset)
	  handle Sharetypes.ShareError s => 
            (share_failures:=tycon::(!share_failures);
             failure_reasons:= s::(!failure_reasons);
             (true,ty_ass))
        end
      else (true, ty_ass)

    (****
     Make sure that the two structures being shared are consistent.
     ****)

    and str_consistent ([],_,_,str_ass,ty_ass,_) = (true,str_ass,ty_ass)
      | str_consistent (strid::strids,str_offspring,str_offspring',str_ass,
			ty_ass,nameset) =
	let
	  val (strshare_successful,str_ass',ty_ass') = 
	    if Assemblies.inStrOffspringDomain(strid, str_offspring') then 
	      share_str(#1 (Assemblies.lookupStrId (strid,str_offspring)),
			#1 (Assemblies.lookupStrId (strid,str_offspring')),
			str_ass,ty_ass,nameset)
	    else (true,str_ass,ty_ass)
	  val (strshare_successful',str_ass'',ty_ass') = 
	    str_consistent (strids,str_offspring,str_offspring',str_ass',
			    ty_ass',nameset)
	in
	  if strshare_successful andalso strshare_successful' then
	    (true,str_ass'',ty_ass')
	  else (false,str_ass,ty_ass)
	end 
      
    and consistent (name,name',str_ass,ty_ass,nameset) =
        let
	   val (str_offspring,type_offspring) = 
	     Assemblies.lookupStrname (name,str_ass)
	   val stridlist = Assemblies.getStrIds str_offspring 
	   val tyconlist = Assemblies.getTyCons type_offspring
	   val (str_offspring',type_offspring') = 
	     Assemblies.lookupStrname (name',str_ass)
	   val (strshare_successful,str_ass',ty_ass') = 
	     str_consistent (stridlist,str_offspring,str_offspring',
			     str_ass,ty_ass,nameset)

           val _ = old_share_failures:=[]

            (* see comment above the old_share_failures declaration
             * above for a rationale for the findFixpoint function.
             *)
        
           fun findFixpoint () =
             (share_failures:=[];
              failure_reasons:=[];
              let val answer =
                NewMap.fold
                (fn (res as (ok, ty_ass), tycon, ran) =>
                 if ok then
                   one_type_share(tycon, ran, type_offspring', ty_ass, nameset)
                 else res)
                ((true, ty_ass'),Assemblies.getTypeOffspringMap type_offspring)
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
                              ("Cannot share types with type constructor " ^
                               (IdentPrint.printTyCon
                                (Lists.hd(!share_failures))) ^ ": " ^ 
                               (Lists.hd(!failure_reasons)))
                          else
                            "Cannot share types with type constructors\n   {"^
                            makeE(!share_failures,!failure_reasons)
                      in
                        raise ShareError (makeErrorMesg())
                      end
                           
                else (old_share_failures:= !share_failures;
                      findFixpoint())
              end)

           val (tyshare_successful,ty_ass'') = findFixpoint()
        in
	   if strshare_successful andalso tyshare_successful then
	     (true,str_ass',ty_ass'')
	   else (false,str_ass,ty_ass)
        end

    (****
     To ensure that the structure assembly is updated correctly the entries
     corresponding to the strnames being shared are first removed from the 
     structure assembly (once it has been determined that the sharing is 
     possible), then the references are updated (sharing done), and 
     then they are both added to the structure assembly again. 
     There is a general problem here to do with sharing functor results with
     functor arguments. This is becase functor arguments look flexible, and
     so we may end up with functor arguments being side effected when we don't
     require it.
     ****)

    and share_str' (name as METASTRNAME (r as ref (NULLNAME _)),
		    name' as METASTRNAME (r' as ref (NULLNAME _)),
		    str_ass,ty_ass,nameset) =
      if Strnames.strname_eq (name, name') then
	(true,str_ass,ty_ass)
      else
	let
	  val (consist,str_ass',ty_ass') = 
	    consistent (name,name',str_ass,ty_ass,nameset) 
	in
	  if consist then
	    let
	      val (str_offspring,type_offspring) =
		Assemblies.lookupStrname (name,str_ass')
	      val (str_offspring',type_offspring') =
		Assemblies.lookupStrname (name',str_ass')
	      val str_ass'' = Assemblies.remfromStrAssembly 
		(name,Assemblies.remfromStrAssembly (name',str_ass'))
	    in
	      (* Here we should check if either name or name' is in nameset *)
	      (if Nameset.member_of_strnames(name, nameset) then
		 r' := name
	       else
		r := name');
	      (true,
	       Assemblies.add_to_StrAssembly 
	       (name, str_offspring, type_offspring,
		Assemblies.add_to_StrAssembly 
		(name', str_offspring', type_offspring',
		 str_ass'')),
	       ty_ass')
	    end
	  else 
            (* I think another error always occurs before this *)
	    raise ShareError "impossible type error 17: structures are not consistent"
	end
      | share_str' (name as METASTRNAME (r as ref (NULLNAME _)),
		   name',str_ass,ty_ass,nameset) = 
        let
          val (consist,str_ass',ty_ass') = 
            consistent (name,name',str_ass,ty_ass,nameset)
        in
          if consist then
            (****
             name' is a rigid structure name.
             ****)
            if cover (name',name,str_ass',nameset) then
              let
                val (str_offspring,type_offspring) =
                  Assemblies.lookupStrname (name,str_ass')
                val str_ass'' = Assemblies.remfromStrAssembly (name,
                                                               str_ass')
              in
                (r := name';
                 (true,
                  Assemblies.add_to_StrAssembly 
                  (name,str_offspring,type_offspring,
                   str_ass''),ty_ass'))
              end
            else 
              raise ShareError "Basis does not cover structure"
          else
            raise ShareError "impossible type error 18: structures are not consistent"
        end
      | share_str' (name,name' as METASTRNAME (r as ref (NULLNAME _)),
		    str_ass,ty_ass,nameset) =
	let
	  val (consist,str_ass',ty_ass') =
	    consistent (name,name',str_ass,ty_ass,nameset)
	in
	  if consist then
	    (****
	     name is a rigid structure name.
	     ****)
	    if cover (name,name',str_ass',nameset) then
	      let
		val (str_offspring,type_offspring) =
		  Assemblies.lookupStrname (name',str_ass')
		val str_ass'' = Assemblies.remfromStrAssembly (name',
							       str_ass')
	      in
		(r := name;
		 (true,
		  Assemblies.add_to_StrAssembly 
		  (name',str_offspring,type_offspring,
		   str_ass''),ty_ass'))
	      end
	    else 
	      raise ShareError "Basis does not cover structure"
	  else
	    raise ShareError "impossible type error 19: structures are not consistent"
	end
      | share_str' (name,name',str_ass,ty_ass,_) =
        if Strnames.strname_eq (name,name') then
          (true,str_ass,ty_ass)
        else
          raise ShareError "Rigid structures are not equal"

    (****
     Make sure that sharing the two structures will not violate covering.
     See The Definition p. 35.
     ****)

   and cover (name,name' as METASTRNAME (ref (NULLNAME _)),str_ass,nameset) =
     let
       val (str_offspring,type_offspring) = 
         Assemblies.lookupStrname (name,str_ass)
       val (str_offspring',type_offspring') = 
         Assemblies.lookupStrname (name',str_ass)
     in
       if Nameset.member_of_strnames (name,nameset) then
         let
           val stridlist = Assemblies.getStrIds str_offspring
           val tyconlist = Assemblies.getTyCons type_offspring
           val stridlist' = Assemblies.getStrIds str_offspring'
           val tyconlist' = Assemblies.getTyCons type_offspring'
         in
           ordered_sublist (stridlist',stridlist) andalso 
           ordered_sublist (tyconlist',tyconlist)
         end
       else true
     end
     | cover _ = Crash.impossible "cover bad parameters"

    and share_str(name,name',str_ass,ty_ass,nameset) =
      let
	val name = Strnames.strip name
	val name' = Strnames.strip name'
      in
	if Nameset.member_of_strnames(name, nameset) andalso
	  Nameset.member_of_strnames(name', nameset) then
	  (* This is to catch the case that the names are functor parameters *)
	  (* and are trying to be shared by the functor result *)
	  if Strnames.strname_eq (name, name') then
	    (true,str_ass,ty_ass)
	  else
	    raise ShareError "Rigid structures are not equal"
	else
	  share_str'(name, name',str_ass,ty_ass, nameset)
      end
	
  end
