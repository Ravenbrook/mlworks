(* __actionfunctions-start.sml the structure *)
(*
$Log: __actionfunctions.sml,v $
Revision 1.10  1995/11/22 09:15:44  daveb
Removed ModuleId parameter.

Revision 1.9  1995/02/14  12:40:08  matthew
Adding Options structure

Revision 1.8  1993/07/29  12:53:28  daveb
Added ModuleId parameter.

Revision 1.7  1993/05/18  19:16:47  jont
Removed integer parameter

Revision 1.6  1993/02/23  13:56:15  matthew
Removed parserenv structure

Revision 1.5  1992/12/08  15:38:14  jont
Removed a number of duplicated signatures and structures

Revision 1.4  1992/11/05  16:11:28  matthew
Changed Error structure to Info

Revision 1.3  1992/09/25  11:41:28  jont
Removed __map, no longer used

Revision 1.2  1992/09/04  08:44:30  richard
Installed central error reporting mechanism.

Revision 1.1  1992/08/25  16:33:12  matthew
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)
require "../utils/__lists";
require "../utils/__set";
require "../basics/__identprint";
require "../basics/__token";
require "../parser/__derived";
require "../utils/__crash";
require "__LRbasics";
require "_actionfunctions";

structure ActionFunctions_ =
  ActionFunctions
    (structure Lists = Lists_
     structure Set = Set_
     structure LRbasics = LRbasics_
     structure Derived = Derived_
     structure IdentPrint = IdentPrint_
     structure Token = Token_
     structure Crash = Crash_);
