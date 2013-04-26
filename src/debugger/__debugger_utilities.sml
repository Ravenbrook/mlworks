(* __debugger_utilities the structure *)
(*
$Log: __debugger_utilities.sml,v $
Revision 1.3  1995/04/13 13:21:32  matthew
Adding Scheme

# Revision 1.2  1995/03/08  11:03:47  matthew
# Removing Tags
#
# Revision 1.1  1995/01/30  13:14:03  matthew
# new unit
# Renamed to debugger_utilities
#
Revision 1.8  1993/12/09  19:26:08  jont
Added copyright message

Revision 1.7  1993/05/18  18:41:33  jont
Removed integer parameter

Revision 1.6  1993/04/29  10:20:21  matthew
 Renamed Debugger_Type_Utilities to DebuggerTypeUtilities

Revision 1.5  1993/02/04  15:45:33  matthew
Changed functor parameter

Revision 1.4  1992/11/10  12:58:13  matthew
Changed Error structure to Info

Revision 1.3  1992/09/03  09:30:06  richard
Insalled central error reporting mechanism.

Revision 1.2  1992/07/16  16:57:59  clive
Added utilites for the polymorphic deduction code

Revision 1.1  1992/07/09  09:42:50  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__crash";
require "../typechecker/__types";
require "../typechecker/__scheme";
require "__debugger_types";
require "_debugger_utilities";

structure DebuggerUtilities_ =
  DebuggerUtilities (structure Lists = Lists_
                     structure Crash = Crash_
                     structure Types = Types_
                     structure Scheme = Scheme_
                     structure Debugger_Types = Debugger_Types_
                       )
