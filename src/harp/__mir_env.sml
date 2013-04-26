(* __mir_env.sml the structure *)
(*
$Log: __mir_env.sml,v $
Revision 1.5  1995/12/04 11:53:28  matthew
Simplifying lambdatypes

Revision 1.4  1992/09/25  11:35:39  jont
Removed __map, no longer used

Revision 1.3  1991/09/02  11:54:37  jont
Removed several irrelevant parameters

Revision 1.2  91/08/23  14:35:20  jont
Added pervasives

Revision 1.1  91/07/25  11:44:10  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__intbtree";
require "../lambda/__lambdatypes";
require "__mirtypes";
require "_mir_env";

structure Mir_Env_ = Mir_Env(
  structure IntMap = IntBTree_
  structure LambdaTypes = LambdaTypes_
  structure MirTypes = MirTypes_
)
