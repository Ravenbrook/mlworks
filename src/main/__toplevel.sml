(* __toplevel.sml the structure *)
(*
 * Revision 1.44  1997/10/20  17:30:40  jont
 * [Bug #30089]
 * Remove OldOs and add OS
 *
 * $Log: __toplevel.sml,v $
 * Revision 1.46  1998/06/11 16:37:48  jont
 * [Bug #70133]
 * Add COFF outputter
 *
 * Revision 1.45  1998/01/27  17:52:24  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.43.2.4  1997/11/26  16:17:25  daveb
 * [Bug #30071]
 *
 * Revision 1.43.2.3  1997/11/20  17:12:15  daveb
 * [Bug #30326]
 *
 * Revision 1.43.2.2  1997/10/29  13:57:09  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Remove OldOs and add OS
 *
 *
 * Revision 1.43.2.1  1997/09/11  20:56:51  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.43  1997/05/12  16:10:13  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.42  1996/10/04  13:05:46  matthew
 * Remove LambdaSub
 *
 * Revision 1.41  1996/03/26  13:10:43  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.40  1995/11/19  15:31:47  daveb
 * Added Project parameter.
 *
Revision 1.39  1995/03/24  16:22:17  matthew
Explicit Stamp structure parameter

Revision 1.38  1995/03/01  12:30:58  matthew
Commenting out LambdaIO structure

Revision 1.37  1995/02/07  13:38:15  matthew
Moving pervasive counts to Basis

Revision 1.36  1994/12/08  17:39:52  jont
Move OS specific stuff into a system link directory

Revision 1.35  1994/02/01  16:16:54  daveb
Replaced FileName with Module.

Revision 1.34  1993/08/23  13:28:42  richard
Added LambdaIO parameter.

Revision 1.33  1993/08/04  18:13:53  daveb
Added ModuleId and FileName parameters.

Revision 1.32  1993/05/18  17:02:09  jont
Removed integer parameter

Revision 1.31  1993/02/09  09:46:57  matthew
Typechecker structure changes

Revision 1.30  1993/01/04  15:52:20  jont
Modified to include __machprint

Revision 1.29  1992/10/27  17:11:39  jont
Removed Error from toplevel signature

Revision 1.28  1992/10/01  14:00:07  richard
Moved lambda module code to a separate structure.

Revision 1.27  1992/09/02  12:54:12  richard
Installed central error reporting mechanism.

Revision 1.26  1992/08/26  09:20:47  clive
Propogation of information about exceptions

Revision 1.25  1992/08/07  15:08:50  davidt
Removed various redundant structure arguments.

Revision 1.24  1992/07/22  15:23:04  jont
Moved all file manipulation into Io

Revision 1.23  1992/06/10  17:27:00  jont
changed to use newmap

Revision 1.22  1992/04/23  10:31:20  jont
Added integer parameter to functor

Revision 1.21  1992/03/05  15:54:15  jont
Changed to use unix structure rather than reapplying functor

Revision 1.20  1992/03/03  14:11:58  jont
Added LambdaSub parameter

Revision 1.19  1992/02/11  14:33:17  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.18  1992/02/11  11:20:12  clive
Work on the new pervasive library mechanism

Revision 1.17  1992/01/31  10:47:52  clive
Added timing to the various sections

Revision 1.16  1992/01/23  16:58:43  jont
Added Tyfun_id parameter

Revision 1.15  1992/01/10  16:37:46  jont
Added diagnostic structure

Revision 1.14  1992/01/08  16:38:00  colin
Added code to maintain unique tyname and strname_ids across modules.

Revision 1.13  1991/12/23  16:15:24  jont
Added unix parameter for file time stamps etc

Revision 1.12  91/12/20  01:24:56  jont
Added Lists and Pervasives as parameters. Removed MachPrint (never used)

Revision 1.11  91/11/08  16:49:05  jont
Added String_ parameter to functor application

Revision 1.10  91/10/28  16:17:03  davidt
Now uses the Print structure.

Revision 1.9  91/10/23  13:19:31  davidt
Now builds using the Crash structure.

Revision 1.8  91/10/16  11:19:59  jont
Added reference to Encapsulate_

Revision 1.7  91/10/02  15:06:31  jont
Added machine dependent code generator

Revision 1.7  91/10/02  15:06:31  jont
Temporary checkin.

Revision 1.6  91/09/03  11:07:32  richard
Included MIR optimiser module in compiler run.

Revision 1.5  91/07/25  14:59:18  jont
Added mir stuff

Revision 1.4  91/07/19  17:31:11  jont
More arguments

Revision 1.3  91/07/11  14:23:15  jont
Has topdecprint if required

Revision 1.2  91/07/10  14:17:56  jont
Completed to handle initial environment and compile files and strings

Revision 1.1  91/07/09  18:55:50  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../system/__os";
require "../utils/__crash";
require "../utils/__text";
require "../utils/__print";
require "../utils/__lists";
require "../utils/_diagnostic";
require "../utils/__mlworks_timer";
require "../basics/__module_id";
require "../parser/__parser";
require "../typechecker/__mod_rules";
require "../typechecker/__basis";
require "../typechecker/__stamp";
require "../lambda/__environ";
require "../lambda/__lambdaprint";
require "../lambda/__environprint";
require "../lambda/__lambda";
require "../lambda/__lambdaoptimiser";
require "../lambda/__lambdamodule";
require "../lambda/__topdecprint";
require "../mir/__mirtypes";
require "../mir/__mir_cg";
require "../mir/__mirprint";
require "../mir/__miroptimiser";
require "../machine/__mach_cg";
require "../machine/__machprint";
require "../machine/__object_output";
require "../debugger/__debugger_types";
require "__primitives";
require "__pervasives";
require "__encapsulate";
require "__mlworks_io";
require "__project";
require "_toplevel";

structure TopLevel_ = TopLevel(
  structure OS = OS
  structure Crash = Crash_
  structure Print = Print_
  structure Lists = Lists_
  structure ModuleId = ModuleId_
  structure Diagnostic = Diagnostic(structure Text = Text_)
  structure Timer = Timer_
  structure Parser = Parser_
  structure Mod_Rules = Module_rules_
  structure Basis = Basis_
  structure Stamp = Stamp_
  structure Environ = Environ_
  structure LambdaPrint = LambdaPrint_
  structure EnvironPrint = EnvironPrint_
  structure Lambda = Lambda_
  structure LambdaOptimiser = LambdaOptimiser_
  structure LambdaModule = LambdaModule_
  structure MirTypes = MirTypes_
  structure Mir_Cg = Mir_Cg_
  structure MirPrint = MirPrint_
  structure MirOptimiser = MirOptimiser_
  structure Mach_Cg = Mach_Cg_
  structure MachPrint = MachPrint_
  structure Object_Output = Object_Output_
  structure TopdecPrint = TopdecPrint_
  structure Primitives = Primitives_
  structure Pervasives = Pervasives_
  structure Encapsulate = Encapsulate_
  structure Io = MLWorksIo_
  structure Project = Project_
  structure Debugger_Types = Debugger_Types_
)
