(*  Utilities for shell etc.
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  $Log: __shell_utils.sml,v $
 *  Revision 1.31  1999/02/19 11:58:55  mitchell
 *  [Bug #190507]
 *  Functor now takes diagnostic structure as additional argument
 *
 * Revision 1.30  1999/02/02  15:59:58  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.29  1998/10/28  11:36:46  jont
 * [Bug #70198]
 * Add link_support structure
 *
 * Revision 1.28  1998/04/24  14:09:54  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.27  1998/01/26  18:37:58  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.26.2.3  1997/11/26  15:16:17  daveb
 * [Bug #30071]
 *
 * Revision 1.26.2.2  1997/11/20  16:54:56  daveb
 * [Bug #30326]
 *
 * Revision 1.26.2.1  1997/09/11  20:54:15  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.26  1997/05/12  16:25:56  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.25  1997/03/20  13:56:53  johnh
 * [Bug #1986]
 * Changed from using Path to OSPath.
 *
 * Revision 1.24  1996/08/05  15:52:14  stephenb
 * Remove the OldOs argument now that the functor has been updated
 * so that it no longer uses OldOs.mtime.
 *
 * Revision 1.23  1996/05/21  11:18:04  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.22  1996/04/11  15:29:49  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.21  1996/03/27  11:53:50  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.20  1996/01/19  15:16:13  stephenb
 * OS reorganisation: the editor structure is now OS dependent
 * so it is to be found in system and not editor.
 *
Revision 1.19  1995/12/04  17:16:22  daveb
Added Project and TopLevel parameters.

Revision 1.18  1995/12/04  15:52:12  matthew
Adding back FileSys

Revision 1.17  1995/09/11  14:25:04  matthew
Adding OS structure.

Revision 1.16  1995/07/13  10:15:08  matthew
Changing BasisTypes to Basis

Revision 1.15  1995/05/25  09:51:09  daveb
Added Preferences parameter.

Revision 1.14  1995/05/01  10:34:21  daveb
Restored ShellTypes parameter (it is used after all).

 *  Revision 1.13  1995/04/28  11:21:20  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *  
 *  Revision 1.12  1995/04/20  15:00:17  daveb
 *  Replaced FileSys parameter with Getenv.
 *  
 *  Revision 1.11  1995/03/17  20:42:14  daveb
 *  Removed unused parameter InterPrint.
 *  
 *  Revision 1.10  1995/01/16  13:04:45  daveb
 *  Replaced Filename argument with Path and FileSys arguments.
 *  
 *  Revision 1.9  1994/12/08  18:07:49  jont
 *  Move OS specific stuff into a system link directory
 *  
 *  Revision 1.8  1994/06/09  16:00:33  nickh
 *  New runtime directory structure.
 *  
 *  Revision 1.7  1994/03/30  16:41:25  daveb
 *  Added ModuleId parameter.
 *  
 *  Revision 1.6  1994/02/02  10:27:50  daveb
 *  Added UnixFileName_ and Module_.
 *  
 *  Revision 1.5  1993/06/16  16:32:41  matthew
 *  Added Tags and Trace structures
 *  
 *  Revision 1.4  1993/05/27  14:52:50  matthew
 *  Added Lists parameter
 *  
 *  Revision 1.3  1993/05/12  11:37:12  matthew
 *  Added some structures
 *  
 *  Revision 1.2  1993/05/11  13:37:26  matthew
 *  Added InterPrinter, Io
 *  
 *  Revision 1.1  1993/04/30  10:54:19  matthew
 *  Initial revision
 *  
 *
 *)

require "../utils/__lists";
require "../rts/gen/__tags";
require "__incremental";
require "__user_context";
require "__shell_types";
require "../system/__os";
require "../system/__getenv";
require "../basics/__module_id";
require "../parser/__parser";
require "../system/__editor";
require "../system/__link_support";
require "../system/__object_output";
require "../typechecker/__types";
require "../typechecker/__basis";
require "../typechecker/__completion";
require "../debugger/__value_printer";
require "../debugger/__newtrace";
require "../main/__toplevel";
require "../main/__project";
require "../main/__proj_file";
require "../main/__mlworks_io";
require "../main/__user_options";
require "../main/__preferences";
require "../main/__encapsulate";
require "../utils/_diagnostic";
require "../utils/__text";

require "_shell_utils";

structure ShellUtils_ = ShellUtils (
  structure Lists = Lists_
  structure Tags = Tags_
  structure Incremental = Incremental_
  structure UserContext = UserContext_
  structure ShellTypes = ShellTypes_
  structure Getenv = Getenv_
  structure OS = OS
  structure OSPath = OS.Path
  structure LinkSupport = LinkSupport_
  structure Encapsulate = Encapsulate_
  structure Object_Output = Object_Output_
  structure ModuleId = ModuleId_
  structure Editor = Editor_
  structure Types = Types_
  structure Basis = Basis_
  structure Completion = Completion_
  structure ValuePrinter = ValuePrinter_
  structure Trace = Trace_
  structure TopLevel = TopLevel_
  structure Project = Project_
  structure ProjFile = ProjFile_
  structure Parser = Parser_
  structure Io = MLWorksIo_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
  structure Diagnostic =
    Diagnostic (structure Text = Text_)
)
