(* _sigma.sml the functor *)
(*
$Log: _sigma.sml,v $
Revision 1.37  1998/02/19 16:47:35  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.36  1998/01/30  09:51:08  johnh
 * [Bug #30326]
 * Merge im change from branch MLWorks_workspace_97
 *
 * Revision 1.35  1997/11/13  11:21:44  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.34.2.2  1997/11/20  17:09:18  daveb
 * [Bug #30326]
 *
 * Revision 1.34.2.1  1997/09/11  21:10:02  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.34  1997/05/19  12:54:47  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.33  1996/10/02  14:08:43  andreww
 * [Bug #1592]
 * propagating level information for new type names.
 *
 * Revision 1.32  1996/04/30  15:32:01  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.31  1995/04/05  09:55:07  matthew
 * Fix for rigid tynames in functor result problem
 * Use Stamp instead of Tyname_id etc.
 * \nImprovements to copying signatures
 *
Revision 1.30  1995/02/07  14:48:04  matthew
Removing debug stuff

Revision 1.29  1994/09/23  12:46:41  matthew
Commented calls to xtime

Revision 1.28  1993/11/30  11:29:36  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.27  1993/06/30  15:37:22  daveb
Removed exception environments.

Revision 1.26  1993/05/21  15:35:10  matthew
Fixed problem with copying COPYSTRs
/

Revision 1.25  1993/04/08  12:50:17  matthew
Simplified interface to *names_of* functions.
Added abstract_sigma function
/

Revision 1.24  1993/03/17  18:38:43  matthew
Nameset signature changes

Revision 1.23  1993/03/04  10:40:15  matthew
Options & Info changes

Revision 1.22  1993/02/19  13:47:17  matthew
Fiddling.

Revision 1.21  1993/02/17  15:37:17  jont
Used compose_maps from environment, and removed COPYSTR of COPYSTR problems

Revision 1.20  1993/02/09  12:07:02  matthew
Changes for BASISTYPES signature

Revision 1.19  1993/02/04  10:10:21  matthew
COPYSTR changes
Strip tynames and strnames before going in nameset

Revision 1.18  1992/12/02  16:19:18  jont
Error message improvements

Revision 1.17  1992/12/01  18:43:00  matthew
Changed Timer.time_it to Timer.xtime.  Added print_timings

Revision 1.16  1992/11/26  16:57:18  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.15  1992/10/30  16:11:19  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.14  1992/10/23  13:15:37  clive
Some bug fixes from Anel

Revision 1.13  1992/09/08  13:06:45  jont
Removed has_a_new_name, no longer needed

Revision 1.12  1992/08/27  18:46:20  davidt
Made various changes so that structure copying can be
done more efficiently.

Revision 1.11  1992/08/11  18:06:16  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.10  1992/08/03  12:27:24  jont
Anel's changes to use NewMap instead of Map

Revision 1.9  1992/07/17  10:38:22  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.8  1992/06/30  10:27:54  jont
Changed to imperative implementation of namesets with hashing

Revision 1.1  1992/04/21  17:27:06  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../typechecker/strnames";
require "../typechecker/nameset";
require "../typechecker/types";
require "../typechecker/scheme";
require "../typechecker/environment";
require "../typechecker/basistypes";
require "stamp";

require "../typechecker/sigma";

functor Sigma (
  structure Strnames  : STRNAMES
  structure Nameset   : NAMESET
  structure Types     : TYPES
  structure Scheme    : TYPESCHEME
  structure Env       : ENVIRONMENT
  structure BasisTypes: BASISTYPES
  structure Stamp : STAMP

  sharing Nameset.Options = Types.Options = Scheme.Options
  sharing Nameset.Datatypes = Env.Datatypes 
    = Scheme.Datatypes = Strnames.Datatypes = Types.Datatypes
    = BasisTypes.Datatypes

  sharing type BasisTypes.Nameset = Nameset.Nameset
  sharing type Types.Datatypes.Stamp = Stamp.Stamp
  sharing type Types.Datatypes.StampMap = Stamp.Map.T

) : SIGMA =
struct
    structure BasisTypes = BasisTypes
    structure Options = Nameset.Options

    open BasisTypes.Datatypes

    (* new_names_of returns all flexible names in a structure *)

    exception GetTyname
    fun get_tyname (ETA_TYFUN name) = name
      | get_tyname _ = raise GetTyname

    fun tyname_strip(METATYNAME{1=ref(ETA_TYFUN tyname), ...}) = tyname_strip tyname
      | tyname_strip tyname = tyname

    fun new_names_of str =
      let
        fun str_names (STR (name,_,env),nameset) =
          let
            val newname = Strnames.strip name
          in
            if (Env.empty_envp env) then
              if (Strnames.uninstantiated newname) then
                Nameset.add_strname (newname,nameset)
              else nameset
            else
              if (Strnames.uninstantiated newname) then
                env_names (env,Nameset.add_strname (newname,nameset))
              else
                env_names (env,nameset)
          end

          (* here, the range of the copy maps define the free names of the structure *)
          (* this arm isn't called for fully expanded structures *)
          | str_names (COPYSTR((smap,tmap),str),nameset) =

            (* Now we just look at the ranges of the two maps *)
            (* These should contain all the free names in the substructure *)
            let
              fun do_strname (nameset,_,strname) =
                if Strnames.uninstantiated strname
                  then Nameset.add_strname (strname,nameset)
                else nameset
              fun do_tyname (nameset,_,TYNAME _) = nameset
                | do_tyname (nameset,_,tyname as (METATYNAME (ref tyfun,_,_,_,_,_))) =
                  if Types.null_tyfunp tyfun
                    then (Nameset.add_tyname (tyname,nameset))
                  else nameset
            in
              Stamp.Map.fold do_strname (Stamp.Map.fold do_tyname (nameset,tmap),smap)
            end
	   
        and env_names (ENV (SE se_map,TE te_map, VE (_, ve_map)),nameset) =
          let 
            fun gather_tynames (nameset, _, TYSTR (tyfun,VE (_,amap))) =
              let
                val nameset' = NewMap.fold gather_ve_tynames (nameset, amap)
              in
                if Types.null_tyfunp tyfun then
                  Nameset.add_tyname (tyname_strip (Types.name tyfun), nameset')
                else
                  nameset'
              end

            and gather_strnames (nameset, _, str) = str_names (str,nameset)

            and gather_ve_tynames (nameset, _, scheme) =
              Nameset.tynames_in_nameset(Scheme.gather_tynames(scheme), nameset)

            val new_nameset = NewMap.fold gather_tynames (nameset, te_map)
            val new_nameset' = NewMap.fold gather_strnames (new_nameset, se_map)
          in
            NewMap.fold gather_ve_tynames (new_nameset', ve_map)
          end
      in
        str_names (str,Nameset.empty_nameset())
      end

    (* names_of returns both flexible and rigid names of a structure. nameset is the accumulator *)

    local 
      fun str_names (STR (name,_,env),nameset) =
        if (Env.empty_envp env) then
          Nameset.add_strname (Strnames.strip name,nameset)
        else
          env_names (env,Nameset.add_strname (Strnames.strip name,nameset))
        | str_names (COPYSTR((smap,tmap),str),nameset) =
          str_names (Env.str_copy (str,smap,tmap),nameset)
	   
      and env_names (ENV (SE se_map,TE te_map,VE (_, ve_map)),nameset) =
        let
          fun gather_tynames(nameset, _, TYSTR (tyfun, _)) =
            if Types.has_a_name tyfun then
              Nameset.add_tyname (tyname_strip(Types.name tyfun), nameset)
            else
              nameset
	    
          fun gather_strnames (nameset, _, str) =
            str_names (str, nameset)

          fun gather_ve_tynames (nameset, _, scheme) = 
            Nameset.tynames_in_nameset (Scheme.gather_tynames (scheme), nameset)
          val new_nameset = NewMap.fold gather_tynames (nameset, te_map)
          val new_nameset' = NewMap.fold gather_strnames (new_nameset, se_map)
        in
          NewMap.fold gather_ve_tynames (new_nameset', ve_map)
        end
    in
      fun names_of str = str_names (str,Nameset.empty_nameset())
      fun names_of_env env = env_names (env,Nameset.empty_nameset())
    end

    fun string_sigma options (BasisTypes.SIGMA (nameset,str)) =
      "SIGMA (" ^ Nameset.string_nameset options nameset ^ "{\n" ^ (Env.string_str str) ^ "})\n"

    fun string_phi options (BasisTypes.PHI (nameset,(str,sigma))) =
      "PHI (" ^ Nameset.string_nameset options nameset ^ ")" ^ 
      "(" ^ Env.string_str str ^ "\n  =>\n  " ^ string_sigma options sigma ^ ")\n"


    (****
     A signature is copied before it is matched against a structure, because
     signature matching is done by side effecting.  To match one signature
     to several structures will therefore become impossible if the signature
     is not copied beforehand.
     ****)

    fun print_map (strname_copies) =
      let
        fun it f [] = () | it f (a::b) = (ignore(f a) ; it f b)
      in
        (print"Copies:\n";
         it
         (fn (id,name) => print(Stamp.string_stamp id ^ ":" ^ Strnames.string_strname name ^ "\n"))
         (Stamp.Map.to_list strname_copies))
      end

    (* This copies the bound tynames in the sigma and returns the relevant *)
    (* substitutions as well as the new sigma *)

    fun sig_copy_return (BasisTypes.SIGMA (nameset,str),expand,
                         strname_copies,tyname_copies,functorp) 
                         newTynameLevel = 
      let 
        val (nameset', strname_copies', tyname_copies') =
          Nameset.nameset_copy (nameset,strname_copies,tyname_copies)
                               newTynameLevel
        val str' = case str of
          COPYSTR(maps, str'') =>
            let
              val (smap,tmap) = Env.compose_maps(maps,(strname_copies',
                                                       tyname_copies'))

              (* If we are doing a functor body, need to add explicit 
                 maps for the functor parameter objects *)

              val (smap',tmap') =
                if functorp
                  then (Stamp.Map.union (strname_copies,smap),
                        Stamp.Map.union(tyname_copies,tmap))
                else (smap,tmap)
            in
              if expand then Env.str_copy (str'',smap',tmap')
              else COPYSTR((smap',tmap'),str'')
            end
        | _ =>
            if expand then Env.str_copy (str, strname_copies',tyname_copies')
            else COPYSTR((strname_copies',tyname_copies'),str)
      in
        (BasisTypes.SIGMA(nameset', str'), strname_copies', tyname_copies')
      end

    fun sig_copy (sigma,expand) newTynameLevel =
      let 
	val (sigma',_,_) =
	  sig_copy_return (sigma, expand,Stamp.Map.empty,
                           Stamp.Map.empty,false) newTynameLevel
      in
	sigma'
      end

    fun phi_copy (phi as BasisTypes.PHI (names,(str,sigma)),expand) 
                 newTynameLevel =
      let
(*
        val _ = output (std_out,"Phi copy:\n")
        val _ = output (std_out,string_phi Options.default_print_options phi)
*)
	val (BasisTypes.SIGMA (names',str'), strname_copies, tyname_copies) =
	  sig_copy_return (BasisTypes.SIGMA (names, str), expand,
                           Stamp.Map.empty, Stamp.Map.empty, false)
                          newTynameLevel

        val (sigma',strname_copies',tyname_copies') = 
          sig_copy_return (sigma, expand,strname_copies, tyname_copies, true)
                          newTynameLevel

        val phi' = BasisTypes.PHI (names', (str', sigma'))

(* DEBUGGING
        val _ = output (std_out,string_phi Options.default_print_options phi')
        val _ = output (std_out,"Phi copy end\n")
*)
      in
	phi'
      end

    (* This functions should copy the sigma with new rigid names 
       for the bound names *)

    fun abstract_sigma (BasisTypes.SIGMA (nameset,str)) newTynameLevel =
      let 
        val (new_nameset, strname_copies, tyname_copies) =
          Nameset.nameset_rigid_copy (nameset,Stamp.Map.empty,Stamp.Map.empty)
                                     newTynameLevel

        val new_str = case str of
          COPYSTR(maps, str) =>
            COPYSTR(Env.compose_maps(maps, (strname_copies, tyname_copies)),
                    str)
        | _ =>
            COPYSTR((strname_copies,tyname_copies),str)
      in
        BasisTypes.SIGMA (new_nameset, new_str)
      end
  end;
