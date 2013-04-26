(* environ.sml  the signature *)
(*
$Log: environ.sml,v $
Revision 1.36  1996/11/22 12:05:54  matthew
Removing reference to MLWorks.Option

 * Revision 1.35  1995/08/01  15:32:53  jont
 * Modification to the detection of overloaded valids
 *
Revision 1.34  1995/08/01  09:50:22  matthew
Adding environment simplifier

Revision 1.33  1995/03/27  16:40:09  jont
Remove Builtin_p and modify FindBuiltin

Revision 1.32  1994/02/28  05:35:45  nosa
Debugger environments for Modules Debugger.

Revision 1.31  1993/10/28  14:40:00  nickh
Merging in code change.

Revision 1.30.1.2  1993/10/27  16:31:48  nickh
Added a new function number_envs, to replace uses of Lists.number_with_size,
a function which was too ugly (and inefficient) to live.

Revision 1.30.1.1  1993/07/07  16:40:24  jont
Fork for bug fixing

Revision 1.30  1993/07/07  16:40:24  daveb
Removed exception environments and interfaces.

Revision 1.29  1993/03/10  15:37:22  matthew
Added type Structure

Revision 1.28  1993/03/09  12:56:07  matthew
Str to Structure

Revision 1.27  1993/02/02  10:13:07  matthew
Added make_interface_from_str.
Rationalised substructures

Revision 1.26  1992/12/08  18:52:17  jont
Removed a number of duplicated signatures and structures

Revision 1.25  1992/10/28  11:46:22  jont
Removed some irrelevant ident comparison functions

Revision 1.24  1992/10/02  16:19:06  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.23  1992/09/22  13:48:53  richard
Added make_str_env.

Revision 1.22  1992/08/26  11:39:17  jont
Removed some redundant structures and sharing

Revision 1.21  1992/08/18  19:39:21  davidt
Added sigid_order and symbol_order functions.

Revision 1.20  1992/08/05  17:03:05  jont
Removed some structures and sharing

Revision 1.19  1992/06/17  15:23:38  jont
Added make_external for benefit of interpreter

Revision 1.18  1992/06/10  15:10:48  jont
Changed to use newmap

Revision 1.17  1992/06/03  14:38:10  jont
Added assign_fields function

Revision 1.16  1992/01/09  17:27:10  jont
Changed paramter ordering in environment update to allow use with
Lists.foldl

Revision 1.15  1991/07/12  17:09:16  jont
Added exception environment to env

Revision 1.14  91/07/11  09:40:55  jont
Added empty_fun_env, add_funid_env

Revision 1.13  91/07/10  12:00:15  jont
Removed make_imperative_primitives (now in main/primitives)

Revision 1.12  91/07/09  17:10:04  jont
Added empty_top_env and lookup_funid

Revision 1.11  91/07/08  17:16:12  jont
Added augment_top_env

Revision 1.10  91/07/08  15:33:23  jont
Added function to find imperative primitives

Revision 1.9  91/07/05  15:01:04  jont
Added overload environment to handle overloaded primitives such as +

Revision 1.8  91/06/27  12:47:44  jont
Removed Findconst from signature, as it's never used

Revision 1.7  91/06/24  11:32:50  jont
Removed match support, as this is internal to _lambda

Revision 1.6  91/06/21  10:30:46  jont
Modified match environment functions for use with fold. Changed
names to be consistent with value environment

Revision 1.5  91/06/19  17:44:00  jont
Added match environment type, and changed the types of matchvar
lookup and generate

Revision 1.4  91/06/17  14:49:00  jont
Change add_valid_env and add_strid_env to have type 'a * Env -> Env
to allow use with foldleft or foldright

Revision 1.3  91/06/12  13:44:00  jont
Added is_empty function for environments

Revision 1.2  91/06/11  16:54:29  jont
Abstracted out the types from the functions

Copyright (c) 1991 Harlequin Ltd.
*)

require "environtypes";

