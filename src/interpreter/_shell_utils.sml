(*  Utilities for shell etc.
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
 *  $Log: _shell_utils.sml,v $
 *  Revision 1.136  1999/03/25 18:53:03  mitchell
 *  [Bug #190532]
 *  Don't apply map_dag when loading
 *
 * Revision 1.135  1999/03/23  17:37:55  mitchell
 * [Bug #190532]
 * Ensure update_dependencies is called on subprojects first
 *
 * Revision 1.134  1999/03/18  12:17:35  daveb
 * [Bug #190521]
 * OS.FileSys.readDir now returns an option type.
 *
 * Revision 1.133  1999/03/18  09:07:04  mitchell
 * [Bug #190532]
 * Use Project.map_dag when compiling a project
 *
 * Revision 1.132  1999/02/19  10:45:36  mitchell
 * [Bug #190507]
 * Change dependency checking messages to diagnostic messages
 *
 * Revision 1.131  1999/02/09  09:50:01  mitchell
 * [Bug #190505]
 * Support for precompilation of subprojects
 *
 * Revision 1.130  1999/02/03  15:53:44  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.129  1999/02/02  16:00:24  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.128  1998/11/26  12:20:46  mitchell
 * [Bug #190493]
 * Make calls to eval originating from the history mechanism distinguishable
 *
 * Revision 1.127  1998/11/03  13:27:08  jont
 * [Bug #70204]
 * Add subprojects into linking process, and place binaries in the right place
 *
 * Revision 1.126  1998/11/02  13:30:38  jont
 * [Bug #70204]
 * Do work for making exes
 *
 * Revision 1.125  1998/10/30  16:20:39  jont
 * [Bug #70198]
 * Add functions to make dlls and exes from a project
 *
 * Revision 1.124  1998/08/13  10:58:15  jont
 * [Bug #30468]
 * Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 * Revision 1.123  1998/05/19  11:49:02  mitchell
 * [Bug #50071]
 * Add support for force compiles and loads
 *
 * Revision 1.122  1998/05/07  09:19:16  mitchell
 * [Bug #50071]
 * Add support for touch_all_sources
 *
 * Revision 1.121  1998/05/01  16:16:56  mitchell
 * [Bug #50071]
 * Remove debug printout
 *
 * Revision 1.120  1998/04/24  15:03:58  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.119  1998/04/02  12:46:51  jont
 * [Bug #30312]
 * Replacing OS.FileSys.modTime with system dependent version to sort out
 * MS time stamp problems.
 *
 * Revision 1.118  1998/02/19  20:22:26  mitchell
 * [Bug #30337]
 * Change uses of OS.Path.concat to take a string list, instead of a pair of strings.
 *
 * Revision 1.117  1998/02/18  17:40:29  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.116  1998/02/10  15:39:39  jont
 * [Bug #70065]
 * Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.115  1998/02/06  14:04:00  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.113.2.7  1997/12/04  15:19:27  daveb
 * [Bug #30017]
 * Rationalised Shell.Project commands:
 * Removed touch_source_file.
 * Added {,show_}{compile,load}_targets.
 * Made load/compile functions take strings instead of module_ids, and
 * explicit location values.
 *
 * Revision 1.113.2.6  1997/12/02  16:31:29  daveb
 * [Bug #30071]
 * Removed functions for loading from source files.
 *
 * Revision 1.113.2.5  1997/11/26  16:50:46  daveb
 * [Bug #30071]
 *
 * Revision 1.113.2.4  1997/11/26  12:19:54  daveb
 * [Bug #30071]
 * The action queue is no more, so ShellUtils.use_{file,string} and
 * ShellUtils.read_dot_mlworks no longer take queue functions.
 *
 * Revision 1.113.2.3  1997/11/20  16:59:23  daveb
 * [Bug #30326]
 *
 * Revision 1.113.2.2  1997/11/11  16:14:58  johnh
 * [Bug #30203]
 * Merging - checking files to be recompiled.
 *
 * Revision 1.113.2.1  1997/09/11  20:54:40  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.114  1997/09/17  16:06:41  brucem
 * [Bug #30203]
 * Incremental.check_mo (and check_module) return module ids
 * , instead of strings.
 *
 * Revision 1.113  1997/07/31  12:37:34  johnh
 * [Bug #50019]
 * Modify process_result to take a UserContext.source_reference type for src.
 *
 * Revision 1.112  1997/05/28  13:53:21  daveb
 * [Bug #30090]
 * Converted lexer to Basis IO.
 * Converted MLWorks.IO.set_modified to OS.FileSys.setTime.
 *
 * Revision 1.111  1997/05/12  16:25:26  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.110  1997/04/23  15:54:21  jont
 * [Bug #20013]
 * Put Use: message under control of print_messages
 *
 * Revision 1.109  1997/04/02  15:15:26  matthew
 * Fixing uncaught SysErr in completion
 *
 * Revision 1.108  1997/03/21  11:59:17  matthew
 * Fixing merge bungle with last change
 *
 * Revision 1.107  1997/03/21  11:50:04  matthew
 * Adding use function
 *
 * Revision 1.106  1997/03/20  17:11:26  johnh
 * [Bug #1849]
 * Added a check to avoid Syserr exception being raised on Win32.
 *
 * Revision 1.105  1997/03/20  13:54:56  johnh
 * [Bug #1986]
 * Changed from using Path to OSPath.
 *
 * Revision 1.104  1997/02/11  18:15:39  daveb
 * Review edit <URI:spring://ML_Notebook/Review/basics/*module.sml>
 * -- Changed name and type of Module.find_sml and Module.sml_name.
 *
 * Revision 1.103  1996/11/06  11:38:15  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.102  1996/11/04  16:36:31  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.101  1996/10/30  13:42:51  io
 * moving String from toplevel
 *
 * Revision 1.100  1996/08/15  14:52:37  daveb
 * [Bug #1519]
 * Type of UserContext.ITEM has changed.
 *
 * Revision 1.99  1996/08/05  15:52:23  stephenb
 * Replace the call to OldOS.mtime with one to OS.FileSys.access
 * since OldOs is deprecated and the mtime call is only being used
 * to determine if the file actually exists.
 *
 * Revision 1.98  1996/07/04  15:36:37  jont
 * Remove debug info saying processing result
 *
 * Revision 1.97  1996/06/20  10:38:13  daveb
 * Bug 1424: Made object_traceable check the trace status of the object.
 *
 * Revision 1.96  1996/06/19  13:36:14  daveb
 * Corrected definition of is_closure.
 *
 * Revision 1.95  1996/05/30  13:04:06  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.94  1996/05/23  12:16:00  stephenb
 * Replace OS.FileSys.realPath with OS.FileSys.fullPath since the latter
 * now does what the former used to do.
 *
 * Revision 1.93  1996/05/21  11:17:36  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.92  1996/05/20  12:12:38  daveb
 * Moved preferences_file_name to new save_image module.
 *
 * Revision 1.91  1996/05/15  15:18:12  matthew
 * Fixing problem with filename completion on Windows
 *
 * Revision 1.90  1996/05/08  11:13:37  daveb
 * Added Info.options argument to use_file.
 *
 * Revision 1.89  1996/05/03  11:49:48  daveb
 * Removed the ShellUtils.Error exception.
 *
 * Revision 1.88  1996/05/03  09:28:10  daveb
 * Removed the Incremental.Error exception.
 *
 * Revision 1.87  1996/05/01  10:06:36  jont
 * String functions explode, implode, chr and ord now only available from
 * String io functions and types instream, oustream, open_in, open_out,
 * close_in, close_out, input, output and end_of_stream 
 * now only available from MLWorks.IO
 *
 * Revision 1.86  1996/04/23  12:47:21  daveb
 * show_source no longer returns a destroy function.
 *
 * Revision 1.85  1996/04/18  15:03:46  jont
 * initbasis moved to basis
 *
 * Revision 1.84  1996/04/17  09:34:28  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.83  1996/04/16  15:43:40  brianm
 * Added exception wrapper to close input stream in use_file().
 *
 * Revision 1.82  1996/04/09  17:06:59  daveb
 * Added preferences argument to load_source, load_file and use_file, 
 * because UserContext.process_result now requires this.
 *
 * Revision 1.81  1996/04/02  11:42:52  daveb
 * Changed Project.load_dependencies to Project.read_dependencies.
 *
 * Revision 1.80  1996/03/27  11:52:58  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.79  1996/03/25  15:39:52  daveb
 * Added delete_from_project.
 * Modified types of some other functions to suit Incremental.match_*_path.
 *
 * Revision 1.78  1996/03/19  12:25:49  daveb
 * Added check_load_file.
 *
 * Revision 1.77  1996/03/18  17:50:10  daveb
 * Incremental.load_mo and Incremental.add_module now return option types.
 *
 * Revision 1.76  1996/03/15  17:05:55  daveb
 * Module.find_sml now takes an Info.options parameter.
 *
 * Revision 1.75  1996/03/15  12:38:37  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.74  1996/03/11  10:33:39  daveb
 * Removed compile_string and default_dynamic.
 *
 * Revision 1.73  1996/03/11  10:22:47  daveb
 * compile_file was passed the wrong project.
 *
 * Revision 1.72  1996/03/04  15:14:16  daveb
 * Renamed Project.check_objects to Project.check_compiled.
 *
 * Revision 1.71  1996/02/29  12:22:18  matthew
 * Adding preference_file_name function
 *
 * Revision 1.70  1996/02/05  17:36:56  daveb
 * Removed commented-out save function.
 * Interface of UserContext has changed.
 *
 *  Revision 1.69  1996/01/22  16:37:31  matthew
 *  Using Info.null_options in call to eval
 *
 *  Revision 1.68  1996/01/22  11:20:37  daveb
 *  Removed history functions (replaced by more complete functionality in
 *  gui_utils).
 *
 *  Revision 1.67  1996/01/19  10:43:05  matthew
 *  Adding catch all handler around call to eval.
 *
 *  Revision 1.66  1996/01/17  17:12:30  matthew
 *  Adding value_from_user_context function
 *
 *  Revision 1.65  1996/01/16  10:07:45  matthew
 *  Fixing bungle with last change.
 *
 *  Revision 1.64  1996/01/15  16:27:46  matthew
 *  Some stuff in completion to deal with stupid NT backslashes in filenames
 *
 *  Revision 1.63  1995/12/13  13:30:45  daveb
 *  Improved wording of check_load_source message.
 *
 *  Revision 1.62  1995/12/13  11:22:17  daveb
 *  Corrected "make" to "load source" in message.
 *
 *  Revision 1.61  1995/12/05  15:17:02  daveb
 *  Removed Module.Cache type.
 *
 *  Revision 1.60  1995/12/04  17:21:00  daveb
 *  Incremental and InterMake have been changed to use Project.
 *
 *  Revision 1.59  1995/12/04  16:56:54  matthew
 *  Thinking about filename completion
 *
 *  Revision 1.58  1995/10/20  10:21:22  daveb
 *  Added show_source.
 *
 *  Revision 1.57  1995/10/17  13:56:38  matthew
 *  Changing interface to tracing
 *
 *  Revision 1.56  1995/09/11  14:32:22  matthew
 *  Adding check on file existing before invoking editor
 *
 *  Revision 1.55  1995/07/19  12:09:12  matthew
 *  Changing parser error reporting.
 *
 *  Revision 1.54  1995/07/13  12:16:23  matthew
 *  Adding compile functions for use by evaluator.
 *
 *  Revision 1.53  1995/06/14  12:19:30  daveb
 *  Removed redundant Context parameter from edit functions.
 *
 *  Revision 1.52  1995/06/05  14:12:21  daveb
 *  UserContext.process_result now takes a user_options argument.
 *
 *  Revision 1.51  1995/05/26  11:33:36  daveb
 *  Split user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.50  1995/05/01  15:29:17  matthew
 *  Changing exception raised by EditObject
 *
 *  Revision 1.49  1995/05/01  09:20:25  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.48  1995/04/28  14:57:37  jont
 *  New module naming stuff
 *
 *  Revision 1.47  1995/04/24  16:25:33  daveb
 *  Added Shell.Make prefix to source strings for load and make.
 *
 *  Revision 1.46  1995/04/21  13:58:51  daveb
 *  Expansion of home dirs moved from FileSys to Getenv.
 *  filesys and path moved from utils to initbasis.
 *  Better error handling.
 *
 *  Revision 1.45  1995/04/12  13:28:01  jont
 *  Change FILESYS to FILE_SYS
 *
 *  Revision 1.44  1995/03/20  11:47:34  matthew
 *  Lexer uses ints as character representation
 *
 *  Revision 1.43  1995/03/06  12:00:44  daveb
 *  Replaced evaluation sequences with calls to ShellTypes.process_result.
 *  Also minor changes as a result of new Path signature.
 *
 *  Revision 1.42  1995/03/02  12:20:24  matthew
 *  Changes to lexer structure
 *
 *  Revision 1.41  1995/02/20  14:24:30  daveb
 *  Made use_file update the context history.
 *
 *  Revision 1.40  1995/01/16  14:22:40  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *  Replaced FileName parameter with FileSys and Path.
 *
 *  Revision 1.39  1994/08/09  15:05:20  daveb
 *  Made use_file return the current modules table when an error occurs.
 *  Renamed source_result to result, added some comments.
 *
 *  Revision 1.38  1994/08/02  10:19:45  daveb
 *  Added editable function.
 *
 *  Revision 1.37  1994/07/29  16:23:39  daveb
 *  Moved preferences out of Options structure.
 *
 *  Revision 1.36  1994/07/28  14:52:52  daveb
 *  Changed uses of InterPrint.definitions to InterPrint.strings.
 *
 *  Revision 1.35  1994/07/26  11:13:19  daveb
 *  Moved set_no_execute to _incremental, so that add_module and
 *  check_module in _incremental don't have to check that the option
 *  is set correctly.
 *
 *  Revision 1.34  1994/07/25  15:17:36  daveb
 *  make_file now updates the delta context correctly.
 *
 *  Revision 1.33  1994/06/23  17:02:24  daveb
 *  Brought use_file up to date with the new context arrangements.
 *
 *  Revision 1.32  1994/06/22  15:29:17  jont
 *  Update debugger information production
 *
 *  Revision 1.31  1994/06/21  14:53:07  daveb
 *  Replaced Context Refs by user_contexts.  Replaced the Context argument
 *  of the Error exception with a list of new modules, for updating the
 *  user_context appropriately.
 *
 *  Revision 1.30  1994/06/09  16:02:08  nickh
 *  New runtime directory structure.
 *
 *  Revision 1.29  1994/05/06  16:31:02  jont
 *  Add incremental parser basis to stuff passed to interprint
 *
 *  Revision 1.28  1994/03/30  18:50:11  daveb
 *  Added touch_compile_module and touch_compile_file.
 *
 *  Revision 1.27  1994/03/25  17:53:56  daveb
 *  Revised functions to work with ActionQueue.with_source_path.
 *
 *  Revision 1.26  1994/03/17  17:25:31  matthew
 *  Added check_make_file and edit_file
 *
 *  Revision 1.25  1994/03/15  15:55:43  matthew
 *  Added untrace function
 *  Fixed a problem with Error exceptions.  These should all be converted to
 * Incremental.Errors 
 *
 *  Revision 1.24  1994/02/21  23:51:54  nosa
 *  Boolean indicator for Monomorphic debugger decapsulation.
 *
 *  Revision 1.23  1994/02/08  14:52:58  daveb
 *   Module.module_and_path is now Module.find_file and is functional.
 *
 *  Revision 1.22  1994/02/02  10:24:10  daveb
 *  make and ad_module now take Modules instead of file names.
 *
 *  Revision 1.21  1994/01/28  16:26:37  matthew
 *
 *  Revision 1.20  1994/01/26  17:56:50  matthew
 *  Added space to error messge
 *
 *  Revision 1.19  1994/01/06  16:14:57  matthew
 *  Added load_file function for loading an mo
 *
 *  Revision 1.18  1993/12/15  13:43:42  matthew
 *  Added level field to Basis.
 *
 *  Revision 1.17  1993/11/02  17:44:42  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.16  1993/10/08  16:20:37  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.15  1993/10/05  10:23:49  jont
 *  Added save_file function
 *
 *  Revision 1.14  1993/09/16  15:42:35  nosa
 *  Pass options to InterPrint.definitions instead of print_options.
 *
 *  Revision 1.13.1.3  1993/11/02  17:32:03  daveb
 *  Minor fixes to use_file.
 *
 *  Revision 1.13.1.2  1993/10/08  15:27:26  matthew
 *  Check for editability of defininitions
 *  Predicates for editability and traceability
 *  Utilities for history menus
 *
 *  Revision 1.13.1.1  1993/08/29  13:31:19  jont
 *  Fork for bug fixing
 *
 *  Revision 1.13  1993/08/29  13:31:19  daveb
 *  Removed "compiling" from message, because I think it's confusing.
 *
 *  Revision 1.12  1993/08/25  14:51:26  matthew
 *  Return quit function from ShellUtils.edit_string
 *
 *  Revision 1.11  1993/08/17  18:29:28  daveb
 *  Changes to reflect use of moduleids.
 *  I think some more work is needed here - e.g. with the edit functions.
 *
 *  Revision 1.10  1993/08/03  11:23:43  matthew
 *  Added filter_completions function to sort and remove duplicates from
 *  completions.
 *
 *  Revision 1.9  1993/07/29  11:14:04  matthew
 *  Use Info.make_default_options rather than Info.default_options
 *  Changed use message
 *  Insert ; after a string to be evaluated
 *  
 *  Revision 1.8  1993/06/30  16:34:15  daveb
 *  Removed exception environments.
 *  
 *  Revision 1.7  1993/06/17  10:52:42  matthew
 *  Added edit_object and trace functions
 *  
 *  Revision 1.6  1993/06/04  14:35:43  daveb
 *  edit functions now return a single string in the erroneous case.
 *  
 *  Revision 1.5  1993/06/01  11:42:14  matthew
 *  Added handler for Io on opening file for use
 *  
 *  Revision 1.4  1993/05/27  15:57:53  matthew
 *  Added error_info parameter to eval
 *  Added completion functions
 *  Changes to error handling
 *  
 *  Revision 1.3  1993/05/12  14:30:11  matthew
 *  Added make, use  and eval functions
 *  
 *  Revision 1.2  1993/05/11  14:59:38  matthew
 *  Added make_file an parse_absolute functions
 *  
 *  Revision 1.1  1993/04/30  10:57:10  matthew
 *  Initial revision
 *  
 *)

require "^.basis.__int";
require "^.basis.__string";
require "^.basis.__list";
require "^.basis.__list_pair";
require "^.basis.__text_io";
require "^.basis.__io";

require "../utils/lists";
require "^.utils.__messages";
require "^.utils.__terminal";
require "../rts/gen/tags";
require "../basis/os";
require "../basis/os_path";
require "../utils/getenv";
require "../basics/module_id";
require "incremental";
require "shell_types";
require "user_context";
require "../parser/parser";
require "../typechecker/types";
require "../typechecker/basis";
require "../typechecker/completion";
require "../main/toplevel";
require "../main/project";
require "../main/proj_file";
require "../main/link_support";
require "../main/object_output";
require "../main/encapsulate";
require "../debugger/value_printer";
require "../debugger/newtrace";
require "../editor/editor";
require "../main/mlworks_io";
require "../main/user_options";
require "../main/preferences";
require "../utils/diagnostic";

require "shell_utils";

functor ShellUtils
  (structure Lists : LISTS
   structure Tags : TAGS
   structure Incremental : INCREMENTAL
   structure Editor : EDITOR
   structure Parser : PARSER
   structure Types : TYPES
   structure Basis : BASIS
   structure Completion : COMPLETION
   structure ValuePrinter : VALUE_PRINTER
   structure TopLevel : TOPLEVEL
   structure Project : PROJECT
   structure ProjFile : PROJ_FILE
   structure Diagnostic: DIAGNOSTIC;
   structure LinkSupport : LINK_SUPPORT
   structure Encapsulate : ENCAPSULATE
   structure Object_Output : OBJECT_OUTPUT
   structure Trace : TRACE
   structure Io : MLWORKS_IO
   structure OS : OS
   structure OSPath : OS_PATH
   structure Getenv : GETENV
   structure ModuleId : MODULE_ID
   structure Preferences : PREFERENCES
   structure UserOptions : USER_OPTIONS
   structure UserContext : USER_CONTEXT
   structure ShellTypes : SHELL_TYPES

   sharing Incremental.InterMake.Compiler.Options = UserOptions.Options =
     	   Completion.Options = ValuePrinter.Options = UserContext.Options =
     	   ShellTypes.Options = TopLevel.Options
     
   sharing Incremental.InterMake.Compiler.Info = Parser.Lexer.Info =
	   Project.Info = TopLevel.Info
   sharing Completion.Datatypes = Basis.BasisTypes.Datatypes =
	   Incremental.Datatypes = Types.Datatypes
   sharing Editor.Location = Parser.Lexer.Info.Location
   sharing Incremental.InterMake.Compiler.Absyn = Parser.Absyn
   sharing Basis.BasisTypes.Datatypes.Ident.Symbol = 
     Parser.Lexer.Token.Symbol
   sharing Incremental.InterMake.Inter_EnvTypes.EnvironTypes.LambdaTypes.Ident =
	   Basis.BasisTypes.Datatypes.Ident

   sharing type Incremental.Result = UserContext.Result
   sharing type Incremental.InterMake.Compiler.TypeBasis =
		Basis.BasisTypes.Basis
   sharing type Incremental.InterMake.Compiler.DebugInformation =
		ValuePrinter.DebugInformation
   sharing type Incremental.InterMake.Compiler.ParserBasis = 
                Parser.ParserBasis
   sharing type Parser.Lexer.Options =
		Incremental.InterMake.Compiler.Options.options
   sharing type Editor.preferences = Preferences.preferences =
		UserContext.preferences = ShellTypes.preferences
   sharing type Preferences.user_preferences = ShellTypes.user_preferences
   sharing type UserOptions.user_context_options =
		UserContext.user_context_options
   sharing type UserContext.user_context = ShellTypes.user_context
   sharing type Trace.UserOptions = UserOptions.user_tool_options =
		ShellTypes.user_options
   sharing type Incremental.Context = Trace.Context = UserContext.Context =
		ShellTypes.Context
   sharing type ValuePrinter.Type = Incremental.Datatypes.Type = Trace.Type
   sharing type Parser.Lexer.TokenStream =
		Incremental.InterMake.Compiler.tokenstream
   sharing type Editor.Location.T = ModuleId.Location
   sharing type ModuleId.ModuleId = Incremental.ModuleId = 
		Project.ModuleId = TopLevel.ModuleId = Object_Output.ModuleId
   sharing type UserContext.identifier =
		Basis.BasisTypes.Datatypes.Ident.Identifier
   sharing type Project.Project = Incremental.InterMake.Project =
		TopLevel.Project = Object_Output.Project
   sharing type Encapsulate.Module = Object_Output.Module
  ) : SHELL_UTILS =
struct
  structure InterMake = Incremental.InterMake
  structure Inter_EnvTypes = InterMake.Inter_EnvTypes
  structure Options = UserOptions.Options
  structure Location = Editor.Location
  structure Info = InterMake.Compiler.Info
  structure Lexer = Parser.Lexer
  structure Token = Lexer.Token
  structure Compiler = InterMake.Compiler
  structure BasisTypes = Basis.BasisTypes
  structure Datatypes = BasisTypes.Datatypes
  structure NewMap = Datatypes.NewMap
  structure Ident = Datatypes.Ident
  structure Symbol = Ident.Symbol

  type user_preferences = Preferences.user_preferences
  type UserOptions = UserOptions.user_tool_options
  type Context = Incremental.Context
  type Type = Incremental.Datatypes.Type
  type ModuleId = Incremental.ModuleId
  type ShellData = ShellTypes.ShellData
  type user_context = UserContext.user_context
  type preferences = Preferences.preferences
  type history_entry = UserContext.history_entry
  type Project = Project.Project

  val _ = Diagnostic.set 0

  fun diagnostic (level, output_function) =
    Diagnostic.output
      level
      (fn verbosity => output_function verbosity)

 val do_debug = false
  fun debug_out s =
    if do_debug then
      Terminal.output("ShellUtils: " ^ s ^ "\n")
    else
      ()

    (* This should use some location function *)
    fun find_source_file (locdata:string) = 
      let
	val sz = size locdata
	fun scan i = 
	  if i < sz then
	    if String.sub(locdata, i) = #":" then
	      substring(locdata, 0, i)
	    else
	      scan(i+1)
	  else
	    locdata
      in
	scan 0
      end
	  
    exception FileFromLocation of string

    (* uneditable filenames are of the form "<...>" *)
    fun uneditable_file s =
      size s = 0 orelse
      (MLWorks.String.ordof(s,0) = ord #"<"
       andalso 
       MLWorks.String.ordof(s,(size s)-1) = ord #">")

    fun file_from_location location =
      let
        fun get_filename Location.UNKNOWN =
	  raise FileFromLocation "Unknown location"
          | get_filename (Location.FILE s) = s
          | get_filename (Location.LINE (s,_)) = s
          | get_filename (Location.POSITION (s,_,_)) = s
          | get_filename (Location.EXTENT {name,...}) = name

        val filename = get_filename location
      in
        if uneditable_file filename
          then raise FileFromLocation (filename^" not a real file")
        else filename
      end

    fun editable location =
      (ignore(file_from_location location);
       true)
      handle FileFromLocation _ => false
      
    exception EditFailed of string

    (* I guess this should be an absolute pathname by this point *)
    fun check_exists s =
      if OS.FileSys.access (s, []) then
        ()
      else
        raise EditFailed ("File " ^ s ^ " does not exist")

    fun show_source (s, preferences) =
      let
        val location = Location.from_string s
	val full_name = file_from_location location
        val _ = check_exists full_name
        val (edit_result, _) =
	  Editor.show_location preferences (full_name,location)
      in
        case edit_result of
          NONE => ()
        | SOME s => raise EditFailed s
      end
      handle FileFromLocation s => raise EditFailed s

    fun edit_location (location, preferences) =
      let
	val full_name = file_from_location location
        val _ = check_exists full_name
        val (edit_result,quitfun) =
	  Editor.edit_from_location preferences (full_name,location)
      in
        case edit_result of
          NONE => quitfun
        | SOME s => raise EditFailed s
      end
      handle FileFromLocation s => raise EditFailed s

    fun edit_file (filename, preferences) =
      let
        val full_name = Getenv.expand_home_dir filename
        val _ = check_exists full_name
        val (result,quitfun) = 
          Editor.edit preferences (full_name, 0)
      in
        case result of 
          NONE => quitfun
        | SOME s => raise EditFailed s
      end
    handle Getenv.BadHomeName s => raise EditFailed s

    fun edit_source (s, preferences) =
      let
        val location = Location.from_string s
      in
        edit_location (location, preferences)
      end

    fun is_code_item object =
      let
        val header = MLWorks.Internal.Value.primary object
      in
        header = Tags.POINTER andalso
        #1 (MLWorks.Internal.Value.header object) = Tags.BACKPTR
      end
          
    fun is_closure object = 
      let
        val header = MLWorks.Internal.Value.primary object
      in
        if header = Tags.POINTER then 
	  case MLWorks.Internal.Value.header object
          of (0, 0) =>
            is_code_item (MLWorks.Internal.Value.sub (object,1))
	  |  (secondary, length) =>
            secondary = Tags.RECORD andalso
            length > 0 andalso
            is_code_item (MLWorks.Internal.Value.sub (object,1))
        else
          header = Tags.PAIRPTR andalso
          is_code_item (MLWorks.Internal.Value.sub (object,0))
      end

    val object_editable = is_closure

    fun edit_object (object, preferences) =
      let
        fun get_location code_name =
          let
            fun aux2((#"]" ::_),acc) = acc
              | aux2(c::l,acc) = aux2(l,c::acc)
              | aux2([],acc) = acc
            fun aux1(#"["::l) = aux2 (l,[])
              | aux1(c::l) = aux1 l
              | aux1 [] = []
            val locchars = aux1 (explode code_name)
          in
            implode (rev locchars)
          end
        fun closure_code_name closure =
          let
            val primary = MLWorks.Internal.Value.primary closure
            val index = if primary = Tags.POINTER then 1 else 0
          in
            MLWorks.Internal.Value.code_name
            (MLWorks.Internal.Value.sub (closure, index))
          end
      in
        if object_editable object
          then 
            let
              val locstring = get_location (closure_code_name object ^ "\n")
            in
              edit_source (locstring, preferences)
            end
        else raise EditFailed "not a function object"
      end

    val cast = MLWorks.Internal.Value.cast

    fun object_traceable object =
      is_closure object andalso
      MLWorks.Internal.Trace.status (cast object) <>
      MLWorks.Internal.Trace.UNTRACEABLE

    fun trace f =
      Trace.trace (Trace.get_function_name (cast f))

    fun untrace f =
      Trace.untrace (Trace.get_function_name (cast f))


  fun make_incremental_options (options,debugger) =
    Incremental.OPTIONS
    {options = options,
     debugger = debugger}


  fun delete_from_project (mod_name, location) =
    let
      val module_id = ModuleId.from_string (mod_name, location)
    in
      Incremental.delete_from_project module_id
    end

  (* Functions to make executables/dlls/sos from the current project *)
  (* At some stage the glue files will need to go into a system specific place *)
  (* as they are specific to the i386 *)
  fun make_exe_from_project(location, options, target, libs) =
    let
      val project = Incremental.get_project()
      val project_name = case ProjFile.getProjectName() of
	NONE => raise OS.SysErr("Project unnamed so can't infer dll name", NONE)
      | SOME name => #base(OS.Path.splitBaseExt(#file(OS.Path.splitDirFile name)))
      (* Check target valid *)
      val targets = Project.currentTargets project
      val _ =
	if not(List.exists (fn t => t = target) targets) then
	  raise OS.SysErr("'" ^ target ^ "' is not a target for the project", NONE)
	else
	  ()
      val libs = OS.Path.joinBaseExt{base=project_name, ext=SOME"lib"} :: libs
      (* Now create the glue *)
      val target = #base(OS.Path.splitBaseExt target)
      val declare = target ^ "$closure$declare"
      val setup = target ^ "$closure$setup$get"
      val glue =
	"\t.text\n" ^
	"\t.align\t4\n" ^
	"\t.globl\t_main\n" ^
	"\t.globl\t_trampoline\n" ^
	"\t.globl\t" ^ setup ^ "\n" ^
	"\t.globl\t" ^ declare ^ "\n" ^
	"_main:\n" ^
	"\tpushl\t%ebp\n" ^
	"\tmovl\t%esp,%ebp\n" ^
	"\tlea\t" ^ declare ^ ",%edx\t/* Get all the global declarations done first */\n" ^
	"\tcall\t" ^ setup ^ "\n" ^
	"\tpush\t%edx\n" ^
	"\tpush\t%eax\n" ^
	"\tcall\t_trampoline\n" ^
	"\tadd\t$8,%esp\n" ^
	"\tmov\t%ebx,%eax\n" ^
	"\tleave\n" ^
	"\tret\n" ^
	"\t.align\t8\n"
      (* Now put the glue in a file *)
      val _ =
	let
	  val stream = TextIO.openOut "exe_glue.S"
	in
	  TextIO.output(stream, glue);
	  TextIO.closeOut stream
	 end
      (* Now assemble the glue *)
      val _ = LinkSupport.gcc "exe_glue.S"
      (* Now make the object name *)
    in
      LinkSupport.link
      {objects=["exe_glue.o"],
       libs=libs,
       target=target,
       target_path = ".",
       dll_or_exe=LinkSupport.EXE,
       base=0wx10000000,
       make_map=true,
       linker=LinkSupport.LOCAL}
    end

  fun is_pervasive_unit s = String.sub(s, 0) = #" "

  fun filter_eq eq [] = []
    | filter_eq eq (arg as [_]) = arg
    | filter_eq eq (x :: xs) = 
        let 
          fun adjoin(a,l) =  
            case List.find (fn b => eq(a,b)) l of
              SOME _ => l
            | _ => a::l

          fun adjoin2(a,b,acc) = if eq(a, b) then acc else adjoin(a,acc)

          fun filter_sub([],acc) = acc
            | filter_sub([a],acc) = adjoin(a,acc)
            | filter_sub(a::(l as b :: _),acc) = filter_sub(l,adjoin2(a,b,acc))

         in filter_sub(xs, [x])
        end

  fun make_dll_from_project(location, options, target, libs) =
    let
      val project = Incremental.get_project()
      val object_name = Project.objectName(options, location)
      (* Get all the units *)
      val targets = Project.currentTargets project
      val targets =
	map
	(fn name => ModuleId.from_string(name, location))
	targets
      val units =
	filter_eq ModuleId.eq
	(List.foldr
	 op@
	 []
	 (map
	  (fn name =>
	   Project.allObjects (options, location)
	   (project, name)
	   )
	  targets))
      val units = List.filter (fn m => String.sub(ModuleId.string m, 0) <> #" ") units
      (* Make sure we have the proper names *)
      val names = map (fn m => Project.get_name(project, m)) units
	handle _ => raise OS.SysErr("Project system has bad unit", NONE)
      (* Now get the mo filenames *)
      val object_names =
	map
	(fn name => object_name(project, name))
	names
      (* Now make the mo archive *)
      val _ = LinkSupport.archive
	{archive=OS.Path.joinBaseExt{base=target, ext=SOME"moa"}, files=object_names}
      (* Now make the stamp file *)
      val stamp_source = LinkSupport.make_stamp target
      (* Now the glue *)
      val glue =
	"\t.text\n" ^
	"\t.globl\t_MLWDLLmain@12\n" ^
	"\t.globl\tml_register_time_stamp\n" ^
	"\t.globl\tuid\n" ^
	"_MLWDLLmain@12:\n" ^
	"\tcmpl\t$1,8(%esp)\n" ^
	"\tjne\tl1\t\t/* Branch if not load */\n" ^
	"\tpushl\t%ebp\n" ^
	"\tmovl\t%esp,%ebp\n" ^
	"\tlea\tuid,%eax\n" ^
	"\tcall\tml_register_time_stamp\t/* Declare us to the runtime system */\n" ^
	"\tleave\n" ^
	"l1:\n" ^
	"\tmov\t$1,%eax\n" ^
	"\tret\t$12\n"
      (* Now make the text/data start/end files *)
      val text_start =
	"\t.text\n" ^
	"\t.globl\ttext_start\n" ^
	"\t.align\t4\n" ^
	"text_start:\n"
      val text_end =
	"\t.text\n" ^
	"\t.globl\ttext_end\n" ^
	"\t.align\t4\n" ^
	"text_end:\n"
      val data_start =
	"\t.data\n" ^
	"\t.globl\tdata_start\n" ^
	"\t.align\t4\n" ^
	"data_start:\n"
      val data_end =
	"\t.data\n" ^
	"\t.globl\tdata_end\n" ^
	"\t.align\t4\n" ^
	"data_end:\n"
      (* This stuff should go away *)
      (* when we start creating our own object files *)
      (* Now deal with creating the sources. *)
      val ids_and_objects = Lists.zip(names, object_names)
      val _ =
	(app
	 (fn (module_id, mo_name) =>
	  ((*print("Creating asm for '" ^ mo_name ^ "'\n");*)
	  Object_Output.output_object_code
	  (Object_Output.ASM, module_id, mo_name, project)
	  (Encapsulate.input_code mo_name)))
	 ids_and_objects)
	handle Encapsulate.BadInput s => raise OS.SysErr(s, NONE)
      (* Now deal with the tacky _text.S and _data.S stuff, which should go away in the future *)
      val (text_names, data_names) =
	ListPair.unzip
	(map
	 (fn object_name =>
	  let
	    val {base, ext} = OS.Path.splitBaseExt object_name
	    val {dir, file} = OS.Path.splitDirFile base
	    val text = OS.Path.joinBaseExt{base=OS.Path.joinDirFile{dir=dir, file = file ^ "_text"},
					   ext = SOME"S"}
	    val data = OS.Path.joinBaseExt{base=OS.Path.joinDirFile{dir=dir, file = file ^ "_data"},
					   ext = SOME"S"}
	  in
	    (text, data)
	  end)
	 object_names)
      val source_names = text_names @ data_names
      (* Now put them all through gcc *)
      (* Since this is only temporary (pending the inclusion of the object file outputter) *)
      (* we'll put the derived files in the current directory *)
      (* These are the glue, the start and end files, and the stamp file *)
      val names_and_contents =
	[("glue.S", glue),
	 ("text_start.S", text_start),
	 ("text_end.S", text_end),
	 ("data_start.S", data_start),
	 ("data_end.S", data_end),
	 ("stamp.S", stamp_source)]
      val _ =
	app
	(fn (name, contents) =>
	 let
	   val stream = TextIO.openOut name
	 in
	   TextIO.output(stream, contents);
	   TextIO.closeOut stream
	 end)
	names_and_contents
      val temp_names = map #1 names_and_contents
      val source_names = temp_names @ source_names
      (* Now put it all through gcc *)
      val _ =
	app
	LinkSupport.gcc
	source_names
      (* Now link it all *)
      val object_names =
	map
	(fn name => OS.Path.joinBaseExt{base= #base(OS.Path.splitBaseExt name), ext=SOME"o"})
	source_names
      val sub_projects = ProjFile.getSubprojects()
      val extra_libs = 
	map
	(fn name => OS.Path.joinBaseExt{base= #base (OS.Path.splitBaseExt name), ext=SOME"lib"})
	sub_projects
    in
      LinkSupport.link
      {objects=object_names,
       libs=libs @ extra_libs,
       target=target,
       target_path = ".",
       dll_or_exe=LinkSupport.DLL,
       base=0wx10000000,
       make_map=true,
       linker=LinkSupport.LOCAL}
    end

  (* All these compile and load commands share the same pattern.  
     A higher-order function seems called for. *)
  fun compile_file
	(location, options)
	error_info
	filename =
    let
      val module_id =
        ModuleId.from_string (filename, location)

      val (project', _) =
        Project.read_dependencies
          (error_info, location)
          (Incremental.get_project (), module_id, Project.empty_map)

      val out_of_date =
        Project.check_compiled
          (error_info, location)
          (project', module_id)
   
    in
      Incremental.set_project
        (TopLevel.compile_file'
	   error_info
	   (options, project', out_of_date))
    end


    (* There should be a more direct way of obtaining the object path 
     * from the project interface. *)

    fun object_path (file_name, location) =
        let 
          val module_id = ModuleId.from_string (file_name, location)
          val project_dir = ProjFile.getProjectDir()
          val (_, objects_dir, _) = ProjFile.getLocations()
	  val (_, modeDetails, curMode) = ProjFile.getModes()
	  val (_, _, curConfig) = ProjFile.getConfigurations()
	  val mode_prefix = 
	    if isSome(curMode) 
            then
	      !(#location(ProjFile.getModeDetails(valOf(curMode),modeDetails)))
	    else ""
	  val config_prefix = getOpt(curConfig, "")
          val path = OS.Path.concat
                     [ objects_dir, config_prefix, mode_prefix, 
                       ModuleId.module_unit_to_string(module_id, "mo") ]
	in	
          OS.Path.mkAbsolute{path=OS.Path.fromUnixPath path, relativeTo=project_dir}
	end
  

  fun force_compile (lo as (location, options)) error_info file_name =
    let val module_id = ModuleId.from_string (file_name, location)
        val path = object_path (file_name, location)
     in OS.FileSys.remove path handle OS.SysErr (s,e) => ();
        Project.set_object_info(Incremental.get_project (), module_id, NONE);
        compile_file lo error_info file_name
    end

  fun get_units (error_info, location) =
    let val _ = Incremental.reset_project()
        val proj = Incremental.get_project ()
        val proj' = Project.map_dag 
                      (Project.update_dependencies (error_info, location))
                      proj
        val _ = Incremental.set_project proj'
     in List.filter
	  (fn (s, _) => String.sub (s, 0) <> #" ")
	  (Project.list_units proj')
    end

  fun force_compile_all (lo as (location, options)) error_info  =
    let fun remove_mo (file_name, module_id) =
            let val path = object_path (file_name, location)
             in OS.FileSys.remove path handle OS.SysErr (s,e) => ();
                Project.set_object_info(Incremental.get_project (), 
                                        module_id, NONE)
            end
     in app remove_mo (get_units (error_info, location));
        app (compile_file lo error_info) (#1 (ProjFile.getTargets()))
    end

  fun show_compile_file
	(location, output_fn)
	error_info
	filename =
    let
      val module_id =
        ModuleId.from_string
          (filename, location)

      val (project', _) =
        Project.read_dependencies
          (error_info, location)
          (Incremental.get_project (), module_id, Project.empty_map)

      val out_of_date =
        Project.check_compiled
          (error_info, location)
          (Incremental.get_project (), module_id)

      val _ = Incremental.set_project project'
    in
      case out_of_date of
        [] => output_fn "No files need compiling\n"
      | _ => (output_fn "Files to compile:\n";
              app
               (fn s => output_fn (" " ^ ModuleId.string s ^ "\n"))
                out_of_date)
    end

  fun load_file
	(user_context, location, options, preferences, output_fn)
	error_info
	filename =
    let
      val module_id = ModuleId.from_string (filename, location)

      val (project', _) =
        Project.read_dependencies
          (error_info, location)
          (Incremental.get_project(), module_id, Project.empty_map)

      val out_of_date =
        Project.check_load_objects
          (error_info, location)
          (project', module_id)

      val _ = Incremental.set_project project'
    in
      case Incremental.load_mos
	     error_info
	     (options, UserContext.get_context user_context,
	      project', module_id, out_of_date, location) of
        NONE =>
	  (* Surely this isn't the best action in a GUI? *)
	  output_fn "up to date\n"
      | SOME result =>
	  UserContext.process_result
	    {src = UserContext.COPY ("Shell.Build.loadObject \"" ^ 
                   ModuleId.string module_id ^ "\""),
	     result = result,
	     user_context = user_context,
	     options = options,
	     preferences = preferences,
	     output_fn = output_fn}
    end
     
  fun show_load_file
	(location, output_fn)
	error_info
	filename =
    let
      val module_id = ModuleId.from_string (filename, location)

      val (project', _) =
        Project.read_dependencies
          (error_info, location)
          (Incremental.get_project (), module_id, Project.empty_map)

      val out_of_date =
        Project.check_load_objects
          (error_info, location)
          (project', module_id)

      val _ = Incremental.set_project project'

      val filelist = map ModuleId.string out_of_date

    in
      case filelist
      of [] =>
        output_fn "No files need loading\n"
      |  _ =>
        (output_fn "Files to load\n";
	 app
           (fn s => output_fn (" " ^ s ^ "\n"))
            filelist)
    end

  (* Much of this code is taken from TopLevel.build.  The differences
     are:  the initial project, and what to do at the end. *)
  fun compile_targets_for 
	(location, options, error_info)
	project =
    let
      val initProject =
	Project.update_dependencies (error_info, location) project

      fun recompile_one
            ((project, depend_map, compile_map), module) =
        let
          fun do_recompile_one mod_id =
            let
              val (project, depend_map) =
                Project.read_dependencies
                  (error_info, location)
                  (project, mod_id, depend_map);

              val (out_of_date, compile_map) =
                Project.check_compiled'
                  (error_info, location)
                  (project, mod_id)
                  ([], compile_map)

              val project =
                TopLevel.compile_file'
                  error_info
                  (options, project, out_of_date);

              val status_map =
                Lists.reducel Project.mark_compiled (compile_map, out_of_date)
            in
              (project, depend_map, compile_map)
            end
        in
          do_recompile_one (ModuleId.from_host (OS.Path.file module, location))
        end

      val (finalProject, _, _) =
        Lists.reducel
          recompile_one
          ((initProject, Project.empty_map, Project.visited_pervasives),
           Project.currentTargets initProject);
    in
      finalProject
    end

  fun compile_targets 
	(location, options)
	error_info =
      Incremental.set_project
        (Project.map_dag (compile_targets_for 
                             (location,options,error_info))
                         (Incremental.get_project ())) 

  fun show_compile_targets_for
	(location, output_fn, error_info) project =
    let
      val name = Project.get_project_name project
      val initProject =
	Project.update_dependencies (error_info, location) project

      fun check_one
            ((project, out_of_date, depend_map, compile_map),
             module) =
        let
          fun do_check_one mod_id =
            let
              val (project, depend_map) =
                Project.read_dependencies
                  (error_info, location)
                  (project, mod_id, depend_map)

              val (out_of_date_now, compile_map) =
                Project.check_compiled'
                  (error_info, location)
                  (project, mod_id)
                  (out_of_date, compile_map)
            in
              (project, out_of_date_now, depend_map, compile_map)
            end
        in
          do_check_one (ModuleId.from_host (OS.Path.file module, location))
        end

      val (finalProject, out_of_date, _, _) =
        Lists.reducel
          check_one
          ((initProject, [], Project.empty_map, Project.visited_pervasives),
           Project.currentTargets initProject)

    in
      case out_of_date of
        [] => output_fn ("No files need compiling for " ^ name ^ "\n")
      | _ => (output_fn ("Files to compile for " ^ name ^ ":\n");
              app
               (fn s => output_fn (" " ^ ModuleId.string s ^ "\n"))
                out_of_date);
      finalProject
    end

  fun show_compile_targets
	(location, output_fn)
	error_info =
      Incremental.set_project
        (Project.map_dag (show_compile_targets_for 
                             (location,output_fn,error_info))
                         (Incremental.get_project ()))

  fun load_targets_for
	(user_context, location, options, preferences, output_fn, error_info) 
        project =
    let
      val initProject =
	Project.update_dependencies (error_info, location) project

      fun reload_one ((project, depend_map), module) =
        let
          fun do_reload_one mod_id =
            let
              val (project', depend_map) =
                Project.read_dependencies
                  (error_info, location)
                  (project, mod_id, depend_map);

	      (* Probably need a check_load_objects', to preserve
		 existing out_of_date list, if not compile_map. *)
              val out_of_date =
                Project.check_load_objects
                  (error_info, location)
                  (project', mod_id)

              val _ = Incremental.set_project project'
            in
              case Incremental.load_mos
                     error_info
                     (options, UserContext.get_context user_context, project',
		      mod_id, out_of_date, location) of
                NONE =>
                  output_fn ("Project " ^ (Project.get_project_name project) 
                                        ^ " is up to date\n")
              | SOME result =>
                  UserContext.process_result
                    {src = UserContext.COPY ("Shell.Build.loadObject \"" ^
                           		     ModuleId.string mod_id ^ "\""),
                     result = result,
                     user_context = user_context,
                     options = options,
                     preferences = preferences,
                     output_fn = output_fn};
              (project', depend_map)
            end
        in
          do_reload_one (ModuleId.from_host (OS.Path.file module, location))
        end

      val (finalProject, _) =
        Lists.reducel
          reload_one
          ((initProject, Project.empty_map),
           Project.currentTargets initProject);
    in
      finalProject
    end


  fun load_targets
	(user_context, location, options, preferences, output_fn)
	error_info =
      Incremental.set_project
        ((*Project.map_dag*) (load_targets_for 
                            (user_context, location, options, preferences, 
                             output_fn, error_info))
                         (Incremental.get_project ()))

  fun show_load_targets_for
	(location, output_fn, error_info) project =
    let
      val initProject =
	Project.update_dependencies (error_info, location) project

      fun check_one
            ((project, out_of_date, depend_map),
             module) =
        let
          fun do_check_one mod_id =
            let
              val (project', depend_map) =
                Project.read_dependencies
                  (error_info, location)
                  (project, mod_id, depend_map)

	      (* Probably need a check_load_objects', to preserve
		 existing out_of_date list, if not compile_map. *)
              val (out_of_date_now) =
                Project.check_load_objects
                  (error_info, location)
                  (project', mod_id)
            in
              (project, out_of_date_now, depend_map)
            end
        in
          do_check_one (ModuleId.from_host (OS.Path.file module, location))
        end

      val (finalProject, out_of_date, _) =
        Lists.reducel
          check_one
          ((initProject, [], Project.empty_map),
           Project.currentTargets initProject)

      val _ = Incremental.set_project finalProject
      val name = Project.get_project_name project
    in
      case out_of_date of
        [] => output_fn ("No files need loading for " ^ name ^ "\n")
      | _ => (output_fn ("Files to load for " ^ name ^ ":\n");
              app
               (fn s => output_fn (" " ^ ModuleId.string s ^ "\n"))
                out_of_date);
      finalProject
    end


  fun show_load_targets
	(location, output_fn)
	error_info =
      Incremental.set_project
        ((*Project.map_dag*) (show_load_targets_for 
                            (location, output_fn, error_info))
                         (Incremental.get_project ()))


  (**** The use functions ****)
  (* This section defines use_file, use_string, and read_dot_mlworks *)

  (* Use taking input from a token stream *)
  fun use_stream
	{token_stream, filename, user_context, toplevel_name, 
         user_options, preferences, debugger, error_info, output_fn, level} =
    let
      fun make_options () =
        ShellTypes.new_options (user_options, user_context)

      fun make_incremental_options () =
        Incremental.OPTIONS
        {options = make_options (),
         debugger = debugger}

      fun next () =
        if Lexer.eof token_stream then ()
        else
          let
            val result =
              Incremental.compile_source
              error_info
              (make_incremental_options(),
               UserContext.get_context user_context,
               Compiler.TOKENSTREAM1 token_stream)
          in
            UserContext.process_result
            {src = UserContext.COPY ("use \"" ^ String.toString filename ^ "\""),
             result = result,
             user_context = user_context,
             options = make_options (),
             preferences = preferences,
             output_fn = output_fn};
            next()
          end

    in
      ShellTypes.with_toplevel_name filename (fn _ => next ())
    end
  handle IO.Io {name = rdr, cause, ...} =>
    let
      val s = exnMessage cause ^ " in: " ^ rdr
    in
      Info.default_error'
        (Info.FATAL, Info.Location.FILE toplevel_name, s)
    end

  fun trim_spaces s =
    let
      fun trim (#" " :: rest) = trim rest
        | trim l = l
    in
      implode (rev (trim (rev (trim (explode s)))))
    end

  fun resolve_file_name (filename,pathname,relative) =
    let
      val expanded_path = 
        OS.FileSys.fullPath (if relative then pathname else ".")
      val expanded_file = 
        Getenv.expand_home_dir (trim_spaces filename)
      val new_name = 
        OSPath.mkCanonical (OSPath.mkAbsolute {path=expanded_file, relativeTo=expanded_path})
    in
      (new_name,OSPath.dir new_name)
    end

  (* A convenient function to wrap an error handler around *)
  fun sub_use_file
	{filename, user_context, toplevel_name, user_options, preferences,
	 debugger, error_info, output_fn, level} =
    let
      (* Unlike make, compile or recompile, use can read a file without a *)
      (* ".sml" extension, for compatibility with other compilers.  Also, *)
      (* the filename argument has already had home directories expanded. *)
      val Options.OPTIONS{compiler_options=Options.COMPILEROPTIONS{print_messages, ...}, ...} =
	ShellTypes.new_options(user_options, user_context)
      val (stream, filename) =
        (TextIO.openIn filename, filename)
        handle IO.Io {name = rdr, cause, ...} =>
          let
	    val s = exnMessage cause ^ " in: " ^ rdr
            val {base, ext} = OSPath.splitBaseExt filename
          in
            if not (isSome ext) then
              let
                val sml_name =
                  OSPath.joinBaseExt {base = base, ext = SOME "sml"}

              in
                (TextIO.openIn sml_name, sml_name)
                handle IO.Io _ =>
                  Info.error'
                  error_info
                  (Info.FATAL, Location.FILE toplevel_name, s)
              end
            else
              Info.error'
              error_info
              (Info.FATAL, Location.FILE toplevel_name, s)
          end
      val _ =
	if print_messages then
	  let
	    fun spaces y =
	      if y <= 0 then "Use: " ^ filename else ("   " ^ spaces (y-1))
	  in
	    output_fn (spaces level ^ "\n")
	  end
	else
	  ()

      val token_stream =
        Lexer.mkFileTokenStream (stream, filename)
    in
      use_stream {token_stream = token_stream,
                  filename = filename,
                  user_context = user_context,
                  toplevel_name = toplevel_name,
                  user_options = user_options,
                  preferences = preferences,
                  debugger = debugger,
                  error_info = error_info,
                  output_fn = output_fn,
                  level = level}
      handle exn => (TextIO.closeIn stream; raise exn);
      TextIO.closeIn stream
    end

  (* We could move these into shell_data if we don't like the globality *)
  val use_level = ref 0
  val use_pathname = ref "."

  (* we need to be careful with the debugger function that is *)
  (* passed in to internal_use_file.   For a normal use, we pass in the *)
  (* identity function.  This means that any exceptions get handled only *)
  (* by the outermost debugger handler and the user can write "use <foo> *)
  (* handle Div => ..." and have it behave correctly. *)

  fun internal_use_file (shell_data, debugger, output_fn, filename) = 
    let
      val ShellTypes.SHELL_DATA {get_user_context,
                                 user_options,
                                 user_preferences,
                                 ...} =
        shell_data
      (* Do we resolve pathnames relative to the pathnames of any uses we *)
      (* are already in or relative to the current working directory? *)
      val Preferences.USER_PREFERENCES 
        ({use_relative_pathname = ref relative,...},_) = user_preferences
      val toplevel_name = ShellTypes.get_current_toplevel_name()
      val (new_name,new_path) = 
        resolve_file_name (filename,!use_pathname,relative)
        handle Getenv.BadHomeName s =>
          Info.default_error'
          (Info.FATAL, Info.Location.FILE toplevel_name,
           "Invalid home name: " ^ s)
             | OS.SysErr _ => 
          Info.default_error'
          (Info.FATAL, Info.Location.FILE toplevel_name,
           "No such file: `" ^ filename ^ "'")

      val error_info = Info.make_default_options ()
      val level = !use_level
      val old_pathname = !use_pathname
    in
      use_level := level + 1;
      use_pathname := new_path;
      sub_use_file {filename = new_name,
                    user_context = get_user_context (),
                    error_info = error_info,
                    toplevel_name = ShellTypes.get_current_toplevel_name(),
                    user_options = user_options,
                    preferences = 
                      Preferences.new_preferences user_preferences,
                    debugger = debugger,
                    output_fn = output_fn,
                    level = level
                    } 
      handle exn => (use_level := level; 
                     use_pathname := old_pathname;
                     raise exn);
      use_level := level;
      use_pathname := old_pathname
    end

  (* Normally when we do a use, we are in the dynamic scope of a debugger *)
  (* function *)
  fun use_file (shell_data, output_fn, pathname) =
    internal_use_file (shell_data, fn x => x, output_fn, pathname)

  fun use_string (shell_data, output_fn, string) =
    let
      val toplevel_name = ShellTypes.get_current_toplevel_name()
      val error_info = Info.make_default_options ()
      val ShellTypes.SHELL_DATA {get_user_context,
                                 user_options,
                                 user_preferences,
                                 ...} =
        shell_data
      val level = !use_level
      val name = "<use_string input>"
      val r = ref string
      val token_stream = 
        Lexer.mkTokenStream 
        (fn _ => let val s = !r in  r := "" ; s end,name)
    in
      use_level := level + 1;
      use_stream {filename = name,
                  token_stream = token_stream,
                  user_context = get_user_context (),
                  error_info = error_info,
                  toplevel_name = ShellTypes.get_current_toplevel_name(),
                  user_options = user_options,
                  preferences = 
                    Preferences.new_preferences user_preferences,
                  debugger = fn x => x,
                  output_fn = output_fn,
                  level = level
                  }
      handle exn => (use_level := level; raise exn);
      use_level := level
    end

  (* Need to handle Info.Stop exceptions ourselves here as this function *)
  (* isn't called eg. within a listener evaluation *)
  (* Ditto for interrupt and return from debugger functions *)

  (* Also pass a proper debugger in here as there isn't a proper one in the *)
  (* evaluation context when this gets called *)

  fun read_dot_mlworks shell_data =
    let
      fun output_fn s = Messages.output s;
      val ShellTypes.SHELL_DATA{debugger,...} = shell_data
    in
      case Getenv.get_startup_filename () of
        NONE => ()
      | SOME pathname =>
          if OS.FileSys.access (pathname, []) handle OS.SysErr _ => false 
            then
              internal_use_file (shell_data, debugger, output_fn, pathname)
              handle Info.Stop _ => ()
                   | MLWorks.Interrupt => ()
                   | ShellTypes.DebuggerTrapped => ()
          else ()
    end 

  exception NotAnExpression = Incremental.NotAnExpression

  fun eval error_info (string, options, context) = 
    let
      val parser_basis = Incremental.parser_basis context
      val input_fn =
        let val sref = ref (string ^ ";")
        in
          fn _ => let val result = !sref in sref := "" ; result end
        end

      (* need to wrap the parser so that we stop on errors *)
      fun error_wrap f a =
        let val result = Info.wrap
          error_info
          (Info.WARNING, Info.RECOVERABLE, 
           Info.FAULT,Location.FILE "Eval Input")
          f
          a
        in
          result
        end

      val token_stream = 
        Parser.Lexer.mkTokenStream (input_fn,"<Eval input>")

      fun doit error_info () =
        let
          fun get_topdec () =
            (let val _ =
               Parser.parse_incrementally
               error_info
               (options,
                token_stream,
                parser_basis,
                Parser.initial_parser_state,
                Parser.Lexer.Token.PLAIN_STATE)
            in
              Info.error' error_info
              (Info.FATAL, Location.FILE "Eval Input", 
               "Unexpected end of line")
            end
            handle
            Parser.FoundTopDec(topdec,newpB,loc) =>
              topdec
          | Parser.SyntaxError(message,location) =>
              Info.error' error_info (Info.FATAL, location, message))
                   
          val topdec = get_topdec ()

        in
          Incremental.evaluate_exp_topdec
          error_info
          (Incremental.OPTIONS{options = options,
                               debugger = fn x => x},
           context,
           topdec)
        end
    in
      error_wrap doit ()
    end

  fun print_value ((object,ty),print_options,context) =
    let
      val debug_info = Incremental.debug_info context
    in
      ValuePrinter.stringify_value false
      (print_options, object, ty, debug_info)
    end

  fun print_type (ty,print_options,context) =
    let
      val completion_env =
        let
          val type_basis = Incremental.type_basis context
          val BasisTypes.BASIS(_,_,_,_,env) = type_basis
        in
          env
        end
    in        
      Completion.print_type (print_options,completion_env,ty)
    end

  datatype COMPLETION = 
    TOKEN of Token.Token |
    STRING of string | 
    NO_COMPLETION

  (* Should do this without allocating *)
  fun prefixp (string1,string2) =
    (size string1 <= size string2) andalso
    (string1 = 
     substring (* could raise Substring *)(string2,0,size string1))

    
  fun do_map (map,to_string,string) =
    NewMap.fold_in_rev_order
    (fn (acc,name,_) =>
     let val string' = to_string name
     in
       if prefixp (string,string')
         then string' :: acc
       else acc
     end)
    ([],map)

  fun get_valid_symbol (Ident.VAR s) = s
    | get_valid_symbol (Ident.CON s) = s
    | get_valid_symbol (Ident.EXCON s) = s
    | get_valid_symbol (Ident.TYCON' s) = s

  fun get_env_names (Datatypes.ENV (Datatypes.SE strmap,
                                    Datatypes.TE tymap,
                                    Datatypes.VE (_,valmap)),
                     id) =
    do_map (strmap,(fn Ident.STRID s => Symbol.symbol_name s),id) @    
    do_map (tymap,(fn Ident.TYCON s => Symbol.symbol_name s),id) @    
    do_map (valmap,(Symbol.symbol_name o get_valid_symbol),id)

  fun get_basis_names (BasisTypes.BASIS(_,
                                        nameset,
                                        BasisTypes.FUNENV funmap,
                                        BasisTypes.SIGENV sigmap,
                                        env),
                       id) =
    get_env_names (env,id) @
    do_map (funmap,(fn Ident.FUNID s => Symbol.symbol_name s),id) @
    do_map (sigmap,(fn Ident.SIGID s => Symbol.symbol_name s),id)

  exception NoEnv

  fun get_env (path,BasisTypes.BASIS(_,_,_,_,env)) =
    let
      fun get_env_env ([],env) = env
        | get_env_env (sym::path,Datatypes.ENV(Datatypes.SE strmap,_,_)) =
          let
            val strid = Ident.STRID(sym)
            val str = NewMap.apply'(strmap,strid)
            fun get_str_env (Datatypes.COPYSTR(_,str)) = get_str_env str
              | get_str_env (Datatypes.STR (_,_,env)) = env
          in
            get_env_env(path,get_str_env str)
          end
    in
      get_env_env (path,env)
    end
    handle NewMap.Undefined => raise NoEnv

  fun split_filename s = 
    (OSPath.dir s, OSPath.file s)

  (* We should review this lot if and when FileSys gets implemented *)
  (* properly. In particular, ensure that the right exceptions are *)
  (* handled *)

  fun find_matches (dir,s) = 
    let
      val names = ref []
      val _ = debug_out ("Opening " ^ dir)

      (* On Win32 if dir is an empty string then Syserr exception is raised. *)
      val directory = if (dir = "") then "." else dir

      (* On Win32 raises an exception if the parameter passed to OS.FileSys.fullPath
       * contains only the drive letter. *)
      val full_path = OS.FileSys.fullPath (Getenv.expand_home_dir directory)
	handle OS.SysErr _ => directory

      val d = OS.FileSys.openDir (full_path)

      fun get_names () = 
        case OS.FileSys.readDir d of
          NONE => ()
        | SOME next =>  
            (if size next >= size s andalso
               substring (next,0,size s) = s
               then names := next :: !names
             else ();
             get_names ())
    in
      get_names ();
      OS.FileSys.closeDir d; (* Should be an exn handler for this too *)
      !names
    end
    (* This shouldn't be a catchall, but we should sort out exactly what *)
    (* exceptions can be raised *)
    (* XXXEXCEPTION: should handle OS.SysErr *)
    handle _ => []

  fun complete_token (sofar,TOKEN (token as Token.RESERVED _),context) =
    complete_token (sofar,
                    TOKEN 
                    (Token.LONGID ([],
                                   Symbol.find_symbol
                                   (Token.makestring token))),
                    context)
    | complete_token (sofar,
                      TOKEN (token as Token.LONGID (path,id)), 
                      context) =
      let
        val type_basis = Incremental.type_basis context
        val string = Symbol.symbol_name id

        val completions = 
          case path of
            [] => get_basis_names (type_basis,string)
          | _ =>
              (let
                val env = get_env (path,type_basis)
                val pathname =
		  concat
                  (rev (Lists.reducel
                        (fn (acc,s) => "." :: Symbol.symbol_name s :: acc)
                        ([],path)))
              in
                map (fn s => pathname ^ s) (get_env_names (env,string))
              end
            handle NoEnv => [])

        fun is_structure_path path =
          (ignore(get_env (path,type_basis)); true) handle NoEnv => false
      in
        case completions of 
          [s] => 
            if s = sofar andalso is_structure_path (path @ [id])
              then [s ^ "."]
            else completions
        | _ => completions
      end


    | complete_token (sofar,STRING s,context) =
      (* s is a filename *)
      let
        (* For this to work on the PC, we need to convert back and forth *)
        (* between double and single backslashes *)
        (* This really is horrible though *)
        fun munge1 ([],acc) = implode (rev acc)
          | munge1 (#"\\" :: #"\\" ::rest,acc) = munge1 (rest, #"\\" ::acc)
          | munge1 (a::rest,acc) = munge1 (rest,a::acc)
        fun munge2 ([],acc) = implode (rev acc)
          | munge2 (#"\\" ::rest,acc) = munge2 (rest, #"\\" :: #"\\" :: acc)
          | munge2 (a::rest,acc) = munge2 (rest,a::acc)
        val munged_sofar = munge1 (explode sofar,[])
        val (dir,fname) = split_filename (munge1 (explode s,[]))
        val names = find_matches (dir,fname)
        val completions' =
          (if dir ="" then names
           else map (fn n => OSPath.concat [dir,n]) names)
 	val completions = map (fn s => munge1 (explode s, [])) completions'
        fun isDir s =
          let
            val s = Getenv.expand_home_dir s
              handle Getenv.BadHomeName _ => s
            val s = OS.FileSys.fullPath s
            val result = OS.FileSys.isDir s
          in
            result
          end
          handle OS.SysErr _ => false
      in
        map (fn s => munge2 (explode s,[]))
        (case completions of 
           [s] => 
             (if s = munged_sofar andalso isDir s
               then [OSPath.concat [s,""]]
               (* XXXEXCEPTION: should handle OS.SysErr *)
             else completions)
         | _ => completions)
      end

    | complete_token _ = []

  fun filter_completions l =
    let
      fun remove_duplicates ([],acc) = acc
        | remove_duplicates ([a],acc) = a :: acc
        | remove_duplicates (a :: (rest as (b :: l)), acc) =
          if a = b 
            then remove_duplicates (rest,acc)
          else remove_duplicates (rest,a::acc)
    in
      remove_duplicates (Lists.qsort ((op>):string*string->bool) l, [])
    end

  fun find_string (s:string) =
    let
      val chars = explode s
      fun strip [] = NO_COMPLETION
        | strip (a::b) =
          if a = #"\"" then (* \" *)
	    find_string (b,[])
          else strip b
      and find_string ([],acc) =
        STRING (implode (rev acc))
        | find_string (a::b,acc) =
          if a = #"\"" then (* \" *)
            strip b
          else 
	    find_string (b,a::acc)
    in
      strip chars
    end
      
  fun get_completions (s,options,context) =
    let
      fun get_token s =
        case find_string s of
          STRING s => STRING s
        | _ => 
            let
              val error_info = Info.make_default_options ()
              fun doit error_info () =
                let
                  val x = ref s
                  fun input_fn _ = 
                    (let val result = !x in x := ""; result end)
                  val ts = Lexer.mkTokenStream (input_fn,"")
                  fun get_token tok =
                    case Lexer.getToken error_info (options,
                                                    Lexer.Token.PLAIN_STATE,
                                                    ts) of
                      Token.EOF (state) => tok
                    | new_tok => get_token (TOKEN new_tok)
                in
                  get_token NO_COMPLETION
                end
            in
              Info.with_report_fun
              error_info
              (fn _ => ())
              doit 
              ()
            end
      val to_complete = get_token s
      val sofar =
        case to_complete of
          NO_COMPLETION => ""
        | TOKEN tok => Token.makestring tok
        | STRING string => string
    in
      (sofar,
       filter_completions (complete_token (sofar,to_complete,context)))
    end

  (* find a common completion *)

  fun find_common_completion [] = ""
    | find_common_completion (target::l) =
      let
        fun check (s,m,n) =
          if m = n 
            then n
          else if MLWorks.String.ordof(s,m) = MLWorks.String.ordof(target,m)
                 then check (s,m+1,n)
               else m
        fun aux ([],n) = n
          | aux ((a::l),n) =
            aux (l,check(a,0,(Int.min (size a,n))))
        val result = (* could raise Substring *)
          substring (target,0,aux(l,size target))
      in
        result
      end

    (* This should evaluate an identifier *)
    fun lookup_name (name,context,default) =
      let
        val tycontext = 
          Basis.basis_to_context (Incremental.type_basis context)
        val valid = Ident.VAR(Symbol.find_symbol name)
        val valtype =
	  #1(Basis.lookup_val (Ident.LONGVALID (Ident.NOPATH, valid),
                               tycontext,
                               Ident.Location.UNKNOWN,
                               false))
        val mlval = Inter_EnvTypes.lookup_val(valid,
                                              Incremental.inter_env context)
      in
        (mlval,valtype)
      end
    handle _ => default (* !!!!!! *)


  fun value_from_history_entry
	(UserContext.ITEM {id, context, source, ...}, options) =
      (* We switch off all the compiler options when calling eval here, 
         which amongst other things enables us to detect that we are compiling
         code associated with the history mechanism.  I suppose we could 
         introduce another option for this, but that seems overkill.  

         At the moment every time we switch focus the menu is refreshed, 
         multiple times, which in turn forces the history to be calculated 
         frequently, as the menu items are not computed lazily.  This then 
         forces the optimiser to be called multiple times whenever we switch 
         windows.  Debugging the optimiser is made very difficult in such a 
         setting, as it is being called all over the place.  If we make the 
         "spurious" calls to the optimiser stand out from the "genuine" ones
         then this simplifies the debugging output.  I'm not totally convinced
         that the event handling, menus and history mechanisms are interacting
         in the way that was originally expected, but the performance hit 
         probably isn't too much at the moment.  
       *)

    let val Options.OPTIONS 
            {listing_options, print_options, compat_options, extension_options,
             compiler_options =
               Options.COMPILEROPTIONS {mips_r4000, sparc_v7, ...} } = options
        val options' = 
            Options.OPTIONS 
            {listing_options=listing_options, print_options=print_options, 
             compat_options=compat_options, 
             extension_options=extension_options,
             compiler_options =
               Options.COMPILEROPTIONS 
               {generate_debug_info=false, debug_variables=false,
                generate_moduler=false, intercept=false, interrupt=false, 
                opt_handlers=false, opt_leaf_fns=false, opt_tail_calls=false,
                opt_self_calls=false, local_functions=false, 
                print_messages=false,
                mips_r4000=mips_r4000, sparc_v7=sparc_v7} }
     in 
      case id of
        Ident.VALUE (Ident.VAR s) =>
	  (let
	    val value =
	      eval Info.null_options
              (Ident.Symbol.symbol_name s,
               options', context)
	  in
            (* This should be done by with_standard_output *)
            TextIO.flushOut TextIO.stdOut;
	    case source of
	      UserContext.STRING str => SOME (str, value)
	    | UserContext.COPY str => SOME (str, value)
	  end
          handle _ => NONE)
      |  _ =>
           NONE
    end

  fun value_from_user_context (user_context, user_options) =
    case UserContext.get_latest user_context
    of NONE => NONE
    |  SOME item =>
      value_from_history_entry
	(item, ShellTypes.new_options (user_options, user_context))
 end
