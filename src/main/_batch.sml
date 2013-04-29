(*  ==== TOP LEVEL BATCH COMPILER ====
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
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: _batch.sml,v $
 *  Revision 1.121  1999/05/27 10:34:21  johnh
 *  [Bug #190553]
 *  FIx require statements to fix bootstrap compiler.
 *
 * Revision 1.120  1999/05/13  09:44:07  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.119  1999/03/04  11:57:10  mitchell
 * [Bug #190511]
 * Fix target ordering
 *
 * Revision 1.118  1999/02/09  09:50:00  mitchell
 * [Bug #190505]
 * Support for precompilation of subprojects
 *
 * Revision 1.117  1999/02/05  11:56:03  mitchell
 * [Bug #190504]
 * Add ability to dump units in dependency order
 *
 * Revision 1.116  1998/07/14  09:36:24  jkbrook
 * [Bug #30435]
 * Remove user-prompting code
 *
 * Revision 1.115  1998/06/15  16:02:35  mitchell
 * [Bug #30418]
 * Handle project reading errors gracefully
 *
 * Revision 1.114  1998/05/29  17:40:05  jkbrook
 * [Bug #30411]
 * Handle licensing for free copies of MLWorks
 *
 * Revision 1.113  1998/05/01  16:34:55  mitchell
 * [Bug #50071]
 * setCurrentConfiguration now takes an option
 *
 * Revision 1.112  1998/04/24  16:23:54  jont
 * [Bug #70109]
 * Put print_messages on
 *
 * Revision 1.111  1998/04/15  13:36:04  johnh
 * [Bug #30319]
 * Make usage info consistent with man page about batch options.
 *
 * Revision 1.110  1998/03/03  08:49:15  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.109  1998/02/19  17:19:20  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.108  1998/02/06  11:33:26  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.107  1997/11/25  11:08:02  johnh
 * [Bug #30134]
 * Replacing use of MLWorks.Deliver.deliver with Internal.save - deliver fn changed to exec only.
 *
 * Revision 1.106  1997/10/10  09:19:06  daveb
 * [Bug #30280]
 * No longer compile for R3000 by default on MIPS.
 *
 * Revision 1.105.2.5  1997/11/20  17:00:43  daveb
 * [Bug #30326]
 *
 * Revision 1.105.2.4  1997/11/11  15:51:45  daveb
 * [Bug #30017]
 * Added updateContextOptionsFromProjFile, to update the compiler options
 * when -mode is passed from the command line.
 *
 * Revision 1.105.2.3  1997/11/04  13:57:05  daveb
 * [Bug #30071]
 * Added new command-line arguments.
 *
 * Revision 1.105.2.2  1997/09/17  16:23:10  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.105.2.1  1997/09/11  20:56:39  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.105  1997/06/10  09:06:01  johnh
 * [Bug #30160]
 * Fixed arg_exists function to return right value.
 *
 * Revision 1.104  1997/05/30  17:11:42  daveb
 * [Bug #30090]
 * Removed calls to MLWorks.IO.*
 *
 * Revision 1.103  1997/05/29  15:28:28  johnh
 * [Bug #30160]
 * Removed redundant pattern in match.
 *
 * Revision 1.102  1997/05/27  15:53:58  johnh
 * [Bug #20033]
 * Added -no-banner option and modified -silent option to suppress the prompt.
 *
 * Revision 1.101  1997/05/27  11:12:52  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.100  1997/05/12  16:12:05  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.99  1997/04/23  10:43:10  daveb
 * [Bug #30040]
 * Turned on local function optimisation by default.
 *
 * Revision 1.98  1997/04/01  16:05:05  daveb
 * [Bug #1995]
 * Changed the defaults settings of the MIPS-specific compiler options back to
 * the most general values, so that we can build and distribute images on the
 * R3000.
 *
 * Revision 1.97  1997/03/27  14:48:21  daveb
 * [Bug #1990]
 * Version.version_string is now Version.versionString, and a function instead
 * of a constant.
 *
 * Revision 1.96  1997/03/25  13:43:08  matthew
 * Renaming mips_r4000 option
 *
 * Revision 1.95  1997/03/21  10:58:01  johnh
 * [Bug #1965]
 * Added a handle for Io.NotSet exception in getting pervasive dir.
 *
 * Revision 1.94  1997/02/28  12:53:10  jont
 * [Bug #1935]
 * Modify handlers for OS.SysErr so they only handle what they should
 * Comment out unreferenced stuff when handling OS.SysEr
 *
 * Revision 1.93  1997/01/24  14:36:06  matthew
 * Adding architecture dependent options
 *
 * Revision 1.92  1997/01/02  15:12:10  matthew
 * Adding local function option
 *
 * Revision 1.91  1997/01/02  11:07:56  jont
 * [Bug #0]
 * Change unix to UNIX in order to use trademarked form
 *
 * Revision 1.90  1996/12/19  11:57:31  jont
 * [Bug #1851]
 * Give the default settings in the help info.
 *
 * Revision 1.89  1996/11/07  12:46:27  daveb
 * Revised licensing scheme to allow registration-style licensing.
 *
 * Revision 1.88  1996/11/06  11:28:43  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.87  1996/11/04  16:32:33  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.86  1996/10/29  17:11:25  io
 * removing toplevel String.
 *
 * Revision 1.85  1996/10/17  12:54:14  jont
 * Add license server stuff
 *
 * Revision 1.84.2.2  1996/10/08  12:21:13  jont
 * Add call to initialise license
 *
 * Revision 1.84.2.1  1996/10/07  16:07:49  hope
 * branched from 1.84
 *
 * Revision 1.84  1996/08/16  15:41:56  daveb
 * Removed -object-path from the usage message.
 *
 * Revision 1.83  1996/07/18  17:27:58  jont
 * Add option to turn on/off compilation messages from intermake
 *
 * Revision 1.82  1996/05/30  13:40:46  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.81  1996/05/16  12:47:19  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change
 *
 * Revision 1.80  1996/05/14  14:19:51  matthew
 * Handle SysErr exception
 *
 * Revision 1.79  1996/05/08  13:32:41  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.78  1996/05/03  12:41:40  nickb
 * Change name of MLWorks.deliver
 *
 * Revision 1.77  1996/05/01  09:47:14  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.76  1996/04/30  09:13:16  matthew
 * Use basis integer structure
 *
 * Revision 1.75  1996/04/29  11:54:12  jont
 * MLWorks.save moved into MLWorks.Internal
 *
 * Revision 1.74  1996/04/26  14:43:05  jont
 * Change use of MLWorks.save to MLWorks.deliver when creating batch images.
 * This saves about 100k smaller images.
 *
 * Revision 1.73  1996/04/17  14:25:20  stephenb
 * Replace any use of MLWorks.exit by Exit.exit.
 *
 * Revision 1.72  1996/03/19  10:51:51  matthew
 * Changing command line args
 *
 * Revision 1.71  1996/03/15  15:54:50  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.70  1996/03/15  12:04:52  matthew
 * Use hyphen as options separator
 *
 * Revision 1.69  1995/12/05  12:36:08  daveb
 * I forgot to uncomment the opt_handlers option handling, which I had commented
 * out while working on the project tool.
 *
 *  Revision 1.68  1995/11/20  17:33:42  daveb
 *  Modified to use new project stuff.
 *
 *  Revision 1.67  1995/11/02  11:37:18  jont
 *  Make default for optimisation of handlers true
 *
 *  Revision 1.66  1995/10/30  11:31:39  jont
 *  Adding opt_handlers compiler option
 *
 *  Revision 1.65  1995/06/30  16:02:21  daveb
 *  Added -float_precision option.
 *
 *  Revision 1.64  1995/06/01  12:30:25  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.63  1995/05/22  16:23:32  jont
 *  Ensure exit code propagated to shell on exit
 *
 *  Revision 1.62  1995/05/02  12:07:45  matthew
 *  Removing debug_polyvariables option
 *
 *  Revision 1.61  1995/04/20  19:38:25  daveb
 *  The path setting functions now handle the BadHomeName exception
 *  themselves, and take a location argument.  The FileSys structure is
 *  no longer needed.
 *
 *  Revision 1.60  1995/04/19  11:11:50  jont
 *  Add ability to set object_path
 *
 *  Revision 1.59  1995/04/12  13:28:17  jont
 *  Change FILESYS to FILE_SYS
 *
 *  Revision 1.58  1995/04/05  14:31:01  matthew
 *  Remving print_minor_timings
 *
 *  Revision 1.57  1995/02/14  14:24:17  matthew
 *  Change to debug option name
 *  ,
 *
 *  Revision 1.56  1995/01/17  16:54:24  daveb
 *  Replaced FileName parameter.
 *
 *  Revision 1.55  1994/08/01  12:53:10  daveb
 *  Moved preferences to separate structure.
 *
 *  Revision 1.54  1994/06/23  11:41:15  daveb
 *  Added -debug_poly_variables (on|off) and -generate_moduler (on|off).
 *
 *  Revision 1.53  1994/06/21  16:02:39  nickh
 *  Remove garbage collection performed before image save.
 *  (This is now done automatically in the runtime).
 *
 *  Revision 1.52  1994/03/22  16:32:49  daveb
 *  Changes to recompile.
 *
 *  Revision 1.51  1994/03/08  11:49:44  daveb
 *  Adding error message if user forgets file arguments.
 *  Removed description of -save from help message.
 *
 *  Revision 1.50  1994/03/01  12:47:12  nosa
 *  stepper option was missing.
 *
 *  Revision 1.49  1994/02/28  07:15:49  nosa
 *  New compiler options generate_stepper and generate_moduler.
 *
 *  Revision 1.48  1994/02/24  15:52:07  daveb
 *  Change to type of Io.set_pervasive_dir.
 *
 *  Revision 1.47  1994/02/24  15:30:28  nickh
 *  Fix the storage manager stuff.
 *
 *  Revision 1.46  1994/02/24  13:52:07  nickh
 *  Change the GC interface for collecting the whole heap.
 *
 *  Revision 1.45  1994/02/21  17:12:09  daveb
 *  Added handler for Encapsulate.BadInput.
 *
 *  Revision 1.44  1994/02/02  17:05:53  daveb
 *  Removed munging of file names, since this is now done properly by FileName.
 *
 *  Revision 1.43  1993/12/23  17:40:06  daveb
 *  Changed default compiler function to suit new regime.
 *
 *  Revision 1.42  1993/12/17  16:26:56  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.41  1993/12/06  12:02:51  daveb
 *  Changed -compile option to -compile_file, hidden from users.
 *  Changed -recompile option to -compile.
 *
 *  Revision 1.40  1993/11/04  16:29:30  jont
 *  Added interrupt option
 *
 *  Revision 1.39  1993/11/01  13:44:54  jont
 *  Fixed for new options
 *
 *  Revision 1.38  1993/09/07  09:27:12  nosa
 *  New compiler option debug_polyvariables for polymorphic debugger.
 *
 *  Revision 1.37  1993/08/28  16:51:20  daveb
 *  The compile and recompile functions now take lists of module names,
 *  so that caches can be preserved across compilations.
 *
 *  Revision 1.36  1993/08/27  16:15:50  daveb
 *  Corrected help message.
 *
 *  Revision 1.35  1993/08/25  10:19:03  daveb
 *  Allow ".sml" extension on module names, for simplicity.
 *
 *  Revision 1.34  1993/08/23  15:30:25  richard
 *  Added output_lambda option.
 *
 *  Revision 1.33  1993/08/20  12:31:33  jont
 *  Added print_timings and print_minor_timings command line options.
 *  These are defaulted (in toplevel) off.
 *
 *  Revision 1.32  1993/08/19  17:47:06  daveb
 *  Changed -show_dependencies to -check_dependencies.
 *
 *  Revision 1.31  1993/08/19  17:05:56  daveb
 *  Added call to Io.set_source_path_from_env.
 *  Fixed translation of foo/bar to foo.bar.
 *
 *  Revision 1.30  1993/08/19  16:37:30  daveb
 *  Added better error message.  Changed -intercept to -trace_profile.
 *  Replaced -no_execute [on|off] with -show_dependencies.
 *
 *  Revision 1.29  1993/08/17  18:49:48  daveb
 *  Changed -pervasive-dir argument to -pervasive_dir, because the other
 *  arguments and the environment variable use underscores instead of hyphens.
 *
 *  Revision 1.28  1993/08/17  17:50:27  daveb
 *  Added -source_path and -recompile_pervasive command line arguments.
 *  Other minor changes to reflect use of ModuleIds.
 *
 *  Revision 1.27  1993/08/12  11:10:16  jont
 *  Fixed up after user_options changes
 *
 *  Revision 1.26  1993/08/02  09:45:10  nosa
 *  New compiler option debug_variables for local and closure variable
 *  inspection in the debugger.
 *
 *  Revision 1.25  1993/05/28  18:44:47  jont
 *  Updated following options changes
 *
 *  Revision 1.24  1993/05/25  16:43:59  matthew
 *  Removed catchall handler and replaced with a handler for Info.Stop
 *
 *  Revision 1.23  1993/05/20  09:41:27  jont
 *  Fixed problems with option changes
 *
 *  Revision 1.22  1993/05/11  16:41:36  jont
 *  Added make -n type facility
 *
 *  Revision 1.21  1993/04/28  10:05:36  richard
 *  Unified profiling and tracing options into `intercept'.
 *  The batch compiler now returns a status code.
 *
 *  Revision 1.20  1993/04/07  15:48:54  jont
 *  Added command line options for overloading on strings and NJ open specs
 *
 *  Revision 1.19  1993/04/06  17:26:32  jont
 *  Moved user_options and version from interpreter to main
 *  Removed the code explosion from lack of updatable records. Now done
 *  in terms of user_options
 *
 *  Revision 1.18  1993/04/05  10:33:17  matthew
 *  Changed ordof to MLWorks.String.ordof
 *
 *  Revision 1.17  1993/04/01  13:12:17  jont
 *  Changed to use default_compat_options
 *
 *  Revision 1.16  1993/03/26  16:33:42  daveb
 *  Modified option handling to reflect changes in the Options type.
 *
 *  Revision 1.15  1993/03/11  13:07:29  matthew
 *  Options changes
 *
 *  Revision 1.14  1993/03/04  17:56:02  matthew
 *  Options & Info changes
 *
 *  Revision 1.13  1993/02/24  14:39:08  jont
 *  Made to use get_pervasive_dir from io
 *
 *  Revision 1.12  1993/02/09  12:35:20  matthew
 *  Changed image saving GC
 *
 *  Revision 1.11  1993/01/05  18:09:16  jont
 *  Modified to deal with extra options for code listing
 *
 *  Revision 1.10  1992/12/17  11:37:10  jont
 *  Added a handler for storage manager exceptions during image save
 *
 *  Revision 1.9  1992/12/08  20:32:34  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.8  1992/12/08  12:07:35  jont
 *  Set up with sensible default compilation options. Used user supplied
 *  compilation options for profile, debug, trace
 *
 *  Revision 1.7  1992/12/04  15:50:24  richard
 *  Now prints the correct version string.  GC is forced before image save
 *  using a hack.
 *
 *  Revision 1.6  1992/12/03  16:10:39  jont
 *  Brought up to date with changes to toplevel and recompile
 *
 *  Revision 1.5  1992/11/27  19:09:20  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.4  1992/11/23  11:48:02  jont
 *  Added interrogation of shell variable PERVASIVE_DIR to get pervasive-dir
 *  in default case. Caught exception coming out of failed compilations
 *  to avoid backtraces. Caught Io specifically in order to report file
 *  operation failures
 *
 *  Revision 1.3  1992/11/18  16:10:15  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.2  1992/09/08  15:29:11  richard
 *  Added verbose option and related output.  Not very neat.
 *
 *  Revision 1.1  1992/09/01  13:11:22  richard
 *  Initial revision
 *
 *)

require "../basis/__int";
require "../basis/__string";
require "../basis/__text_io";
require "../basis/__io";
require "../system/__os";

require "../utils/mlworks_exit";
require "encapsulate";
require "version";
require "user_options";
require "mlworks_io";
require "toplevel";
require "proj_file";
require "batch";

functor Batch (
  structure Io		 : MLWORKS_IO
  structure User_Options : USER_OPTIONS
  structure ProjFile	 : PROJ_FILE
  structure TopLevel	 : TOPLEVEL
  structure Encapsulate	 : ENCAPSULATE
  structure Version	 : VERSION
  structure Exit         : MLWORKS_EXIT

  sharing TopLevel.Options = User_Options.Options

  sharing type TopLevel.Info.Location.T = Io.Location = ProjFile.location
  sharing type TopLevel.Info.options = ProjFile.error_info
) : BATCH =
  struct
    structure Exit = Exit
    structure Options = TopLevel.Options
    structure Info = TopLevel.Info

    val verbose = ref false

    datatype compiler =
      NO_COMPILER
    | BATCH of Info.options -> Options.options -> string list -> unit
    | PROJECT of Info.options -> Options.options -> unit -> unit

    fun out s = TextIO.output (TextIO.stdErr, s)

    fun info message =
      if !verbose then
        (app out message;
         out "\n")
      else ()

    fun arg_exists (test_arg, []) = false
      | arg_exists (test_arg, (arg::args)) = 
	let 
	  val sz = size arg
	in
	  if sz = 0 orelse String.sub(arg, 0) <> #"-" then false
	  else
	    if substring (arg, 1, sz-1) = test_arg then true 
	    else 
	      arg_exists (test_arg, args)
	end

    fun updateContextOptionsFromProjFile
          (User_Options.USER_CONTEXT_OPTIONS (context_opts, _)) =
    let
      val (_, modeDetails, currentMode) = ProjFile.getModes ()
    in
      case currentMode of
        NONE => ()
      | SOME name =>
          case ProjFile.getModeDetails (name, modeDetails) of
            (* XXX - handler needed for NoConfigDetailsFound -
               or put this functionality in ProjFile *)
            r =>
	      (#generate_interruptable_code context_opts :=
		 !(#generate_interruptable_code r);
               #generate_interceptable_code context_opts :=
		 !(#generate_interceptable_code r);
               #generate_debug_info context_opts :=
		 !(#generate_debug_info r);
               #generate_variable_debug_info context_opts :=
		 !(#generate_variable_debug_info r);
               #optimize_leaf_fns context_opts :=
		 !(#optimize_leaf_fns r);
               #optimize_tail_calls context_opts :=
		 !(#optimize_tail_calls r);
               #optimize_self_tail_calls context_opts :=
		 !(#optimize_self_tail_calls r);
               #mips_r4000 context_opts :=
		 !(#mips_r4000 r);
               #sparc_v7 context_opts :=
		 !(#sparc_v7 r))
    end

    exception Error of string list
    exception Option of string

    fun usage () = 
      out
      "Usage:   mlbatch [options...]\n\
       \Options:\n\
       \  -verbose\n\
       \          Enable verbose mode.  When in verbose mode the system will\n\
       \          give messages indicating the various options interpreted\n\
       \          during argument processing, otherwise it will not.\n\
       \  -silent\n\
       \          Disable verbose mode.\n\
       \  -project file\n\
       \          Specifies the project file to use.  This must precede all the\n\
       \          following options on the command line.\n\
       \  -mode name\n\
       \          Specifies which mode to use.  Reports an error if the mode does\n\
       \          exist in the specified project file.  This option overrides the\n\
       \          setting of a mode as current in the project file.  If no mode is\n\
       \          specified on the command line, the mode specified as current in\n\
       \          the project file is used.\n\
       \  -target name\n\
       \          Specifies a target to recompile.\n\
       \          Multiple targets may be specified by repeated use of this option.\n\
       \          If any options are specified on the command line, the setting of\n\
       \          targets as current in the project file are ignored.  If no\n\
       \          targets are specified on the command line, those specified as\n\
       \          current in the project file are recompiled.\n\
       \  -configuration name\n\
       \          If the project includes configurations, this specifies which one\n\
       \          to use.  This option overrides the setting of a configuration as\n\
       \          current in the project file.\n\
       \          If a project includes configurations, and none is specified on the\n\
       \          command line, the configuration specified as current in the\n\
       \          project file is used.\n\
       \  -object-path dir\n\
       \          Specifies the directory in which to find/put the object files.\n\
       \          The project must have been specified earlier on the command line.\n\
       \          This overrides the specification in the project file.  If the\n\
       \          directory includes the string '%S', this is expanded to the\n\
       \          directory containing the source file.\n\
       \  -build\n\
       \          Builds the specified project using the current targets in the\n\
       \          current configuration (if any) with the current mode.\n\
       \  -show-build\n\
       \          Show the files that would be recompiled by the -build option.\n\
       \  -list-objects\n\
       \          Show all the files that are used in the building of the current\n\
       \          targets.\n\
       \  -dump-objects filename\n\
       \          Write a file containing all the object files needed to build the\n\
       \          current targets in dependency order.\n\
       \  -source-path path\n\ 
       \          Sets the path that mlbatch searches for source files.  'path' is\n\
       \          a colon-separated list of directories.  For example,\n\
       \          ~/ml/src:/usr/sml/src.  The default path contains the current\n\
       \          directory and the directory in which MLWorks was installed.\n\
       \  -compile files\n\
       \          For each named file, this option recursively compiles any files\n\
       \          on which that file depends that are out of date with respect to\n\
       \          their source.  No default.\n\
       \  -check-dependencies files\n\
       \          Process the source files in check-dependencies mode.  Inclusion of\n\
       \          the .sml suffix in source file names is optional.  Produces a list\n\
       \          of the source files that would be compiled if you submitted the\n\
       \          same list of files to the -compile option.\n\
       \  -old-definition [on|off]\n\
       \          When set to on, use the semantics of the old version of SML,\n\
       \          dating back to 1990.  Default set to off.\n\
       \  -debug [on|off]\n\
       \          Controls whether MLWorks generates debugging information.\n\
       \          Default off.\n\
       \  -debug-variables [on|off]\n\
       \          Controls whether MLWorks generates variable debugging information.\n\
       \          Default off.\n\
       \  -trace-profile [on|off]\n\
       \          Controls whether MLWorks generates code that can be traced\n\
       \          or profiled with the call counter.\n\
       \          Default off.\n\
       \  -interrupt [on|off]\n\
       \          Controls whether interruptable code is enabled.  Default off.\n\
       \  -mips-r4000-and-later [on|off]\n\
       \          Compile code for MIPS R4000 and later versions.\n\
       \          Default on.\n\
       \  -sparc-v7 [on|off]\n\
       \          Compile code for Version 7 of the SPARC architecture.\n\
       \          Default off.\n"

    val compiler = ref NO_COMPILER

    (* project is a flag used to indicate whether a project has been
       specified on the command line.  If none is specified, options to
       set the configuration, mode or targets report an error. *)
    val project = ref false

    (* targets is a list of targets specified on the command line (if any).
       After processing the arguments, these are set in the project.
       If none are specified on the command line, the setting in the
       project file is used.  *)
    val targets = ref []: string list ref

    (* dump_objects_filename, if not NONE, is set to the name of a file
       that is to receive the list of object files, in dependency order,
       constituting the current project. *)
    val dump_objects_filename = ref NONE : string option ref

    fun obey_options
	(tool_options as User_Options.USER_TOOL_OPTIONS(tool_opts, _),
	 context_options as User_Options.USER_CONTEXT_OPTIONS (context_opts, _),
	 args) =
    let
      fun aux [] = (tool_options, context_options, [], !compiler, rev(!targets))
      |   aux (arg::args) =
        let
          val sz = size arg
        in
          if sz = 0 orelse String.sub(arg, 0) <> #"-" then
            (tool_options, context_options, (arg::args), !compiler, !targets)
          else
            (case (substring (arg, 1, sz-1), args) of
               ("verbose", rest) =>
                 (verbose := true;
                  info ["Verbose mode."];
                  aux rest)
	     | ("print-timings", rest) =>
                 (TopLevel.print_timings := true;
                  info ["Printing major timings."];
                  aux rest)
             | ("silent", rest) =>
                 (info ["Silent mode."];
                  verbose := false;
                  aux rest)
             | ("pervasive-dir", dir::rest) =>
                 ((Io.set_pervasive_dir (dir, Info.Location.FILE "Command Line")
		   handle OS.SysErr _ =>
		     raise Error 
			     ["Invalid pervasive directory specification: ",
			      dir]);
		  info ["Pervasive library directory set to `",
			Io.get_pervasive_dir (), "'."]
		  handle Io.NotSet _ =>
		    raise Error ["Pervasive directory not set."];
		  aux rest)
             | ("object-path", dir::rest) =>
                 ((Io.set_object_path (dir, Info.Location.FILE "Command Line")
		   handle OS.SysErr _ =>
		     raise Error
			     ["Invalid object path specification: ",
			      dir]);
		  info ["Object path set to `", Io.get_object_path(), "'."]
		  handle Io.NotSet _ =>
		    raise Error ["Object path not set."];
		  aux rest)
	     | ("source-path", path::rest) =>
		 ((Io.set_source_path_from_string
		     (path, Info.Location.FILE "Command Line")
		   handle OS.SysErr _ =>
		     raise Error
			     ["Invalid source path specification: ", path]);
		  info ["Source path set to `", path, "'."];
		  aux rest)
             | ("float-precision", arg::rest) =>
		 (case Int.fromString arg of
                    SOME n =>
                      (info ["Precision of floating point printing set to ",
                             arg, "."];
                       (case tool_opts of
                          {float_precision, ...} =>
                            float_precision := n);
                          aux rest)
                  | _ => 
                      raise Option "float_precision")
             | ("opt-handlers", "on"::rest) =>
                 (info ["Optimised handlers enabled."];
		  (case context_opts of
		     {optimize_handlers, ...} =>
		       optimize_handlers := true);
		  aux rest)
             | ("opt-handlers", "off"::rest) =>
                 (info ["Optimised handlers disabled."];
		  (case context_opts of
		     {optimize_handlers, ...} =>
		       optimize_handlers := false);
		  aux rest)
             | ("local-functions", "on"::rest) =>
                 (info ["Local Functions enabled."];
		  (case context_opts of
		     {local_functions, ...} =>
		       local_functions := true);
		  aux rest)
             | ("local-functions", "off"::rest) =>
                 (info ["Local Functions disabled."];
		  (case context_opts of
		     {local_functions, ...} =>
		       local_functions := false);
		  aux rest)
             | ("debug", "on"::rest) =>
                 (info ["Debugging information enabled."];
		  (case context_opts of
		     {generate_debug_info, ...} =>
		       generate_debug_info := true);
		  aux rest)
             | ("debug", "off"::rest) =>
                 (info ["Debugging information disabled."];
		  (case context_opts of
		     {generate_debug_info, ...} =>
		       generate_debug_info := false);
		  aux rest)
             | ("debug-variables", "on"::rest) =>
                 (info ["Variable Debugging information enabled."];
		  (case context_opts of
		     {generate_variable_debug_info, ...} =>
		       generate_variable_debug_info := true);
		  aux rest)
             | ("debug-variables", "off"::rest) =>
                 (info ["Variable Debugging information disabled."];
		  (case context_opts of
		     {generate_variable_debug_info, ...} =>
		       generate_variable_debug_info := false);
		  aux rest)
             | ("generate-moduler", "on"::rest) =>
                 (info ["Module Debugging information enabled."];
		  (case context_opts of
		     {generate_moduler, ...} =>
		       generate_moduler := true);
		  aux rest)
             | ("generate_moduler", "off"::rest) =>
                 (info ["Module Debugging information disabled."];
		  (case context_opts of
		     {generate_moduler, ...} =>
		       generate_moduler := false);
		  aux rest)
             | ("interrupt", "on"::rest) =>
                 (info ["Interruptable code enabled."];
		  (case context_opts of
		     {generate_interruptable_code, ...} =>
		       generate_interruptable_code := true);
		  aux rest)
             | ("interrupt", "off"::rest) =>
                 (info ["Interruptable code disabled."];
		  (case context_opts of
		     {generate_interruptable_code, ...} =>
		       generate_interruptable_code := false);
		  aux rest)
             | ("trace-profile", "on"::rest) =>
                 (info ["Interception enabled."];
		  (case context_opts of
		     {generate_interceptable_code, ...} =>
		       generate_interceptable_code := true);
		  aux rest)
             | ("trace-profile", "off"::rest) =>
                 (info ["Interception disabled."];
		  (case context_opts of
		     {generate_interceptable_code, ...} =>
		       generate_interceptable_code := false);
		  aux rest)
             | ("mips-r4000-and-later", "on"::rest) =>
                 (info ["Compiling for MIPS R4000 and later"];
		  (#mips_r4000 context_opts) := true;
                  aux rest)
             | ("mips-r4000-and-later", "off"::rest) =>
                 (info ["Not compiling for MIPS R4000 and later"];
		  (#mips_r4000 context_opts) := false;
                  aux rest)
             | ("sparc-v7", "on"::rest) =>
                 (info ["Compiling for SPARC Version 7"];
		  (#sparc_v7 context_opts) := true;
                  aux rest)
             | ("sparc-v7", "off"::rest) =>
                 (info ["Not compiling for SPARC Version 7"];
		  (#sparc_v7 context_opts) := false;
                  aux rest)
	     | ("absyn", "on" :: rest) =>
                 (info ["abstract syntax tree printing enabled."];
		  (case tool_opts of
		     {show_absyn, ...} =>
		       show_absyn := true);
		  aux rest)
	     | ("absyn", "off" :: rest) =>
                 (info ["abstract syntax tree printing disabled."];
		  (case tool_opts of
		     {show_absyn, ...} =>
		       show_absyn := false);
		  aux rest)
	     | ("lambda", "on" :: rest) =>
                 (info ["lambda calculus printing enabled."];
		  (case tool_opts of
		     {show_lambda, ...} =>
		       show_lambda := true);
		  aux rest)
	     | ("lambda", "off" :: rest) =>
                 (info ["lambda calculus printing disabled."];
		  (case tool_opts of
		     {show_lambda, ...} =>
		       show_lambda := false);
		  aux rest)
	     | ("opt-lambda", "on" :: rest) =>
                 (info ["optimised lambda calculus printing enabled."];
		  (case tool_opts of
		     {show_opt_lambda, ...} =>
		       show_opt_lambda := true);
		  aux rest)
	     | ("opt-lambda", "off" :: rest) =>
                 (info ["optimised lambda calculus  printing disabled."];
		  (case tool_opts of
		     {show_opt_lambda, ...} =>
		       show_opt_lambda := false);
		  aux rest)
	     | ("environ", "on" :: rest) =>
                 (info ["lambda calculus environment printing enabled."];
		  (case tool_opts of
		     {show_environ, ...} =>
		       show_environ := true);
		  aux rest)
	     | ("environ", "off" :: rest) =>
                 (info ["lambda calculus environment printing disabled."];
		  (case tool_opts of
		     {show_environ, ...} =>
		       show_environ := false);
		  aux rest)
	     | ("mir", "on" :: rest) =>
                 (info ["machine independent representation printing enabled."];
		  (case tool_opts of
		     {show_mir, ...} =>
		       show_mir := true);
		  aux rest)
	     | ("mir", "off" :: rest) =>
                 (info ["machine independent representation printing disabled."];
		  (case tool_opts of
		     {show_mir, ...} =>
		       show_mir := false);
		  aux rest)
	     | ("opt-mir", "on" :: rest) =>
                 (info ["optimised machine independent representation printing enabled."];
		  (case tool_opts of
		     {show_opt_mir, ...} =>
		       show_opt_mir := true);
		  aux rest)
	     | ("opt-mir", "off" :: rest) =>
                 (info ["optimised machine independent representation printing disabled."];
		  (case tool_opts of
		     {show_opt_mir, ...} =>
		       show_opt_mir := false);
		  aux rest)
	     | ("machine", "on" :: rest) =>
                 (info ["machine code printing enabled."];
		  (case tool_opts of
		     {show_mach, ...} =>
		       show_mach := true);
		  aux rest)
	     | ("machine", "off" :: rest) =>
                 (info ["machine code printing disabled."];
		  (case tool_opts of
		     {show_mach, ...} =>
		       show_mach := false);
		  aux rest)
	     | ("old-definition", "on" :: rest) =>
		 (info ["Use semantics of old version of SML"];
		  (case context_opts of
		     {old_definition, ...} =>
		       old_definition := true);
		  aux rest)
	     | ("old-definition", "off" :: rest) =>
		 (info ["Use semantics of new version of SML"];
		  (case context_opts of
		     {old_definition, ...} =>
		       old_definition := false);
		  aux rest)
	     | ("nj-sig", "on" :: rest) =>
		 (info ["New Jersey signatures enabled."];
		  (case context_opts of
		     {nj_signatures, ...} =>
		       nj_signatures := true);
		  aux rest)
	     | ("nj-sig", "off" :: rest) =>
		 (info ["New Jersey signatures disabled."];
		  (case context_opts of
		     {nj_signatures, ...} =>
		       nj_signatures := false);
		  aux rest)
	     | ("project", file :: rest) =>
		 (info ["Reading Project file `", file, "'."];
		  ProjFile.open_proj file
                    handle ProjFile.InvalidProjectFile reason =>
  		      raise Error
		        ["Unable to read project file: ", reason, "."];
		  project := true;
		  aux rest)
	     | ("build", rest) =>
           	 (compiler := PROJECT TopLevel.build;
                  info ["Building project."];
                  aux rest)
	     | ("show-build", rest) =>
           	 (compiler := PROJECT TopLevel.show_build;
                  info ["Showing files to build project."];
                  aux rest)
	     | ("configuration", config :: rest) =>
		 (if !project then
           	    ProjFile.setCurrentConfiguration
		      (Info.make_default_options (),
		       Info.Location.FILE "<batch compiler:options>")
		      (SOME config)
		  else
		    raise Error
		      ["Configuration ", config,
		       " not set: no project specified."];
                  info ["Setting configuration to ", config, "."];
                  aux rest)
	     | ("mode", mode :: rest) =>
		 (if !project then
           	    (ProjFile.setCurrentMode
		       (Info.make_default_options (),
		        Info.Location.FILE "<batch compiler:options>")
		       mode;
		     updateContextOptionsFromProjFile (context_options))  
		  else
		    raise Error
		      ["Mode ", mode, " not set: no project specified."];
                  info ["Setting mode to ", mode, "."];
                  aux rest)
	     | ("target", target :: rest) =>
		 (if !project then
		    targets := target :: !targets
		  else
		    raise Error
		      ["Target ", target, " not set: no project specified."];
                  info ["Adding ", target, " to list of targets."];
                  aux rest)
             | ("compile-file", rest) =>
                 (compiler := BATCH TopLevel.compile_file;
                  info ["Compile single files mode."];
                  aux rest)
             | ("check-dependencies", rest) =>
           	 (compiler := BATCH TopLevel.check_dependencies;
                  info ["Checking dependencies."];
                  aux rest)
             | ("list-objects", rest) =>
           	 (compiler := BATCH TopLevel.list_objects;
                  info ["Listing object files."];
                  aux rest)
             | ("dump-objects", filename::rest) =>
                 (dump_objects_filename := SOME filename;
                  aux rest)
             | ("compile", rest) =>
           	 (compiler := BATCH TopLevel.recompile_file;
		  info ["Compile mode."];
                  aux rest)
             | ("compile-pervasive", rest) =>
                 (info ["Compiling pervasive library"];
                  TopLevel.recompile_pervasive
		    (Info.make_default_options ())
		    (User_Options.new_options (tool_options, context_options));
                  aux rest)
	   (* Nothing needs to be done for -no-banner as it was processed separately, 
	    * and earlier, but needs to be included as it is a valid option. *)
	     | ("no-banner", rest) =>
		  aux rest
             | ("save", filename::rest) =>
                 (info ["Saving image to `", filename, "'."];
		  ignore(MLWorks.Internal.save
		    (filename, fn () =>
				let
				  val x = obey(MLWorks.arguments())
				in
				  Exit.exit x
				end));
		  aux rest)
             | (other, rest) =>
                 raise Option other)
        end
    in
      aux args
    end

    and obey (args : string list) : Exit.status =
      (if not (arg_exists("no-banner", args)) then
	 info [Version.versionString ()]
       else
	 ();
       Io.set_pervasive_dir_from_env (Info.Location.FILE "<Initialisation>");
       let
	 val default_batch_options =
	   Options.OPTIONS
	    {listing_options = Options.LISTINGOPTIONS {show_absyn = false,
						       show_lambda = false,
						       show_match = false,
						       show_opt_lambda = false,
						       show_environ = false,
						       show_mir = false,
						       show_opt_mir = false,
						       show_mach = false
						       },
	    compiler_options = Options.COMPILEROPTIONS {generate_debug_info = false,
                                                        debug_variables = false,
                                                        generate_moduler = false,
                                                        intercept = false,
							interrupt = false,
							opt_handlers = false,
							opt_leaf_fns = true,
							opt_tail_calls = true,
							opt_self_calls = true,
							local_functions = true,
							print_messages = true,
                                                        mips_r4000 = true,
                                                        sparc_v7 = false},
	    print_options = Options.PRINTOPTIONS {maximum_seq_size = 10,
						  maximum_string_size = 255,
						  maximum_ref_depth = 3,
						  maximum_str_depth = 2,
						  maximum_sig_depth = 1,
						  maximum_depth = 7,
						  float_precision = 10,
						  print_fn_details = false,
						  print_exn_details = true,
						  show_eq_info = false,
						  show_id_class = false},
	    compat_options = Options.default_compat_options,
	    extension_options = Options.default_extension_options}

	 val tool_options =
	   User_Options.make_user_tool_options
	     default_batch_options

	 val context_options =
	   User_Options.make_user_context_options
	     default_batch_options

	 (*
	 (* Turn on optimisation of handlers by default *)
	 val _ = case context_options of
	   User_Options.USER_CONTEXT_OPTIONS({optimize_handlers, ...}, _) =>
	     optimize_handlers := true
	 *)

	 val (tool_options, context_options, files, compiler, targets) =
	   obey_options (tool_options, context_options, args)

	 val _ =
           if targets <> [] then
	     (out "Setting targets: ";
              case targets of
                [target] => out (target ^ "\n")
              | targets => 
                  (out "\n"; app (fn s => (out ("  " ^ s ^ "\n"))) targets);
	      ProjFile.setCurrentTargets
	        (Info.make_default_options (),
	         Info.Location.FILE "<batch compiler:options>")
	        targets)
           else
	     ()

	 val new_options =
	   User_Options.new_options (tool_options, context_options)
       in
        case files
	 of [] =>
	   (case compiler 
	    of PROJECT f =>
	      f (Info.make_default_options ()) new_options ()
	    |  BATCH _ =>
	      info ["No files to compile"]
	    |  _ => ())
	 | _ => 
	   (case compiler 
	    of BATCH f =>
	      f (Info.make_default_options ()) new_options files
	    |  _ =>
	      info ["Excess arguments ignored"]);

        case !dump_objects_filename
         of NONE => ()
          | SOME filename =>
              if !project 
              then
                ( info ["Dumping dependency list to `", filename, "'."];
           	  TopLevel.dump_objects (Info.make_default_options ()) 
                                        new_options filename )
              else
		raise Error ["No project specified."];

         Exit.success
       end)
     handle Option s=>
       (out ("Unknown, or bad usage of, option '" ^ s ^ "'\n");
	usage ();
	Exit.badUsage)
          | MLWorks.Internal.Save message =>
	      (out (message ^ "\n");
	       Exit.save)
	  | Encapsulate.BadInput s =>
	      (out (s ^ "\n");
	       Exit.badInput)
	  | exn as IO.Io _ =>
	      (out ("Uncaught exception " ^ exnMessage exn ^ "\n");
               Exit.uncaughtIOException)
          | OS.SysErr (s,err) =>
              let
(*
                val s' =
                  case err of
                    SOME e => OS.errorMsg e
                  | _ => ""
*)
              in
                out ("System error: " ^ s ^ (* ":" ^ s' ^ *) "\n");
                Exit.failure
              end
          | Error s =>
              (app out s;
	       out "\n";
               Exit.failure)
          | Info.Stop _ => Exit.stop
  end
