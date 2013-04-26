(* __nameset.sml the structure *)
(*
$Log: __nameset.sml,v $
Revision 1.13  1999/02/02 16:01:38  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.12  1995/03/24  15:10:24  matthew
 * Adding structure Stamp
 *
Revision 1.11  1995/02/02  13:46:16  matthew
Removing debug stuff

Revision 1.10  1993/03/17  18:28:58  matthew
Added NamesetTypes structure

Revision 1.9  1993/03/02  16:27:35  matthew
Indentation change (hardly worth it)

Revision 1.8  1993/02/08  17:37:49  matthew
Nameset type definition moved to BasisTypes

Revision 1.7  1992/09/08  17:11:39  jont
Added Crash = Crash_ to main functor application

Revision 1.6  1992/08/04  15:45:50  davidt
Took out redundant Array arguement and require.

Revision 1.5  1992/07/16  19:12:29  jont
added btree parameter

Revision 1.4  1992/06/30  10:30:37  jont
Changed to imperative implementation of namesets with hashing

Revision 1.1  1992/04/21  17:20:19  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../utils/__set";
require "../utils/__crash";
require "../utils/__print";
require "__types";
require "__strnames";
require "__namesettypes";
require "__stamp";
require "_nameset";

structure Nameset_ = Nameset(
  structure Set       = Set_
  structure Crash     = Crash_
  structure Print     = Print_
  structure Types     = Types_
  structure NamesetTypes = NamesetTypes_
  structure Strnames  = Strnames_
  structure Stamp = Stamp_
);
