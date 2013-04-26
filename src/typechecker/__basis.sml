(* __basis.sml the structure *)
(*
$Log: __basis.sml,v $
Revision 1.9  1996/09/25 14:11:32  andreww
[Bug #1593]
Adding Stamp structure to the basis functor.

 * Revision 1.8  1995/02/07  16:05:18  matthew
 * Adding Strenv structure
 *
Revision 1.7  1995/01/30  11:46:13  matthew
Rationalizing debugger

Revision 1.6  1993/02/08  18:19:36  matthew
Changes for BASISTYPES signature

Revision 1.5  1992/10/01  12:08:05  richard
Added Types structure parameter.

Revision 1.4  1992/08/11  18:37:44  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1992/01/27  17:33:38  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:37:55  jont
Added copyright message

Revision 1.1  91/06/07  11:10:10  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__print";
require "../basics/__identprint";
require "__valenv";
require "__strenv";
require "__tyenv";
require "__scheme";
require "__nameset";
require "__environment";
require "__sigma";
require "__types";
require "__stamp";
require "_basis";
  
structure Basis_ = Basis(
  structure Stamp = Stamp_
  structure IdentPrint = IdentPrint_
  structure Valenv = Valenv_
  structure Strenv = Strenv_
  structure Tyenv = Tyenv_
  structure Nameset = Nameset_
  structure Scheme = Scheme_
  structure Env = Environment_
  structure Sigma = Sigma_
  structure Types = Types_
  structure Lists = Lists_
  structure Print = Print_
);
