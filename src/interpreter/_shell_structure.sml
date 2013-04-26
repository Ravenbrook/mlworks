(*  Shell structure; defined in terms of compiler datatypes so that
 *  we can add it to the initial context.
 *
 *  This is a nasty piece of work. types, values, exceptions and structures
 *  are built allowing connection of user input to builtin functions. There
 *  is no available type checking to ensure that this connection is consistent.
 *  At present, there is a convention that values within structure records
 *  should be annotated with their types as a consistency check that the
 *  externally visible type and the internal type they are connected to are the
 *  same. This is only a manual check, an automatic one is not currently
 *  available. Please stick to this convention until a better way is found.
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
 *  $Log: _shell_structure.sml,v $
 *  Revision 1.219  1999/05/12 11:17:37  daveb
 *  [Bug #190554]
 *  Type of Timer.checkCPUTimer has changed.
 *
 * Revision 1.218  1999/03/18  10:20:13  mitchell
 * [Bug #190534]
 * Ensure projects created by Shell.Project have Debug and Release modes as default
 *
 * Revision 1.217  1999/02/05  14:30:09  mitchell
 * [Bug #190502]
 * Disable generation of .S files
 *
 * Revision 1.216  1999/02/03  15:58:42  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.215  1999/02/02  16:00:17  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.214  1998/12/09  13:52:44  johnh
 * [Bug #70240]
 * Remove project units for configuration files when current configuration changes.
 *
 * Revision 1.213  1998/12/08  16:41:33  johnh
 * [Bug #190494]
 * Check for duplicate module ids when adding new files and changing configurations.
 *
 * Revision 1.212  1998/11/04  16:26:45  johnh
 * reset project when opening an existing one to clear out units.
 *
 * Revision 1.211  1998/10/30  17:49:02  jont
 * [Bug #70204]
 * Do work for making exes
 *
 * Revision 1.210  1998/10/30  14:24:13  jont
 * [Bug #70204]
 * Add Shell.Project.makeDll
 *
 * Revision 1.209  1998/08/13  11:03:41  jont
 * [Bug #30468]
 * Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 * Revision 1.208  1998/08/03  12:42:53  johnh
 * [Bug #30420]
 * Don't handle Info.Stop during compilation to bring up project error.
 *
 * Revision 1.207  1998/07/30  15:53:34  johnh
 * [Bug #30420]
 * Raise error when no targets exist in project.
 *
 * Revision 1.206  1998/07/30  11:11:07  mitchell
 * [Bug #30439]
 * Don't allow the user to save a non-existent project!
 * And make sure the project window gets updated with new project name when using saveAs
 *
 * Revision 1.205  1998/07/29  09:29:17  johnh
 * [Bug #30453]
 * Check for a new target being in the list of files.
 *
 * Revision 1.204  1998/07/14  12:26:18  johnh
 * [Bug #30417]
 * Add saveProjectAs and showName => showFilename
 *
 * Revision 1.203  1998/06/22  13:36:07  mitchell
 * [Bug #30429]
 * Warn when saving sessions with debugging information enabled
 *
 * Revision 1.202  1998/06/17  16:27:07  johnh
 * [Bug #30423]
 * Add call to Incremental.reset_project for a new project.
 *
 * Revision 1.201  1998/06/16  11:34:35  mitchell
 * [Bug #30422]
 * Make newProject take a working directory argument
 *
 * Revision 1.200  1998/05/28  17:06:48  johnh
 * [Bug #30369]
 * Replace source path with a list of files.
 *
 * Revision 1.199  1998/05/19  11:48:26  mitchell
 * [Bug #50071]
 * Replace touch* functions in Shell.Project by forceCompile* and forceLoad*
 *
 * Revision 1.198  1998/05/07  09:19:45  mitchell
 * [Bug #50071]
 * Add touchAllSources to Shell.Project
 *
 * Revision 1.197  1998/05/01  16:19:32  mitchell
 * [Bug #50071]
 * Remove debug printout
 *
 * Revision 1.196  1998/05/01  14:02:45  mitchell
 * [Bug #50071]
 * Flesh out Shell.Project interface
 *
 * Revision 1.195  1998/04/24  16:34:34  johnh
 * [Bug #30229]
 * Group compiler options to allow more flexibility.
 *
 * Revision 1.194  1998/03/26  11:03:22  jont
 * [Bug #30090]
 * Remove MLWorks.IO. Change spec of Shell.Timer.printTiming
 * to use a string->unit outputter function insteadm of an outstream
 *
 * Revision 1.193  1998/03/02  15:07:22  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.192  1998/02/19  19:39:44  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.191  1998/01/29  14:52:48  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.190  1997/11/09  09:19:50  jont
 * [Bug #30089]
 * Remove use of MLWorks.Time.Elapsed in favour of basis timer
 *
 * Revision 1.189  1997/10/31  09:48:34  johnh
 * [Bug #30233]
 * Change editor interface.
 *
 * Revision 1.188  1997/10/01  16:44:02  jkbrook
 * [Bug #20088]
 * Merging from MLWorks_11:
 * SML'96 should be SML'97
 *
 * Revision 1.187.2.5  1997/12/03  16:05:10  daveb
 * [Bug #30017]
 * Rationalised Shell.Project commands:
 * ShellUtils functions now take strings instead of module_ids, and
 * explicit location values.
 * Added functions for loadAll and showLoadAll.
 * Removed TopLevel.
 *
 * Revision 1.187.2.4  1997/11/26  11:36:40  daveb
 * [Bug #30071]
 * The action queue is no more, so ShellUtils.use_{file,string} and
 * ShellUtils.read_dot_mlworks no longer take queue functions.
 *
 * Revision 1.187.2.3  1997/11/20  16:59:10  daveb
 * [Bug #30326]
 *
 * Revision 1.187.2.2  1997/11/17  16:54:37  daveb
 * [Bug #30017]
 * Added Shell.Project.
 * Removed Shell.Build and Shell.File.
 * Removed all uses of the Action Queue.
 *
 * Revision 1.187.2.1  1997/09/11  20:54:17  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.187  1997/05/27  11:12:39  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.186  1997/05/12  16:34:43  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.185  1997/04/11  12:03:57  jont
 * [Bug #2026]
 * Ensure setPervasive and setSourcePath handle OS.SysErr
 *
 * Revision 1.184  1997/03/25  11:59:27  matthew
 * Renaming R4000 option
 *
 * Revision 1.183  1997/03/21  12:04:50  johnh
 * [Bug #1965]
 * Handled Io.NotSet for getting paths.
 *
 * Revision 1.182  1997/03/19  17:03:30  matthew
 * Changing use to work properly
 *
 * Revision 1.181  1997/01/24  11:06:33  matthew
 * Adding platform dependent options
 *
 * Revision 1.180  1997/01/02  15:09:00  matthew
 * Adding local functions option
 *
 * Revision 1.179  1996/11/06  13:28:12  andreww
 * [Bug #1711]
 * adding side-effect to oldDefinition option: set equality attribute
 * on real_tyname.
 *
 * Revision 1.178  1996/11/06  11:14:15  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.177  1996/10/30  15:21:37  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.176  1996/10/10  14:36:38  andreww
 * [Bug #1654]
 * Shell.Dynamic.type -> Shell.Dynamic.type_rep
 *
 * Revision 1.175  1996/10/04  15:50:50  andreww
 * [Bug #1592]
 * threading extra level argument to make_tyname
 *
 * Revision 1.174  1996/08/20  13:49:48  daveb
 * [Bug #1480]
 * Implemented compile-and-load properly.
 *
 * Revision 1.173  1996/08/08  10:56:37  andreww
 * [Bug #714]
 * Introduce a new Debugger structure into Shell.Options that
 * interfaces the flags in debugger/__stack_frame.sml
 *
 * Revision 1.172  1996/08/07  12:39:31  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_scheme.sml and _types.sml
 *
 * Revision 1.171  1996/08/05  14:56:14  daveb
 * Removed Shell.Path.objectPath and Shell.Path.setObjectPath for the beta
 * release.
 *
 * Revision 1.170  1996/08/01  12:35:37  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.169  1996/07/19  15:00:43  jont
 * Add print_messages to Shell.Options.Compiler
 *
 * Revision 1.168  1996/06/23  17:43:56  brianm
 * Correcting bungled definition of Shell.Editor.Custom ...
 *
 * Revision 1.166  1996/05/23  12:15:30  stephenb
 * Replace OS.FileSys.realPath with OS.FileSys.fullPath since the latter
 * now does what the former used to do.
 *
 * Revision 1.165  1996/05/22  13:02:46  daveb
 * Reorganised the options menus.
 *
 * Revision 1.164  1996/05/21  16:12:41  daveb
 * Various renamings.
 *
 * Revision 1.163  1996/05/20  15:57:09  daveb
 * Commented out Shell.Module.save, as it is not implemented.
 *
 * Revision 1.162  1996/05/20  14:08:19  daveb
 * Moved the code for saving images, parsing command lines, etc. to a new file.
 *
 * Revision 1.161  1996/05/16  12:54:24  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.160  1996/05/08  13:40:26  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.159  1996/05/03  09:50:53  daveb
 * Removed the ShellUtils.Error exception.
 *
 * Revision 1.158  1996/05/01  10:25:33  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.157  1996/04/30  09:39:52  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.156  1996/04/29  12:02:56  jont
 * Changes concerning MLWorks.save
 *
 * Revision 1.155  1996/04/18  15:03:37  jont
 * initbasis moved to basis
 *
 * Revision 1.154  1996/04/18  12:44:45  matthew
 * ** No reason given. **
 *
 * Revision 1.153  1996/04/17  14:09:41  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.152  1996/04/02  11:48:34  daveb
 * Changing loadDependencies to readDependencies.
 *
 * Revision 1.151  1996/03/27  11:25:00  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.150  1996/03/26  12:15:30  daveb
 * I forgot to add the type for Shell.Module.delete.
 *
 * Revision 1.149  1996/03/25  10:59:01  daveb
 * Added Shell.Module.delete.
 *
 * Revision 1.148  1996/03/19  17:10:02  matthew
 * Removing some options
 *  .
 *
 * Removing some options
 *
 * Revision 1.147  1996/03/19  15:55:26  daveb
 * Added Shell.{File,Module}.queryLoadObject
 *
 * Revision 1.146  1996/03/18  13:03:27  nickb
 * Fix deliverFn to use the standard streams.
 *
 * Revision 1.145  1996/03/15  15:52:54  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.144  1996/03/15  12:11:04  matthew
 * Changing argument separato to hyphen from underscore
 *
 * Revision 1.143  1996/03/14  14:42:47  matthew
 * Adding compileAndLoad functionality
 *
 * Revision 1.142  1996/03/08  15:02:53  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.141  1996/03/05  15:11:22  matthew
 * Fixing problem with .mlworks_preferences and command line arguments\
 *
 * Revision 1.140  1996/02/29  14:20:17  matthew
 * Adding reading preferences file
 *
 * Revision 1.139  1996/02/23  16:02:54  daveb
 * Converted to new capitalisation scheme (sigh).
 *
 * Revision 1.138  1996/02/23  14:52:28  daveb
 * Moved Shell.Inspector.inspect to Shell.Dynamic.inspect.
 *
 * Revision 1.137  1996/02/22  13:09:21  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.136  1996/02/16  15:00:49  nickb
 * Export becomes Deliver.
 *
 *  Revision 1.135  1996/02/08  11:17:41  daveb
 *  Removed the Shell.TopEnv structure.
 *
 *  Revision 1.134  1996/02/06  17:15:43  jont
 *  Ensure exportFn restores break_hook and generalises_ref
 *  even when it succeeds
 *
 *  Revision 1.133  1996/01/25  14:58:22  jont
 *  Fix breakpoint setting to use the correct types
 *  Added type constraints to all values in structure records
 *  for some consistency checking
 *
 *  Revision 1.132  1996/01/23  10:31:15  daveb
 *  Revised names of compilation functions.
 *
 *  Revision 1.131  1995/12/27  13:39:20  jont
 *  Removing Option in favour of MLWorks.Option
 *
 *  Revision 1.130  1995/12/11  17:21:13  daveb
 *  Revised previous log message.
 *
 *  Revision 1.129  1995/12/11  16:31:08  daveb
 *  Changed name of Debug.status_all to Debug.info_all
 *
 *  Revision 1.128  1995/12/11  15:17:23  daveb
 *  Reversing previous change.
 *
 *  Revision 1.127  1995/12/11  10:40:25  daveb
 *  Changed the arguments of add_debug_info to use Incremental.debugging_options.
 *
 *  Revision 1.126  1995/12/05  10:18:43  daveb
 *  Corrected previous log message.
 *
 *  Revision 1.125  1995/12/04  16:49:12  daveb
 *  The Shell.Compile structure has changed to match the new Compilation
 *  Manager.  The type of the ShellUtils.Error exception has changed.
 *
 *  Revision 1.124  1995/11/29  16:59:29  jont
 *  Ensure saved images don't believe the X interface is already running
 *  Modify the already running message not to refer to X
 *
 *  Revision 1.123  1995/11/29  10:40:47  matthew
 *  Adding switch for value polymorphism.
 *
 *  Revision 1.122  1995/11/22  17:12:43  jont
 *  Allow source_path and pervasive_dir as arguments to incremental systems
 *  Also add object_path for completeness
 *
 *  Revision 1.121  1995/10/26  11:28:45  jont
 *  Adding opt_handlers compiler option
 *
 *  Revision 1.120  1995/10/26  10:31:02  matthew
 *  Changing untrace_all function
 *
 *  Revision 1.119  1995/10/24  16:38:24  nickb
 *  Add Shell.Profile.profile_tool.
 *
 *  Revision 1.118  1995/10/24  15:25:20  nickb
 *  Add profiling functions.
 *
 *  Revision 1.117  1995/10/18  14:55:48  nickb
 *  Add Shell.Profile.
 *
 *  Revision 1.116  1995/10/18  11:37:39  jont
 *  Add exec_save to shell structure for saving executables
 *
 *  Revision 1.115  1995/10/17  13:57:37  matthew
 *  Simplifying trace interface
 *
 *  Revision 1.114  1995/10/06  11:09:43  daveb
 *  Changed -motif to -gui in usage message, and added -{debug,optimize}_mode.
 *  Also removed -full_menus and -short_menus from the user messages (the
 *  arguments still work, but we don't advertise them).
 *
 *  Revision 1.113  1995/10/04  10:06:09  daveb
 *  Changed -motif command line argument to -gui.
 *
 *  Revision 1.112  1995/10/04  09:56:28  daveb
 *  Added -debug_mode and -optimize_mode command line arguments.
 *
 *  Revision 1.111  1995/09/13  13:48:36  jont
 *  Add exportFn to shell structure
 *
 *  Revision 1.110  1995/09/12  16:08:42  matthew
 *  Adding Interrupt handler around start_x_interface
 *
 *  Revision 1.109  1995/08/10  14:55:49  daveb
 *  Replaced redundant construction of built-in types.
 *
 *  Revision 1.108  1995/07/12  13:24:19  jont
 *  Add parameter to make_shell_structure to indicate image type (ie tty or motif)
 *
 *  Revision 1.107  1995/06/30  16:18:41  daveb
 *  Added float_precision option to ValuePrinter options.
 *
 *  Revision 1.106  1995/06/20  12:59:37  daveb
 *  Context options were calling the wrong update functions.
 *
 *  Revision 1.105  1995/06/20  12:36:55  daveb
 *  Added variable info mode.
 *
 *  Revision 1.104  1995/06/14  14:11:18  daveb
 *  ShellUtils.edit_* functions no longer require a context argument.
 *  Added new preferences to the Shell.Preferences structure.
 *
 *  Revision 1.103  1995/06/13  14:30:57  daveb
 *  Removed show_id_class and show_eq_info value printer options from interface.
 *
 *  Revision 1.102  1995/06/01  15:53:27  matthew
 *  Adding Shell.Make.touch_all
 *
 *  Revision 1.101  1995/05/31  10:06:40  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.100  1995/05/15  15:08:41  matthew
 *  Renaming nj_semicolons
 *
 *  Revision 1.99  1995/05/10  11:05:16  matthew
 *  Removed debug_polyvariables and step options
 *
 *  Revision 1.98  1995/05/04  16:59:25  jont
 *  add capability to set object_path
 *
 *  Revision 1.97  1995/04/28  12:21:28  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.96  1995/04/24  15:58:36  daveb
 *  Removed stepper option, commented out poly_variable and moduler options.
 *  Also commented out default_overloads option.
 *
 *  Revision 1.95  1995/04/21  14:23:07  daveb
 *  Expansion of home dirs moved from FileSys to Getenv.
 *  Better error handling.
 *  filesys moved from utils to initbasis.
 *
 *  Revision 1.94  1995/04/20  12:18:54  matthew
 *  Changed most of the functions with dynamic arguments to look up type
 *  information in the debug information
 *  First version of new step and breakpoint stuff
 *
 *  Revision 1.93  1995/04/12  13:27:41  jont
 *  Change FILESYS to FILE_SYS
 *
 *  Revision 1.92  1995/03/24  15:24:28  matthew
 *  Replacing Tyfun_id etc. with Stamp
 *
 *  Revision 1.91  1995/03/02  12:16:32  matthew
 *  Added simple trace functions
 *
 *  Revision 1.90  1995/03/02  10:52:33  daveb
 *  Removed InterPrint, Crash and TopLevel parameters.
 *
 *  Revision 1.89  1995/01/30  11:29:00  matthew
 *  Added function for printing debug annotations
 *  This is for internal use only really.
 *
 *  Revision 1.88  1995/01/24  17:44:20  daveb
 *  Replaced FileName parameter with FileSys and Path.
 *
 *  Revision 1.87  1994/12/07  11:33:59  matthew
 *  Changing uses of cast
 *
 *  Revision 1.86  1994/09/22  15:58:58  matthew
 *  Changes to tycon lookup
 *
 *  Revision 1.85  1994/08/10  14:38:15  daveb
 *  Moved call to read_dot_mlworks here from _tty_listener.
 *
 *  Revision 1.84  1994/08/09  17:56:35  daveb
 *  Revised help message for startup.
 *
 *  Revision 1.83  1994/08/02  14:01:54  daveb
 *  Added new editor options.
 *
 *  Revision 1.82  1994/08/01  09:47:01  daveb
 *  Changes to editor selection.
 *
 *  Revision 1.81  1994/07/27  12:44:08  daveb
 *  Added -full_menus and -short_menus options.
 *
 *  Revision 1.80  1994/07/14  16:16:16  daveb
 *  Saved images now take arguments to select tty or motif mode.
 *  x_interface_fn takes a boolean that indicates whether it is called
 *  from the TTY interface or whether MLWorks invoked it on start-up.
 *
 *  Revision 1.79  1994/06/23  11:38:02  jont
 *  Update debugger information production
 *
 *  Revision 1.78  1994/06/22  16:32:26  nickh
 *  Add Shell.Trace.untrace_all.
 *
 *  Revision 1.77  1994/06/21  16:03:18  nickh
 *  Remove garbage collection performed before image save.
 *  (this is now done automatically in the runtime).
 *
 *  Revision 1.76  1994/05/05  17:16:30  daveb
 *  Added default_overloads option.
 *
 *  Revision 1.75  1994/04/07  13:59:49  daveb
 *  Made Shell.Options.Mode.{debugging,optimising} bool options.
 *
 *  Revision 1.74  1994/03/30  18:35:52  daveb
 *  Implemented touch_compile_{module,file}.
 *
 *  Revision 1.73  1994/03/30  11:38:12  daveb
 *  Revised Shell.Options.Compatibility
 *
 *  Revision 1.72  1994/03/28  14:00:52  daveb
 *  Moved some functions from Shell.Make into the new structures Shell.Path
 *  and Shell.Compile.  Added _module versions of make & compile functions.
 *
 *  Revision 1.71  1994/03/21  10:23:21  matthew
 *  Added ability to define exceptions.
 *  Used this to improve errors from eval, edit etc.
 *
 *  Revision 1.70  1994/03/16  11:26:54  matthew
 *  Added edit_function function to Shell.Editor
 *
 *  Revision 1.69  1994/03/15  12:23:44  matthew
 *  Tidying up - removing replace and gc functions
 *
 *  Revision 1.67  1994/02/28  08:47:13  nosa
 *  Deleted compiler option debug_polyvariables in Debugger_Types.INFO;
 *  Boolean indicator for Monomorphic debugger decapsulation;\ncompilation options for Step and Modules Debuggers.
 *
 *  Revision 1.66  1994/02/25  17:00:20  daveb
 *  Changing Shell.Debug structure.
 *
 *  Revision 1.64  1994/02/24  16:14:17  nickh
 *  Change to storage manager interface.
 *
 *  Revision 1.63  1994/02/24  11:00:56  daveb
 *  Fixed types of functions to set and get pervasive directory and source
 *  path, ensuring that all necessary expansion is done.
 *
 *  Revision 1.62  1994/02/23  17:39:08  matthew
 *  Changing inspector interface
 *
 *  Revision 1.61  1994/02/02  11:04:34  daveb
 *  ActionQueue no longer has Incremental as a substructure.  And the
 *  functionality of trans_home_name has been hidden.
 *
 *  Revision 1.60  1994/01/28  16:22:57  matthew
 *  Better locations in error messages
 *
 *  Revision 1.59  1994/01/26  17:04:40  matthew
 *  Added handler to reset no_execute
 *
 *  Revision 1.58  1993/12/21  14:41:29  matthew
 *  Added load function to Make structure
 *
 *  Revision 1.57  1993/12/17  16:29:28  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.56  1993/12/15  15:23:10  matthew
 *  Added level field to Basis.
 *
 *  Revision 1.55  1993/12/09  18:35:14  matthew
 *  Added Shell.Dynamic.replace
 *
 *  Revision 1.54  1993/12/06  17:45:10  daveb
 *  Added Shell.Options.Preferences.
 *
 *  Revision 1.53  1993/12/06  16:13:36  daveb
 *  Changed Shell.Make.remake_file to Shell.Make.force_make, and
 *  Shell.Make.recompile to Shell.Make.compile (hiding old Shell.Make.compile).
 *
 *  Revision 1.52  1993/11/30  13:59:34  matthew
 *  Added is_abs field to TYNAME and METATYNAME
 *  Further work may be needed here.
 *
 *  Revision 1.51  1993/11/23  15:40:31  nickh
 *  Added Shell.Timer structure.
 *
 *  Revision 1.50  1993/11/05  16:55:54  jont
 *  Added shell structure support for requesting interruptable tight loops
 *
 *  Revision 1.49  1993/10/13  12:20:39  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.48  1993/10/05  10:22:15  jont
 *  Added Shell.Make.save function

 *  Revision 1.46.1.2  1993/10/12  14:34:39  daveb
 *  Changed print options.
 *
 *  Revision 1.47  1993/09/16  15:59:38  nosa
 *  Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.
 *
 *  Revision 1.46.1.1  1993/08/28  17:00:38  jont
 *  Fork for bug fixing
 *
 *  Revision 1.46  1993/08/28  17:00:38  daveb
 *   Added source_path, set_pervasive, pervasive to Shell.Make.
 *
 *  Revision 1.45  1993/08/25  14:32:35  matthew
 *  Return quit function from ShellUtils.edit_string
 *
 *  Revision 1.44  1993/08/24  15:24:46  matthew
 *  Tidied up mode functions
 *
 *  Revision 1.43  1993/08/19  17:45:30  daveb
 *  Removed core-only and functional options, since they didn't do anything.
 *  Added Make.check_dependecies.
 *
 *  Revision 1.42  1993/08/12  16:01:39  daveb
 *  Changes to reflect changes in Io structure.
 *
 *  Revision 1.41  1993/08/10  16:26:01  matthew
 *  Changes to user_options to store update functions
 *
 *  Revision 1.40  1993/08/10  15:36:41  matthew
 *  Rationalization.  Added Trace, Dynamic and Inspector substructures.
 *
 *  Revision 1.39  1993/08/04  09:10:30  matthew
 *  Renamed strict option to standard.
 *
 *  Revision 1.38  1993/07/30  13:52:43  nosa
 *  new compiler option debug_variables for local and closure variable
 *  inspection in the debugger;
 *  structure Option.
 *
 *  Revision 1.37  1993/07/29  16:48:20  matthew
 *  Added call to trans_home_name for recompile and compile
 *
 *  Revision 1.36  1993/06/30  16:42:35  daveb
 *  Removed exception environments.
 *
 *  Revision 1.35  1993/06/04  14:55:34  daveb
 *  edit functions now return a single string in the errorneous case.
 *
 *  Revision 1.34  1993/06/02  14:04:07  matthew
 *  Added untrace function
 *
 *  Revision 1.33  1993/05/26  16:11:40  matthew
 *  Removed Parser added ShellUtils structure
 *  Uses ShellUtils.eval function
 *
 *  Revision 1.32  1993/05/19  16:21:18  daveb
 *  Changed type of Shell.Options.*.* to 'a Shell.Options.Option,
 *  and added Shell.Options.{set, get}
 *
 *  Revision 1.31  1993/05/19  10:06:55  daveb
 *  Rearranged some of the options.
 *
 *  Revision 1.30  1993/05/14  16:46:04  jont
 *  Added New Jersey interpretation of weak type variables under option control
 *
 *  Revision 1.29  1993/05/13  16:14:35  jont
 *  Added wide ranging option control for NJ flavour, Harlequin flavour,
 *  Strict flavour. These are in Shell.Options.flavour, I need a better name
 *
 *  Revision 1.28  1993/05/11  18:15:50  jont
 *  Added make -n control to shell.Options.Compiler
 *
 *  Revision 1.27  1993/05/11  16:15:54  matthew
 *  Changed eval_string function
 *  Changes to use
 *
 *  Revision 1.26  1993/05/10  14:14:40  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.25  1993/05/07  10:47:05  matthew
 *  Added Tracing
 *
 *  Revision 1.24  1993/05/06  13:23:55  matthew
 *  InterPrint signature changes
 *
 *  Revision 1.23  1993/04/28  10:26:57  richard
 *  Unified profiling and tracing options into `intercept'.
 *  Removed poly_makestring option.
 *
 *  Revision 1.22  1993/04/22  11:45:29  richard
 *  Removed pervasive editor.  Changed editor selection type to string.
 *
 *  Revision 1.21  1993/04/21  16:33:12  matthew
 *  Changed interface to tty inspector
 *
 *  Revision 1.20  1993/04/21  13:45:47  richard
 *  Removed old tracing stuff.
 *
 *  Revision 1.19  1993/04/20  15:48:25  matthew
 *  Removed trace functions
 *  Added add_inspect_method function
 *
 *  Revision 1.18  1993/04/15  09:29:02  jont
 *  Added editor options and editor to shell structure
 *
 *  Revision 1.17  1993/04/13  15:39:31  matthew
 *  Added Shell.lambda_switches for control of lambda optimisations
 *  This is probably not a permanent feature.
 *
 *  Revision 1.16  1993/04/13  09:52:30  matthew
 *  Added dynamic value and type printing functions
 *
 *  Revision 1.15  1993/04/08  15:18:07  jont
 *  Minor change to interface to editor
 *
 *  Revision 1.14  1993/04/06  16:33:46  jont
 *  Moved user_options and version from interpreter to main
 *
 *  Revision 1.13  1993/04/02  15:48:28  matthew
 *  Added Shell.eval and Shell.print functions
 *  Signature changes
 *
 *  Revision 1.12  1993/03/30  10:36:39  matthew
 *  Removed read_dot_mlworks
 *  Changed to use a shell_data ref so a shell structure is made only once and
 *  is shared between all shells
 *  Removed a lot on unnecessary casts and added some type constraints
 *
 *  Revision 1.11  1993/03/29  16:16:24  jont
 *  Removed get_pervasive_dir, using one in io instead
 *
 *  Revision 1.10  1993/03/26  17:02:31  matthew
 *  Removed debugger structure.  Break function comes from shell_data
 *
 *  Revision 1.9  1993/03/25  10:15:52  daveb
 *  Added Options.Extension.
 *  ActionQueue.do_actions now takes a single ShellData argument.
 *
 *  Revision 1.8  1993/03/19  19:36:35  matthew
 *  Pass context_ref to ActionQueue.do_actions
 *
 *  Revision 1.7  1993/03/18  18:05:30  matthew
 *   Added .mlworks facility
 *
 *  Revision 1.6  1993/03/15  17:56:57  matthew
 *  Simplified ShellType types
 *
 *  Revision 1.5  1993/03/12  12:09:36  matthew
 *  Added break and inspector functions
 *  Changed to use ShellData type
 *
 *  Revision 1.4  1993/03/10  18:08:57  jont
 *  Added Editor substructure to the shell
 *
 *  Revision 1.3  1993/03/09  15:48:32  matthew
 *  Options & Info changes
 *  Changes for ShellTypes.ShellData type
 *
 *  Revision 1.2  1993/03/04  10:25:30  daveb
 *  Types.empty_rec_type is now called Types._empty_rectype.
 *
 *  Revision 1.1  1993/03/02  19:21:07  daveb
 *  Initial revision
 *)

require "../basis/__int";
require "../basis/__list";
require "../basis/__timer";
require "../system/__time";

require "../utils/lists";
require "../basis/os";
require "../utils/getenv";
require "../basics/module_id";
require "../typechecker/types";
require "../typechecker/strenv";
require "../typechecker/tyenv";
require "../typechecker/environment";
require "../typechecker/valenv";
require "../typechecker/scheme";
require "../typechecker/basistypes";
require "../main/mlworks_io";
require "../debugger/debugger_utilities";
require "../debugger/value_printer";
require "../debugger/newtrace";
require "../debugger/stack_frame";
require "inspector";
require "inspector_values";
require "incremental";
require "shell_types";
require "user_context";
require "../main/user_options";
require "../main/preferences";
require "../main/proj_file";
require "../main/project";
require "../editor/custom";

require "shell_utils";
require "save_image";
require "shell_structure";

functor ShellStructure (
  structure Lists : LISTS
  structure OS : OS
  structure Getenv : GETENV
  structure ModuleId : MODULE_ID
  structure Types : TYPES
  structure Strenv : STRENV
  structure Tyenv : TYENV
  structure Valenv : VALENV
  structure Scheme : SCHEME
  structure BasisTypes : BASISTYPES
  structure Env : ENVIRONMENT
  structure DebuggerUtilities : DEBUGGER_UTILITIES
  structure ValuePrinter : VALUE_PRINTER
  structure Trace : TRACE
  structure Io : MLWORKS_IO
  structure ProjFile : PROJ_FILE
  structure Project : PROJECT
  structure UserOptions : USER_OPTIONS
  structure Preferences : PREFERENCES
  structure ShellTypes: SHELL_TYPES
  structure UserContext: USER_CONTEXT
  structure Inspector : INSPECTOR
  structure InspectorValues : INSPECTOR_VALUES
  structure Incremental: INCREMENTAL
  structure ShellUtils : SHELL_UTILS
  structure SaveImage : SAVE_IMAGE
  structure CustomEditor : CUSTOM_EDITOR
  structure StackFrame : STACK_FRAME

  sharing Types.Datatypes = Strenv.Datatypes = Tyenv.Datatypes =
          Valenv.Datatypes = Scheme.Datatypes = BasisTypes.Datatypes =
          Incremental.Datatypes = Env.Datatypes
  sharing Incremental.InterMake.Compiler.Info =
          ShellUtils.Info
  sharing UserOptions.Options =
          ValuePrinter.Options =
          ShellTypes.Options =
    	  Incremental.InterMake.Compiler.Options =
          Types.Options =
          ShellUtils.Options =
          DebuggerUtilities.Debugger_Types.Options
  sharing Types.Datatypes.Ident =
	  Incremental.InterMake.Compiler.Absyn.Ident
  sharing Types.Datatypes.NewMap =
	  Incremental.InterMake.Compiler.NewMap

  sharing type ModuleId.ModuleId = Incremental.ModuleId = Project.ModuleId
  sharing type DebuggerUtilities.Debugger_Types.information =
	       ValuePrinter.DebugInformation =
    	       Incremental.InterMake.Compiler.DebugInformation
  sharing type BasisTypes.Datatypes.Type = ValuePrinter.Type =
               InspectorValues.Type = Trace.Type = ShellUtils.Type =
               DebuggerUtilities.Debugger_Types.Type = Inspector.Type
  sharing type Incremental.InterMake.Compiler.TypeBasis =
    	       ValuePrinter.TypeBasis =
	       BasisTypes.Basis
  sharing type UserOptions.user_tool_options =
	       ShellTypes.user_options = Trace.UserOptions =
               ShellUtils.UserOptions
  sharing type ShellTypes.Context = Trace.Context =
	       Incremental.Context = ShellUtils.Context
  sharing type ShellTypes.ShellData = Inspector.ShellData =
               SaveImage.ShellData = ShellUtils.ShellData
  sharing type ShellUtils.preferences = ShellTypes.preferences = 
               Preferences.preferences
  sharing type ShellUtils.user_context =
	       ShellTypes.user_context = UserContext.user_context 
  sharing type UserOptions.user_context_options =
	       UserContext.user_context_options
  sharing type Preferences.user_preferences = ShellTypes.user_preferences
  sharing type Io.Location = Incremental.InterMake.Compiler.Info.Location.T =
	       ModuleId.Location = ProjFile.location
  sharing type ShellUtils.Info.options = ProjFile.error_info
  sharing type Project.Project = Incremental.InterMake.Project
): SHELL_STRUCTURE =
  struct
    structure InterMake = Incremental.InterMake
    structure Compiler = InterMake.Compiler
    structure Debugger_Types = DebuggerUtilities.Debugger_Types
    structure BasisTypes = BasisTypes
    structure Datatypes = Types.Datatypes
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure Info = Compiler.Info
    structure Options = UserOptions.Options
    structure NewMap = Datatypes.NewMap
    structure Profile = MLWorks.Profile

    type ShellData = ShellTypes.ShellData
    type Context = Incremental.Context
    type IncrementalOptions = Incremental.options

    (* Utility functions *)
    (* Maybe these should be in a library somewhere *)

    val find_symbol = Symbol.find_symbol

    val cast = MLWorks.Internal.Value.cast

    (* Debugger stuff *)

    (* Take a function object, find its type from the debug information, and make *)
    (* a dynamic object *)

    exception MakeDynamic of string
    fun make_dynamic (f : 'a -> 'b) =
      let
        val debug_info = InterMake.current_debug_information ()
        val string = Trace.get_function_string f
        val t = (cast f) : MLWorks.Internal.Value.T
      in
        case Debugger_Types.lookup_debug_info (debug_info,string) of
          SOME (Debugger_Types.FUNINFO {ty,...}) =>
            (t,DebuggerUtilities.close_type ty)
        | _ => (print(string ^ "\n");
                raise MakeDynamic string)
      end


    (* This is a bit of a hack really. *)
    fun do_trace_error s = raise MLWorks.Internal.Trace.Trace s

    fun trace_full_dynamic (shell_data,(name,f2,f3)) =
      let
        val valtys = (name,make_dynamic f2,
                      make_dynamic f3)
      in
        Trace.trace_full valtys
      end
      handle MakeDynamic s => do_trace_error ("No debug information for " ^ s)

    fun print_dynamic (shell_data,dyn : MLWorks.Internal.Dynamic.dynamic) =
      let
        val print_options = ShellTypes.get_current_print_options shell_data
        val context = ShellTypes.get_current_context shell_data
        val debug_info = Incremental.debug_info context
        val (value,ty) = cast dyn
      in
        ValuePrinter.stringify_value false (print_options,
                                            value,
                                            ty,
                                            debug_info)
      end

    fun print_type (shell_data, tyrep : MLWorks.Internal.Dynamic.type_rep) =
      let
        val ty : Datatypes.Type = cast tyrep
        val options = ShellTypes.get_current_options shell_data
      in
        Types.print_type options ty
      end

    (* Here I try to make an exception constructor *)

    fun make_exn_tag s = s ^ "[<Shell>]"

    fun environment_error_exn label =
      (ref (),make_exn_tag label)

    fun make_environment_error_exn (exn : unit ref * string, s) : exn =
      cast (exn, s)

    fun env_error (exn, s) =
      raise (make_environment_error_exn (exn,s))

    (* Make the visible structures of the shell. This is called once to make
       a single shell_structure.  The data for each shell is obtained from a
       global reference.  This means that the shell_data_ref object should not
       be dereferences outside the shell functions. *)

    fun make_shell_structure is_a_tty_image (shell_data_ref, initial_context) =
      let
	val error_info = Info.make_default_options ()

        (* probably all access functions should be like this *)
        fun get_context () = ShellTypes.get_current_context (!shell_data_ref)

        fun shell_exit_fn n =
          let val (ShellTypes.SHELL_DATA{exit_fn,...}) = (!shell_data_ref)
          in
            exit_fn n
          end

        open Datatypes

        (* utilities for making the structures visible in shell *)

        (* make the types *)

        (* This won't quite work with abstypes, maybe *)

	fun get_runtime_type(longtycon as Ident.LONGTYCON(_, Ident.TYCON sy)) =
	  let
	    val Incremental.CONTEXT
	      {compiler_basis=Compiler.BASIS
	       {type_basis=BasisTypes.BASIS{5=env, ...}, ...}, ...} = initial_context
	    val TYSTR(tyfun, valenv) = Env.lookup_longtycon (longtycon,env)
	  in
	    CONSTYPE([], METATYNAME(ref tyfun, Symbol.symbol_name sy, 0,
				    ref(Types.equalityp tyfun), ref valenv, ref false))
	  end

        fun schemify ty = UNBOUND_SCHEME (ty,NONE)

	fun make_tyvar name = TYVAR (ref (0,NULLTYPE,NO_INSTANCE),
				     Ident.TYVAR (find_symbol name,
						  false,
						  false))

	fun mk_longtycon (p,s) =
	    let
	      val sym = find_symbol s
	      val symlist = map find_symbol p
	    in
	      Ident.LONGTYCON (Ident.mkPath symlist,
			       Ident.TYCON sym)
	    end


	fun mk_record l =
	  let
	    fun mk_record' (n,[],acc) = acc
	      | mk_record' (n,(lab,ty)::ls,acc) =
		let
		  val newacc =
		    Types.add_to_rectype (Ident.LAB (find_symbol lab),
					  ty,
					  acc)
		in
		  mk_record' (n+1, ls, newacc)
		end
	  in
	    mk_record' (1,l,Types.empty_rectype)
	  end

	fun make_tuple tylist =
	  let
	    val lab = ref 0
	  in
	    mk_record
	    (map
	     (fn x => (lab := (!lab +1);
		       (Int.toString (!lab),x)))
	      tylist)
	  end
			
        fun make_pair (a,b) =
	  make_tuple [a,b]

        fun make_triple (a,b,c) =
	  make_tuple [a,b,c]

        val string_pair =
          make_pair(Types.string_type,Types.string_type)

        val dynamic2 =
	  make_tuple [Types.dynamic_type,
		      Types.dynamic_type]

        val dynamic2_to_unit =
          FUNTYPE (dynamic2,Types.empty_rectype)

	val option_tyname =
	  Types.make_tyname (1, true, "option", NONE, 0)
                    (* top-level, so tyname gets level 0 *)

	val target_type_tyname =
	  Types.make_tyname (0, true, "targetType", NONE, 0)
                    (* top-level, so tyname gets level 0 *)


        val target_type = schemify(CONSTYPE([], target_type_tyname))


        fun build_record_type list =
          List.foldl
            (fn ((label, typ), rectype) =>
              Types.add_to_rectype(
                Types.Datatypes.Ident.LAB(
                  Types.Datatypes.Ident.Symbol.find_symbol label), 
                typ,
                rectype)) Types.empty_rectype
            list;

        val mode_details_type =
            build_record_type
            [("location", Types.string_type),
             ("generate_interruptable_code", Types.bool_type),
             ("generate_interceptable_code", Types.bool_type),
             ("generate_debug_info", Types.bool_type),
             ("generate_variable_debug_info", Types.bool_type),
             ("optimize_leaf_fns", Types.bool_type),
             ("optimize_tail_calls", Types.bool_type),
             ("optimize_self_tail_calls", Types.bool_type),
             ("mips_r4000", Types.bool_type),
             ("sparc_v7", Types.bool_type)];


        val configuration_details_type =
            build_record_type
            [("files", CONSTYPE([Types.string_type], Types.list_tyname)),
             ("library", CONSTYPE([Types.string_type], Types.list_tyname))];

        val location_details_type =
            build_record_type
            [("libraryPath", CONSTYPE([Types.string_type], Types.list_tyname)),
             ("objectsLoc", Types.string_type),
             ("binariesLoc", Types.string_type)];

        val about_details_type =
            build_record_type
            [("description", Types.string_type),
             ("version", Types.string_type)];

        val consumer_type =
          schemify (FUNTYPE(make_pair(Types.string_type,
                                      FUNTYPE(Types.string_type, Types.empty_rectype)),
                            Types.string_type))

        val show_type =
          schemify (FUNTYPE (Types.empty_rectype,CONSTYPE([Types.string_type], Types.list_tyname)))

        val string_to_dynamic =
          schemify (FUNTYPE (Types.string_type, Types.dynamic_type))

        val dynamic_to_string =
          schemify (FUNTYPE (Types.dynamic_type, Types.string_type))

        val dynamic_to_type =
          schemify (FUNTYPE (Types.dynamic_type, Types.typerep_type))

        val dynamic_to_unit =
          schemify (FUNTYPE (Types.dynamic_type, Types.empty_rectype))

        val type_to_string =
          schemify (FUNTYPE (Types.typerep_type, Types.string_type))

        val unit_to_unit =
          schemify (FUNTYPE (Types.empty_rectype, Types.empty_rectype))

        val int_to_unit =
          schemify (FUNTYPE (Types.int_type, Types.empty_rectype))

        val bool_to_unit =
          schemify (FUNTYPE (Types.bool_type, Types.empty_rectype))

        val string_to_unit =
          schemify (FUNTYPE (Types.string_type, Types.empty_rectype))

        val unit_to_string =
          schemify (FUNTYPE (Types.empty_rectype, Types.string_type))

	val string_cross_string_to_unit =
	  schemify(FUNTYPE (make_pair(Types.string_type, Types.string_type),
			     Types.empty_rectype))

	val string_cross_bool_to_unit =
	  schemify(FUNTYPE (make_pair(Types.string_type, Types.bool_type),
			     Types.empty_rectype))

        val string_to_exn_type =
	  FUNTYPE (Types.string_type, Types.exn_type)
        val string_to_exn = schemify string_to_exn_type

        val type_pair_to_exn_type =
	  FUNTYPE
	    (make_pair (Types.typerep_type, Types.typerep_type), Types.exn_type)
        val type_pair_to_exn = schemify type_pair_to_exn_type

	val string_cross_string_list_to_unit =
	  schemify(FUNTYPE(make_pair(Types.string_type, CONSTYPE([Types.string_type], Types.list_tyname)),
			   Types.empty_rectype))

	local
	  val alpha = make_tyvar "'a"
	  val beta  = make_tyvar "'b"
          fun make_alpha_beta_to_type ty =
	    let
	      val type_instance =
	        FUNTYPE (FUNTYPE (alpha,beta), ty)
	    in
	      Scheme.make_scheme([alpha,beta], (type_instance, NONE))
	    end

	in
	  val fun_to_bool = make_alpha_beta_to_type Types.bool_type
	  val fun_to_string = make_alpha_beta_to_type Types.string_type
	  val fun_to_unit = make_alpha_beta_to_type Types.empty_rectype
          val fun_to_fun =
            let
              val alpha = make_tyvar "'a"
              val beta  = make_tyvar "'b"
            in
              Scheme.make_scheme ([alpha,beta], (FUNTYPE (FUNTYPE (alpha,beta),FUNTYPE (alpha,beta)),NONE))
            end
          val trace_full_type =
            let
              val c = make_tyvar "'c"
              val d = make_tyvar "'d"
              val e = make_tyvar "'e"
              val f = make_tyvar "'f"
            in
              Scheme.make_scheme
              ([c,d,e,f],
               (FUNTYPE (make_tuple [Types.string_type,
                                     FUNTYPE (c,d),
                                     FUNTYPE (e,f)],
                         Types.empty_rectype),
                NONE))
            end
	end

        val string_list_to_unit =
          schemify (FUNTYPE (CONSTYPE([Types.string_type], Types.list_tyname),
                             Types.empty_rectype))

	val string_to_string_cross_string_list =
	  schemify (FUNTYPE (Types.string_type,
			make_pair (Types.string_type,
				   CONSTYPE([Types.string_type], Types.list_tyname))))

        val string_list_cross_string_list =
            make_pair(CONSTYPE([Types.string_type], Types.list_tyname),
                      CONSTYPE([Types.string_type], Types.list_tyname))

        val string_cross_string_cross_string_list =
            make_triple(Types.string_type,
                        Types.string_type,
                        CONSTYPE([Types.string_type], Types.list_tyname)
                       )

        val string_cross_target_type_to_unit =
          schemify (FUNTYPE (make_pair(Types.string_type,
                                       CONSTYPE([], target_type_tyname)),
                             Types.empty_rectype))

        val string_to_target_type =
          schemify (FUNTYPE (Types.string_type,
                             CONSTYPE([], target_type_tyname)))

        val string_to_mode_details =
          schemify (FUNTYPE (Types.string_type,
                             mode_details_type))

        val string_to_configuration_details =
          schemify (FUNTYPE (Types.string_type,
                             configuration_details_type))

        val string_cross_mode_details_to_unit =
          schemify (FUNTYPE (make_pair(Types.string_type,
                                       mode_details_type),
                             Types.empty_rectype))

        val string_cross_configuration_details_to_unit =
          schemify (FUNTYPE (make_pair(Types.string_type,
                                       configuration_details_type),
                             Types.empty_rectype))

        val unit_to_location_details =
          schemify (FUNTYPE (Types.empty_rectype, location_details_type))

        val location_details_to_unit =
          schemify (FUNTYPE (location_details_type, Types.empty_rectype))

        val unit_to_about_details =
          schemify (FUNTYPE (Types.empty_rectype, about_details_type))

        val about_details_to_unit =
          schemify (FUNTYPE (about_details_type, Types.empty_rectype))

        val string_cross_string_cross_string_list_to_unit =
          schemify (FUNTYPE (string_cross_string_cross_string_list,
                             Types.empty_rectype))

	val string_to_string =
	  schemify (FUNTYPE (Types.string_type, Types.string_type))

        val string_to_string_cross_string_cross_string_list =
          schemify (FUNTYPE (Types.string_type,
                             string_cross_string_cross_string_list))

        val unit_to_string_list =
          schemify (FUNTYPE (Types.empty_rectype,
                             CONSTYPE([Types.string_type], Types.list_tyname)))

        val unit_to_string_list_cross_string_list =
          schemify (FUNTYPE (Types.empty_rectype,
                             string_list_cross_string_list))

        val opt_switches_type =
          CONSTYPE([make_pair(Types.string_type,
                              CONSTYPE([Types.bool_type],Types.ref_tyname))],
                   Types.list_tyname)

	fun mk_valenv (vals,exns) =
          let val valvalenv =
            Lists.reducel
            (fn (ve, (name,scheme)) =>
             Valenv.add_to_ve
             (Ident.VAR(find_symbol name),scheme,ve))
            (empty_valenv, vals)
          in
            Lists.reducel
            (fn (ve, (name, scheme)) =>
             Valenv.add_to_ve
             (Ident.EXCON(find_symbol name),scheme,ve))
            (valvalenv, exns)
          end


	fun mk_tyenv l =
	  Lists.reducel
	  (fn (te, (name, tystr)) =>
	   Tyenv.add_to_te
	   (te,
	    Ident.TYCON(find_symbol name),
	    tystr))
	  (Tyenv.empty_tyenv, l)

	fun mk_strenv l =
	  Lists.reducel
	  (fn (se, (name, str)) =>
	   Strenv.add_to_se(
			    Ident.STRID(find_symbol name),
			    str,
			    se
			    )
	   )
	  (Strenv.empty_strenv, l)

	fun mk_mixed_structure(strs, tys, vals,exns) =
          STR
	    (STRNAME (Types.make_stamp ()),
	     ref NONE,
	     ENV(mk_strenv strs,
                 mk_tyenv tys,
	         mk_valenv (vals,exns)))

	fun mk_structure vals = mk_mixed_structure([], [], vals, [])
	fun mk_exn_structure (vals,exns) = mk_mixed_structure([], [], vals, exns)
	fun mk_option t = schemify (CONSTYPE([t], option_tyname))

	(* To make an exception that the user can handle, define the label
	   and exception value here, trap any internal exception and raise
	   the new one, and put the new one in the user-visible space. *)

        val edit_exn_label = "EditError"
        val eval_exn_label = "EvalError"
	val path_exn_label = "PathError"
        val inspect_exn_label = "InspectError"
        val project_exn_label = "ProjectError"

        val edit_exn = environment_error_exn edit_exn_label
        val eval_exn = environment_error_exn eval_exn_label
        val path_exn = environment_error_exn path_exn_label
        val inspect_exn = environment_error_exn inspect_exn_label
        val project_exn = environment_error_exn project_exn_label

        fun do_inspect_error s = env_error (inspect_exn,s)

        fun eval_string (shell_data,string) =
          let
            val context = ShellTypes.get_current_context shell_data
            val options = ShellTypes.get_current_options shell_data
            val error_info = Info.make_default_options ()
            val result =
              Info.with_report_fun
              error_info
              (fn _ => ())
              ShellUtils.eval
              (string,options,context)
          in
            (cast result) : MLWorks.Internal.Dynamic.dynamic
          end
        handle Info.Stop (e, _) =>
	  env_error (eval_exn, Info.string_error e)

        fun shell_eval_fn s =
          eval_string (!shell_data_ref,s)

        fun use_fun s =
          let
            val ShellTypes.SHELL_DATA {get_user_context,
                                       user_options,
                                       user_preferences,
                                       debugger,
                                       ...} = !shell_data_ref
            fun output_fn s = print s
            val error_info = Info.make_default_options ()
          in
            ShellUtils.use_file (!shell_data_ref, print, s)
          end

        fun use_string_fun s =
          let
            val ShellTypes.SHELL_DATA {get_user_context,
                                       user_options,
                                       user_preferences,
                                       debugger,
                                       ...} = !shell_data_ref
            fun output_fn s = print s
            val error_info = Info.make_default_options ()
          in
            ShellUtils.use_string (!shell_data_ref, print, s)
          end

        fun shell_dyn_trace_full d = trace_full_dynamic (!shell_data_ref,d)
        fun shell_dyn_print_val d = print_dynamic (!shell_data_ref,d)
        fun shell_dyn_print_type t = print_type (!shell_data_ref,t)

        fun add_inspect_method (f : 'a -> 'b) =
          InspectorValues.add_inspect_method (make_dynamic f)
          handle MakeDynamic s => do_inspect_error ("No debug information for " ^ s)

        fun delete_inspect_method (f : 'a -> 'b) =
          InspectorValues.delete_inspect_method (make_dynamic f)
          handle MakeDynamic s => do_inspect_error ("No debug information for " ^ s)

        fun delete_all_inspect_methods () =
          InspectorValues.delete_all_inspect_methods ()

        val inspect_it_fn  : unit -> unit =
          (fn () => Inspector.inspect_it (!shell_data_ref))

        val inspect_dyn_fn =
          (fn (d: MLWorks.Internal.Dynamic.dynamic) =>
	     Inspector.inspect_value (cast d,!shell_data_ref))

        val value_printer_structure = mk_structure
          [("showFnDetails",  mk_option Types.bool_type),
           ("showExnDetails",  mk_option Types.bool_type),
           ("floatPrecision",  mk_option Types.int_type),
           ("maximumSeqSize",  mk_option Types.int_type),
           ("maximumStringSize",  mk_option Types.int_type),
           ("maximumRefDepth",  mk_option Types.int_type),
           ("maximumStrDepth",  mk_option Types.int_type),
           ("maximumSigDepth",  mk_option Types.int_type),
           ("maximumDepth",  mk_option Types.int_type)
           ]

	type internal_exn_rep = unit ref * string

	type 'a option_rep = (unit -> 'a) * ('a -> unit)

        (* Make up the type 'a Option * 'a -> unit *)
        val set_option_type =
          let
            val aty = make_tyvar "'a"
	    val aty_option = CONSTYPE([aty], option_tyname)
          in
            Scheme.make_scheme ([aty],
                                (FUNTYPE(make_pair (aty_option, aty),
                                        Types.empty_rectype),NONE))
          end

	fun set_option ((_, setter), v) = setter v;

        (* Make up the type 'a Option -> 'a *)
        val get_option_type =
          let
            val aty = make_tyvar "'a"
	    val aty_option = CONSTYPE([aty], option_tyname)
          in
            Scheme.make_scheme ([aty], (FUNTYPE(aty_option, aty),NONE))
          end

	fun get_option (getter, _) = getter ();

        fun get_tool_option_fun f () =
	  let val UserOptions.USER_TOOL_OPTIONS (user_options,_) =
		ShellTypes.get_user_options (!shell_data_ref)
	  in !(f user_options)
	  end
	
	fun set_tool_option_fun f v =
	  let val UserOptions.USER_TOOL_OPTIONS (user_options,ref update_fns) =
		ShellTypes.get_user_options (!shell_data_ref)
	  in
            (f user_options) := v;
            app (fn f => f ()) update_fns
	  end

	fun make_tool_option_rep f =
	  (get_tool_option_fun f, set_tool_option_fun f)
	
        fun get_context_option_fun f () =
	  let val UserOptions.USER_CONTEXT_OPTIONS (user_options, _) =
		UserContext.get_user_options
		  (ShellTypes.get_user_context (!shell_data_ref))
	  in !(f user_options)
	  end
	
	fun set_context_option_fun f v =
	  let
	    val UserOptions.USER_CONTEXT_OPTIONS
		  (user_options, ref update_fns) =
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
	  in
            (f user_options) := v;
            app (fn f => f ()) update_fns
	  end

	fun make_context_option_rep f =
	  (get_context_option_fun f, set_context_option_fun f)

        (* changing oldDefinition option in Shell.Options.Language *)
        (* ought to affect the equality attribute on Types.real_tyname *)

	fun make_oldDefinition_option_rep f =
	  (get_context_option_fun f,
           (fn f => fn v => (Types.real_tyname_equality_attribute := v;
                             set_context_option_fun f v)) f)

	
        fun update_user_options () =
          let
            val user_context_options =
	      UserContext.get_user_options
                (ShellTypes.get_user_context (!shell_data_ref))
          in
            UserOptions.update_user_context_options user_context_options
          end

        fun get_preference_fun f () =
	  let val Preferences.USER_PREFERENCES (user_preferences, _) =
		ShellTypes.get_user_preferences (!shell_data_ref)
	  in !(f user_preferences)
	  end
	
	fun set_preference_fun f v =
	  let
	    val Preferences.USER_PREFERENCES
		  (user_preferences, ref update_fns) =
		ShellTypes.get_user_preferences (!shell_data_ref)
	  in
            (f user_preferences) := v;
            app (fn f => f ()) update_fns
	  end

	fun make_preference_rep f =
	  (get_preference_fun f, set_preference_fun f)
	
	val value_printer_record =
          cast
          {maximumDepth =
	     (make_tool_option_rep #maximum_depth) : int option_rep,
           maximumRefDepth =
	     (make_tool_option_rep #maximum_ref_depth) : int option_rep,
           maximumStrDepth =
	     (make_tool_option_rep #maximum_str_depth) : int option_rep,
           maximumSigDepth =
	     (make_tool_option_rep #maximum_sig_depth) : int option_rep,
           maximumSeqSize =
	     (make_tool_option_rep #maximum_seq_size) : int option_rep,
           maximumStringSize =
	     (make_tool_option_rep #maximum_string_size) : int option_rep,
           floatPrecision =
	     (make_tool_option_rep #float_precision) : int option_rep,
           showFnDetails =
	     (make_tool_option_rep #show_fn_details) : bool option_rep,
           showExnDetails =
	     (make_tool_option_rep #show_exn_details) : bool option_rep
           }

	val internals_structure = mk_structure
	  [("showAbsyn", mk_option Types.bool_type),
	   ("showLambda", mk_option Types.bool_type),
	   ("showOptLambda", mk_option Types.bool_type),
	   ("showEnviron", mk_option Types.bool_type),
	   ("showMir", mk_option Types.bool_type),
	   ("showOptMir", mk_option Types.bool_type),
	   ("showMach", mk_option Types.bool_type)]

	val internals_record =
          cast
	  {showAbsyn = (make_tool_option_rep #show_absyn) : bool option_rep,
	   showLambda = (make_tool_option_rep #show_lambda) : bool option_rep,
	   showOptLambda =
	     (make_tool_option_rep #show_opt_lambda) : bool option_rep,
	   showEnviron =
	     (make_tool_option_rep #show_environ) : bool option_rep,
	   showMir = (make_tool_option_rep #show_mir) : bool option_rep,
	   showOptMir =
	     (make_tool_option_rep #show_opt_mir) : bool option_rep,
	   showMach = (make_tool_option_rep #show_mach) : bool option_rep
	   }

	val preferences_structure = mk_structure
	  [
	   ("oneWayEditorName", mk_option Types.string_type),
	   ("twoWayEditorName", mk_option Types.string_type),
	   ("editor", mk_option Types.string_type),
	   ("externalEditorCommand", mk_option Types.string_type),
	   ("maximumHistorySize", mk_option Types.int_type),
	   ("maximumErrors", mk_option Types.int_type),
	   ("useCompletionMenu", mk_option Types.bool_type),
	   ("useDebugger",  mk_option Types.bool_type),
	   ("useErrorBrowser",  mk_option Types.bool_type),
	   ("useRelativePathname",  mk_option Types.bool_type),
	   ("useWindowDebugger",  mk_option Types.bool_type)]

	val preferences_record =
          cast
          {editor = (make_preference_rep #editor) : string option_rep,
           externalEditorCommand =
	     (make_preference_rep #externalEditorCommand) : string option_rep,
           oneWayEditorName =
	     (make_preference_rep #oneWayEditorName) : string option_rep,
           twoWayEditorName =
	     (make_preference_rep #twoWayEditorName) : string option_rep,
           maximumHistorySize =
             (make_preference_rep #history_length) : int option_rep,
           maximumErrors =
             (make_preference_rep #max_num_errors) : int option_rep,
           useCompletionMenu =
             (make_preference_rep #completion_menu) : bool option_rep,
           useDebugger =
	     (make_preference_rep #use_debugger) : bool option_rep,
           useErrorBrowser =
	     (make_preference_rep #use_error_browser) : bool option_rep,
           useRelativePathname =
	     (make_preference_rep #use_relative_pathname) : bool option_rep,
           useWindowDebugger =
	     (make_preference_rep #window_debugger) : bool option_rep
           }

	val compiler_structure = mk_structure
          [("generateTraceProfileCode", mk_option Types.bool_type),
	   ("generateDebugInfo", mk_option Types.bool_type),
	   ("generateLocalFunctions", mk_option Types.bool_type),
	   ("generateVariableDebugInfo", mk_option Types.bool_type),
	   (*
           ("generate_moduler", mk_option Types.bool_type),
	   *)
	   ("interruptTightLoops", mk_option Types.bool_type),
	   ("mipsR4000andLater", mk_option Types.bool_type),
	   ("optimizeHandlers", mk_option Types.bool_type),
	   ("optimizeLeafFns", mk_option Types.bool_type),
	   ("optimizeTailCalls", mk_option Types.bool_type),
	   ("optimizeSelfTailCalls", mk_option Types.bool_type),
	   ("printCompilerMessages", mk_option Types.bool_type),
	   ("sparcV7", mk_option Types.bool_type)
           ]

	val compiler_record =
          cast
          {generateTraceProfileCode =
             (make_context_option_rep #generate_interceptable_code) :
	       bool option_rep,
           generateDebugInfo =
             (make_context_option_rep #generate_debug_info) : bool option_rep,
           generateLocalFunctions =
             (make_context_option_rep #local_functions) : bool option_rep,
           generateVariableDebugInfo =
             (make_context_option_rep #generate_variable_debug_info) :
	       bool option_rep,
	   (*
           generate_moduler =
           (make_context_option_rep #generate_moduler) : bool option_rep,
	   *)
	   interruptTightLoops =
	   (make_context_option_rep #generate_interruptable_code) :
	   bool option_rep,
           mipsR4000andLater =
             (make_context_option_rep #mips_r4000) :
	       bool option_rep,
           optimizeHandlers = (make_context_option_rep #optimize_handlers) :
	   bool option_rep,
           optimizeLeafFns = (make_context_option_rep #optimize_leaf_fns) :
	   bool option_rep,
           optimizeTailCalls = (make_context_option_rep #optimize_tail_calls):
	   bool option_rep,
           optimizeSelfTailCalls = (make_context_option_rep #optimize_self_tail_calls):
	   bool option_rep,
	   printCompilerMessages = (make_context_option_rep #print_messages):
	   bool option_rep,
           sparcV7 = (make_context_option_rep #sparc_v7) : bool option_rep
           }

        val debugger_structure = mk_structure
          [("hideCFrames", mk_option Types.bool_type),
           ("hideSetupFrames", mk_option Types.bool_type),
           ("hideAnonymousFrames", mk_option Types.bool_type),
           ("hideHandlerFrames", mk_option Types.bool_type),
           ("hideDeliveredFrames", mk_option Types.bool_type),
           ("hideDuplicateFrames", mk_option Types.bool_type)]

	val debugger_record =
          let
            fun mkDebuggerOption flag =
              (fn ()=> !flag, fn v => (flag:=v))
          in
            cast
            {hideCFrames =
             (mkDebuggerOption StackFrame.hide_c_frames)
                                                   : bool option_rep,
	     hideSetupFrames =
             (mkDebuggerOption StackFrame.hide_setup_frames)
                                                    : bool option_rep,
             hideAnonymousFrames =
	     (mkDebuggerOption StackFrame.hide_anonymous_frames)
                                                    : bool option_rep,
             hideHandlerFrames =
	     (mkDebuggerOption StackFrame.hide_handler_frames)
                                                    : bool option_rep,
             hideDeliveredFrames =
	     (mkDebuggerOption StackFrame.hide_delivered_frames)
                                                    : bool option_rep,
             hideDuplicateFrames =
	     (mkDebuggerOption StackFrame.hide_duplicate_frames)
                                                    : bool option_rep}
          end


	val language_structure = mk_structure
	  [("oldDefinition", mk_option Types.bool_type),
	   ("opOptional", mk_option Types.bool_type),
	   ("limitedOpen", mk_option Types.bool_type),
	   ("weakTyvars", mk_option Types.bool_type),
	   ("fixityInSignatures", mk_option Types.bool_type),
	   ("fixityInOpen", mk_option Types.bool_type),
	   ("abstractions", mk_option Types.bool_type),
           ("requireReservedWord", mk_option Types.bool_type),
           ("typeDynamic", mk_option Types.bool_type)
	   (*
	   ("default_overloads", mk_option Types.bool_type),
	   *)
	   ]

	val language_record =
	  cast
	  {oldDefinition =
	     (make_oldDefinition_option_rep #old_definition) : bool option_rep,
	   opOptional =
	     (make_context_option_rep #nj_op_in_datatype) : bool option_rep,
	   limitedOpen =
	     (make_context_option_rep #nj_signatures) : bool option_rep,
	   weakTyvars =
	     (make_context_option_rep #weak_type_vars) : bool option_rep,
	   fixityInSignatures =
	     (make_context_option_rep #fixity_specs) : bool option_rep,
	   fixityInOpen =
	     (make_context_option_rep #open_fixity) : bool option_rep,
           abstractions =
	     (make_context_option_rep #abstractions) : bool option_rep,
           requireReservedWord =
	     (make_context_option_rep #require_keyword) : bool option_rep,
           typeDynamic =
	     (make_context_option_rep #type_dynamic) : bool option_rep
	   (*
	   default_overloads =
	     (make_context_option_rep #default_overloads) : bool option_rep,
	   *)}

	val mode_option_structure = mk_structure
	  [("compatibility", unit_to_unit),
	   ("sml'97", unit_to_unit),
	   ("sml'90", unit_to_unit),
	   ("optimizing", unit_to_unit),
	   ("quick_compile", unit_to_unit),
	   ("debugging", unit_to_unit)]

	fun select_compatibility () =
	  let
	    val user_context_options =
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
	  in
	    UserOptions.select_compatibility user_context_options;
	    UserOptions.update_user_context_options user_context_options
	  end
	
	fun select_sml'97 () =
	  let
	    val user_context_options =
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
            val _ = MLWorks.Internal.Dynamic.generalises_ref:=
              Scheme.SML96_dynamic_generalises
            val _ = Types.real_tyname_equality_attribute := false
	  in
	    UserOptions.select_sml'97 user_context_options;
	    UserOptions.update_user_context_options user_context_options
	  end

	fun select_sml'90 () =
	  let
	    val user_context_options =
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
            val _ = MLWorks.Internal.Dynamic.generalises_ref:=
              Scheme.SML90_dynamic_generalises
            val _ = Types.real_tyname_equality_attribute := true
    	  in
	    UserOptions.select_sml'90 user_context_options;
	    UserOptions.update_user_context_options user_context_options
	  end

	fun select_optimizing () =
	  let
	    val user_context_options =
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
	  in
	    UserOptions.select_optimizing user_context_options;
	    UserOptions.update_user_context_options user_context_options
	  end

	fun select_debugging () =
	  let
	    val user_context_options =
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
	  in
	    UserOptions.select_debugging user_context_options;
	    UserOptions.update_user_context_options user_context_options
	  end

	fun select_quick_compile () =
	  let
	    val user_context_options = 
	      UserContext.get_user_options
	        (ShellTypes.get_user_context (!shell_data_ref))
	  in
	    UserOptions.select_quick_compile user_context_options;
	    UserOptions.update_user_context_options user_context_options
	  end

	val mode_option_record =
	  cast
	  {compatibility = select_compatibility : unit -> unit,
	   sml'97 = select_sml'97 : unit -> unit,
	   sml'90 = select_sml'90 : unit -> unit,
	   quick_compile = select_quick_compile : unit -> unit,
	   optimizing = select_optimizing : unit -> unit,
	   debugging = select_debugging : unit -> unit}

        val inspector_structure =
          mk_exn_structure
          ([("addInspectMethod",fun_to_unit),
            ("deleteInspectMethod",fun_to_unit),
            ("deleteAllInspectMethods",unit_to_unit),
            ("inspectIt",unit_to_unit)],
           [(inspect_exn_label,string_to_exn)])

        val inspector_record =
          cast
          {a_InspectError = inspect_exn : internal_exn_rep,
           a_inspectIt = inspect_it_fn : unit -> unit,
           a_addInspectMethod = add_inspect_method : ('a -> 'b) -> unit,
           a_deleteInspectMethod = delete_inspect_method : ('a -> 'b) -> unit,
           a_deleteAllInspectMethods =
	     delete_all_inspect_methods : unit -> unit}

        val dynamic_structure = mk_mixed_structure
          ([],
	   [("dynamic",
	     TYSTR (ETA_TYFUN Types.dynamic_tyname, empty_valenv)),
	    ("type_rep",
	     TYSTR (ETA_TYFUN Types.typerep_tyname, empty_valenv))],
	   [("eval", string_to_dynamic),
	    ("getType", dynamic_to_type),
            ("inspect",dynamic_to_unit),
            ("printValue",dynamic_to_string),
            ("printType",type_to_string)],
           [(eval_exn_label, string_to_exn),
	    ("Coerce", type_pair_to_exn)])

	val coerce_exn =
	  (* This gets the value of the Coerce exception *)
	  let
	    (* First we apply the function that constructs the exception
	       to some dummy arguments *)
	    val the_exn = MLWorks.Internal.Dynamic.Coerce (cast (0, 0))
	  in
	    (* Now we strip off the argument from the constructed exception *)
	    case cast the_exn
	    of (internal_rep, _) => internal_rep: internal_exn_rep
	  end

        val dynamic_record =
          cast
          {a_eval = shell_eval_fn : string -> MLWorks.Internal.Dynamic.dynamic,
           a_EvalError = eval_exn : internal_exn_rep,
	   a_Coerce = coerce_exn: internal_exn_rep,
	   a_getType = MLWorks.Internal.Value.cast (fn (a,b) => b),
           a_inspect =
	     inspect_dyn_fn : MLWorks.Internal.Dynamic.dynamic -> unit,
           a_printValue =
	     shell_dyn_print_val : MLWorks.Internal.Dynamic.dynamic -> string,
           a_printType =
	     shell_dyn_print_type : MLWorks.Internal.Dynamic.type_rep -> string}

        val trace_structure = mk_structure
          [("breakpoint",string_to_unit),
           ("trace",string_to_unit),
           ("unbreakpoint",string_to_unit),
           ("untrace",string_to_unit),
           ("traceFull",trace_full_type),
	   ("untraceAll",unit_to_unit),
	   ("unbreakAll",unit_to_unit)]

	fun break name = Trace.break{name=name, hits=0, max=1}

        val trace_record =
          cast
          {a_breakpoint = break : string-> unit,
           a_trace = Trace.trace : string-> unit,
           a_unbreakpoint = Trace.unbreak : string-> unit,
           a_untrace = Trace.untrace : string-> unit,
           a_traceFull =
	     shell_dyn_trace_full : (string * ('c -> 'd) * ('e -> 'f) -> unit),
           a_untraceAll = Trace.untrace_all : unit -> unit,
           a_unbreakAll = Trace.unbreak_all : unit -> unit}
           
        type mode_details =
          {location:				      string,
           generate_interruptable_code:               bool,
           generate_interceptable_code:               bool,
           generate_debug_info:                       bool,
           generate_variable_debug_info:              bool,
           optimize_leaf_fns:                         bool,
           optimize_tail_calls:                       bool,
           optimize_self_tail_calls:                  bool,
           mips_r4000:                                bool,
           sparc_v7:                                  bool}

        type configuration_details =
          {files:				      string list,
           library:                                   string list}


        type location_details =
           {libraryPath:	string list,
            objectsLoc:	        string,
            binariesLoc:	string}

        type about_details = 
           {description:	string,
            version:		string}

        val project_structure = mk_mixed_structure 
          ([],
           [(*("targetType",
               TYSTR (ETA_TYFUN target_type_tyname, empty_valenv)), *)
            ("mode_details", 
               TYSTR (TYFUN(mode_details_type,0), empty_valenv)),
            ("configuration_details", 
               TYSTR (TYFUN(configuration_details_type,0), empty_valenv)),
            ("location_details", 
               TYSTR (TYFUN(location_details_type,0), empty_valenv)),
            ("about_details", 
               TYSTR (TYFUN(about_details_type,0), empty_valenv))],
           [
           (*
           ("IMAGE", target_type),
           ("OBJECT_FILE", target_type),
           ("EXECUTABLE", target_type),
           ("LIBRARY", target_type),
           *)
           ("newProject", string_to_unit),
           ("openProject", string_to_unit),
           ("saveProject", unit_to_unit),
           ("saveProjectAs", string_to_unit),
           ("closeProject", unit_to_unit),
           ("setFiles", string_list_to_unit),
           ("showFiles", unit_to_string_list),
           
           ("setSubprojects", string_list_to_unit),
           ("showSubprojects", unit_to_string_list),
           ("setLocations", location_details_to_unit),
           ("showLocations", unit_to_location_details),
           ("setAboutInfo", about_details_to_unit),
           ("showAboutInfo", unit_to_about_details),
           ("showFilename", unit_to_string),
           
	   ("setConfiguration", string_to_unit),
	   ("removeConfiguration", string_to_unit),
	   ("setConfigurationDetails", string_cross_configuration_details_to_unit),
	   ("showAllConfigurations", unit_to_string_list),
	   ("showCurrentConfiguration", unit_to_string),
	   ("showConfigurationDetails", string_to_configuration_details),

	   ("setMode", string_to_unit),
	   ("removeMode", string_to_unit),
	   ("setModeDetails", string_cross_mode_details_to_unit),
	   ("showAllModes", unit_to_string_list),
	   ("showCurrentMode", unit_to_string),
	   ("showModeDetails", string_to_mode_details),

	   ("setTargets", string_list_to_unit),
           ("setTargetDetails", string_to_unit),
           ("removeTarget", string_to_unit),
           ("showAllTargets", unit_to_string_list),
           ("showCurrentTargets", unit_to_string_list),
           (* ("showTargetDetails", string_to_target_type), *)

	   ("compile", string_to_unit),
           ("showCompile", string_to_unit),
           ("forceCompile", string_to_unit),

           ("compileAll", unit_to_unit),
           ("showCompileAll", unit_to_unit),
	   ("forceCompileAll", unit_to_unit),

           ("load", string_to_unit),
           ("showLoad", string_to_unit),
           ("forceLoad", string_to_unit),

           ("loadAll", unit_to_unit),
           ("showLoadAll", unit_to_unit),
           ("forceLoadAll", unit_to_unit),

	   (* ("makeDll", string_cross_string_list_to_unit), *)
	   ("makeExe", string_cross_string_list_to_unit),
	   (*
           ("listObjects", unit_to_unit),
	   *)
           ("delete", string_to_unit),
           ("readDependencies", string_to_unit)],
           [(project_exn_label,string_to_exn)])

        fun refresh_project () =
          Incremental.set_project(Incremental.get_project())

	fun get_location () =
	  Info.Location.FILE (ShellTypes.get_current_toplevel_name ())


(* handling Info.Stop here to raise the ProjectError exception is not 
 * what we want because it then also catches compiler errors and reports
 * them as project errors.  Quick fix is needed for release but this 
 * still needs attention so that the case where no targets are selected
 * is reported by an exception being raised so that users of Shell.Project
 * can catch it in their programs.
 *)
	fun compile_all () =
	  (ShellUtils.compile_targets
	    (get_location (),
	     ShellTypes.get_current_options (!shell_data_ref))
	    error_info)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)
	fun show_compile_all () =
	  (ShellUtils.show_compile_targets
	    (get_location (), print)
	    error_info)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun compile filename =
          (ShellUtils.compile_file
            (get_location (),
	     ShellTypes.get_current_options (!shell_data_ref))
            error_info
            filename)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun show_compile filename =
          (ShellUtils.show_compile_file
            (get_location (), print)
            error_info
            filename)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun force_compile filename = 
          (ShellUtils.force_compile 
            (get_location (),
	     ShellTypes.get_current_options (!shell_data_ref))
            error_info
            filename)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun force_compile_all () = 
          (ShellUtils.force_compile_all
            (get_location (),
	     ShellTypes.get_current_options (!shell_data_ref))
            error_info)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun delete_from_project s =
	  ShellUtils.delete_from_project (s, get_location ())

	fun load filename =
          (ShellUtils.load_file
            (ShellTypes.get_user_context (!shell_data_ref),
	     get_location (),
	     ShellTypes.get_current_options (!shell_data_ref),
             ShellTypes.get_current_preferences (!shell_data_ref),
	     print)
            error_info
            filename)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun show_load filename =
          (ShellUtils.show_load_file
            (get_location (), print)
            error_info
            filename)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun load_targets () =
	  (ShellUtils.load_targets
	    (ShellTypes.get_user_context (!shell_data_ref),
	     get_location (),
	     ShellTypes.get_current_options (!shell_data_ref),
             ShellTypes.get_current_preferences (!shell_data_ref),
	     print)
            error_info)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun show_load_targets () =
          (ShellUtils.show_load_targets
            (get_location (), print)
            error_info)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun force_load filename =
          (let
            val module_id = ModuleId.from_string (filename, get_location ())
          in
	    Incremental.delete_module error_info module_id;
            load filename
          end)
(*
          handle Info.Stop (e, _) =>
	    env_error (project_exn, Info.string_error e)
*)

	fun read_dependencies filename =
          let
	    val toplevel_name = ShellTypes.get_current_toplevel_name ()

            val module_id =
                  ModuleId.from_string
                    (filename, Info.Location.FILE toplevel_name)
          in
	    Incremental.read_dependencies
	      toplevel_name
              error_info
              module_id
          end

        fun show_mode_details mode =
          let val (modes, details, _) = ProjFile.getModes()
           in if List.exists(fn m => m = mode) modes
              then let val {name, location, generate_interruptable_code,
                            generate_interceptable_code, generate_debug_info,
                            generate_variable_debug_info, optimize_leaf_fns,
                            optimize_tail_calls, optimize_self_tail_calls,
                            mips_r4000, sparc_v7} = ProjFile.getModeDetails(mode, details)
                    in {location = !location,
                        generate_interruptable_code = !generate_interruptable_code,
                        generate_interceptable_code = !generate_interceptable_code, 
                        generate_debug_info = !generate_debug_info,
                        generate_variable_debug_info = !generate_variable_debug_info,
                        optimize_leaf_fns = !optimize_leaf_fns,
                        optimize_tail_calls = !optimize_tail_calls, 
                        optimize_self_tail_calls = !optimize_self_tail_calls,
                        mips_r4000 = !mips_r4000, 
                        sparc_v7 = !sparc_v7}
                   end
                 else env_error (project_exn, "There is no mode called " ^ mode)
          end

        fun set_mode_details (mode, 
                              {location, generate_interruptable_code,
                               generate_interceptable_code, generate_debug_info,
                               generate_variable_debug_info, optimize_leaf_fns,
                               optimize_tail_calls, optimize_self_tail_calls,
                               mips_r4000, sparc_v7}) =
          let val (modes, details, _) = ProjFile.getModes()
              val (_, modes') = List.partition (fn m => m = mode) modes
              val (_, details') = List.partition (fn r => #name r = mode) details
              val details = 
                {name = mode,
                 location = ref location,
                 generate_interruptable_code = ref generate_interruptable_code,
                 generate_interceptable_code = ref generate_interceptable_code, 
                 generate_debug_info = ref generate_debug_info,
                 generate_variable_debug_info = ref generate_variable_debug_info,
                 optimize_leaf_fns = ref optimize_leaf_fns,
                 optimize_tail_calls = ref optimize_tail_calls, 
                 optimize_self_tail_calls = ref optimize_self_tail_calls,
                 mips_r4000 = ref mips_r4000, 
                 sparc_v7 = ref sparc_v7}
           in ProjFile.setModes (mode::modes', details::details');
              refresh_project()
          end

        fun remove_mode mode =
          let val (modes, details, current_mode) = ProjFile.getModes()
              val (_, modes') = List.partition (fn m => m = mode) modes
              val (mode_l, details') = List.partition (fn r => #name r = mode) details
           in 
              if mode_l = []
              then env_error (project_exn, "Cannot remove " ^ mode ^ " as it does not exist")
              else if mode = getOpt(current_mode,"")
              then env_error (project_exn, "Cannot remove " ^ mode ^ " as it is the current mode")
              else (ProjFile.setModes (modes', details'); refresh_project())
          end

        fun show_config_details config =
          let val (configs, details, _) = ProjFile.getConfigurations()
           in if List.exists(fn c => c = config) configs
              then let val {name, files, library} =
                              ProjFile.getConfigDetails(config, details)
                    in {files = files, library = library} end
              else env_error (project_exn, "There is no configuration called " ^ config)
          end

	fun duplicate_mod_ids [] ids = NONE
	  | duplicate_mod_ids (a::rest) ids =
	    let 
	      val filen = OS.Path.file a
	      val id = ModuleId.from_host (filen, get_location())
	    in
	      if (List.exists (fn id' => ModuleId.eq(id,id')) ids) then (SOME filen)
	      else duplicate_mod_ids rest (id :: ids)
	    end

	fun rem_old_config_units new_config =
          let
            val (configs, c_details, old_config) = ProjFile.getConfigurations()
            fun get_c_files config =
              (#files (ProjFile.getConfigDetails (config, c_details)))
              handle ProjFile.NoConfigDetailsFound c => []
            fun get_c_modules config =
              map (fn f => ModuleId.from_host(OS.Path.file f,
                                              Info.Location.FILE "Project Properties"))
                  (get_c_files config)
            fun remove_unit (mod_id, proj) = Project.delete(proj, mod_id, false)
            val init_proj = Incremental.get_project()
            val set = Incremental.set_project
          in
            case (old_config, new_config) of
              (NONE, _) => ()
	    | (SOME old, NONE) =>
		set (foldl remove_unit init_proj (get_c_modules old))
            | (SOME old, SOME new) =>
		if (old = new) then ()
		else
                  set (foldl remove_unit init_proj (get_c_modules old))
          end

	fun set_configuration config =
          let val (configs, configDetails, curConfig) = ProjFile.getConfigurations() 
          in 
	    if (List.exists (fn c => c = config) configs) then
              let
		val common_files = ProjFile.getFiles()
		val config_files = #files (ProjFile.getConfigDetails(config, configDetails))
	      in
		case (duplicate_mod_ids (common_files @ config_files) []) of
		  NONE => 
		    (rem_old_config_units (SOME config);
		     ProjFile.setCurrentConfiguration
                       (error_info, get_location ())
                       (SOME config); 
                     refresh_project())
		| SOME f =>
		  env_error (project_exn,
			     "Cannot change to configuration; filename clash: " ^ f)
	      end
            else
              env_error (project_exn, 
                         "The configuration " ^ config ^ " is undefined")
          end

        fun set_config_details (config, {files, library}) =
          let 
	    val (configs, details, curConfig) = ProjFile.getConfigurations()
            val (_, configs') = List.partition (fn c => c = config) configs
            val (_, details') = List.partition (fn r => #name r = config) details
            val details = {name = config, files = files, library=library}
	    val com_files = ProjFile.getFiles()
          in 
	    case (duplicate_mod_ids (com_files @ files) []) of
	      NONE => 
		(ProjFile.setConfigurations (config::configs', details::details');
              	 refresh_project())
	    | SOME f => 
		env_error (project_exn, 
		          "No duplicate filenames allowed. <" ^ f ^ "> already exists");
	    case curConfig of 
	      NONE => set_configuration config
	    | SOME c => if (List.exists (fn c' => c=c') configs') then () 
			else set_configuration config
          end

        fun remove_config config =
          let val (configs, details, current_config) = ProjFile.getConfigurations()
              val (_, configs') = List.partition (fn c => c = config) configs
              val (config_l, details') = List.partition (fn r => #name r = config) details
           in 
              if config_l = []
              then env_error (project_exn, "Cannot remove " ^ config ^ " as it does not exist") 
              else ();
              if config = getOpt(current_config,"") 
              then 
		(case configs' of 
		   [] => 
		     (rem_old_config_units NONE;
		      ProjFile.setCurrentConfiguration (error_info, get_location ()) NONE)
		 | (c::rest) => set_configuration c)
              else ();
              ProjFile.setConfigurations (configs', details'); 
              refresh_project()
          end

        fun show_location_details () =
          let val (libraryPath, objectsLoc, binariesLoc) = ProjFile.getLocations()
           in {libraryPath=libraryPath, objectsLoc=objectsLoc, binariesLoc=binariesLoc}
          end

        fun set_location_details {libraryPath, objectsLoc, binariesLoc} =
          ( ProjFile.setLocations(libraryPath, objectsLoc, binariesLoc);
            refresh_project() )

        fun show_about_details () =
          let val (description, version) = ProjFile.getAboutInfo()
           in {description=description, version=version}
          end

        fun set_about_details {description, version} =
          ( ProjFile.setAboutInfo(description, version);
            refresh_project() )

	val project_record =
	  cast
	    {(*
             a_IMAGE = ProjFile.IMAGE : ProjFile.target_type,
             a_OBJECT_FILE = ProjFile.OBJECT_FILE : ProjFile.target_type,
             a_EXECUTABLE = ProjFile.EXECUTABLE : ProjFile.target_type,
             a_LIBRARY = ProjFile.LIBRARY : ProjFile.target_type,
             *)
             a_ProjectError = project_exn : internal_exn_rep,
             a_openProject =
	       (fn file => (ProjFile.open_proj file; 
			    Incremental.reset_project();
			    refresh_project())
                  handle _ => env_error (project_exn, "Unable to open project file " ^ file)
               ): string -> unit,
	     a_newProject =
	       (fn dir => 
                  let val abs_dir = OS.Path.mkAbsolute{path=dir, relativeTo=OS.FileSys.getDir()}
                   in if (OS.FileSys.isDir abs_dir handle OS.SysErr _ => false)
                      then
 			(ProjFile.new_proj dir; 
			 Incremental.reset_project();
                         ProjFile.setInitialModes();
			 refresh_project())
                     else env_error (project_exn, 
                                      abs_dir ^ " is not a directory")
                  end) : string -> unit,
	     a_saveProject =
	       (fn () => 
                  case ProjFile.getProjectName() of
                    SOME "" => 
  		      env_error (project_exn, "New project has no name")
                  | SOME file => 
  		      ( ProjFile.save_proj file
                        handle _ => env_error (project_exn, 
                                               "Unable to save project file to " ^ file) )
                  | NONE =>
                      env_error (project_exn, "There is no current project to save")
               ): unit -> unit,
	     a_saveProjectAs =
	       (fn file => 
                  case ProjFile.getProjectName() of
                    SOME _ => 
                      ( (ProjFile.save_proj file; refresh_project())
                        handle _ => env_error (project_exn, 
                                               "Unable to save project file to " ^ file) )
                  | NONE =>
                      env_error (project_exn, "There is no current project to save")
               ): string -> unit,
	     a_closeProject =
	       (fn () => (ProjFile.close_proj(); refresh_project())) : unit -> unit,
	     a_setFiles =
	       (fn files => 
		  let
		    val (configs, c_details, curConfig) = ProjFile.getConfigurations()
		    val config_files = 
		      case curConfig of 
			NONE => []
		      | SOME c => #files (ProjFile.getConfigDetails(c, c_details))
		  in
		    case (duplicate_mod_ids (files @ config_files) []) of
		      NONE => (ProjFile.setFiles files; refresh_project())
		    | SOME f => 
		        env_error (project_exn, 
				   "No duplicate filenames allowed. <" ^ f ^ "> already exists")
		  end
               ): string list -> unit,

	     a_showFiles =
	       (fn () => ProjFile.getFiles ()): unit -> string list,
	     a_setSubprojects =
	       (fn subs => (ProjFile.setSubprojects subs; refresh_project())
                           handle _ => env_error (project_exn, "Unable to open subprojects")
               ): string list -> unit,
	     a_showSubprojects =
	       (fn () => ProjFile.getSubprojects ()): unit -> string list,
             a_showLocations = 
	       show_location_details : unit -> location_details,
             a_setLocations = 
	       set_location_details : location_details -> unit,
             a_showAboutInfo = 
	       show_about_details : unit -> about_details,
             a_setAboutInfo = 
	       set_about_details : about_details -> unit,
             a_showFilename = 
	       (fn () => getOpt(ProjFile.getProjectName(), "")) : unit -> string,

	     a_setConfiguration =
               set_configuration : string -> unit,
             a_removeConfiguration = 
	       remove_config : string -> unit,
	     a_setTargets = 
	       (fn targets => 
                  let val (_, _, details) = ProjFile.getTargets()
                   in app (fn t => if List.exists(fn (t',_) => t = t') details
                                   then ()
                                   else env_error (project_exn, 
                                        "The target " ^ t ^ " is undefined"))
                          targets;

                      ProjFile.setCurrentTargets
                        (error_info, get_location ())
                        targets; 
                      refresh_project()
                  end
               ): string list -> unit,
             a_setTargetDetails =
               (fn target =>
                  let val c_target = OS.Path.mkCanonical target
		      val (enabled, disabled, details) = ProjFile.getTargets()
		      val t_file = OS.Path.file c_target
                      val (target1, enabled') = List.partition (fn t => t = t_file) enabled
                      val (target2, disabled') = List.partition (fn t => t = t_file) disabled
                      val details' = List.filter (fn (t,_) => t <> t_file) details
                   in 
		     (ProjFile.setTargets(t_file::enabled', disabled', 
                                          (t_file,ProjFile.OBJECT_FILE)::details');
                       refresh_project())
                      handle _ => env_error (project_exn, "Unable to set target details for " ^ target)
                  end): string -> unit,
             a_removeTarget =
               (fn target =>
                  (let val (enabled, disabled, details) = ProjFile.getTargets()
                       val (target1, enabled') = List.partition (fn t => t = target) enabled
                       val (target2, disabled') = List.partition (fn t => t = target) disabled
                       val details' = List.filter (fn (t,_) => t <> target) details
                    in if null target1
                       then if null target2
                            then env_error (project_exn, "There is no target called " ^ target)
                            else ProjFile.setTargets(enabled, disabled', details')
                       else ProjFile.setTargets(enabled', disabled, details')
                   end; refresh_project())): string -> unit,
             a_showAllTargets =
               (fn () =>
                  let val (enabled, disabled, _) = ProjFile.getTargets()
                   in enabled @ disabled end): unit -> string list,
             a_showCurrentTargets =
               (fn () =>
                  let val (enabled, _, _) = ProjFile.getTargets()
                   in enabled end): unit -> string list,
             (*
             a_showTargetDetails =
               (fn target =>
                  let val (enabled, disabled, details) = ProjFile.getTargets()
                   in case List.find (fn (t,_) => t = target) details of
                        NONE => env_error (project_exn, "There is no target called " ^ target)
                      | SOME(_, target_type) => target_type
                  end) : string -> ProjFile.target_type,
	     *)
             a_setMode = 
	       (fn mode => 
                 let val (modes, _, _) = ProjFile.getModes() 
                  in if List.exists(fn m => m = mode) modes
                     then (ProjFile.setCurrentMode
                             (error_info, get_location ())
                             mode; refresh_project())
                     else
                       env_error (project_exn, 
                                  "The mode " ^ mode ^ " is undefined")
                 end
               ): string -> unit,
             a_removeMode = 
	       remove_mode : string -> unit,
             a_showAllModes = 
               (fn () => 
                 let val (modes, details, _) = ProjFile.getModes() in modes end)
               : unit -> string list,
             a_showCurrentMode = 
               (fn () => 
                 case ProjFile.getModes() of
                   (_, _, SOME s) => s
                 | _ => env_error (project_exn, "There is no current mode"))
               : unit -> string,
             a_showModeDetails = 
	       show_mode_details : string -> mode_details,
             a_setModeDetails = 
	       set_mode_details : string * mode_details -> unit,
             a_showAllConfigurations = 
               (fn () => 
                 let val (configs, _, _) = ProjFile.getConfigurations() in configs end)
               : unit -> string list,
             a_showCurrentConfiguration = 
               (fn () => 
                 case ProjFile.getConfigurations() of
                   (_, _, SOME s) => s
                 | _ => env_error (project_exn, "There is no current configuration"))
               : unit -> string,
             a_showConfigurationDetails = 
	       show_config_details : string -> configuration_details,
             a_setConfigurationDetails = 
	       set_config_details : string * configuration_details -> unit,

	     a_compile = compile: string -> unit,
	     a_showCompile = show_compile: string -> unit,
	     a_forceCompile = force_compile: string -> unit,

	     a_compileAll = compile_all: unit -> unit,
	     a_showCompileAll = show_compile_all: unit -> unit,
	     a_forceCompileAll = force_compile_all: unit -> unit,

	     a_load = load: string -> unit,
	     a_showLoad = show_load: string -> unit,
             a_forceLoad = force_load: string -> unit,

             a_loadAll = load_targets: unit -> unit,
	     a_showLoadAll = show_load_targets: unit -> unit,
             a_forceLoadAll =
	       (fn () => (Incremental.delete_all_modules true;
                          load_targets ())): unit -> unit,

	     (* a_makeDll =
  	      * (fn (target, libs) =>
	      * ShellUtils.make_dll_from_project(get_location(), error_info, target, libs) handle
	      * exn as OS.SysErr(s, _) => (print(s ^ "\n"); raise exn)) : string * string list -> unit, 
              *)
	     a_makeExe =
	       (fn (target, libs) =>
		ShellUtils.make_exe_from_project(get_location(), error_info, target, libs) handle
		exn as OS.SysErr(s, _) => (print(s ^ "\n"); raise exn)) : string * string list -> unit,
	     (*
	     a_listObjects =
	      (fn filename => 
		 TopLevel.list_objects
		   error_info
		   (ShellTypes.get_current_options (!shell_data_ref))
		   [filename]): string -> unit,
	     *)
	     a_delete = delete_from_project: string -> unit,
	     a_readDependencies = read_dependencies: string -> unit}

	val path_structure = mk_exn_structure
          ([("setSourcePath", string_list_to_unit),
            ("sourcePath", unit_to_string_list),
	    (*
            ("setObjectPath", string_to_unit),
            ("objectPath", unit_to_string),
	    *)
            ("setPervasive", string_to_unit),
            ("pervasive", unit_to_string)],
           [(path_exn_label,string_to_exn)])

	fun set_source_path l =
	  Io.set_source_path
	    (map
	     (fn x =>
	      (OS.FileSys.fullPath(Getenv.expand_home_dir x))
	      handle Getenv.BadHomeName s => env_error (path_exn, s)
		   | OS.SysErr(str, err) =>
		let
		  val str = case err of
		    NONE => str
		  | SOME err => OS.errorMsg err
		in
		  env_error(path_exn, str ^ ": " ^ x)
		end)
	     l)

	fun get_source_path () = Io.get_source_path ()

	(*
	fun set_object_path s =
	  Io.set_object_path(Getenv.expand_home_dir s, Info.Location.FILE"<Shell>")
          handle
	  Getenv.BadHomeName s => env_error (path_exn, s)

	val get_object_path = Io.get_object_path
	(* XXXEXCEPTION: should handle Io.NotSet *)
	*)

	fun set_pervasive_dir s =
	  Io.set_pervasive_dir
	    (OS.FileSys.fullPath (Getenv.expand_home_dir s),
	     Info.Location.FILE"<Shell>")
          handle
            Getenv.BadHomeName s => env_error (path_exn, s)
	  | OS.SysErr(str, err) =>
	      let
		val str = case err of
		  NONE => str
		| SOME err => OS.errorMsg err
	      in
		env_error(path_exn, str ^ ": " ^ s)
	      end

	fun get_pervasive_dir () =
	  Io.get_pervasive_dir ()
	  handle Io.NotSet s => env_error (path_exn, s)

	val path_record =
	   cast
	     {a_setSourcePath = set_source_path : string list -> unit,
	      a_sourcePath = get_source_path : unit -> string list,
	      a_setPervasive = set_pervasive_dir : string -> unit,
	      a_pervasive = get_pervasive_dir : unit -> string,
	      (*
	      a_setObjectPath = set_object_path : string -> unit,
	      a_objectPath = get_object_path : unit -> string,
	      *)
              a_Path = path_exn : internal_exn_rep}

        val custom_editor_structure =
(*
     val addCommand : string * string -> unit
     val addConnectDialog : string * string * string list -> unit
     val removeCommand : string -> string
     val removeDialog : string -> (string * string list)
     val commandNames  : unit -> string list
     val dialogNames  : unit -> string list
*)
	  mk_structure
	    ([("addCommand", string_cross_string_to_unit),
              ("addConnectDialog", string_cross_string_cross_string_list_to_unit),
              ("removeCommand", string_to_string),
              ("removeDialog", string_to_string_cross_string_list),
              ("commandNames", unit_to_string_list),
              ("dialogNames", unit_to_string_list)])

        val custom_editor_record = cast
          {a_addCommand = CustomEditor.addCommand : string * string -> unit,
           a_addConnectDialog = CustomEditor.addConnectDialog : (string * string * string list) -> unit,
	   a_removeCommand = CustomEditor.removeCommand :
		string -> string,
           a_removeDialog = CustomEditor.removeDialog :
		string -> (string * string list),
           a_commandNames = CustomEditor.commandNames : unit -> string list,
           a_dialogNames = CustomEditor.dialogNames : unit -> string list
          }

	fun edit_file string =
          (ignore(ShellUtils.edit_file
	     (string, ShellTypes.get_current_preferences (!shell_data_ref)));
           ())
          handle ShellUtils.EditFailed s => env_error (edit_exn, s)

	fun edit_definition (f : 'a -> 'b) =
          let
            val f : MLWorks.Internal.Value.T = cast f
	    val preferences =
	      ShellTypes.get_current_preferences (!shell_data_ref)
          in
            ignore(ShellUtils.edit_object (f, preferences));
            ()
          end
          handle ShellUtils.EditFailed s => env_error (edit_exn, s)

        val editor_structure =
	     (* Prefix "a_" for values, "b_" for exceptions,
	        and "c_" for structures, to ensure correct ordering.
	      *)
	  mk_mixed_structure
	    ([("Custom",custom_editor_structure)],
	     [],
	     [("editFile", string_to_unit),
              ("editDefinition",fun_to_unit)],
             [(edit_exn_label,string_to_exn)])

        val editor_record = cast
          {a_editFile = edit_file : string -> unit,
           a_editDefinition = edit_definition : ('a -> 'b) -> unit,
           a_EditError = edit_exn : internal_exn_rep,
           c_custom = custom_editor_record}

	val debug_structure =
	     STR (
	       STRNAME (Types.make_stamp ()),
               ref NONE,
	       ENV (
		 Strenv.empty_strenv,
		 Tyenv.empty_tyenv,
		 Lists.reducel
		   (fn (ve, (name, typescheme)) =>
		      Valenv.add_to_ve(
		        Ident.VAR(find_symbol name),
		        typescheme,
		        ve
		      )
		   )
		   (empty_valenv,
		    [("info", fun_to_string),
		     ("infoAll", unit_to_string_list),
                     ("status", fun_to_bool),
                     ("stepThrough", fun_to_fun),
		     ("clear", fun_to_unit),
		     ("clearAll", unit_to_unit)])
	       )
	     )

        fun debug_clear f =
          let
	    val name = ValuePrinter.function_name f
          in
	    UserContext.clear_debug_info
	      (ShellTypes.get_user_context (!shell_data_ref), name)
          end

        fun debug_clear_all () =
	  UserContext.clear_debug_all_info
	    (ShellTypes.get_user_context (!shell_data_ref))
    
        fun debug_status f =
          let
            val debug_info = Incremental.debug_info (get_context ())
	    val name = ValuePrinter.function_name f
          in
            case Debugger_Types.lookup_debug_info (debug_info,name) of
              SOME _ => true
            | _ => false
          end

        fun debug_info f =
          let
            val options = ShellTypes.get_current_options
                            (!ShellTypes.shell_data_ref)
            val debug_info = Incremental.debug_info (get_context ())
	    val name = ValuePrinter.function_name f
          in
	    Debugger_Types.print_function_information options
            (name,debug_info,true)
          end

        fun debug_info_all () =
          let
            val options = ShellTypes.get_current_options
                                 (!ShellTypes.shell_data_ref)
            val debug_info = Incremental.debug_info (get_context ())
          in
            Debugger_Types.print_information options (debug_info,true)
          end

	val debug_record =
             cast
             {a_clearAll = debug_clear_all : unit -> unit,
              a_clear = debug_clear : ('a -> 'b) -> unit,
              a_info = debug_info : ('a -> 'b) -> string,
              a_infoAll = debug_info_all : unit -> string list,
              a_status = debug_status : ('a -> 'b) -> bool,
              a_stepThrough = Trace.step_through : ('a -> 'b) -> ('a -> 'b)}

        val options_structure =
          STR (STRNAME (Types.make_stamp ()),
               ref NONE,
	       ENV(mk_strenv
		     [("Preferences", preferences_structure),
		      ("ValuePrinter", value_printer_structure),
	    	      ("Compiler", compiler_structure),
                      ("Debugger", debugger_structure),
	    	      ("Internals", internals_structure),
	    	      ("Language", language_structure),
		      ("Mode", mode_option_structure)],
                   mk_tyenv
		     [("option",
		       TYSTR (ETA_TYFUN option_tyname, empty_valenv))],
		   mk_valenv
                   ([("set", set_option_type),
                     ("get", get_option_type)],
                    [])))

	val options_record =
	     (* Prefix "a_" for values, "b_" for exceptions,
	        and "c_" for structures, to ensure correct ordering.
	      *)
             cast
             {a_set = set_option : 'a option_rep * 'a -> unit,
	      a_get = get_option : 'a option_rep -> 'a,
	      c_compiler = compiler_record,
              c_debugger = debugger_record,
              c_internals = internals_record,
              c_valuePrinter = value_printer_record,
	      c_language = language_record,
	      c_mode = mode_option_record,
	      c_preferences = preferences_record
	     }

	local
	  (* profiling functions for Shell.Profile *)
	  val time_space_profile_manner =
	    Profile.make_manner
	    {time = true,
	     space = true,
	     calls = false,
	     copies = false,
	     depth = 0,
	     breakdown = []}

	  val time_space_profile_options =
	    Profile.Options {scan = 10,
			     selector = fn _ => time_space_profile_manner}

	  val time_profile_manner =
	    Profile.make_manner
	    {time = true,
	     space = false,
	     calls = false,
	     copies = false,
	     depth = 0,
	     breakdown = []}

	  val time_profile_options =
	    Profile.Options {scan = 10,
			     selector = fn _ => time_profile_manner}

	  val space_profile_manner =
	    Profile.make_manner
	    {time = false,
	     space = true,
	     calls = false,
	     copies = false,
	     depth = 0,
	     breakdown = []}

	  val space_profile_options =
	    Profile.Options {scan = 10,
			     selector = fn _ => space_profile_manner}

	  fun profile_tool p =
	    ShellTypes.get_current_profiler (!shell_data_ref) p

	  fun profile_full opt f a =
	    let
	      val (r,p) = Profile.profile opt f a
	    in
	      (profile_tool p;
	       case r of
		 Profile.Result r => r
	       | Profile.Exception e => raise e)
	    end

	  val time_space_profile = profile_full time_space_profile_options
	  val time_profile = profile_full time_profile_options
	  val space_profile = profile_full space_profile_options

	  val profile_options_tycon = mk_longtycon(["MLWorks",
						    "Profile"],
						    "options")

	  val profile_tycon = mk_longtycon(["MLWorks",
					    "Profile"],
					   "profile")

	  val profile_options_type = get_runtime_type profile_options_tycon

	  val profile_type = get_runtime_type profile_tycon

	  (* profile has type ('a -> 'b) -> 'a -> 'b
	   * full has type options -> ('a -> 'b) -> 'a -> 'b *)

	  val (profiler_type, profile_full_type) =
	    let
	      val alpha = make_tyvar "'a"
	      val beta = make_tyvar "'b"
	      val profile_type_instance = FUNTYPE (FUNTYPE (alpha,beta),
						   FUNTYPE (alpha,beta))
	      val full_type_instance = FUNTYPE (profile_options_type,
						profile_type_instance)
	      val free_type_vars = [alpha,beta]
	    in
	      (Scheme.make_scheme(free_type_vars, (profile_type_instance,
						   NONE)),
	       Scheme.make_scheme(free_type_vars, (full_type_instance,
						   NONE)))
	    end

	  (* profile_tool has type profile -> unit *)
	  val profile_tool_type = schemify (FUNTYPE (profile_type,
						     Types.empty_rectype))

	in
	  val profile_structure =
	    STR(
		STRNAME(Types.make_stamp ()),
		ref NONE,
		ENV (Strenv.empty_strenv,
		     Tyenv.empty_tyenv,
		     Lists.reducel
		     (fn (ve, (name, typescheme)) =>
		      Valenv.add_to_ve
		      (Ident.VAR (find_symbol name),
		       typescheme,
		       ve))
		     (empty_valenv,
		      [("profile",profiler_type),
		       ("profileFull", profile_full_type),
		       ("profileSpace",profiler_type),
		       ("profileTime",profiler_type),
		       ("profileTool",profile_tool_type)])))
	  val profile_record =
	    cast
	    {a_profile = time_space_profile : ('a -> 'b) -> 'a -> 'b,
	     a_profileFull =
	       profile_full : Profile.options -> ('a -> 'b) -> 'a -> 'b,
	     a_profileSpace = space_profile : ('a -> 'b) -> 'a -> 'b,
	     a_profileTime = time_profile : ('a -> 'b) -> 'a -> 'b,
	     a_profileTool = profile_tool : Profile.profile -> unit}
	end

	local
	  (* various timing functions for Shell.Timer *)

	  fun time_iterations n f a =
	    let
	      fun time' 0 = ()
		| time' n = (ignore(f a);
			     time' (n-1))
	      val (cpu_timer, real_timer) =
		(Timer.startCPUTimer(), Timer.startRealTimer())
	    in
	      (time' n;
	       (Timer.checkCPUTimer cpu_timer,
		Timer.checkGCTime cpu_timer,
	        Timer.checkRealTimer real_timer))
	    end
	
	  val time = time_iterations 1
	
	  fun print_timing {outputter : string -> unit, name, function} arg =
	    let
	      val (cpu_timer, real_timer) =
		(Timer.startCPUTimer(), Timer.startRealTimer())
		
	      fun times_to_string({usr, sys}, gc, real_elapsed) =
		concat [Time.toString real_elapsed,
			" (user: ",
			Time.toString usr,
			"(gc: ",
			Time.toString gc,
			"), system: ",
			Time.toString sys,
			")"]

	      fun print_time () =
		let
		  val elapsed =
		    (Timer.checkCPUTimer cpu_timer,
		     Timer.checkGCTime cpu_timer,
		     Timer.checkRealTimer real_timer)
		in
		  outputter(concat ["Time for ", name, " : ",
				    times_to_string elapsed,
				    "\n"])
		end
	
	      val result =
		function arg
		handle exn => (print_time () ; raise exn)
	    in
	      (print_time () ; result)
	    end
	
	  (* change this if MLWorks.Internal.Types.time ever changes *)
	
	  val time_tycon = mk_longtycon (["MLWorks",
					  "Internal",
					  "Types"],
					 "time")

	  val time_type = get_runtime_type time_tycon

	  val cpu_time_type = mk_record[("usr", time_type),
					("sys", time_type)]

	  val elapsed_t_type = make_tuple[cpu_time_type, time_type, time_type]
	
	  type elapsed_type = ({sys: Time.time, usr: Time.time} * Time.time * Time.time)

	  val outputter_type = FUNTYPE(Types.string_type, Types.empty_rectype)
	
	  (* time has type ('a -> 'b) -> 'a -> elapsed_t_type *)
	
	  val time_type =
	    let
	      val alpha = make_tyvar "'a"
	      val beta  = make_tyvar "'b"
	      val time_type_instance = FUNTYPE (FUNTYPE (alpha,beta),
						FUNTYPE (alpha,elapsed_t_type))
	    in
	      Scheme.make_scheme([alpha,beta], (time_type_instance,
						NONE))
	    end
	
	  (* time_iterations has type int -> ('a -> 'b) -> 'a -> elapsed_t_type *)
	
	  val time_iterations_type =
	    let
	      val alpha = make_tyvar "'a"
	      val beta  = make_tyvar "'b"
	      val time_iterations_type_instance =
		FUNTYPE(Types.int_type,
			FUNTYPE (FUNTYPE (alpha,beta),
				 FUNTYPE (alpha,elapsed_t_type)))
	    in
	      Scheme.make_scheme([alpha,beta], (time_iterations_type_instance,
						NONE))
	    end
	
	  (*  print_timing has type
	   {outputter: string -> unit,
	    name: string,
	    function: ('a -> 'b)} -> 'a -> 'b
	   *)
	
	  val print_timing_type =
	    let
	      val alpha = make_tyvar "'a"
	      val beta  = make_tyvar "'b"
	      val print_timing_type_instance =
		FUNTYPE(mk_record [("outputter",outputter_type),
				   ("name",Types.string_type),
				   ("function",FUNTYPE (alpha, beta))],
			FUNTYPE (alpha,beta))
	    in
	      Scheme.make_scheme([alpha,beta], (print_timing_type_instance,
						NONE))
	    end
	in

	  val timer_structure =
	    STR(
		STRNAME (Types.make_stamp ()),
		ref NONE,
		ENV (Strenv.empty_strenv,
		     Tyenv.empty_tyenv,
		     Lists.reducel
		     (fn (ve, (name, typescheme)) =>
		      Valenv.add_to_ve
		      (Ident.VAR (find_symbol name),
		       typescheme,
		       ve))
		     (empty_valenv,
		      [("time",time_type),
		       ("timeIterations", time_iterations_type),
		       ("printTiming", print_timing_type)])))
	
	  val timer_record =
	    cast
	    {a_time = time : ('a -> 'b) -> 'a -> elapsed_type,
	     a_timeIterations =
	       time_iterations :
		 int -> ('a -> 'b) -> 'a -> elapsed_type,
	     a_printTiming = print_timing : {outputter: string -> unit,
					     name: string,
					     function: ('a -> 'b)} -> 'a -> 'b}
	end
	
        (* make the context itself *)
        val context =
          #1(Incremental.add_value
             (#1(Incremental.add_value
                 (initial_context,
                  "use",
                  UNBOUND_SCHEME (FUNTYPE (Types.string_type, Types.empty_rectype),
                                  NONE),
                  cast (use_fun : string -> unit)
                  )),
              "use_string",
              UNBOUND_SCHEME (FUNTYPE (Types.string_type, Types.empty_rectype),
                              NONE),
              cast (use_string_fun : string -> unit)
              ))

	local
          fun handler_fn msg =
            Info.default_error'
            (Info.FATAL,
             Info.Location.FILE (ShellTypes.get_current_toplevel_name ()),
             msg)

          val (context', identifiers) =
            Incremental.add_structure
              (context,
               "Shell",
               mk_mixed_structure
                 ([("Project", project_structure),
                   ("Path", path_structure),
		   ("Options", options_structure),
		   ("Debug", debug_structure),
		   ("Editor", editor_structure),
                   ("Trace", trace_structure),
                   ("Dynamic",dynamic_structure),
                   ("Inspector",inspector_structure),
		   ("Timer", timer_structure),
		   ("Profile", profile_structure)
		   ],
		  [],
		  [("exit", int_to_unit),
		   ("startGUI", unit_to_unit),
		   ("saveImage", string_cross_bool_to_unit)
		   ],
                  []),
	       (* Prefix "a_" for values, "b_" for exceptions,
	          and "c_" for structures, to ensure correct ordering.
	        *)
               cast{
                   a_exit = shell_exit_fn : int -> unit,
		   a_saveImage =
                     (fn (name, exe) => 
	               ( if (get_context_option_fun 
                              (#generate_debug_info) ()) orelse
                            (get_context_option_fun 
                              (#generate_variable_debug_info) ())
                         then print ("Warning: enabling the debug options " ^
                                     "may result in large saved images.\n")
                         else ();
                         SaveImage.saveImage
	                 (is_a_tty_image, handler_fn) (name, exe) ))
                     : string * bool -> unit,
		   a_startGUI =
		     (fn () =>
			SaveImage.startGUI
			  true
			  (!shell_data_ref)) : unit -> unit,
                   c_inspector = inspector_record,
                   c_dynamic = dynamic_record,
                   c_trace = trace_record,
		   c_project = project_record,
		   c_path = path_record,
		   c_debug = debug_record,
		   c_editor = editor_record,
		   c_options = options_record,
		   c_timer = timer_record,
		   c_profile = profile_record
		 })
        in
          val context = context'
	end


	(* Now add debug info for the Environment errors exception *)

	(* Note that labels must be unique -- so a better mechanism is needed
	 if we want two exceptions called "Error" for example *)
        val environment_debug_info =
          Lists.reducel
          (fn (debug_info,(label,exn_type)) =>
           (Debugger_Types.add_debug_info
            (debug_info,
             make_exn_tag label,
             Debugger_Types.FUNINFO {ty=exn_type,
                                     is_leaf=true,
				     has_saved_arg=false,
                                     annotations=[],
                                     runtime_env=Debugger_Types.RuntimeEnv.EMPTY,
                                     is_exn=true})))
          (Debugger_Types.empty_information,
           [(edit_exn_label,string_to_exn_type),
            (eval_exn_label,string_to_exn_type),
            (inspect_exn_label,string_to_exn_type),
            (project_exn_label,string_to_exn_type)])

        val context =
	  Incremental.add_debug_info
	    (Options.default_options, environment_debug_info,context)

      in
        context
      end (* of make_shell_structure *)

  end
