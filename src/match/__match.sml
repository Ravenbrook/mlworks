(* __match.sml the structure *)
(*
$Log: __match.sml,v $
Revision 1.14  1995/12/27 15:53:23  jont
Remove __option

Revision 1.13  1995/07/19  15:33:43  jont
Add scons structure for scon_eqval

Revision 1.12  1995/02/07  14:14:53  matthew
Renaming Type_Utils

Revision 1.11  1994/09/13  13:47:54  matthew
Abstraction of debug information

Revision 1.10  1993/05/28  10:23:55  nosa
structure Option.

Revision 1.9  1993/05/18  17:06:35  jont
Removed integer parameter

Revision 1.8  1992/11/04  14:53:45  jont
Changes to allow IntNewMap to be used on MatchVar

Revision 1.7  1992/08/19  16:08:10  davidt
Took out various redundant structure arguments.

Revision 1.6  1992/03/23  11:38:37  jont
Added requires for __ident and __identprint

Revision 1.5  1992/01/23  14:05:23  jont
Added type_utils parameter

Revision 1.4  1992/01/22  19:44:45  jont
Added Crash parameter

Revision 1.3  1991/11/27  12:58:26  jont
Changed name of Match_utils to Match_Utils

Revision 1.2  91/11/21  16:32:48  jont
Added copyright message

Revision 1.1  91/06/07  11:05:59  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__crash";
require "../utils/_counter";
require "../basics/__scons";
require "../basics/__identprint";
require "../basics/__absynprint";
require "../typechecker/__types";
require "__type_utils";

require "_match";

structure Match_ = Match (
  structure Lists = Lists_
  structure Crash = Crash_
  structure MVCounter = Counter()
  structure Scons = Scons_
  structure IdentPrint = IdentPrint_
  structure AbsynPrint = AbsynPrint_
  structure Types = Types_
  structure TypeUtils = TypeUtils_
)

