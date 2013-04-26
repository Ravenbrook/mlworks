(*  ==== COMPILER SHELL ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __shell.sml,v $
 *  Revision 1.23  1998/01/26 18:35:10  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 * Revision 1.22.10.2  1997/11/26  11:19:55  daveb
 * [Bug #30071]
 *
 * Revision 1.22.10.1  1997/09/11  20:54:27  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.22  1995/04/28  11:52:51  daveb
 * Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.21  1995/03/17  20:41:58  daveb
 *  Removed unused parameter InterPrint.
 *
 *  Revision 1.20  1994/02/02  10:49:37  daveb
 *  Added Incremental parameter.
 *
 *  Revision 1.19  1993/04/06  17:49:03  daveb
 *  Added Crash parameter.
 *
 *  Revision 1.18  1993/04/06  16:24:33  jont
 *  Moved user_options and version from interpreter to main
 *
 *  Revision 1.17  1993/03/29  16:51:36  matthew
 *  Removed ShellStructure structure
 *
 *  Revision 1.16  1993/03/08  13:10:29  matthew
 *  Added Parser structure
 *  Removed some unnecessary structures
 *
 *  Revision 1.15  1993/03/01  17:09:55  daveb
 *  Major revision.  Now provides a shell for both TTY and X based listeners.
 *
 *  Revision 1.14  1992/12/03  19:41:59  daveb
 *  Added Dialogs structure.
 *
 *  Revision 1.13  1992/12/03  14:09:40  daveb
 *  Er - I managed to delete the closing parenthesis!
 *
 *  Revision 1.12  1992/12/02  16:21:32  daveb
 *  Changed default prompt function.
 *
 *  Revision 1.11  1992/11/30  16:37:29  clive
 *  Added the version structure
 *
 *  Revision 1.10  1992/11/27  20:27:30  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.9  1992/11/25  10:29:38  matthew
 *  Added Stream structure
 *
 *  Revision 1.8  1992/11/24  12:04:32  clive
 *  Added the Crash structure
 *
 *  Revision 1.7  1992/11/19  18:13:09  matthew
 *  Added recompile and compile, and some info bug fixes.
 *
 *  Revision 1.6  1992/11/12  17:27:30  clive
 *  Need the Scheme functor
 *
 *  Revision 1.5  1992/11/05  13:14:28  daveb
 *  Added ValuePrinter to arguments of functor.
 *
 *  Revision 1.4  1992/10/14  11:42:40  richard
 *  Added the subline parameter to the prompter.
 *
 *  Revision 1.3  1992/10/08  12:41:09  clive
 *  Modified to call debugger
 *
 *  Revision 1.2  1992/10/06  13:56:45  richard
 *  Added Lists_ parameter.
 *
 *  Revision 1.1  1992/10/01  12:02:26  richard
 *  Initial revision
 *
 *)

require "../utils/__lists";
require "../utils/__crash";
require "../parser/__parser";
require "../main/__user_options";
require "__incremental";
require "__shell_types";
require "__user_context";
require "_shell";

structure Shell_ = Shell (
  structure Parser = Parser_
  structure Lists = Lists_
  structure Crash = Crash_
  structure ShellTypes = ShellTypes_
  structure UserContext = UserContext_
  structure UserOptions = UserOptions_
  structure Incremental = Incremental_
);
