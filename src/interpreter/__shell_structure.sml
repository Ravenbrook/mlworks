(*  Shell structure structure.
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Log: __shell_structure.sml,v $
 *  Revision 1.33  1998/12/07 14:28:13  johnh
 *  [Bug #70240]
 *  need Project.delete function.
 *
 * Revision 1.32  1998/01/26  18:36:32  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.30.2.4  1997/11/20  16:54:47  daveb
 * [Bug #30326]
 *
 * Revision 1.30.2.3  1997/11/17  17:00:59  daveb
 * [Bug #30071]
 * Added ProjFile, TopLevel and ModuleId.
 * Removed ActionQueue and IdentPrint, and some redundant requires.
 *
 * Revision 1.30.2.2  1997/10/29  15:29:56  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Removed OldOs
 *
 * Revision 1.30.2.1  1997/09/11  20:54:39  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.30  1997/05/12  16:35:08  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.29  1996/08/08  10:50:42  andreww
 * [Bug #714]
 * Introduce a new Debugger structure into Shell.Options that
 * interfaces the flags in debugger/__stack_frame.sml
 *
 * Revision 1.28  1996/06/14  17:27:22  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.27  1996/05/17  16:51:05  daveb
 * Added SaveImage parameter.
 *
 * Revision 1.26  1996/05/08  13:29:13  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.25  1996/04/17  14:06:26  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.24  1996/03/27  12:16:35  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.23  1996/02/29  11:09:13  matthew
 *  Adding Os structure
 *
 * Revision 1.22  1995/11/22  14:26:10  daveb
 * Removed Recompile parameter.
 *
 *  Revision 1.21  1995/05/25  12:56:07  daveb
 *  Added Preferences parameter.
 *  
 *  Revision 1.20  1995/04/21  13:33:47  daveb
 *  Replaced Path argument with Getenv.
 *  
 *  Revision 1.19  1995/04/13  13:28:31  matthew
 *  Change Debugger_Types to DebuggerUtilities
 *  
 *  Revision 1.18  1995/03/17  20:48:34  daveb
 *  Removed unused parameters.
 *  
 *  Revision 1.17  1995/01/13  16:03:44  daveb
 *  Replaced FileName structure with Path and FileSys.
 *  
 *  Revision 1.16  1994/12/09  10:45:14  jont
 *  Move OS specific stuff into a system link directory
 *  
 *  Revision 1.15  1994/03/21  17:52:06  matthew
 *  Removed Editor structure
 *  
 *  Revision 1.14  1994/02/24  11:54:07  daveb
 *  Added FileName parameter.
 *  
 *  Revision 1.13  1994/02/02  11:07:23  daveb
 *  Added Incremental parameter.
 *  
 *  Revision 1.12  1993/05/26  15:57:53  matthew
 *   Removed Parser, added ShellUtils structure
 *  
 *  Revision 1.11  1993/05/06  17:14:42  matthew
 *  Added Trace structure
 *  
 *  Revision 1.10  1993/05/06  13:22:13  matthew
 *  Added ValuePrinter structure
 *  
 *  Revision 1.9  1993/04/20  10:21:34  matthew
 *  Added InspectorValues structure
 *  
 *  Revision 1.8  1993/04/13  15:21:19  jont
 *  Added environment parameter
 *  
 *  Revision 1.7  1993/04/06  16:34:14  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.6  1993/04/02  13:48:47  matthew
 *  Added Parser and Debugger_Types structure
 *  
 *  Revision 1.5  1993/03/29  09:53:39  jont
 *  Added io structure parameter
 *  
 *  Revision 1.4  1993/03/26  17:08:06  matthew
 *  Removed Ml_Debugger structure
 *  
 *  Revision 1.3  1993/03/11  17:52:46  matthew
 *  Added Ml_Debugger and Inspector structures.
 *  
 *  Revision 1.2  1993/03/10  17:50:07  jont
 *  Added Editor substructure to the shell
 *  
 *  Revision 1.1  1993/03/01  13:23:41  daveb
 *  Initial revision
 *)

require "../utils/__lists";
require "../system/__os";
require "../system/__getenv";
require "../basics/__module_id";
require "../typechecker/__types";
require "../typechecker/__strenv";
require "../typechecker/__valenv";
require "../typechecker/__tyenv";
require "../typechecker/__environment";
require "../typechecker/__scheme";
require "../typechecker/__basistypes";
require "../debugger/__debugger_utilities";
require "../debugger/__value_printer";
require "../debugger/__newtrace";
require "../debugger/__stack_frame";
require "../editor/__custom";
require "../main/__mlworks_io";
require "../main/__proj_file";
require "../main/__project";
require "../main/__toplevel";
require "__inspector";
require "__inspector_values";
require "__incremental";
require "__shell_types";
require "__user_context";
require "../main/__user_options";
require "../main/__preferences";
require "__save_image";
require "__shell_utils";

require "_shell_structure";

structure ShellStructure_ =
  ShellStructure (
    structure Lists = Lists_
    structure OS = OS
    structure Getenv = Getenv_
    structure ModuleId = ModuleId_
    structure Types = Types_
    structure Strenv = Strenv_
    structure Valenv = Valenv_
    structure Tyenv = Tyenv_
    structure Env = Environment_
    structure Scheme = Scheme_
    structure BasisTypes = BasisTypes_
    structure DebuggerUtilities = DebuggerUtilities_
    structure ValuePrinter = ValuePrinter_
    structure Trace = Trace_
    structure StackFrame = StackFrame_
    structure CustomEditor = CustomEditor_
    structure Io = MLWorksIo_
    structure Project = Project_
    structure ProjFile = ProjFile_
    structure TopLevel = TopLevel_
    structure Inspector = Inspector_
    structure InspectorValues = InspectorValues_
    structure Incremental = Incremental_
    structure ShellTypes = ShellTypes_
    structure UserContext = UserContext_
    structure UserOptions = UserOptions_
    structure Preferences = Preferences_
    structure SaveImage = SaveImage_
    structure ShellUtils = ShellUtils_
  );
