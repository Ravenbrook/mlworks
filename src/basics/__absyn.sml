(* __absyn.sml the structure *)
(*
$Log: __absyn.sml,v $
Revision 1.15  1995/12/05 12:08:46  jont
Add Types and Lists to functor parameters

Revision 1.14  1995/11/22  09:16:00  daveb
Removed ModuleId parameter.

Revision 1.13  1995/01/04  12:20:41  matthew
Renaming debugger_env to runtime_env

Revision 1.12  1994/09/13  10:13:54  matthew
Abstraction of debug information

Revision 1.11  1993/07/30  14:43:20  daveb
Removed Option parameter, added ModuleId parameter.

Revision 1.10  1993/06/01  08:34:52  nosa
structure Option.

Revision 1.9  1993/05/18  18:42:40  jont
Removed integer parameter

Revision 1.8  1993/02/08  15:38:33  matthew
Removed nameset structure and ref nameset from FunBind (which wasn't used)

Revision 1.7  1993/02/03  17:48:54  matthew
Rationalised functor parameter

Revision 1.6  1992/12/17  17:33:36  matthew
> Changed int and real scons to carry a location around

Revision 1.5  1992/09/04  08:26:04  richard
Installed central error reporting mechanism.

Revision 1.4  1992/05/19  09:36:53  clive
Added marks for better error reporting

Revision 1.3  1991/11/21  15:52:25  jont
Added copyright message

Revision 1.2  91/06/27  13:42:00  colin
added Interface annotation for signature expressions

Revision 1.1  91/06/07  10:49:28  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../typechecker/__types";
require "../debugger/__runtime_env";
require "../utils/__set";
require "../utils/__lists";
require "_absyn";

structure Absyn_ =
  Absyn (structure Types = Types_
         structure RuntimeEnv = RuntimeEnv_
	 structure Set = Set_
	 structure Lists = Lists_);