signature ENVIRON =
sig
  structure EnvironTypes: ENVIRONTYPES

  type Structure

  val empty_env: EnvironTypes.Env
  val empty_fun_env: EnvironTypes.Fun_Env
  val empty_top_env: EnvironTypes.Top_Env

  val empty_denv: EnvironTypes.DebuggerEnv

  val add_valid_env: EnvironTypes.Env * (EnvironTypes.LambdaTypes.Ident.ValId * EnvironTypes.comp) ->
    EnvironTypes.Env
    (* Add one ValId translation to an existing environment *)

  val add_strid_env:
    EnvironTypes.Env * (EnvironTypes.LambdaTypes.Ident.StrId * (EnvironTypes.Env * EnvironTypes.comp * bool))
      -> EnvironTypes.Env
    (* Add one StrId translation to an existing environment *)

  val add_valid_denv: EnvironTypes.DebuggerEnv * (EnvironTypes.LambdaTypes.Ident.ValId * EnvironTypes.DebuggerExp) ->
    EnvironTypes.DebuggerEnv
    (* Add one ValId translation to an existing environment *)

  val add_strid_denv:
    EnvironTypes.DebuggerEnv * 
    (EnvironTypes.LambdaTypes.Ident.StrId * EnvironTypes.DebuggerStrExp)
      -> EnvironTypes.DebuggerEnv
    (* Add one StrId translation to an existing environment *)

  val augment_env: EnvironTypes.Env * EnvironTypes.Env -> EnvironTypes.Env
    (* augment env by new env *)

  val augment_denv : 
    EnvironTypes.DebuggerEnv * EnvironTypes.DebuggerEnv -> EnvironTypes.DebuggerEnv
    (* augment env by new env *)

  val lookup_valid: EnvironTypes.LambdaTypes.Ident.ValId * EnvironTypes.Env -> EnvironTypes.comp

  val lookup_strid: EnvironTypes.LambdaTypes.Ident.StrId * EnvironTypes.Env ->
    EnvironTypes.Env * EnvironTypes.comp * bool

  val lookup_valid': EnvironTypes.LambdaTypes.Ident.ValId * EnvironTypes.DebuggerEnv -> EnvironTypes.DebuggerExp

  val lookup_strid': EnvironTypes.LambdaTypes.Ident.StrId * EnvironTypes.DebuggerEnv ->
    EnvironTypes.DebuggerStrExp

  val FindBuiltin: EnvironTypes.LambdaTypes.Ident.LongValId * EnvironTypes.Env ->
    EnvironTypes.LambdaTypes.Primitive option

  val define_overloaded_ops: (string * EnvironTypes.LambdaTypes.Primitive) list -> unit

  val overloaded_op: EnvironTypes.LambdaTypes.Ident.ValId -> 
    EnvironTypes.LambdaTypes.Primitive option

  val add_funid_env:
    EnvironTypes.Fun_Env *
    (EnvironTypes.LambdaTypes.Ident.FunId * (EnvironTypes.comp * EnvironTypes.Env * bool))
    -> EnvironTypes.Fun_Env
    (* Add one FunId translation to an existing environment *)

  val augment_top_env:
    EnvironTypes.Top_Env * EnvironTypes.Top_Env -> EnvironTypes.Top_Env
    (* augment top env by new top env *)

  val lookup_funid: EnvironTypes.LambdaTypes.Ident.FunId * EnvironTypes.Fun_Env ->
    EnvironTypes.comp * EnvironTypes.Env * bool

  val assign_fields : EnvironTypes.Top_Env -> EnvironTypes.Top_Env

  val number_envs : ('a list * 'b list * 'c list) ->
                     (('a * EnvironTypes.comp) list *
		      ('b * EnvironTypes.comp) list *
		      ('c * EnvironTypes.comp) list)

  val make_external : EnvironTypes.Top_Env -> EnvironTypes.Top_Env

  (* Take a Str and turn it into a lambda environment in which all *)
  (* identifiers are mapped to appropriately numbered fields.  Substructures *)
  (* are treated recursively. *)

  val make_str_env : Structure * bool -> EnvironTypes.Env

  val make_str_dexp : Structure -> EnvironTypes.DebuggerStrExp

  val simplify_topenv : EnvironTypes.Top_Env * EnvironTypes.LambdaTypes.LambdaExp -> EnvironTypes.Top_Env

end
