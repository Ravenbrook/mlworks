(* __unify.sml the structure *)
(*
$Log: __unify.sml,v $
Revision 1.8  1995/02/02 14:06:33  matthew
Removing debug structure

Revision 1.7  1993/05/18  18:22:38  jont
Removed integer parameter

Revision 1.6  1993/04/01  16:35:52  jont
Added option structure to functor parameters

Revision 1.5  1993/02/08  12:02:30  matthew
Changes for BASISTYPES signature

Revision 1.4  1992/04/16  17:51:42  jont
Added lists parameter

Revision 1.3  1992/01/27  18:55:05  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:43:09  jont
Added copyright message

Revision 1.1  91/06/07  11:33:43  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__print";
require "../utils/__lists";
require "../utils/__crash";
require "../main/__options";
require "../typechecker/__types";
require "../typechecker/_unify";

structure Unify_ = Unify(
  structure Crash     = Crash_
  structure Lists     = Lists_
  structure Print     = Print_
  structure Options = Options_
  structure Types     = Types_
);
