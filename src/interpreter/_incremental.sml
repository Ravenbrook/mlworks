(*  ==== INCREMENTAL COMPILER ====
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
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: _incremental.sml,v $
 *  Revision 1.143  1998/11/26 10:47:33  johnh
 *  [Bug #70240]
 *  Change spec of Project.delete
 *
 * Revision 1.142  1998/06/08  10:00:52  jont
 * [Bug #50071]
 * Fix compiler warning
 *
 * Revision 1.141  1998/05/07  09:20:02  mitchell
 * [Bug #50071]
 * Fix reset project to reread from the project file
 *
 * Revision 1.140  1998/04/24  15:49:25  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.139  1998/01/29  16:16:18  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.137.2.7  1997/12/04  16:47:36  daveb
 * [Bug #30017]
 * Rationalised Shell/GUI Project commands:
 * Moved check_mo to ShellUtils, ditto for Project manipulation part of
 * load_mo.  Left the core part as load_mos, which loads all files in a list.
 *
 * Revision 1.137.2.6  1997/12/02  16:37:35  daveb
 * [Bug #30071]
 * Removed functions for loading from source files.
 *
 * Revision 1.137.2.5  1997/11/26  12:17:11  daveb
 * [Bug #30071]
 * match_{source,object}_path are no longer needed.
 *
 * Revision 1.137.2.4  1997/11/20  16:56:30  daveb
 * [Bug #30326]
 *
 * Revision 1.137.2.3  1997/11/11  16:13:06  johnh
 * [Bug #30203]
 * Merging - checking files to be recompiled.
 *
 * Revision 1.137.2.2  1997/09/17  15:50:49  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.137.2.1  1997/09/11  20:54:49  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.138  1997/09/17  15:49:11  brucem
 * [Bug #30203]
 * make check_mo and check_module return module ids.
 *
 * Revision 1.137  1997/05/28  08:56:42  johnh
 * [Bug #20033]
 * Pass extra arg to set_source_path to indicate -silent option.
 *
 * Revision 1.136  1997/05/21  17:09:25  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.135  1997/05/12  16:18:57  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.134  1997/05/02  16:55:26  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.133  1997/04/09  16:25:35  jont
 * [Bug #2040]
 * Make InterMake.load take an options argument
 *
 * Revision 1.132  1997/03/21  11:28:21  johnh
 * [Bug #1965]
 * Handling Io.NotSet for objectName.
 *
 * Revision 1.131  1997/02/11  18:13:05  daveb
 * Review edit <URI:spring://ML_Notebook/Review/basics/*module.sml>
 * -- Changed name and type of Module.mo_name and Module.sml_name.
 *
 * Revision 1.130  1996/10/30  14:54:56  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.129  1996/10/25  14:41:08  andreww
 * [Bug #1686]
 * propagating change made to parserenv: type constructor environment
 * added to parser env, for datatype replication.
 *
 * Revision 1.128  1996/08/16  14:01:34  jont
 * [Bug #1553]
 * Make match_object_path convert .sml into .mo, rather than adding it
 *
 * Revision 1.127  1996/07/02  09:40:47  daveb
 * Bug 1448/Support Call 35: Added remove_file_info to project and incremental,
 * and called it from _save_image.
 *
 * Revision 1.126  1996/06/24  10:41:45  stephenb
 * Fix #1330 - Shell.File.loadObject doesn't look for .mo extension
 *
 * Revision 1.125  1996/06/21  12:28:35  stephenb
 * Out with the old in with the new -- replaced OldOS and Lists by OS and List
 * respectively.  This was done to simplify fixing #1330.
 *
 * Revision 1.124  1996/05/03  10:56:59  daveb
 * Improved error messages from match_source_path and match_object_path.
 *
 * Revision 1.123  1996/05/03  09:15:49  daveb
 * Ensured that all changes to the project update the global project, even
 * when errors occur.
 * Removed Error exception.
 *
 * Revision 1.122  1996/05/01  09:47:24  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.121  1996/04/16  14:59:15  daveb
 * Removed some extraneous debugging statements.
 *
 * Revision 1.120  1996/04/16  12:05:04  jont
 * Add a call to Compiler.make_external on the result of compiling a module
 * which has already been compiled but is not visible at top level.
 * Made the same fix for loading object files
 *
 * Revision 1.119  1996/04/02  11:37:05  daveb
 * Added read_dependencies.
 *
 * Revision 1.118  1996/03/27  11:43:08  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.117  1996/03/26  17:15:34  matthew
 * New field in VALdec
 *
 * Revision 1.116  1996/03/26  11:47:25  jont
 * Set the lambda environment after compilation of the builtin library correctly
 * Remove debugging messages when loading mo files
 *
 * Revision 1.115  1996/03/26  09:44:30  daveb
 * Added match_source_path and match_object_path, which do some of the work
 * that Module.with_source_path used to do, plus checking for attempts to use
 * different files with the same unit name.
 * Changed type of some other functions for use with these new ones.
 *
 * Revision 1.114  1996/03/19  16:33:09  matthew
 * Replace Map.merge by Map.union
 *
 * Revision 1.113  1996/03/19  12:18:25  daveb
 * Added check_mo.
 *
 * Revision 1.112  1996/03/19  10:34:27  daveb
 * When a module is up to date, add_module and load_mo no longer read the
 * signatures from the file on disk.  They use whatever info is stored in
 * the project.
 *
 * Revision 1.111  1996/03/19  10:20:10  daveb
 * Removed filename field from result type.
 *
 * Revision 1.110  1996/03/19  10:02:40  daveb
 * Made load_mo and add_module return NONE if the module is both up to date
 * and visible.
 *
 * Revision 1.109  1996/03/18  16:12:35  daveb
 * Changed implementation of identifiers_from_result to extract identifiers
 * from the type basis.
 *
 * Revision 1.108  1996/03/18  14:12:11  daveb
 * Added call to set object path from the environment.  This is needed for
 * the call to Project.reset_pervasives.
 *
 * Revision 1.107  1996/03/14  17:47:11  daveb
 * Added support for loading libraries that share compiler code.
 *
 * Revision 1.106  1996/03/14  16:19:38  daveb
 * Reduced amount of information stored in projects for loaded units.
 *
 * Revision 1.105  1996/03/04  14:57:08  daveb
 * Changed information stored in project for loaded compilation units.
 *
 * Revision 1.104  1996/02/27  13:43:35  daveb
 * Hid implementation of Project.Unit type.
 *
 * Revision 1.103  1996/02/23  17:54:32  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.102  1995/12/27  14:57:41  jont
 * Removing Option in favour of MLWorks.Option
 *
 *  Revision 1.101  1995/12/11  16:49:41  daveb
 *  Now passes debug info around as accumulated info instead of a basis.
 *
 *  Revision 1.100  1995/12/11  16:15:52  daveb
 *  Fixed propagation of debug information.
 *
 *  Revision 1.99  1995/12/11  15:18:12  daveb
 *  Reversing previous change.
 *
 *  Revision 1.98  1995/12/11  10:27:52  daveb
 *  Changed compilation of pervasives to generate debug_info.
 *
 *  Revision 1.97  1995/12/06  18:39:34  daveb
 *  Reinstated delete_module and delete_all_modules.
 *
 *  Revision 1.96  1995/11/29  14:39:33  daveb
 *  Modifications to use new project stuff.
 *
 *  Revision 1.95  1995/07/28  12:27:38  matthew
 *  Adding error handlers for load_file etc.
 *
 *  Revision 1.94  1995/07/13  12:01:20  matthew
 *  Moved identifier to Ident
 *
 *  Revision 1.93  1995/06/01  16:20:59  matthew
 *  Adding delete_all_modules
 *
 *  Revision 1.92  1995/05/11  13:48:49  matthew
 *  Removing crash function
 *
 *  Revision 1.91  1995/05/02  16:07:54  jont
 *  Make mo loading use object_path
 *
 *  Revision 1.90  1995/04/20  14:52:17  daveb
 *  Io.set_source_path_from_env now takes a location.
 *
 *  Revision 1.89  1995/03/30  13:22:32  matthew
 *  Replacing Tyfun_id etc. with Stamp
 *
 *  Revision 1.88  1995/03/06  11:47:19  daveb
 *  Merged identifier list with Result type.
 *
 *  Revision 1.87  1995/02/13  17:11:14  matthew
 *  Removing (some) stepper variables
 *
 *  Revision 1.86  1995/02/08  12:23:16  matthew
 *  Improvements to interface to typechecker
 *
 *  Revision 1.85  1995/01/30  16:13:05  daveb
 *  Removed horrible UNIX-dependent hack of module names.
 *
 *  Revision 1.84  1995/01/30  15:16:37  matthew
 *  Debugger changes
 *
 *  Revision 1.83  1995/01/16  17:32:33  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *
 *  Revision 1.82  1994/12/06  10:29:46  matthew
 *  Changing uses of cast
 *
 *  Revision 1.81  1994/09/22  16:29:19  matthew
 *  Change to Basis.lookup_val
 *
 *  Revision 1.80  1994/08/09  13:51:32  daveb
 *  Renamed SourceResult to Result, and made it a datatype with a record
 *  argument instead of a tuple.  Added a modules field for returning the
 *  updated modules table, which fixed a bug in the behaviour of make.
 *
 *  Revision 1.79  1994/08/01  08:27:34  daveb
 *  Moved preferences out of options structures.
 *
 *  Revision 1.78  1994/07/29  11:49:40  daveb
 *  Made load_mo return a SourceResult value.
 *
 *  Revision 1.77  1994/07/26  11:11:58  daveb
 *  Moved set_no_execute here from _shell_utils, so that add_module and
 *  check_module don't have to check that the option is set correctly.
 *
 *  Revision 1.76  1994/07/26  10:17:07  daveb
 *  Removed inter_env component of InterMake.Result type.
 *
 *  Revision 1.75  1994/07/25  15:01:59  daveb
 *  Changed add_module to return a SourceResult, so that it can be used to
 *  build both a full context and a delta context.  Took the no_execute
 *  functionality out of add_module and put it in a separate function
 *  (check_module).  Made some of the debugger code readable.
 *
 *  Revision 1.74  1994/06/22  15:11:04  jont
 *  Update debugger information production
 *
 *  Revision 1.73  1994/06/21  16:22:26  daveb
 *   Added empty context (initial contexts aren't empty).
 *  Changed Context components of Error and Interrupted exceptions to a set
 *  of new modules, so that the user_context can be updated appropriately.
 *  Added update_modules to aid this task.
 *
 *  Revision 1.72  1994/06/06  12:49:00  nosa
 *  Breakpoint settings on function exits.
 *
 *  Revision 1.71  1994/05/12  15:04:29  daveb
 *  Basis.lookup_val now takes an extra argument.
 *  Also added a sharing constraint.
 *
 *  Revision 1.70  1994/05/06  16:28:38  jont
 *  Add function to give parser basis from source result
 *
 *  Revision 1.69  1994/03/25  17:13:16  daveb
 *  Changed add_module and delete_module and load_mo to take ModuleIds.
 *
 *  Revision 1.68  1994/03/18  14:27:28  matthew
 *  Added add_debug_info
 *  add_module returns a file list
 *
 *  Revision 1.67  1994/03/15  17:05:25  matthew
 *  Put load_time back in InterMake.Result
 *
 *  Revision 1.66  1994/02/28  06:50:16  nosa
 *  Debugger environments for Modules Debugger.
 *
 *  Revision 1.65  1994/02/25  15:51:23  daveb
 *  Adding clear_debug functionality.
 *
 *  Revision 1.64  1994/02/01  16:46:15  daveb
 *  _add_module now takes a Module argument instead of a file name.
 *
 *  Revision 1.63  1994/01/28  16:21:35  matthew
 *  Better locations in error messages
 *
 *  Revision 1.62  1994/01/26  14:47:40  matthew
 *  Numerous changes and simplifications:
 *  Removed load_time
 *  Made various accumulators refs within make
 *  Simplified interface to compiler.
 *
 *  Revision 1.61  1994/01/10  14:21:44  matthew
 *  Added function for loading an mo file.
 *
 *  Revision 1.60  1993/12/15  13:42:20  matthew
 *  Added level field to Basis.
 *
 *  Revision 1.59  1993/11/22  14:59:14  jont
 *  Changed use of runtime system modules to remove the time stamp field
 *
 *  Revision 1.58  1993/10/05  10:13:49  jont
 *  Changes to do with remembering whether compilations are of pervasives
 *
 *  Revision 1.57  1993/09/03  10:45:37  nosa
 *  lookup_val now returns runtime_instance for polymorphic debugger.
 *
 *  Revision 1.56  1993/09/02  17:08:14  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.55.1.2  1993/09/01  15:04:11  matthew
 *  Simplified debugger interface to InterMake.make
 *  Use InterMake.with_debug_info to set the debug information for the debugger
 *
 *  Revision 1.55  1993/08/16  11:38:08  daveb
 *  Changes to support moduleids and reflect changes to Io signature.
 *
 *  Revision 1.54  1993/07/30  14:18:55  nosa
 *  structure Option.
 *
 *  Revision 1.53  1993/07/29  16:00:08  matthew
 *  Changed Info.default_options to Info.make_default_options, which creates a new
 *  options object.
 *  Added Interrupted exceptions and handlers.
 *
 *  Revision 1.52  1993/07/05  14:21:17  daveb
 *  Removed exception environments.
 *
 *  Revision 1.51  1993/06/04  15:58:39  daveb
 *  Deleted the name component of the context type.
 *
 *  Revision 1.50  1993/05/26  17:09:09  matthew
 *  Changes to Error handling
 *
 *  Revision 1.49  1993/05/14  11:59:18  jont
 *  Added Crash parameter to functor parameter
 *
 *  Revision 1.48  1993/05/12  10:42:39  matthew
 *  Added is_an_expression function
 *
 *  Revision 1.47  1993/05/11  12:50:03  matthew
 *  Added error_list to Error exception
 *
 *  Revision 1.46  1993/05/10  14:08:31  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.45  1993/05/06  13:53:21  matthew
 *  add_module takes an explicit monitor function argument
 *
 *  Revision 1.44  1993/04/26  16:44:28  jont
 *  Added code to remove FullPervasiveLibrary_ from initial environment
 *
 *  Revision 1.43  1993/04/02  13:40:52  matthew
 *  Added evaluate_exp_topdec
 *
 *  Revision 1.42  1993/03/29  17:48:39  matthew
 *  removed string parameter from debugger function
 *
 *  Revision 1.41  1993/03/29  16:14:06  jont
 *  Removed get_pervasive_dir, using one in io instead
 *
 *  Revision 1.40  1993/03/19  11:54:22  matthew
 *  Removed add_source which is split up into compile_source and add_definitions
 *
 *  Revision 1.39  1993/03/17  12:20:33  matthew
 *  Added parserbasis field to Compiler.TOPDEC source
 *
 *  Revision 1.38  1993/03/11  13:35:53  matthew
 *  Simplified debugger function
 *  Signature revisions
 *
 *  Revision 1.37  1993/03/09  15:07:04  matthew
 *  Options & Info changes
 *  Changed options type
 *
 *  Revision 1.36  1993/03/04  10:40:55  daveb
 *  Added newlines to build messages.
 *
 *  Revision 1.35  1993/02/22  09:48:34  matthew
 *  Added code to update parser environment when adding a structure to a context.
 *
 *  Revision 1.34  1993/02/19  18:56:44  jont
 *  Fixed sharing problem between Option and InterMake.FileName.Option
 *
 *  Revision 1.33  1993/02/09  10:23:30  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.32  1993/02/04  16:56:49  matthew
 *  Signature Changes.
 *
 *  Revision 1.31  1993/01/28  09:49:20  jont
 *  Changed default make options to turn off debug, tracing and profiling
 *
 *  Revision 1.30  1993/01/05  10:53:47  jont
 *  Modified to deal with new code printing options
 *
 *  Revision 1.29  1992/12/18  10:11:31  clive
 *  We also pass the current module forward for the source_displayer
 *
 *  Revision 1.28  1992/12/09  14:20:09  clive
 *  Changes propagated from the lower levels
 *
 *  Revision 1.27  1992/12/08  17:17:30  clive
 *  Added find_module for the source_displayer
 *
 *  Revision 1.26  1992/12/08  12:26:38  daveb
 *  Removed some sharing constraints.
 *
 *  Revision 1.25  1992/12/04  13:00:35  richard
 *  Added module list parameter to make of pervasive files.
 *
 *  Revision 1.24  1992/12/03  20:31:35  daveb
 *  Changes to support the PERVASIVE_DIR Unix environment variable.
 *  Removed a sharing constraint.
 *
 *  Revision 1.23  1992/12/03  12:09:17  clive
 *  Added the delete_module function
 *
 *  Revision 1.22  1992/12/02  17:05:52  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.21  1992/12/01  16:33:52  matthew
 *  Added a comment.
 *
 *  Revision 1.20  1992/11/30  17:39:57  clive
 *  Debugger now takes a more up-to-date environment
 *
 *  Revision 1.19  1992/11/26  19:20:59  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.18  1992/11/26  17:23:16  clive
 *  Added clear_debug_info function
 *
 *  Revision 1.17  1992/11/23  09:32:52  clive
 *  Dealt with the fact that the code slot is now optional (we can throw it away
 *  after loading)
 *
 *  Revision 1.16  1992/11/20  16:22:48  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.15  1992/11/19  09:55:47  clive
 *  Changed intermake to wrap a debugger around the loading operation
 *
 *  Revision 1.14  1992/11/18  17:44:14  matthew
 *  More Error -> Info revision
 *
 *  Revision 1.13  1992/11/17  17:35:16  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.12  1992/11/11  17:52:16  daveb
 *  Added env function to extract th environment from a context.
 *
 *  Revision 1.11  1992/10/26  15:43:48  clive
 *  Got exit working, and passed through enough for debugger to bind frame arguments to it
 *  on invoking a sub-shell
 *
 *  Revision 1.10  1992/10/22  09:39:13  richard
 *  Added make options as distinct from compiler options.
 *  Dealt with a make error which might return a partially updated module table.
 *
 *  Revision 1.10  1992/10/20  14:09:15  richard
 *  Added make options as distinct from compiler options.
 *  Dealt with a make error which might return a partially updated module table.
 *
 *  Revision 1.9  1992/10/16  11:23:40  clive
 *  Changes for windowing listener
 *
 *  Revision 1.8  1992/10/14  15:10:24  richard
 *  Incorporated the make system.
 *
 *  Revision 1.7  1992/10/08  11:43:52  richard
 *  Changed add_topdec to add_source of compiler source type.
 *
 *  Revision 1.6  1992/10/08  08:54:00  richard
 *  Added return of identifiers from add_value and add_structure.
 *
 *  Revision 1.5  1992/10/07  16:17:05  richard
 *  The incremental compiler now uses the generalised Compiler structure.
 *
 *  Revision 1.4  1992/10/06  15:52:44  richard
 *  Removed inadequate add_source_file.
 *
 *  Revision 1.3  1992/10/06  10:38:37  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.2  1992/10/02  07:40:32  richard
 *  add_topdec was returning the wrong context.
 *
 *  Revision 1.1  1992/10/01  17:26:19  richard
 *  Initial revision
 *
 *)

require "^.basis.list";
require "^.basis.__text_io";

require "../utils/diagnostic";
require "../utils/crash";
require "../basics/module_id";
require "../main/project";
require "../main/proj_file";
require "../main/encapsulate";
require "../lambda/environ";
require "../typechecker/basis";
require "../typechecker/stamp";
require "../lexer/lexer";
require "../parser/parserenv";
require "../main/mlworks_io";
require "interload";
require "intermake";
require "incremental";

functor Incremental
  (structure Environ : ENVIRON
   structure InterLoad : INTERLOAD
   structure InterMake : INTERMAKE
   structure Basis : BASIS
   structure Stamp : STAMP
   structure Lexer : LEXER
   structure ParserEnv : PARSERENV
   structure List : LIST
   structure Diagnostic : DIAGNOSTIC
   structure Io : MLWORKS_IO
   structure ModuleId : MODULE_ID
   structure Project : PROJECT
   structure ProjFile : PROJ_FILE
   structure Encapsulate : ENCAPSULATE
   structure Crash : CRASH

   sharing Environ.EnvironTypes = InterMake.Inter_EnvTypes.EnvironTypes
   sharing InterLoad.Inter_EnvTypes = InterMake.Inter_EnvTypes
   sharing ParserEnv.Map = Basis.BasisTypes.Datatypes.NewMap
   sharing ParserEnv.Ident = Basis.BasisTypes.Datatypes.Ident =
	   InterMake.Compiler.Absyn.Ident =
	   Environ.EnvironTypes.LambdaTypes.Ident
   sharing Environ.EnvironTypes.NewMap = Basis.BasisTypes.Datatypes.NewMap =
	   InterMake.Compiler.NewMap
   sharing ParserEnv.Ident.Location = InterMake.Compiler.Info.Location
   sharing InterMake.Compiler.Info = Project.Info

   sharing type Project.Project = InterMake.Project
   sharing type InterMake.Compiler.Module = InterLoad.Module
   sharing type Environ.Structure = Basis.BasisTypes.Datatypes.Structure
   sharing type Environ.EnvironTypes.LambdaTypes.Type =
		Basis.BasisTypes.Datatypes.Type
   sharing type InterMake.Compiler.TypeBasis = Basis.BasisTypes.Basis
   sharing type Lexer.TokenStream = InterMake.Compiler.tokenstream
   sharing type InterMake.Compiler.ParserBasis = ParserEnv.pB
   sharing type Io.ModuleId = Project.ModuleId =
		InterMake.ModuleId = ModuleId.ModuleId
   sharing type InterMake.Compiler.DebuggerEnv =
		Environ.EnvironTypes.DebuggerEnv
   sharing type ParserEnv.Ident.Location.T = ModuleId.Location = Io.Location
   sharing type Basis.BasisTypes.Datatypes.Stamp = Stamp.Stamp
   sharing type Basis.BasisTypes.Datatypes.StampMap = Stamp.Map.T
   sharing type InterMake.Compiler.basis = Project.CompilerBasis
   sharing type InterMake.Compiler.id_cache = Project.IdCache
) : INCREMENTAL =
  struct
    structure Compiler = InterMake.Compiler
    structure PE = ParserEnv
    structure Lexer = Lexer
    structure Info = Compiler.Info
    structure EnvironTypes = Environ.EnvironTypes
    structure BasisTypes = Basis.BasisTypes
    structure Datatypes = BasisTypes.Datatypes
    structure Map = Datatypes.NewMap
    structure Diagnostic = Diagnostic
    structure Absyn = Compiler.Absyn
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure LambdaTypes = EnvironTypes.LambdaTypes
    structure Inter_EnvTypes = InterMake.Inter_EnvTypes
    structure InterMake = InterMake
    structure Options = Inter_EnvTypes.Options

    type ModuleId = ModuleId.ModuleId

    val empty_compiler_basis =
      case InterMake.Compiler.initial_basis of
        InterMake.Compiler.BASIS
          {parser_basis,
           type_basis,
           lambda_environment,
           debugger_environment,
           debug_info} =>
      InterMake.Compiler.BASIS
        {parser_basis = ParserEnv.empty_pB,
         type_basis = type_basis,
         lambda_environment = lambda_environment,
         debugger_environment = debugger_environment,
         debug_info = debug_info}

    fun diagnostic (level, output_function) =
      Diagnostic.output level
      (fn verbosity => "Incremental: " :: (output_function verbosity))

    fun diagnostic_fn (level, output_function) =
      Diagnostic.output_fn level
      (fn (verbosity, stream) => (TextIO.output (stream, "Incremental: ");
				  output_function (verbosity, stream)))

    fun fatality (location, message) =
      Info.error'
      (Info.make_default_options ())
      (Info.FATAL, location, message)

    datatype Context =
      CONTEXT of {topdec		: int,
                  compiler_basis	: Compiler.basis,
                  inter_env		: Inter_EnvTypes.inter_env,
                  signatures		: (Ident.SigId, Absyn.SigExp) Map.map}

    datatype options =
      OPTIONS of
      {options	        : Options.options,
       debugger		: (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T) ->
                          (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T)}

    val default_error_info = Info.make_default_options ()


    val cast = MLWorks.Internal.Value.cast

    (*  === THE INITIAL CONTEXT ===  *)

    (* When we apply _incremental, it sets up the builtin and pervasive
       libraries.  This involves assorted low-level hackery.  The type
       bases are obtained by compiling the files.  The actual code is
       obtained from the run-time. *)

    (* First set the relevant global values. *)

    (* The boolean parameter refers to whether the -silent option was specified, 
     * but this is not needed here. *)
    val _ = Io.set_source_path_from_env
		((Info.Location.FILE "Initial Context"), false);
    val _ = Io.set_object_path_from_env
		(Info.Location.FILE "Initial Context");

    val _ = Stamp.reset_counter Basis.pervasive_stamp_count

    type register_key = int
    val key_count = ref 0;
    val register_map = ref (Map.empty' (op< : int * int -> bool))

    fun add_update_fn f =
      (key_count := !key_count + 1;
       register_map := Map.define (!register_map, !key_count, f);
       !key_count)

    fun remove_update_fn c =
      register_map := Map.undefine (!register_map, c)


    (**********************
      This is the global project, used by the all versions and instances
      of the interpreter build system.
      All functions in this file should ensure that this is up to date,
      including cases when they raise exceptions.
     **********************)

    val inf_loc = (default_error_info, Info.Location.FILE "_incremental");

    val project =
      ref (Project.initialize inf_loc);

    fun set_project p =
      (project := p;
       Map.iterate (fn (_, f) => f()) (!register_map))

    fun get_project () = 
      if ProjFile.changed()
      then 
	let val p = Project.fromFileInfo inf_loc (!project)
         in project := p; p 
        end
      else
        !project
      
    fun delete_from_project m =
      set_project (Project.delete (!project, m, true))

    local
      val _ = diagnostic_fn (0, fn (_, stream) =>
				TextIO.output (stream, "making the builtin library\n"))

      val runtime_modules =
	map (fn (str, value, _) => (str, value))
	    (!MLWorks.Internal.Runtime.modules)

      (* Now recompile the built-in library. *)
      val (builtin_library_result, builtin_module, _) =
	InterMake.compile
	  (fn y => y)
	  (Compiler.initial_basis_for_builtin_library, Inter_EnvTypes.empty_env)
	  (default_error_info,
	   Info.Location.FILE "Making BuiltIn Library",
	   Options.default_options)
	  (SOME runtime_modules)
	  (!project, Io.builtin_library_id, 
	   Compiler.get_basis_debug_info
	     Compiler.initial_basis_for_builtin_library)

      (* Now munge the result to set the lambda environment to the built-in
	 lambda environment.  This would be simpler if SML supported
	 record updating. *)
      val debugger_environment =
        case Project.get_loaded_info
 	       (!project, Io.builtin_library_id)
	of NONE =>
	  Crash.impossible "Can't find loaded information for builtin library"
	|  SOME {file_time, load_time, basis, id_cache, module, dependencies} =>
	  let
            val Compiler.BASIS
		  {parser_basis, type_basis, debugger_environment, debug_info,
		   ...} = basis

	    val new_basis =
              Compiler.BASIS
                {parser_basis = parser_basis,
		 type_basis = type_basis,
                 debug_info = debug_info,
                 lambda_environment = Compiler.builtin_lambda_environment,
                 debugger_environment = debugger_environment}
	  in
            Project.set_loaded_info
              (!project,
               Io.builtin_library_id,
               SOME
		 {file_time = file_time,
		  load_time = load_time,
		  id_cache = id_cache,
		  basis = new_basis,
		  module = module,
		  dependencies = dependencies});
	    debugger_environment
	  end

      (* Now do the same thing for the pervasive library.  Begin by
	 getting the list of dependencies from the project. *)
      val _ =
	diagnostic_fn (0, fn (_, stream) =>
			  TextIO.output (stream, "making the pervasive library\n"))

      val out_of_date =
	Project.check_perv_loaded
	  (default_error_info,
	   Info.Location.FILE "Making Pervasive Library")
	  (!project)

      fun compile_perv (module_id, (_, _, accumulated_info)) =
	(* returns (compiler_result, module, accumulated_info') *)
	  InterMake.compile
	    (fn y => y)
	    (Compiler.initial_basis, Inter_EnvTypes.empty_env)
	    (default_error_info,
	     Info.Location.FILE "Making Pervasive Library",
	     Options.default_options)
	    (SOME runtime_modules)
	    (!project, module_id, accumulated_info)

      val (pervasive_library_result, pervasive_module, _) =
	(* The builtin_library_result and builtin_module are used here as
	   dummy values. *)
	List.foldl
	  compile_perv
	  (builtin_library_result, builtin_module,
	   Compiler.get_basis_debug_info Compiler.initial_basis)
	   out_of_date
	
      val Compiler.RESULT {basis, signatures, ...} =
        pervasive_library_result

      val Compiler.BASIS {lambda_environment, parser_basis, ...} = basis

        (* we need to propagate the parser type constructor environment
           out of the pervasive library into the main basis.  Otherwise
           we won't be able to replicated pervasive datastructures. *)

      val ParserEnv.B(_,_,ParserEnv.E(_,_,pervasive_pTE,_)) = parser_basis

      val inter_env =
        Inter_EnvTypes.augment_with_module
          (Inter_EnvTypes.empty_env, lambda_environment, pervasive_module)
        handle Inter_EnvTypes.Augment =>
          Crash.impossible "Module does not match generated environment"

      val strid = Ident.STRID(Symbol.find_symbol "FullPervasiveLibrary_")

      val inter_env = Inter_EnvTypes.remove_str(inter_env, strid)
    in
      val initial_basis =
        let
          val Compiler.BASIS{parser_basis,
                             type_basis,
                             lambda_environment,
			     debug_info,
                             ...} = Compiler.initial_basis

          val augmented_parser_basis =
               ParserEnv.augment_pB
               (ParserEnv.B(ParserEnv.empty_pF,
                            ParserEnv.empty_pG,
                            ParserEnv.E(ParserEnv.empty_pFE,
                                        ParserEnv.empty_pVE,
                                        pervasive_pTE,
                                        ParserEnv.empty_pSE)),
               parser_basis)
        in
          Compiler.BASIS{parser_basis=augmented_parser_basis,
                         type_basis=type_basis,
                         lambda_environment=lambda_environment,
                         debugger_environment=debugger_environment,
                         debug_info=debug_info}
        end

      val basis = Compiler.remove_str(basis, strid)

      val initial_compiler_basis =
        Compiler.make_external
	  (Compiler.augment (Options.default_options, initial_basis, basis))

      val initial_inter_env = inter_env

      val initial =
        CONTEXT {topdec = 0,
                 compiler_basis = initial_compiler_basis,
                 inter_env = inter_env,
                 signatures = signatures}
    end

    (* The following call removes all information about the pervasive files
       from the project, leaving only the information about the loaded
       modules.  This enables batch compilation using a different set of
       pervasives.  *)
    val _ = Project.reset_pervasives (!project)

    fun clear_debug_all_info
	  (CONTEXT {compiler_basis, topdec, inter_env, signatures}) =
      CONTEXT{topdec=topdec, 
              inter_env=inter_env,
              signatures=signatures, 
              compiler_basis = Compiler.clear_debug_all_info compiler_basis}
      
    fun clear_debug_info
	  (name,
	   CONTEXT {compiler_basis, topdec, inter_env, signatures}) =
      CONTEXT{topdec=topdec, 
              inter_env=inter_env,
              signatures=signatures, 
              compiler_basis =
		Compiler.clear_debug_info (name, compiler_basis)}

    fun add_debug_info
	  (options, debug_info,
	   CONTEXT {compiler_basis, topdec, inter_env, signatures}) =
      CONTEXT{topdec=topdec, 
              inter_env=inter_env,
              signatures=signatures, 
              compiler_basis =
              Compiler.add_debug_info
		(options, debug_info, compiler_basis)}

    fun topdec (CONTEXT record) = #topdec record
    fun compiler_basis (CONTEXT record) = #compiler_basis record
    fun parser_basis (CONTEXT {compiler_basis =
       Compiler.BASIS {parser_basis, ...}, ...}) = parser_basis
    fun type_basis (CONTEXT {compiler_basis = Compiler.BASIS {type_basis, ...}, ...}) = type_basis
    fun lambda_environment (CONTEXT {compiler_basis = Compiler.BASIS {lambda_environment, ...}, ...}) = lambda_environment
    fun debug_info (CONTEXT {compiler_basis = Compiler.BASIS {debug_info, ...}, ...}) = debug_info
    fun inter_env (CONTEXT record) = #inter_env record
    fun signatures (CONTEXT record) = #signatures record

    val empty_context =
      CONTEXT
	{topdec = 0,
	 compiler_basis = InterMake.Compiler.empty_basis,
	 inter_env = Inter_EnvTypes.empty_env,
	 signatures = Map.empty' Ident.sigid_lt}

    (* The result type for compile_source and load_mo; pass to
       add_definitions to extend a context.  delta_basis and delta_signatures
       contain the definitions from the compiled source or mo file.
       new_module is a new loaded module. *)

    datatype Result = 
      RESULT of
        {delta_basis: Compiler.basis,
         delta_signatures: (Ident.SigId,Absyn.SigExp) Map.map,
         new_module: MLWorks.Internal.Value.T}

    val empty_signatures = Map.empty' Datatypes.Ident.sigid_lt

    fun identifiers_from_result
        (RESULT {delta_basis = Compiler.BASIS {type_basis, ...}, ...}) =
      Compiler.extract_identifiers ([], type_basis)

    fun pb_from_result
	  (RESULT {delta_basis = Compiler.BASIS {parser_basis, ...}, ...}) =
      parser_basis

    (*  === COMPILE SOURCE CODE INTO A CONTEXT ===  *)

    fun compile_source
      error_info
      (inc_options as OPTIONS {options,debugger,...},
       (CONTEXT {compiler_basis, inter_env, ...}),
       source) =
      let
        val filename =
          case source of
            Compiler.TOKENSTREAM token_stream => Lexer.associated_filename token_stream
          | Compiler.TOKENSTREAM1 token_stream => Lexer.associated_filename token_stream
          | Compiler.TOPDEC (filename,_,_) => filename

        val _ = diagnostic_fn
          (2, fn (_, stream) =>
           (TextIO.output (stream, "Compiling topdec from ");
            TextIO.output (stream, filename)))

        val (_, Compiler.RESULT {basis = topdec_compiler_basis,
                                 signatures = aug_signatures,
                                 id_cache,
                                 code}) =
          Compiler.compile
          (error_info, options)
          (fn (_, _, location) =>
           Info.error'
           error_info
           (Info.FATAL, location, "require used at top level")
           (* maybe this should generate a warning, not an error *)
           )
          ((), compiler_basis, false)
          (false, source)

        (* Replace the values bound in the lambda environment with *)
        (* external references. *)

        val aug_compiler_basis = Compiler.make_external topdec_compiler_basis

        val Compiler.BASIS{debug_info,...} =
	  Compiler.augment (options, compiler_basis, topdec_compiler_basis)

        (* Create a callable function from the generated code and invoke it, *)
        (* giving an untyped module. *)
        val module =
          let
            fun module_map module_name =
	      case Project.get_loaded_info
		     (!project,
		      ModuleId.from_mo_string
		        (module_name, Info.Location.UNKNOWN))
	      of SOME {module, ...} => module
	      |  NONE =>
		Crash.impossible
		  ("can't find module " ^ module_name ^ " in project")
          in
            case code of
              NONE =>
                Info.error'
                error_info
                (Info.FAULT, Info.Location.FILE filename,
                 concat ["`", filename, "' database entry has no code recorded. "])
            | SOME code' => 
                InterMake.with_debug_information
                debug_info
                (fn () =>
                 InterLoad.load
                 debugger
                 (inter_env, module_map)
                 code')
          end
      in
        RESULT
	  {delta_basis = aug_compiler_basis,
 	   delta_signatures = aug_signatures,
	   new_module = module}
      end

    exception NotAnExpression

    fun evaluate_exp_topdec error_info (inc_options,context,topdec) =
      let
        open Absyn
        fun is_an_expression (STRDECtopdec (strdec,_)) =
          (case strdec of
             (DECstrdec (VALdec ([(pat,_,_)],[],_,_))) =>
               (case pat of
                  VALpat ((valid,_),_) =>
                    (case valid of
                       Ident.LONGVALID (Ident.NOPATH,Ident.VAR sym) =>
                         Symbol.symbol_name sym = "it"
                     | _ => false)
                | _ => false)
           | _ => false)
          | is_an_expression _ = false
      in 
        if not(is_an_expression topdec)
          then raise NotAnExpression
        else
          let
            val (RESULT {delta_basis, new_module, ...}) =
              compile_source
              error_info
              (inc_options,
               context,
               Compiler.TOPDEC("",topdec,PE.empty_pB))
            val Compiler.BASIS{type_basis,...} = delta_basis
            val ittype = #1(Basis.lookup_val (Ident.LONGVALID (Ident.NOPATH,Ident.VAR(Symbol.find_symbol"it")),
                                              Basis.basis_to_context type_basis,
                                              Info.Location.UNKNOWN,
                                              false))
            val val_list : MLWorks.Internal.Value.T list = cast new_module
          in
            case val_list of
              [itval] => (itval,ittype)
            | _ => Crash.impossible "Wrong number of bindings in evaluate_exp_topdec"
          end
      end

    fun add_definitions
	  (options,
	   CONTEXT{topdec, compiler_basis, signatures, inter_env, ...},
           RESULT
	     {delta_basis, delta_signatures, new_module, ...}) =
      let
        val new_compiler_basis =
	  Compiler.augment (options, compiler_basis, delta_basis)

        val new_signatures =
	  Map.union (signatures, delta_signatures)

        (* Incorporate the results of the loading into the interpreter *)
        (* environment to form the result context. *)
        val new_inter_env =
          let
            val Compiler.BASIS {lambda_environment, ...} = delta_basis
          in
            Inter_EnvTypes.augment_with_module
	      (inter_env, lambda_environment, new_module)
            handle Inter_EnvTypes.Augment =>
              Crash.impossible "Module does not match generated environment"
          end
      in
        CONTEXT {topdec = topdec+1,
                 compiler_basis = new_compiler_basis,
                 signatures = new_signatures,
                 inter_env = new_inter_env}
      end

   fun load_mos
         error_info
         (options, CONTEXT {compiler_basis, ...}, project,
          moduleid, mod_id_list, location) =
     (* mod_id_list is a list of modules to be loaded.
	module_id is the "top-level" one, which must be made visible.  *)
     let
       fun load_one (module_id, _) =
         SOME (InterMake.load
               options
               (project, location)
               module_id)
     in
       case List.foldl load_one NONE mod_id_list
       of SOME (compiler_result, new_module) =>
         let
           val result =
             case compiler_result
             of Compiler.RESULT
                  {basis = new_basis, signatures = new_signatures, ...} =>
               RESULT
                 {delta_basis = Compiler.make_external new_basis,
                  delta_signatures = new_signatures,
                  new_module = new_module}
         in
           Project.set_visible (project, moduleid, true);
           SOME result
         end
       |  NONE =>
         (* For this case to be reached, mod_id_list must be empty.
            We need to get the previously compiled module and basis,
            and compile the current file to get the signature
            field of the result value. *)
	 (* XXX we don't seem to compile the file after all? 
	    daveb 3/12/97 *)
         if Project.is_visible (project, moduleid) then
           NONE
         else
           case Project.get_loaded_info (project, moduleid)
           of SOME {basis, id_cache, module, ...} =>
             let
               val _ = Project.set_visible (project, moduleid, true);

               val result =
                 RESULT
                   {delta_basis = Compiler.make_external basis,
                    delta_signatures = empty_signatures,
                    new_module = module}
             in
               SOME result
             end
           |  NONE =>
             Crash.impossible "impossible NONE returned in Incremental.load.mos"
      end

    fun delete_module error_info module_id =
      Project.set_loaded_info (!project, module_id, NONE)

    fun delete_all_modules true =
      Project.clear_all_loaded_info (!project, not o ModuleId.is_pervasive)
    |   delete_all_modules false =
      Project.clear_all_loaded_info (!project, fn _ => true)

    fun remove_file_info () = Project.remove_file_info (!project)

    (* The name here should be consistent with the one used in _lambda *)
    (* Should be defined in a common module really *)
    val overload_var =
      Ident.VAR (Ident.Symbol.find_symbol "<overload function>")

    fun read_dependencies toplevel_name error_info module_id =
      project :=
        (#1 (Project.read_dependencies
               (error_info, Info.Location.FILE toplevel_name)
               (!project, module_id, Project.empty_map)))

    fun check_module error_info (module_id, toplevel_name) =
      let
	val _ =
	  diagnostic
	    (2, fn _ =>
		  ["Checking load source `", ModuleId.string module_id, "'"])

        val (new_project, _) =
	  Project.read_dependencies
	    (error_info, Info.Location.FILE toplevel_name)
	    (!project, module_id, Project.empty_map)

	val _ = set_project new_project

	val module_ids =
	  Project.check_load_source
	    (error_info, Info.Location.FILE toplevel_name)
	    (new_project, module_id)
      in
	module_ids
      end

    (* This currently isn't used -- but I want to keep it around in case
       we resurrect the preloading code.
    fun add_module'
	  preloaded
	  error_info
	  (OPTIONS {options, debugger, ...})
          (CONTEXT {compiler_basis, inter_env, ...}, moduleid, toplevel_name) =
      let
        val _ =
	  diagnostic
	    (2, fn _ =>
		  ["Adding make module `", ModuleId.string moduleid, "'"])

	val generate_moduler =
	  case options
	  of Options.OPTIONS
	       {compiler_options =
		  Options.COMPILEROPTIONS {generate_moduler, ...},
		...} => generate_moduler

        (* Here we set up overload_var for the generate_moduler case *)
        val initial_compiler_basis as Compiler.BASIS
	      {parser_basis, type_basis, lambda_environment,
	       debugger_environment, debug_info} =
	  if generate_moduler then
            let
              val Compiler.BASIS
		    {parser_basis, type_basis, lambda_environment,
                     debugger_environment, debug_info} =
		initial_compiler_basis
            in
              Compiler.BASIS
		{parser_basis=parser_basis,
                 type_basis=type_basis,
                 lambda_environment =
		   Environ.augment_top_env
		     (lambda_environment,
                      EnvironTypes.TOP_ENV
			(Environ.add_valid_env
			   (Environ.empty_env,
			    (overload_var, EnvironTypes.EXTERNAL)),
			 Environ.empty_fun_env)),
                 debugger_environment=debugger_environment,
                 debug_info=debug_info}
            end
          else
	    initial_compiler_basis 

	val initial_inter_env =
          if generate_moduler then
            Inter_EnvTypes.add_val
	      (initial_inter_env,
               (overload_var,
                Inter_EnvTypes.lookup_val (overload_var,inter_env)))
            (* Catch overload_var not being defined *)
            handle Map.Undefined =>
	      Crash.impossible "<overload function> not defined"
          else 
	    initial_inter_env
 
        val (new_project, _) =
	  Project.read_dependencies
	    (error_info, Info.Location.FILE toplevel_name)
	    (!project, moduleid, Project.empty_map)

	val _ = set_project new_project

        val out_of_date =
	  Project.check_load_source
	    (error_info, Info.Location.FILE toplevel_name)
	    (new_project, moduleid)

        fun compile_one (module_id, NONE) =
	  (* NONE => first call.  Use initial compiler_basis. *)
	  SOME (InterMake.compile
	          debugger
	            (initial_compiler_basis, initial_inter_env)
	            (error_info,
		     Info.Location.FILE toplevel_name, options)
	            preloaded
	            (new_project, module_id,
		     Compiler.get_basis_debug_info compiler_basis))
        |   compile_one (module_id, SOME (_, _, accumulated_info)) =
	  SOME (InterMake.compile
	          debugger
	            (initial_compiler_basis, initial_inter_env)
	            (error_info, 
		     Info.Location.FILE toplevel_name,
		     options)
	            preloaded
	            (new_project, module_id, accumulated_info))

        val result =
	  case List.foldl compile_one NONE out_of_date
	  of SOME 
	       (compiler_result, new_module, accumulated_info) =>
	    let
	      val result =
	        case compiler_result
	        of Compiler.RESULT
	             {basis = new_basis, signatures = new_signatures, ...} =>
	          RESULT
	            {delta_basis =
	               Compiler.make_external
		         (Compiler.adjust_compiler_basis_debug_info
		            (new_basis, accumulated_info)),
	             delta_signatures = new_signatures,
	             new_module = new_module}
	    in
	      Project.set_visible (new_project, moduleid, true);
	      SOME result
	    end
	  |  NONE =>
            (* For this case to be reached, out_of_date must be empty.
               We need to get the previously compiled module and basis,
               and compile the current file to get the signature
               field of the result value. *)
	    if Project.is_visible (new_project, moduleid) then
	      NONE
	    else
	      case Project.get_loaded_info (new_project, moduleid)
	      of SOME {basis, module, ...} =>
	        let
	          val result =
	            RESULT
	              {delta_basis = Compiler.make_external basis,
	               delta_signatures = empty_signatures,
	               new_module = module}
	        in
	          Project.set_visible (new_project, moduleid, true);
	          SOME result
	        end
	      |  NONE => 
	        Crash.impossible
		  "impossible NONE returned in Incremental.compile"
      in
	result
      end

    local
      (* This reference holds the project that the compilation manager
         uses when it resets itself. *)
      val preloaded = ref NONE
    in
      fun preload (context, mod_name) =
        let
          val runtime_modules =
            map (fn (str, value, _) => (str, value))
            (!MLWorks.Internal.Runtime.modules)
  
          val module_id =
            ModuleId.from_string (mod_name, Info.Location.FILE "_incremental")

          val _ =
            diagnostic_fn (0, fn (_, stream) =>
                            TextIO.output (stream, "making " ^ mod_name ^ "\n"))

          val options =
            OPTIONS {options = Options.default_options,
                     debugger = fn x => x}

          val result =
            add_module'
              (SOME runtime_modules)
	      default_error_info
              options
              (context, module_id, "Loading" ^ mod_name)
        in
	  Project.set_visible (!project, module_id, false);
          Project.reset_pervasives (!project);
          pervasive_project := !project;
	  preloaded := result
        end

      fun get_preload () =
	case !preloaded 
	of SOME r => r
	|  NONE => Crash.impossible "get_preloaded"
    end
    *)

   local
      val pervasive_project = !project
   in
      (* This allows the compilation manager to clear all entries. *)
      fun reset_project () = 
        (ignore(ProjFile.changed());
	 (* Sets flag to false as we are going to reread it anyway *)
         set_project (Project.fromFileInfo inf_loc (pervasive_project)))
   end


    (*  === ADD BINDINGS TO EXISTING VALUES ===  *)

    fun add_value (context, identifier, scheme, value) =
      let
        val
          CONTEXT {topdec,
                   compiler_basis =
                     Compiler.BASIS
                     {parser_basis,
                      type_basis,
                      lambda_environment = EnvironTypes.TOP_ENV (lambda_env, lambda_functor_env),
                      debugger_environment = debugger_env,
                      debug_info},
                   inter_env,
                   signatures} = context
	val ident = Ident.VAR
		      (Ident.Symbol.find_symbol identifier)
        val new_lambda_env =
	  Environ.add_valid_env (lambda_env,
				 (ident, EnvironTypes.EXTERNAL))
        val new_debugger_env =
	  Environ.add_valid_denv (debugger_env,
				 (ident, EnvironTypes.NULLEXP))
        val new_inter_env = Inter_EnvTypes.add_val (inter_env, (ident, value))
        local val PE.B(pF,pG,PE.E(pFE,pVE,pTE,pSE)) = parser_basis
        in
          (* this isn't really necessary if its only a VAR *)
          val new_parser_basis = 
            PE.B(pF,pG,PE.E(pFE,PE.addValId(fn (_,_,x) => x,ident,pVE),
                            pTE,pSE))
        end
      in
        (CONTEXT {topdec = topdec+1,
                  compiler_basis =
                    Compiler.BASIS
                    {parser_basis = new_parser_basis,
                     type_basis = Basis.add_val (type_basis,ident,scheme),
                     lambda_environment = EnvironTypes.TOP_ENV (new_lambda_env,
                                                                lambda_functor_env),
                     debugger_environment = new_debugger_env,
                     debug_info = debug_info},
                  inter_env = new_inter_env,
                  signatures = signatures},
        [Ident.VALUE ident])
      end

    fun env (CONTEXT{
	       compiler_basis =
                 Compiler.BASIS{
                   type_basis =
		     BasisTypes.BASIS(_,_, _, _, env),
                   ...
		 },
	       ...
	    }) = env

    fun extend_parser_basis (strid,str,PE.B(pF,pG,PE.E(pFE,pVE,pTE,pSE))) =
      let
        fun make_pVE valenv =
          Map.fold
          (fn (pVE,valid,_) => PE.addValId(fn (_,_,x) => x,valid,pVE))
          (PE.empty_pVE,valenv)

        fun make_str_pE(Datatypes.COPYSTR(_,str)) = make_str_pE(str)
          | make_str_pE(Datatypes.STR(_,_,env)) = make_env_pE env
        and make_env_pE (Datatypes.ENV(Datatypes.SE strenv,
                                       _,
                                       Datatypes.VE(_,valenv))) =
          PE.E(PE.empty_pFE,
               make_pVE valenv, pTE,
               PE.SE (Map.map (fn (_,str) => make_str_pE (str)) strenv))
      in
        PE.B(pF,
             pG,
             PE.E(pFE,pVE,pTE,PE.addStrId(fn (_,_,pE) => pE,
                                          strid,make_str_pE str,
                                          pSE)))
      end

    fun add_structure (context, identifier, str, value) =
      let
        val
          CONTEXT {topdec,
                   compiler_basis =
                     Compiler.BASIS
                     {parser_basis,
                      type_basis,
                      lambda_environment = EnvironTypes.TOP_ENV (lambda_env, lambda_functor_env),
                      debugger_environment = debugger_env,
                      debug_info = debug_info},
                   inter_env, signatures} = context
        val ident = Ident.STRID (Ident.Symbol.find_symbol identifier)
        val new_lambda_env = Environ.add_strid_env (lambda_env, 
                                                    (ident, 
                                                     (Environ.make_str_env (str,false), 
                                                      EnvironTypes.EXTERNAL,false)))
        val new_debugger_env = Environ.add_strid_denv (debugger_env, (ident, Environ.make_str_dexp str))
        val new_inter_env = Inter_EnvTypes.add_str (inter_env, (ident, value))
        val new_parser_basis = extend_parser_basis (ident,str,parser_basis)
      in
        (CONTEXT {topdec = topdec+1,
                  compiler_basis =
                    Compiler.BASIS
                    {parser_basis = new_parser_basis,
                     type_basis = Basis.add_str (type_basis,ident,str),
                     lambda_environment = EnvironTypes.TOP_ENV (new_lambda_env, lambda_functor_env),
                     debugger_environment = new_debugger_env,
                     debug_info = debug_info},
                  inter_env = new_inter_env,
                  signatures = signatures},
        [Ident.STRUCTURE ident])
      end

  end
