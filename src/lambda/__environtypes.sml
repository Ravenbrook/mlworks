(* __environtypes.sml the structure *)
(*
$Log: __environtypes.sml,v $
Revision 1.6  1993/07/07 16:39:40  daveb
Removed Interface structure.

Revision 1.5  1993/03/10  15:43:39  matthew
Signature revisions

Revision 1.4  1993/01/26  09:35:33  matthew
Simplified parameter signature

Revision 1.3  1992/06/10  13:18:03  jont
Changed to use newmap

Revision 1.2  1991/07/08  17:49:40  jont
Added Interface for use in functor environment

Revision 1.1  91/06/11  11:13:00  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__btree";
require "__lambdatypes";
require "_environtypes";

structure EnvironTypes_ =
  EnvironTypes(structure NewMap = BTree_
               structure LambdaTypes = LambdaTypes_
               )
