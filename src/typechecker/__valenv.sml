(* __valenv.sml the structure *)
(*
$Log: __valenv.sml,v $
Revision 1.9  1995/05/26 10:10:52  matthew
Get list of builtin library values from Primitives

Revision 1.8  1995/02/02  14:08:26  matthew
Removing debug structure

Revision 1.7  1994/05/04  17:32:19  daveb
Added Info structure.

Revision 1.6  1992/08/11  17:54:11  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/07/16  18:59:28  jont
added btree parameter

Revision 1.4  1992/01/27  18:57:45  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.3  1992/01/27  18:57:45  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:43:32  jont
Added copyright message

Revision 1.1  91/06/07  11:33:58  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../main/__info";
require "../main/__primitives";
require "../basics/__identprint";
require "../typechecker/__types";
require "../typechecker/__scheme";

require "../typechecker/_valenv";

structure Valenv_ = Valenv(
  structure Crash     = Crash_
  structure Lists     = Lists_
  structure Info      = Info_
  structure Primitives      = Primitives_
  structure IdentPrint = IdentPrint_
  structure Types     = Types_
  structure Scheme    = Scheme_
);



