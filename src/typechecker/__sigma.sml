(* __newsigma.sml the structure *)
(*
$Log: __sigma.sml,v $
Revision 1.11  1998/01/30 09:50:44  johnh
[Bug #30326]
Merge im change from branch MLWorks_workspace_97

 * Revision 1.10  1997/11/13  11:24:04  jont
 * [Bug #30089]
 * Remove unnecessary require of utils/__timer
 *
 * Revision 1.9.10.2  1997/11/20  17:09:15  daveb
 * [Bug #30326]
 *
 * Revision 1.9.10.1  1997/09/11  21:10:25  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.9  1995/03/24  15:13:27  matthew
 * Adding Stamp
 *
Revision 1.8  1995/02/07  14:49:10  matthew
Removing debug stuff

Revision 1.7  1993/03/17  18:36:58  matthew
Added BasisTypes structure

Revision 1.6  1992/08/03  12:58:42  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/06/24  17:19:43  jont
Changed to imperative implementation of namesets with hashing

Revision 1.1  1992/04/21  14:59:01  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "__strnames";
require "__nameset";
require "__types";
require "__scheme";
require "__environment";
require "__basistypes";
require "__stamp";
require "_sigma";

structure Sigma_ = Sigma(
  structure Strnames  = Strnames_
  structure Nameset   = Nameset_
  structure Types     = Types_
  structure Scheme    = Scheme_
  structure Env       = Environment_
  structure BasisTypes = BasisTypes_
  structure Stamp = Stamp_
);
