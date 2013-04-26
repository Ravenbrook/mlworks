(* debugger_print.sml the signature *)
(*
$Log: debugger_print.sml,v $
Revision 1.8  1995/03/07 15:04:10  matthew
Making debugger platform independent

# Revision 1.6  1995/01/20  12:07:11  matthew
# Renaming debugger_env to runtime_env
#
# Revision 1.5  1994/09/13  16:22:04  matthew
# Abstraction of debug information
#
# Revision 1.4  1993/08/16  13:02:13  nosa
# print_env now takes parent-frames for polymorphic debugger.
#
# Revision 1.3  1993/08/05  16:24:41  nosa
# print_env now returns list used in inspector invocation in debugger-window.
#
# Revision 1.2  1993/08/04  09:53:29  nosa
# Changed type of print_env.
#
# Revision 1.1  1993/07/30  15:45:32  nosa
# Initial revision
#

Copyright (c) 1991 Harlequin Ltd.
*)

require "../main/options";
require "runtime_env";

signature DEBUGGER_PRINT =
  sig

    structure RuntimeEnv : RUNTIMEENV
    structure Options : OPTIONS

    val print_env : 
      ((MLWorks.Internal.Value.Frame.frame * RuntimeEnv.RuntimeEnv * RuntimeEnv.Type)
       * ((RuntimeEnv.Type * MLWorks.Internal.Value.T) -> string)
       * Options.options * bool 
      * (MLWorks.Internal.Value.Frame.frame * RuntimeEnv.RuntimeEnv * RuntimeEnv.Type) list) -> 
      string * 
      (string * (RuntimeEnv.Type * MLWorks.Internal.Value.ml_value * string)) list


  end
