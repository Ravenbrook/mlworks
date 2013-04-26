(* _inter_envtypes.sml the functor *)
(*
$Log: _inter_envtypes.sml,v $
Revision 1.23  1998/02/20 09:33:51  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.22  1997/05/19  10:43:47  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.21  1996/05/01  09:40:55  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.20  1996/03/19  16:19:42  matthew
 * Problems with value polymorphism
 *
 * Revision 1.19  1996/02/23  17:48:49  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.18  1994/12/06  10:32:23  matthew
 * Changing uses of cast
 *
Revision 1.17  1993/07/05  13:55:20  daveb
Removed exception environments.

Revision 1.16  1993/04/26  17:01:01  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.15  1993/03/11  10:26:12  matthew
Signature revisions

Revision 1.14  1993/03/04  18:08:06  matthew
Options & Info changes

Revision 1.13  1992/11/27  15:06:10  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.12  1992/10/27  18:29:00  jont
Changeed maps to use valid_lt. Removed dependence on _environ

Revision 1.11  1992/10/13  14:13:32  richard
Corrected a the *completely* bogus implementation of augment.
Added print.

Revision 1.10  1992/10/06  08:27:40  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.9  1992/09/10  16:57:33  richard
Added augment_with_module to do the job of linking module contents
into the environment.

Revision 1.8  1992/08/26  18:57:15  richard
Rationalisation of the MLWorks structure.

Revision 1.7  1992/08/26  18:54:42  jont
Removed some redundant structures and sharing

Revision 1.6  1992/08/19  10:55:15  clive
Changes to reflect pervasive_library changes

Revision 1.5  1992/08/13  16:17:09  clive
Changes to reflect lower level sharing changes

Revision 1.4  1992/08/04  18:47:17  jont
Reworked in terms of NewMap.fold and NewMap.union

Revision 1.3  1992/07/29  09:53:03  jont
Removed references to callc_codes and __callc_codes

Revision 1.2  1992/06/19  17:01:55  jont
Fixed the source errors

Revision 1.1  1992/06/18  12:10:39  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/lists";
require "../lambda/environtypes";
require "../basics/identprint";
require "inter_envtypes";

functor Inter_EnvTypes(
  structure Lists : LISTS
  structure EnvironTypes : ENVIRONTYPES
  structure IdentPrint : IDENTPRINT

  sharing IdentPrint.Ident = EnvironTypes.LambdaTypes.Ident
) : INTER_ENVTYPES =
struct
  structure NewMap = EnvironTypes.NewMap
  structure Ident = EnvironTypes.LambdaTypes.Ident
  structure EnvironTypes = EnvironTypes
  structure Options = IdentPrint.Options

  datatype inter_env =
    INTER_ENV of
    (Ident.ValId, MLWorks.Internal.Value.ml_value) NewMap.map * (* VARs *)
    (Ident.StrId, MLWorks.Internal.Value.ml_value) NewMap.map * (* STRs *)
    (Ident.FunId, MLWorks.Internal.Value.ml_value) NewMap.map (* FUNs *)

  val castit = MLWorks.Internal.Value.cast

  val empty_val_map = NewMap.empty (Ident.valid_lt,Ident.valid_eq)

  val empty_str_map = NewMap.empty (Ident.strid_lt,Ident.strid_eq)

  val empty_fun_map = NewMap.empty (Ident.funid_lt,Ident.funid_eq)

  fun lookup_val(valid, INTER_ENV(val_map, _, _)) =
    NewMap.apply'(val_map, valid)

  fun lookup_str(strid, INTER_ENV(_, str_map, _)) =
    NewMap.apply'(str_map, strid)

  fun lookup_fun(funid, INTER_ENV(_, _, fun_map)) =
    NewMap.apply'(fun_map, funid)

  fun add_val(INTER_ENV(val_map, str_map, fun_map), (valid, value)) =
    INTER_ENV(NewMap.define(val_map, valid, value), str_map, fun_map)

  fun add_str(INTER_ENV(val_map, str_map, fun_map), (strid, value)) =
    INTER_ENV(val_map, NewMap.define(str_map, strid, value), fun_map)

  fun add_fun(INTER_ENV(val_map, str_map, fun_map), (funid, value)) =
    INTER_ENV(val_map, str_map, NewMap.define(fun_map, funid, value))

  fun add_val'(INTER_ENV(val_map, str_map, fun_map), valid, value) =
    INTER_ENV(NewMap.define(val_map, valid, value), str_map, fun_map)

  fun add_str'(INTER_ENV(val_map, str_map, fun_map), strid, value) =
    INTER_ENV(val_map, NewMap.define(str_map, strid, value), fun_map)

  fun add_fun'(INTER_ENV(val_map, str_map, fun_map), funid, value) =
    INTER_ENV(val_map, str_map, NewMap.define(fun_map, funid, value))

  fun add_val_list arg =
    Lists.reducel
    add_val
    arg

  fun add_str_list arg =
    Lists.reducel
    add_str
    arg

  fun add_fun_list arg =
    Lists.reducel
    add_fun
    arg

  val empty_env =
    INTER_ENV(empty_val_map, empty_str_map, empty_fun_map)

  fun remove_str(INTER_ENV(val_map, str_map, fun_map), strid) =
    INTER_ENV(val_map, NewMap.undefine(str_map, strid), fun_map)

  fun augment(inter_env,
	      INTER_ENV(val_map, str_map, fun_map)) =
    let
      val inter_env = NewMap.fold add_val' (inter_env, val_map)
      val inter_env = NewMap.fold add_fun' (inter_env, fun_map)
      val inter_env = NewMap.fold add_str' (inter_env, str_map)
    in
      inter_env
    end

  exception Augment

  fun augment_with_module
        (inter_env,
         EnvironTypes.TOP_ENV (EnvironTypes.ENV (values, structures),
                               EnvironTypes.FUN_ENV functors),
         module) =
    let
      fun link (values, [], alist, f) = (values, alist)
        | link ([], h::_, alist, f) = (print(f h ^ "\n"); raise Augment)
        | link (value::values, x::xs, alist, f) =
          link (values, xs, (x, value)::alist, f)

      val module : MLWorks.Internal.Value.T list = castit module          
      val (module, value_bindings)     = link (module, NewMap.domain_ordered values, [], IdentPrint.debug_printValId)
      val (module, structure_bindings) = link (module, NewMap.domain_ordered structures, [], IdentPrint.printStrId)
      val (module, functor_bindings)   = link (module, NewMap.domain_ordered functors, [], IdentPrint.printFunId)
    in
      ignore(if module = [] then [] else (print"module not empty\n"; raise Augment));
      add_fun_list
      (add_str_list
        (add_val_list
         (inter_env,
          value_bindings),
        structure_bindings),
       functor_bindings)
    end

  fun print options print (out, INTER_ENV (values, structures, functors)) =
    let
      val out =
        NewMap.fold
        (fn (out, valid, _) => print (print (out, " "),
				      IdentPrint.debug_printValId valid))
        (print (out, "values:"), values)
      val out = print (out, "\n")
      val out =
        NewMap.fold
        (fn (out, strid, _) => print (print (out, " "), IdentPrint.printStrId strid))
        (print (out, "structures:"), structures)
      val out = print (out, "\n")
      val out =
        NewMap.fold
        (fn (out, funid, _) => print (print (out, " "), IdentPrint.printFunId funid))
        (print (out, "functors:"), functors)
      val out = print (out, "\n")
    in
      out
    end

end
