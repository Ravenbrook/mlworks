(* _mir_env.sml the functor *)
(*
$Log: _mir_env.sml,v $
Revision 1.21  1996/03/28 10:45:44  matthew
Adding where type clause

 * Revision 1.20  1995/12/04  11:52:22  matthew
 * Simplifying lambdatypes
 *
Revision 1.19  1994/10/13  10:22:37  matthew
Make lookup_in_closure return an Option value

Revision 1.18  1993/03/10  17:13:50  matthew
Signature revisions

Revision 1.17  1993/02/01  17:32:05  matthew
Added sharing

Revision 1.16  1992/10/30  12:10:31  jont
Changed to use LambdaTypes.Map

Revision 1.15  1992/10/29  18:21:27  jont
Removed LVar_ordering in favour of LVar_order (both same)

Revision 1.14  1992/10/05  09:46:31  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.13  1992/08/19  18:11:44  davidt
Mir_Env now uses NewMap instead of Map.

Revision 1.12  1992/07/21  11:37:40  jont
Removed is_in_lambda_env and is_in_closure_env, not needed

Revision 1.11  1992/03/12  12:50:31  jont
Changed environments to use eqfunmaps (slightly more efficient)

Revision 1.10  1991/09/05  16:35:49  jont
Added augment_lambda_env

Revision 1.9  91/09/02  11:52:34  jont
Removed translations from primitives to HARP

Revision 1.8  91/08/30  14:55:33  jont
Removed Prim_Calc and associated items, now explicit in mir_cg

Revision 1.7  91/08/23  14:03:08  jont
Changed to use pervasives

Revision 1.6  91/08/15  11:17:13  jont
Updated for later version of HARP

Revision 1.5  91/08/09  12:51:06  jont
Added encodings for unary minus

Revision 1.4  91/08/07  15:30:27  jont
Added special constant equality functions

Revision 1.3  91/07/30  17:28:03  jont
Added closure environment

Revision 1.2  91/07/26  14:21:47  jont
Added empty_lambda_env

Revision 1.1  91/07/25  11:36:35  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/intnewmap";
require "../lambda/lambdatypes";
require "mirtypes";
require "mir_env";

functor Mir_Env(
  structure LambdaTypes : LAMBDATYPES where type LVar = int
  structure MirTypes : MIRTYPES
  structure IntMap : INTNEWMAP
  sharing type MirTypes.Debugger_Types.Type = LambdaTypes.Type
                ) : MIR_ENV =

struct
  structure LambdaTypes = LambdaTypes
  structure MirTypes = MirTypes

  type 'a Map = 'a IntMap.T

  datatype Lambda_Env = LAMBDA_ENV of (MirTypes.any_register) IntMap.T
  val empty_lambda_env =
    LAMBDA_ENV(IntMap.empty)

  datatype Closure_Env = CLOSURE_ENV of (int) IntMap.T
  val empty_closure_env = CLOSURE_ENV(IntMap.empty)

  fun add_lambda_env((lv, reg), LAMBDA_ENV env) = LAMBDA_ENV(IntMap.define(env, lv, reg))
  fun lookup_lambda(lv, LAMBDA_ENV env) = IntMap.tryApply'(env, lv)

  fun augment_lambda_env(LAMBDA_ENV lenv1, LAMBDA_ENV lenv2) = LAMBDA_ENV(IntMap.union(lenv1, lenv2))
  fun add_closure_env((lv, i), CLOSURE_ENV env) = CLOSURE_ENV(IntMap.define(env, lv, i))

  fun lookup_in_closure(lv, CLOSURE_ENV env) = IntMap.tryApply'(env, lv)
end
