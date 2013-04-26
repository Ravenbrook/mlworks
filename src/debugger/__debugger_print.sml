(* __debugger_print.sml the structure *)
(*
$Log: __debugger_print.sml,v $
Revision 1.5  1995/01/18 11:01:39  matthew
Renaming debugger_env to runtime_env

# Revision 1.4  1994/09/13  16:23:32  matthew
# Abstraction of debug information
#
# Revision 1.3  1994/06/09  15:47:56  nickh
# New runtime directory structure.
#
# Revision 1.2  1993/09/07  08:53:44  nosa
# structure Tags.
#
# Revision 1.1  1993/07/30  15:48:33  nosa
# Initial revision
#

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../main/__options";
require "../typechecker/__types";
require "../rts/gen/__tags";
require "__runtime_env";
require "__debugger_utilities";
require "_debugger_print";

structure DebuggerPrint_ = DebuggerPrint(structure Crash = Crash_
                                         structure Lists = Lists_
                                         structure Options = Options_
                                         structure Types = Types_
                                         structure Tags = Tags_
                                         structure RuntimeEnv = RuntimeEnv_
                                         structure DebuggerUtilities = DebuggerUtilities_
                                           );
