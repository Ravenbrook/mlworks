(* __ml_debugger.sml the structure *)
(*
$Log: __ml_debugger.sml,v $
Revision 1.30  1998/04/09 09:52:30  jont
[Bug #70085]
Add Project to list of functor parameters

 * Revision 1.29  1998/03/31  11:27:20  jont
 * [Bug #70077]
 * Remove use of Path_
 *
 * Revision 1.28  1996/05/21  11:11:16  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.27  1996/04/12  08:30:03  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.26  1996/03/27  12:11:11  stephenb
 * Replace Path/PATH by Os.Path/OS_PATH
 *
 * Revision 1.25  1996/02/26  13:50:25  stephenb
 * Add StackFrame
 *
 * Revision 1.24  1995/03/08  10:49:44  matthew
 * Adding StackInterface structure
 *
Revision 1.22  1995/01/30  13:23:11  matthew
Renaming debugger_type_utilities

Revision 1.21  1995/01/27  11:44:39  daveb
Added Path parameter.

Revision 1.20  1994/09/14  15:19:28  matthew
Abstraction of debug information

Revision 1.19  1994/07/29  16:34:37  daveb
Added Preferences argument.

Revision 1.18  1994/06/09  15:48:06  nickh
New runtime directory structure.

Revision 1.17  1994/02/21  17:30:22  nosa
structure Encapsulate for type basis decapsulation facility for Monomorphic debugger.

Revision 1.16  1993/12/09  19:26:55  jont
Added copyright message

Revision 1.15  1993/08/17  18:14:04  daveb
Removed Io structure.

Revision 1.14  1993/07/22  15:27:09  nosa
Debugger Environments for local and closure variable inspection
in the debugger.

Revision 1.13  1993/05/18  13:56:57  jont
Removed integer parameter

Revision 1.12  1993/04/30  11:02:53  matthew
 Added ShellUtils structure

Revision 1.11  1993/04/29  10:19:14  matthew
Renamed Debugger_Type_Utilities to DebuggerTypeUtilities
Renamed Get_Type_Information to GetTypeInformation

Revision 1.10  1992/11/27  16:14:47  clive
ValuePrinter structure now needed by the debugger

Revision 1.9  1992/11/05  18:18:31  richard
Added Tags parameter.

Revision 1.8  1992/10/26  11:26:54  clive
Took out trace and added binding of frame arguments to it

Revision 1.7  1992/10/12  11:17:14  clive
Tynames now have a slot recording their definition point

Revision 1.6  1992/10/06  15:25:38  clive
Changes for the use of new shell

Revision 1.5  1992/10/05  15:01:04  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.4  1992/08/19  10:27:11  clive
Changed to reflect changes to pervasive_library

Revision 1.3  1992/07/28  11:16:33  clive
Periodical checking in - many improvements

Revision 1.2  1992/07/14  10:09:23  clive
Made the debugger work better, and changes for the new interface to the runtime system

Revision 1.1  1992/06/22  15:21:32  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__crash";
require "../main/__encapsulate";
require "../main/__preferences";
require "../main/__project";
require "../basics/__module_id";
require "../basics/__location";
require "../typechecker/__types";
require "../interpreter/__incremental";
require "../interpreter/__shell_utils";
require "../rts/gen/__tags";
require "__value_printer";
require "__debugger_print";
require "../machine/__stack_interface";
require "__debugger_utilities";
require "__newtrace";
require "__stack_frame";
require "^.system.__os";
require "_ml_debugger";

structure Ml_Debugger_ = 
  Ml_Debugger(structure Lists = Lists_
              structure Crash = Crash_
	      structure Path = OS.Path;
              structure Encapsulate = Encapsulate_
              structure Preferences = Preferences_
	      structure Project = Project_
	      structure ModuleId = ModuleId_
	      structure Location = Location_
              structure Types = Types_
              structure Incremental = Incremental_
              structure ShellUtils = ShellUtils_
              structure ValuePrinter = ValuePrinter_
              structure StackInterface = StackInterface_
              structure DebuggerUtilities = DebuggerUtilities_
              structure Tags = Tags_
              structure DebuggerPrint = DebuggerPrint_
              structure Trace = Trace_
              structure StackFrame = StackFrame_
                )
