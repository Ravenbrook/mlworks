(*
$Log: __absynprint.sml,v $
Revision 1.5  1993/05/18 13:35:15  jont
Removed Integer parameter

Revision 1.4  1992/12/08  18:30:55  jont
Removed a number of duplicated signatures and structures

Revision 1.3  1992/02/14  14:02:28  jont
Added integer parameter

Revision 1.2  1991/11/19  19:25:37  jont
Added crash parameter

Revision 1.1  91/06/07  10:51:30  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "../utils/__sexpr";
require "../utils/__lists";
require "../utils/__set";
require "__identprint";
require "__absyn";
require "../typechecker/__types";
require "_absynprint";

structure AbsynPrint_ = AbsynPrint(
  structure Sexpr      = Sexpr_
  structure Set        = Set_
  structure Lists      = Lists_
  structure IdentPrint = IdentPrint_
  structure Absyn      = Absyn_
  structure Types      = Types_
)
