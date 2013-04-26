(* mir_cg.sml the signature *)
(*
$Log: mir_cg.sml,v $
Revision 1.24  1995/02/13 15:04:43  matthew
Changes to DebuggerTypes structure
Changes to DebuggerTypes structure

Revision 1.23  1993/06/23  15:27:01  daveb
Replaced EnvironTypes with LambdaTypes.

Revision 1.22  1993/03/10  17:18:03  matthew
Signature revisions

Revision 1.21  1993/03/04  14:49:12  matthew
Options & Info changes

Revision 1.20  1992/12/08  19:36:31  jont
Removed a number of duplicated signatures and structures

Revision 1.19  1992/12/01  14:58:51  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.18  1992/11/04  15:49:14  matthew
Changed Error structure to Info

Revision 1.17  1992/09/10  09:35:22  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.16  1992/09/09  10:03:41  clive
Added flag to switch off warning messages in generating recipes

Revision 1.15  1992/09/01  11:30:12  clive
Added switches for self call optimisation

Revision 1.14  1992/08/26  14:30:53  jont
Removed some redundant structures and sharing

Revision 1.13  1992/08/24  16:11:31  clive
Added details about leafness to the debug information

Revision 1.12  1992/08/07  11:37:03  clive
Added a flag to turn off tail-call optimisation

Revision 1.11  1992/07/08  10:50:35  clive
Added call point information

Revision 1.10  1992/06/11  10:50:09  clive
Changes for the recording of FNexp type information

Revision 1.9  1992/05/08  16:15:55  jont
*** empty log message ***

Revision 1.8  1992/04/13  15:22:23  clive
First version of the profiler

Revision 1.7  1992/01/14  12:26:56  clive
More work on arrays

Revision 1.6  1992/01/14  12:26:56  jont
Added diagnostic parameter

Revision 1.5  1991/09/18  12:00:27  jont
Removed fn_arg etc to separate module

Revision 1.4  91/09/16  15:49:56  jont
Added sp, fp, handler

Revision 1.3  91/08/07  15:23:02  jont
Added cl_arg' for the function body version of the closure pointer,
whereas cl_arg is now only for the caller immediately prior to the
call, and for the function entry sequence. This preserves a calle
save model

Revision 1.2  91/07/31  18:05:32  jont
Exported the arg and closure registers

Revision 1.1  91/07/25  10:27:36  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/diagnostic";
require "../lambda/lambdatypes";
require "../main/info";
require "../main/options";
require "mirtypes";

signature MIR_CG = sig
  structure Diagnostic : DIAGNOSTIC
  structure LambdaTypes : LAMBDATYPES
  structure MirTypes : MIRTYPES
  structure Info : INFO
  structure Options : OPTIONS

  sharing type MirTypes.Debugger_Types.Type = LambdaTypes.Type

  val mir_cg :
    Info.options ->
    Options.options * LambdaTypes.LambdaExp * string * MirTypes.Debugger_Types.information ->
    MirTypes.mir_code * MirTypes.Debugger_Types.information
end
