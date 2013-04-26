
(*
 * Lambda Optimiser: lambdasub.sml
 * sub-functions for lambda modules.
 *
 * Copyright (c) 1991 Harlequin Ltd.
 *)

(*
require "../utils/__crash";
require "../utils/__print";
require "../utils/__delayed_newhashtable";
require "../main/__primitives";
*)

require "__lambdatypes";
require "_lambdasub";

structure LambdaSub_ = LambdaSub(
(*
  structure Crash = Crash_
  structure Print = Print_
  structure Primitives = Primitives_
  structure DelayedNewHashTable = DelayedNewHashTable_
*)
  structure LambdaTypes = LambdaTypes_
)

(*
$Log: __lambdasub.sml,v $
Revision 1.11  1996/10/31 15:39:03  io
[Bug #1614]
remove Lists

 * Revision 1.10  1995/03/01  12:40:01  matthew
 * Trimming down for new optimizer
 *
Revision 1.9  1992/09/21  11:55:30  clive
Changed hashtables to a single structure implementation

Revision 1.8  1992/07/03  09:20:42  davida
Added new parameter.

Revision 1.7  1992/04/22  16:43:11  clive
General speed improvements

Revision 1.6  1992/02/28  18:56:28  jont
Added balanced tree parameter

Revision 1.5  1991/10/22  15:54:25  davidt
Now builds using the Crash_ structure

Revision 1.4  91/09/06  10:15:39  davida
List sub-functions removed and put in Lists

Revision 1.3  91/07/24  12:52:24  davida
Now takes primitive structure as arg for is_expansive 
(and later some function examining commutativity of primitives)

Revision 1.2  91/07/16  16:21:54  davida
> Added new functions set_of_lvars and is_expansive.

Revision 1.1  91/07/15  16:09:40  davida
Initial revision

*)

