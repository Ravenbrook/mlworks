(*  ==== INTERPRETER MAKE SYSTEM ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __intermake.sml,v $
 *  Revision 1.21  1998/01/27 12:02:58  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 * Revision 1.19.2.4  1997/11/26  15:15:50  daveb
 * [Bug #30071]
 *
 * Revision 1.19.2.3  1997/11/20  16:54:27  daveb
 * [Bug #30326]
 *
 * Revision 1.19.2.2  1997/10/29  13:50:46  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Remove OldOs and add OS
 *
 *
 * Revision 1.19.2.1  1997/09/11  20:54:28  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.19  1997/05/12  16:15:34  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.18  1996/03/26  13:00:24  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.17  1995/11/19  15:29:30  daveb
 * Added Project parameter.
 *
 *  Revision 1.16  1995/03/24  16:24:31  matthew
 *  Explicit Stamp structure parameter
 *
 *  Revision 1.15  1995/03/17  20:35:10  daveb
 *  Removed unused parameter.
 *
 *  Revision 1.14  1994/12/08  17:58:46  jont
 *  Move OS specific stuff into a system link directory
 *
 *  Revision 1.13  1994/02/01  17:12:49  daveb
 *  Replaced UnixFileName_ with Module_.
 *
 *  Revision 1.12  1994/01/26  17:52:58  matthew
 *   Remove Environ structure
 *
 *  Revision 1.11  1994/01/04  17:15:18  matthew
 *  Removed Debugger_Types parameter
 *
 *  Revision 1.10  1993/12/07  11:25:48  daveb
 *  Removed EnvironPrint parameter.
 *
 *  Revision 1.9  1993/09/14  16:43:35  jont
 *  Added Encapsulate_ and Basis_ parameters to functor application
 *
 *  Revision 1.8  1993/07/30  11:03:13  daveb
 *  Added Crash and ModuleId parameters.
 *
 *  Revision 1.7  1993/05/18  15:16:39  jont
 *  Removed integer parameter
 *
 *  Revision 1.6  1993/04/02  13:45:28  matthew
 *  Added Debugger_Types structure
 *
 *  Revision 1.5  1993/03/08  10:18:12  matthew
 *  Added lexer structure
 *
 *  Revision 1.4  1992/11/23  16:54:03  clive
 *  Added the Io structure to allow the filename to be shortened in debug strings
 *
 *  Revision 1.3  1992/11/17  17:21:33  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.2  1992/10/19  16:42:21  richard
 *  Added Integer_ parameter.
 *
 *  Revision 1.1  1992/10/12  17:12:51  richard
 *  Initial revision
 *
 *)

require "../main/__compiler";
require "../lexer/__lexer";
require "../main/__mlworks_io";
require "../main/__encapsulate";
require "../typechecker/__basis";
require "../typechecker/__stamp";
require "../utils/__lists";
require "../utils/__text";
require "../utils/_diagnostic";
require "../utils/__crash";
require "../basics/__module_id";
require "../main/__project";
require "__interload";
require "_intermake";

structure InterMake_ =
  InterMake (structure Compiler = Compiler_
	     structure Encapsulate = Encapsulate_
	     structure Basis = Basis_
	     structure Stamp = Stamp_
             structure Lexer = Lexer_
             structure MLWorksIo = MLWorksIo_
             structure Lists = Lists_
             structure Crash = Crash_
             structure ModuleId = ModuleId_
             structure Project = Project_
             structure Diagnostic =
	       Diagnostic (structure Text = Text_)
             structure InterLoad = InterLoad_
	       );
