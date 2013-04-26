(* _toplevel.sml the functor *)
(*
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: _toplevel.sml,v $
 * Revision 1.262  1999/03/23 17:37:54  mitchell
 * [Bug #190532]
 * Ensure update_dependencies is called on subprojects first
 *
 * Revision 1.261  1999/03/18  08:53:40  mitchell
 * [Bug #190532]
 * Build subprojects before building project
 *
 * Revision 1.260  1999/02/12  12:03:33  mitchell
 * [Bug #190505]
 * Suppress precompiling messages for pervasives
 *
 * Revision 1.259  1999/02/10  12:37:01  mitchell
 * [Bug #190505]
 * Don't precompile the pervasives when compiling the pervasives...
 *
 * Revision 1.258  1999/02/09  10:28:40  mitchell
 * [Bug #190505]
 * Support for precompilation of subprojects
 *
 * Revision 1.257  1999/02/05  14:15:40  mitchell
 * [Bug #190502]
 * Disable generation of .S files
 *
 * Revision 1.256  1999/02/05  11:56:19  mitchell
 * [Bug #190504]
 * Add ability to dump units in dependency order
 *
 * Revision 1.255  1999/02/03  15:20:28  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.254  1998/10/22  16:07:47  jont
 * [Bug #70194]
 * Generate object output direct from .mo files
 *
 * Revision 1.253  1998/10/22  13:06:53  jont
 * [Bug #70218]
 * Modified interface to output_object_code.
 * Also moving this to after output of mo, so that later it can use that instead
 * of direct compiler output. This will allow testing on .o from .mo stuff
 *
 * Revision 1.252  1998/06/24  10:54:02  jont
 * [Bug #70133]
 * Add COFF outputter
 *
 * Revision 1.251  1998/04/24  16:07:57  jont
 * [Bug #70109]
 * Making printing of compiling messages dependent
 * on the print_messages field of options
 *
 * Revision 1.250  1998/04/24  15:31:24  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.249  1998/04/22  15:59:42  jont
 * [Bug #70099]
 * Modify following changes to encapsulation order
 *
 * Revision 1.248  1998/04/02  12:50:17  jont
 * [Bug #30312]
 * Replacing OS.FileSys.modTime with system dependent version to sort out
 * MS time stamp problems.
 *
 * Revision 1.247  1998/02/19  17:16:20  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.246  1998/02/06  11:26:08  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 * Added a call to Project.pervasiveObjectName from do_input.
 *
 * Revision 1.245  1998/01/30  17:52:34  jont
 * [Bug #70051]
 * Modify to detect missing pervasive objects without giving compiler fault
 *
 * Revision 1.244  1997/11/25  10:27:18  jont
 * [Bug #30328]
 * Add environment parameter to decode_type_basis
 * for finding pervasive type names
 *
 * Revision 1.243  1997/11/13  11:19:16  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.242  1997/10/20  20:24:49  jont
 * [Bug #30089]
 * Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 * Revision 1.241  1997/10/08  17:45:58  daveb
 * [Bug #20090]
 * Changed consistency info in object files to store the modification times
 * of the corresponding source files.
 *
 * Revision 1.240.2.7  1997/12/03  19:30:48  daveb
 * [Bug #30071]
 * Project.fromFileInfo now takes a project argument.
 *
 * Revision 1.240.2.6  1997/11/26  16:34:12  daveb
 * [Bug #30071]
 *
 * Revision 1.240.2.5  1997/11/20  17:12:21  daveb
 * [Bug #30326]
 *
 * Revision 1.240.2.4  1997/10/29  14:00:00  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 *
 * Revision 1.240.2.3  1997/10/29  11:53:47  daveb
 * [Bug #20090]
 * Changed consistency info in object files to store the modification times
 * of the corresponding source files.
 *
 * Revision 1.240.2.2  1997/09/17  15:57:32  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.240.2.1  1997/09/11  20:56:53  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.240  1997/05/27  15:50:31  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.239  1997/05/27  12:24:22  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.238  1997/05/12  16:09:56  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.237  1997/05/02  16:41:29  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.236  1997/04/10  16:49:24  jont
 * [Bug #1984]
 * Tidy up the unknown locations when giving No such file errors.
 *
 * Revision 1.235  1997/03/25  11:44:35  matthew
 * Renamed R4000 option
 *
 * Revision 1.234  1997/03/21  11:33:05  johnh
 * [Bug #1965]
 * Handling Io.NotSet for objectName.
 *
 * Revision 1.233  1997/02/12  13:22:33  daveb
 * Review edit <URI:spring://ML_Notebook/Review/basics/*module.sml>
 * -- Changed name and type of Module.mo_name.
 *
 * Revision 1.232  1997/01/21  11:03:38  matthew
 * Adding architecture specific options
 *
 * Revision 1.231  1997/01/02  15:24:10  matthew
 * Changes to lambda code
 *
 * Revision 1.230  1996/11/06  11:29:12  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.229  1996/10/29  16:12:18  io
 * moving String from toplevel
 *
 * Revision 1.228  1996/10/04  13:05:16  matthew
 * Remove LambdaSub
 *
 * Revision 1.227  1996/09/04  11:26:45  daveb
 * [Bug #1584]
 * Removed mention of object path from error message.
 *
 * Revision 1.226  1996/08/06  14:21:39  andreww
 * [Bug #1521]
 * propagating changes made to typechecker/_types.sml
 * (pass options rather than print_options)
 *
 * Revision 1.225  1996/07/30  10:57:46  daveb
 * Corrected mistake in check_dependencies.
 *
 * Revision 1.224  1996/07/18  17:20:04  jont
 * Add option to turn on/off compilation messages from intermake
 *
 * Revision 1.223  1996/05/30  12:50:18  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.222  1996/04/30  17:23:25  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.221  1996/04/29  15:00:26  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.220  1996/04/02  11:17:59  daveb
 * Changed Project.load_dependencies to Project.read_dependencies.
 *
 * Revision 1.219  1996/03/27  10:58:03  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.218  1996/03/25  15:32:13  daveb
 * Added handlers for Module.BadHomeName.
 * Replaced explicit setting of source path with new version of
 * Module.with_source_path.
 *
 * Revision 1.217  1996/03/15  17:01:19  daveb
 * Module.mo_name now takes an Info.options argument.
 *
 * Revision 1.216  1996/03/15  14:36:11  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.215  1996/03/06  13:14:45  daveb
 * Types of Project object info and Encapsulate.input_all have changed.
 *
 * Revision 1.214  1996/02/22  14:12:40  jont
 * Replacing Map with NewMap
 *
 * Revision 1.213  1996/02/09  15:02:26  daveb
 * Added a handler for the case when the encapsulator is given a bad file name.
 *
Revision 1.212  1995/12/12  11:31:56  daveb
Changed wording of warning message.

Revision 1.211  1995/12/05  11:31:00  daveb
Modified type of compile_file' to support Project Tool.

Revision 1.210  1995/10/25  17:58:56  jont
Adding opt_handlers compiler option

Revision 1.209  1995/09/11  10:57:59  daveb
The Type of LambdaTypes.SCON has changed.

Revision 1.208  1995/09/05  15:59:35  jont
Add sml_cache to interface for compile_file' to improve finding
of .mo files

Revision 1.207  1995/08/01  14:25:35  matthew
Adding environment simplication function

Revision 1.206  1995/05/31  10:05:32  matthew
Added debugging flag to mir optimiser

Revision 1.205  1995/05/02  12:07:08  matthew
Removing debug_polyvariables option

Revision 1.204  1995/04/28  15:43:35  jont
Module naming improvements

Revision 1.203  1995/04/21  13:58:14  jont
Eliminate use of require_list
Replaced with an integer option, and removed as a parameter to do_subrequires

Revision 1.202  1995/04/20  14:09:10  jont
Ensure proper module names used in the require lists

Revision 1.201  1995/04/05  14:45:57  matthew
Combining stamp counts in one.
Other simplifications -- removed minor timings and test_string
Argument to mod_rules that describes if we are in separate compilation

Revision 1.200  1995/03/02  12:58:23  matthew
Changes to Debugger_Types

Revision 1.199  1995/02/17  14:53:45  daveb
Added diagnostic when extending the source path.

Revision 1.198  1995/02/07  12:56:59  matthew
Moving pervasive counts to Basis

Revision 1.197  1995/01/17  16:15:30  daveb
Replaced Option structure with references to MLWorks.Option.
Removed obsolete sharing constraint.

Revision 1.196  1994/12/08  17:30:53  jont
Move OS specific stuff into a system link directory

Revision 1.195  1994/10/13  11:25:51  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.194  1994/10/10  10:28:43  matthew
Improved module caching
Lambdatypes changes.

Revision 1.193  1994/09/19  13:56:59  matthew
Changes to lambdatypes

Revision 1.192  1994/07/29  17:31:23  daveb
Moved preferences into a separate structure.

Revision 1.191  1994/07/19  16:02:33  matthew
Functions take a list of parameters

Revision 1.190  1994/04/07  16:38:01  jont
Add original require file names to consistency info.

Revision 1.189  1994/03/21  15:16:38  daveb
added compile_module.

Revision 1.188  1994/03/16  13:00:42  matthew
Changed name of pervasive stream to <Pervasive> (helps with debug info)

Revision 1.187  1994/03/15  17:28:36  matthew
Use the full filename for the location in token stream rather than module id.
This is to allow the error file finding mechanism to work

Revision 1.186  1994/02/28  08:21:10  nosa
Step and Modules Debugger compiler options.

Revision 1.185  1994/02/25  12:37:25  daveb
Removed redundant code.

Revision 1.184  1994/02/16  16:42:31  jont
Fixed so that even empty files produce non-empty require_lists

Revision 1.183  1994/02/08  14:52:17  daveb
Module.module_and_path is now Module.find_file, is functional, and is
called on all arguments to compile_file before any compilation is done.

Revision 1.182  1994/02/01  16:14:57  daveb
Module names have been moved from FileName to Module.

Revision 1.181  1994/01/18  16:06:02  matthew
Undid previous undo.

Revision 1.180  1994/01/13  13:05:55  matthew
Use short module name after all.
Otherwise decapsulation breaks

Revision 1.179  1994/01/11  17:00:37  matthew
Put longer module identifier in mo dependencies.

Revision 1.178  1994/01/10  15:17:39  matthew
Added range information for tyname_id's etc.

Revision 1.177  1993/12/17  17:24:28  io
Moved some sigs from machine/ to main/

Revision 1.176  1993/12/15  13:53:39  matthew
Renamed Encapsulate.Basistypes to Encapsulate.BasisTypes

Revision 1.175  1993/11/15  14:17:31  nickh
New pervasive Time structure.

Revision 1.174  1993/11/05  09:57:58  jont
Added interrupt option

Revision 1.173  1993/09/27  14:57:33  jont
Merging in bug fixes

Revision 1.172  1993/09/17  14:02:30  nosa
FNs now passed closed-over type variables and
stack frame-offset for runtime-instance for polymorphic debugger;
change also to Debugger_Types.INFO.

Revision 1.170.1.3  1993/09/27  11:22:14  jont
Changed to returned pervasive_mo cache and to use it.

Revision 1.171  1993/09/15  18:48:38  jont
Merged in bug fixes

Revision 1.170.1.2  1993/09/15  15:49:00  jont
Fixed problem whereby require_table and require_list did not consist of full
module names, and hence multiple versions of modules could arise

Revision 1.170.1.1  1993/08/28  16:44:19  jont
Fork for bug fixing

Revision 1.170  1993/08/28  16:44:19  daveb
Changed find_object and compile_file' to take a filename cache.
Changed type of compile_file to take a list of strings, so that caches can
be preserved between each compilation (I haven't implemented this yet).

Revision 1.169  1993/08/26  18:59:00  daveb
Improved searching for mos.

Revision 1.168  1993/08/26  12:55:27  richard
Changed the require syntax back to old style so that NJ can cope.

Revision 1.167  1993/08/25  13:12:13  daveb
Io.get_pervasive_dir can raise Io.NotSet.

Revision 1.166  1993/08/24  15:23:58  daveb
ModuleId.from_string now takes a location argument.

Revision 1.165  1993/08/23  15:17:12  richard
Added code to output the optimised lambda code into a file called
test.lam if the output_lambda option is enabled.  This is for use
in the COMPARE project.

Revision 1.164  1993/08/19  14:35:28  daveb
Made compiler always announce the start of a new compilation.

Revision 1.163  1993/08/17  16:34:07  daveb
Major changes to support ModuleIds and search path.

Revision 1.162  1993/08/12  14:08:09  jont
Changed the way pervasive require is done to use new multiple unget
in lexer. Much simpler code as a result.

Revision 1.161  1993/08/03  16:42:19  jont
Modified to disallow requires after non-require topdecs. Some modifications to ensure
rigid tynames and strnames are consistent if a file is required and subrequired

Revision 1.160  1993/07/15  15:50:36  nosa
Debugger Environments for local and closure variable inspection
in the debugger;
structure Option.

Revision 1.159  1993/07/12  10:55:27  daveb
Augmented type basis before passing it to trans_topdec.

Revision 1.158  1993/06/30  13:21:18  daveb
Now passes type basis to trans_topdec.
Removed show_match and generate_debug_inhibit_warnings.

Revision 1.157  1993/06/02  17:40:47  jont
Changed to use new mod_rules interface. All unnecessary
assembly calculations removed

Revision 1.156  1993/05/28  13:31:10  jont
Cleaned up after assembly changes

Revision 1.155  1993/05/28  10:35:42  matthew
 Changed Info.wrap
Put filename rather than module name into tokenstream and thence
into locations.

Revision 1.154  1993/05/27  12:45:32  jont
Stopped encapsulating and decapsulating assemblies

Revision 1.153  1993/05/25  16:02:08  jont
Changes because Assemblies now has BasisTypes instead of Datatypes

Revision 1.152  1993/05/18  17:01:55  jont
Removed integer parameter

Revision 1.151  1993/05/11  17:25:14  jont
Fixed bug whereby counters were pushed after resetting them, instead of before

Revision 1.150  1993/05/11  12:49:27  jont
Changes to lambda optimiser to allow removal of inlining for tracing

Revision 1.149  1993/04/22  15:24:14  jont
Added pop_counters to normal exit for compilation

Revision 1.148  1993/04/21  13:12:32  jont
Removed the Lists.exists test in favour of a map for subrequired files

Revision 1.147  1993/04/14  15:57:08  matthew
Changed some print_timings to print_minor_timings and defaulted
print_minor_timings to false.

Revision 1.146  1993/04/13  15:13:22  matthew
Exposed lambda optimisation switches

Revision 1.145  1993/04/06  15:45:17  jont
Made separate compilation push and pop the relevant counters from simple types
round the compilation, thus not affecting the interpreter

Revision 1.144  1993/03/12  11:58:09  matthew
Options changes
Signature revisions

Revision 1.143  1993/03/09  12:57:29  matthew
Options & Info changes

Revision 1.142  1993/02/09  09:49:00  matthew
Typechecker structure changes

Revision 1.141  1993/02/04  16:23:52  matthew
Changed sharing.

Revision 1.140  1993/01/28  09:52:22  jont
Changed explicit definition of default compiler options to refer to new one
in MirTypes

Revision 1.139  1993/01/05  18:18:23  jont
Modified to use Info.listing_fn for code printing etc

Revision 1.138  1992/12/17  10:40:15  clive
Changed debug info to have only module name - needed to pass module table through to window stuff

Revision 1.137  1992/12/08  20:21:14  jont
Removed a number of duplicated signatures and structures

Revision 1.136  1992/12/08  14:06:29  clive
Set the initial start up flags to compile small code at maximum speed

Revision 1.135  1992/12/08  13:41:44  daveb
Options weren't being passed by error_wrap; now they are.

Revision 1.134  1992/12/02  15:57:18  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.133  1992/12/02  14:05:47  jont
Modified to remove redundant info signatures

Revision 1.132  1992/11/27  15:42:02  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.131  1992/11/25  17:30:47  matthew
Changed error messages

Revision 1.130  1992/11/19  19:17:44  jont
Removed Info structure from parser, tidied upderived

Revision 1.129  1992/11/18  11:51:50  matthew
Changed Error structure to Info

Revision 1.128  1992/11/07  15:40:00  richard
Changed the pervasives and representation of time.
Added a cache on the results of Encapsulate.input_info.
Changed format of consistency info.

Revision 1.127  1992/11/04  16:39:59  jont
Removed for the second time a sharing constraint on NewMap

Revision 1.126  1992/11/03  12:29:09  daveb
Setting show_mir (etc.) now produces output without the need to call
Diagnostic.set 2.

Revision 1.124  1992/10/27  17:11:42  jont
Removed Error from toplevel signature

Revision 1.123  1992/10/15  16:11:23  clive
Anel's changes for encapsulating assemblies

Revision 1.122  1992/10/14  12:06:31  richard
Added line number to token stream input functions.
Added location information to the `require' topdec.

Revision 1.121  1992/10/12  12:00:53  clive
Tynames now have a slot recording their definition point

Revision 1.120  1992/10/01  13:56:35  richard
Moved lambda module code and strname reducing code elsewhere so that
they can be shared with the incremental compiler.  Also makes things
tidier, imho.

Revision 1.119  1992/09/24  06:21:11  richard
Added sharing contraint on Error to signature.

Revision 1.118  1992/09/23  16:43:48  jont
Removed add_fn_names (obsolete)

Revision 1.117  1992/09/21  18:16:06  jont
Turned off default printing of lambda code and environment

Revision 1.116  1992/09/16  08:45:36  daveb
show_eq_info controls printing of equality attribute of tycons.
show_id_class controls printing of id classes (VAR, CON or EXCON).

Revision 1.115  1992/09/15  12:30:57  jont
Minor improvements in handling requires, mainly removing some from_lists
Removed valenvs from METATYNAMEs where there is a further tyname below

Revision 1.114  1992/09/10  10:35:09  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.
Added `augment'.

Revision 1.113  1992/09/09  10:04:28  clive
Added flag to switch off warning messages in generating recipes

Revision 1.112  1992/09/08  11:55:34  richard
Changed error wrapper to cope with new ERROR signature.
Added missing wrappers in compile_ts.

Revision 1.111  1992/09/07  10:26:44  jont
Added reduction of meta typenames and tyfuns to reduce chain length
after sharing/instantiation

Revision 1.110  1992/09/04  13:25:59  richard
Moved the special names out of the compiler as a whole.
Installed central error reporting mechanism.

Revision 1.109  1992/09/01  16:44:33  clive
Switches for self_calling and fix to binding the compilation unit list result

Revision 1.108  1992/08/26  17:19:05  jont
Removed some redundant structures and sharing

Revision 1.107  1992/08/26  09:12:49  clive
Propogation of information about exceptions

Revision 1.106  1992/08/25  19:01:47  davidt
Added Timer.xtime call for Encapsulate.input_all.

Revision 1.105  1992/08/25  16:19:59  richard
Added bytearray and bits to pervasive modules.

Revision 1.104  1992/08/25  13:32:03  clive
Added details about leafness to the debug information

Revision 1.103  1992/08/20  18:00:17  davidt
Made changes to allow mo files to be copied.

Revision 1.102  1992/08/19  14:02:54  davidt
Changed printing of user-level errors so that it prints
'***' at the start of the line, to help find errors
amongst timing info.

Revision 1.101  1992/08/18  15:00:55  davidt
Took out an extra print statement. Now gets input in bigger
chunks using input instead of input_line.

Revision 1.100  1992/08/17  11:31:07  davidt
Changed to use MLWorks.IO.input_line

Revision 1.99  1992/08/14  16:44:37  davidt
Changed to use new Encapsulate interface.

Revision 1.98  1992/08/12  13:28:21  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.97  1992/08/10  17:28:02  davidt
Changed MLworks to MLWorks.

Revision 1.96  1992/08/10  12:00:15  davidt
Encapsulate.output_file now does everything, instead of
TopLevel calling a number of different Encapsulate
files. Changed list of pervasive files.

Revision 1.92  1992/08/05  18:25:25  jont
Added strnasme contraction to reduce the number of refs traversed
in type checking and sharing. Fixed up a naff sharing constraint

Revision 1.91  1992/07/23  12:45:11  clive
Use of new hash tables, removed some concatenation and compression of integers in encapsulator

Revision 1.90  1992/07/23  08:06:29  clive
Equality type problem in info = []

Revision 1.89  1992/07/22  16:09:52  jont
Added return of abstract syntax tree to compile_ts

Revision 1.88  1992/07/22  15:35:17  jont
Moved all file manipulation into Io

Revision 1.87  1992/07/21  18:40:55  jont
Modifications to allow less string concatenation and copying

Revision 1.86  1992/07/14  16:17:25  richard
Removed obsolete memory profiling code.

Revision 1.85  1992/07/08  15:34:21  clive
Added call point information recording

Revision 1.84  1992/07/03  13:43:21  davida
Added LET constructor and new slot to APP.

Revision 1.83  1992/06/18  14:50:05  jont
Modified spec of compile_ts to return lambda expression

Revision 1.82  1992/06/18  09:47:51  davida
Added switch to allow compilation to stop at
lambda, and also display of size of lambda expr.

Revision 1.81  1992/06/16  11:23:22  davida
Changed to use (much) faster Lambda Print,
added margin ref.

Revision 1.80  1992/06/15  15:26:59  jont
Coded main section of compile_ts for interpreter

Revision 1.79  1992/06/12  19:14:52  jont
Added functions to do compiling and return results

Revision 1.78  1992/06/11  14:59:49  clive
Added flags for the recording of debug type information

Revision 1.77  1992/06/10  17:54:59  jont
changed to produce lists as compilation units instead of tuples
changed to use newmap

Revision 1.76  1992/05/19  10:25:23  jont
Changed Mach_Cg_ to Mach_Cg

Revision 1.75  1992/05/14  14:24:53  clive
Added memory profiling flag

Revision 1.74  1992/05/13  16:51:59  jont
Removed a redundant augment_cb from the compilation process

Revision 1.73  1992/05/13  11:01:43  jont
Modified for two integer time stamps

Revision 1.72  1992/05/08  11:48:18  jont
Added timing for entire encapsulation process

Revision 1.71  1992/05/06  12:10:01  jont
Added do_check_bindings bool ref to control the checking of uniqueness
of bound lambda variable names. Default off

Revision 1.70  1992/04/23  19:03:09  jont
Removed reference to pervasive flush_out. Added an input_line function

Revision 1.69  1992/04/23  10:30:21  jont
Expanded some of the decoding messages to give more info

Revision 1.68  1992/04/13  15:31:23  clive
First version of the profiler

Revision 1.67  1992/03/27  12:49:21  jont
*** empty log message ***

Revision 1.66  1992/03/25  15:19:12  matthew
Slight change to parsing error message

Revision 1.65  1992/03/18  14:48:51  jont
Changed an instance of LambdaTypes_ to LambdaTypes

Revision 1.64  1992/03/17  18:43:46  jont
Added bool ref for add_fn_names to control addition of function names

Revision 1.63  1992/03/13  14:15:23  jont
Fixed problem whereby tyname_count, strname_count, tyfun_count overflowed

Revision 1.62  1992/03/04  23:06:08  jont
Added some functions to check lambda calculus consistency

Revision 1.61  1992/02/20  12:31:24  jont
Added show_match to control printing of match trees

Revision 1.60  1992/02/18  09:01:10  clive
Rewrote end_is function in terms of functions already defined

Revision 1.59  1992/02/14  16:07:40  richard
Changes to reflect changes in MirOptimiser signature.

Revision 1.58  1992/02/14  12:37:17  clive
root_name applied to pervasive_library_path before requiring it

Revision 1.57  1992/02/14  09:44:34  clive
Needed an extra newline in one of the print statements

Revision 1.56  1992/02/13  15:43:39  clive
New pervasive library code

Revision 1.55  1992/02/07  13:11:48  richard
Changed Table to Map to reflect changes in MirRegisters.

Revision 1.54  1992/02/04  19:20:16  jont
Removed sharing constraint on Parser.Ident (no longer there)

Revision 1.53  1992/01/31  12:59:33  clive
Nextened the printing

Revision 1.52  1992/01/31  12:33:05  clive
Added timing to the various sections

Revision 1.51  1992/01/28  19:09:46  jont
Added option not to do lambda optimisation

Revision 1.50  1992/01/24  11:14:11  jont
Modified to deal with absolute pathnames in requires

Revision 1.49  1992/01/23  16:52:15  jont
Changed to encode tyfun_ids similarly to tyname_ids

Revision 1.48  1992/01/22  18:53:30  jont
Moved info about reset of tyname and strname counters to level 3

Revision 1.47  1992/01/15  13:43:10  jont
Added call to clean_basis to remove old encodings of pervasives

Revision 1.46  1992/01/10  19:21:30  jont
Added various diagnostics

Revision 1.45  1992/01/08  20:14:37  colin
added call to reset_assemblies before each compilation.

Revision 1.44  1992/01/08  16:36:19  colin
Added code to maintain unique tyname and strname_ids across modules.

Revision 1.43  1992/01/06  19:32:28  jont
Added recursive loading of typechecker bases for requires

Revision 1.42  1992/01/06  13:21:35  jont
Changed to use new binding type

Revision 1.41  1991/12/23  17:33:43  jont
Fixed bug whereby the wrong object file name was being used

Revision 1.40  91/12/23  16:14:41  jont
Added file time stamp checking

Revision 1.39  91/12/20  17:35:52  jont
Added separation of required environments from generated ones. This may
need further thought.

Revision 1.38  91/12/20  01:29:59  jont
Added full parsing and handling of require topdecs, including
rebuilding the environments and making the new bindings

Revision 1.37  91/12/19  18:14:59  jont
Added environment and consistency info reading and writing, and
handling of require topdec s

Revision 1.36  91/12/18  19:50:52  jont
Added output of encoded typechecker basis and rereading

Revision 1.35  91/12/17  16:54:19  jont
Added writing of parser env to output file, and rereading it.

Revision 1.34  91/12/16  15:48:10  jont
Added some progress messages

Revision 1.33  91/12/10  14:51:45  jont
Added output of environment

Revision 1.32  91/11/18  11:37:34  richard
Added some newline characters that were bugging me by their absence.

Revision 1.31  91/11/14  10:57:27  richard
Removed references to fp_doubles.

Revision 1.30  91/11/08  17:51:11  jont
Added show_mach to refer to corresponding item in mach_cg, so we can off
opcode listings

Revision 1.29  91/11/08  17:00:50  jont
Added production of output file names for compile function,
so <name>.sml -> <name>.mo

Revision 1.28  91/10/28  16:21:28  davidt
Changed lots of pervasive prints to Print.print.

Revision 1.27  91/10/23  13:18:31  davidt
Stopped default printing out of mir code (it took too long).
Fixed an non-exhaustive binding using a Crash.impossible.

Revision 1.26  91/10/22  17:22:29  davidt
Removed exception handlers (impossible exception has been replaced
by calls to Crash.impossible).

Revision 1.25  91/10/16  11:22:08  jont
Added calls to encapsulate and output the code

Revision 1.24  91/10/15  14:47:14  richard
Changed the way Mach_Cg is called because the register assignment
tables have moved.

Revision 1.23  91/10/10  10:20:13  jont
Made all code generation take place at all times

Revision 1.22  91/10/08  17:43:44  jont
Added call to Mach_Cg.mach_cg

Revision 1.21  91/10/03  09:48:49  jont
Added machine dependent code generator

Revision 1.21  91/10/03  09:48:49  jont
Temporary checkin.

Revision 1.20  91/10/03  08:57:04  jont
Added show_mach

Revision 1.19  91/09/16  11:37:25  davida
Added show_lambda, show_opt_lambda, show_environ
switches.

Revision 1.18  91/09/10  13:19:29  davida
Added printing of optimised lambda-code, as
the lambda-optimiser no longer prints it by default...

Revision 1.17  91/09/04  17:14:18  jont
Added show_opt_mir to control production and printing of optimised
intermediate code

Revision 1.16  91/09/03  11:07:32  richard
Included MIR optimiser module in compiler run.

Revision 1.15  91/08/23  15:49:18  jont
Removed init_prim, as no longer required

Revision 1.14  91/08/06  17:30:23  jont
Removed code generation from non-optimised lambda code

Revision 1.13  91/08/06  13:58:07  davida
Removed printing of optimised lambda code,
as it's printed by the optimiser by default.

Revision 1.12  91/08/06  13:04:13  davida
Added switches for mir and absyn printing,
changed to use different lambda-print function.

Revision 1.11  91/08/05  16:33:10  jont
Split printing of results into two parts for better diagnostics

Revision 1.10  91/08/02  10:00:29  davida
Removed superfluous argument from LambdaOptimiser.optimise call.

Revision 1.9  91/07/31  19:48:07  jont
Stopped printing abstract syntax tree

Revision 1.8  91/07/30  14:03:50  jont
Minor changes to do with calling mir

Revision 1.7  91/07/25  16:07:06  jont
Added mir stuff

Revision 1.6  91/07/19  17:35:58  jont
First attempt at abstracting out external arguments

Revision 1.5  91/07/12  18:50:38  jont
Used new toplevel environment printer

Revision 1.4  91/07/11  15:25:42  jont
Has topdecprint if required

Revision 1.3  91/07/11  13:12:59  jont
Produced correct top level output in terms of ordering, environment
as fields etc.

Revision 1.2  91/07/10  15:01:49  jont
Completed to handle initial environment and compile files and strings

Revision 1.1  91/07/09  18:58:16  jont
Initial revision

*)

require "../basis/__io";
require "../basis/__text_io";
require "../basis/__int";
require "../basis/os";
require "^.system.__file_time";

require "../utils/crash";
require "../utils/print";
require "../utils/lists";
require "../utils/diagnostic";
require "../utils/mlworks_timer";
require "../basics/module_id";
require "../parser/parser";
require "../typechecker/mod_rules";
require "../typechecker/basis";
require "../typechecker/stamp";
require "../lambda/environ";
require "../lambda/lambdaprint";
require "../lambda/environprint";
require "../lambda/lambda";
require "../lambda/lambdaoptimiser";
require "../lambda/lambdamodule";
require "../lambda/topdecprint";
require "../mir/mir_cg";
require "../mir/mirprint";
require "../mir/miroptimiser";
require "mach_cg";
require "machprint";
require "object_output";
require "project";
require "primitives";
require "pervasives";
require "encapsulate";
require "mlworks_io";
require "toplevel";

functor TopLevel
 (structure OS : OS
  structure Crash : CRASH
  structure Print : PRINT
  structure Lists : LISTS
  structure Diagnostic : DIAGNOSTIC
  structure Timer : INTERNAL_TIMER
  structure Parser : PARSER
  structure Mod_Rules : MODULE_RULES
  structure Basis : BASIS
  structure Stamp : STAMP
  structure Environ : ENVIRON
  structure LambdaPrint : LAMBDAPRINT
  structure EnvironPrint : ENVIRONPRINT
  structure Lambda : LAMBDA
  structure LambdaOptimiser : LAMBDAOPTIMISER
  structure LambdaModule : LAMBDAMODULE
  structure Mir_Cg : MIR_CG
  structure MirPrint : MIRPRINT
  structure MirOptimiser : MIROPTIMISER
  structure Mach_Cg : MACH_CG
  structure MachPrint : MACHPRINT
  structure Object_Output : OBJECT_OUTPUT
  structure TopdecPrint : TOPDECPRINT
  structure Primitives : PRIMITIVES
  structure Pervasives : PERVASIVES
  structure Encapsulate : ENCAPSULATE
  structure Io : MLWORKS_IO
  structure ModuleId : MODULE_ID
  structure Project : PROJECT

  sharing Lambda.Options =
          Mir_Cg.Options =
	  EnvironPrint.Options =
	  LambdaPrint.Options =
	  TopdecPrint.Options =
	  LambdaOptimiser.Options =
          Mod_Rules.Options =
          Mach_Cg.Options

  sharing Parser.Lexer.Info = Lambda.Info = Mir_Cg.Info = Mach_Cg.Info =
          Mod_Rules.Info = Project.Info
  sharing Basis.BasisTypes = Mod_Rules.Assemblies.Basistypes =
	  Encapsulate.BasisTypes = Lambda.BasisTypes
  sharing Mir_Cg.MirTypes.Debugger_Types =
	  Encapsulate.Debugger_Types
  sharing Parser.Absyn.Set = Basis.BasisTypes.Set
  sharing Parser.Absyn =
	  Mod_Rules.Absyn =
	  Lambda.Absyn =
	  TopdecPrint.Absyn
  sharing Environ.EnvironTypes.LambdaTypes =
	  LambdaPrint.LambdaTypes =
    	  LambdaOptimiser.LambdaTypes =
	  Lambda.EnvironTypes.LambdaTypes =
	  Mir_Cg.LambdaTypes
  sharing Environ.EnvironTypes =
	  Lambda.EnvironTypes =
    	  Primitives.EnvironTypes =
	  EnvironPrint.EnvironTypes =
    	  Encapsulate.EnvironTypes =
	  LambdaModule.EnvironTypes
  sharing Mir_Cg.MirTypes =
   	  MirPrint.MirTypes =
	  MirOptimiser.MirTypes =
	  Mach_Cg.MirTypes =
	  MirOptimiser.MirTypes
  sharing Mach_Cg.MachSpec = MirOptimiser.MachSpec
  sharing Basis.BasisTypes.Datatypes.Ident = LambdaPrint.LambdaTypes.Ident
  sharing Encapsulate.ParserEnv.Map = Basis.BasisTypes.Datatypes.NewMap

  sharing type Parser.Lexer.Options = Lambda.Options.options
  sharing type Mach_Cg.Opcode = MachPrint.Opcode = Object_Output.Opcode
  sharing type Mach_Cg.Module = Encapsulate.Module = Object_Output.Module
  sharing type Parser.Absyn.Type = Basis.BasisTypes.Datatypes.Type =
	       Mir_Cg.LambdaTypes.Type
  sharing type Parser.Absyn.Structure = Basis.BasisTypes.Datatypes.Structure
  sharing type Parser.ParserBasis = Encapsulate.ParserEnv.pB
  sharing type LambdaPrint.LambdaTypes.Primitive = Pervasives.pervasive
  sharing type ModuleId.ModuleId = Project.ModuleId = Io.ModuleId = Object_Output.ModuleId
  sharing type ModuleId.Location = Basis.BasisTypes.Datatypes.Ident.Location.T
  sharing type Lambda.DebugInformation =
	       Mir_Cg.MirTypes.Debugger_Types.information
  sharing type Basis.BasisTypes.Datatypes.Stamp = Stamp.Stamp
  sharing type Basis.BasisTypes.Datatypes.StampMap = Stamp.Map.T
  sharing type Object_Output.Project = Project.Project
) : TOPLEVEL =

struct
  structure EnvironTypes = Environ.EnvironTypes
  structure Assemblies = Mod_Rules.Assemblies
  structure BasisTypes = Assemblies.Basistypes
  structure Absyn = Parser.Absyn
  structure LambdaTypes = LambdaPrint.LambdaTypes
  structure Lexer = Parser.Lexer
  structure Datatypes = Basis.BasisTypes.Datatypes
  structure NewMap = Datatypes.NewMap
  structure Ident = Datatypes.Ident
  structure Parser = Parser
  structure Diagnostic = Diagnostic
  structure Set = LambdaTypes.Set
  structure MirTypes = Mir_Cg.MirTypes
  structure Debugger_Types = MirTypes.Debugger_Types
  structure Info = Lexer.Info
  structure Options = LambdaOptimiser.Options
  structure Token = Lexer.Token
  structure FileSys = OS.FileSys

  type TypeBasis = BasisTypes.Basis
  type ParserBasis = Parser.ParserBasis 

  type ModuleId = ModuleId.ModuleId

  type Project = Project.Project



  val do_lambda_opt = ref true
  val print_timings = ref false

  val do_diagnostic = true
  val _ = Diagnostic.set 0

  fun diagnostic_output level =
    if do_diagnostic then Diagnostic.output level else fn f => ()

  (* Redundant now *)
  val do_check_bindings = ref false

  val error_output_level = ref Info.ADVICE

  datatype compiler_basis =
    CB of (Parser.ParserBasis * BasisTypes.Basis * EnvironTypes.Top_Env)

  val empty_cb =
    CB (Parser.empty_pB, Basis.empty_basis, Environ.empty_top_env)

  val initial_cgb =
    EnvironTypes.TOP_ENV
    (Primitives.initial_env, Environ.empty_fun_env)

  fun augment (CB (p, t, c), CB (p', t', c')) =
    CB (Parser.augment_pB (p, p'),
        Basis.basis_circle_plus_basis (t, t'),
        Environ.augment_top_env (c, c'))

  val after_builtin_cgb =
    EnvironTypes.TOP_ENV
    (Primitives.env_after_builtin, Environ.empty_fun_env)

  val non_ml_defineable_cgb =
    EnvironTypes.TOP_ENV
    (Primitives.env_for_not_ml_definable_builtins, Environ.empty_fun_env)

  val initial_cgb_for_builtin_library =
    EnvironTypes.TOP_ENV
    (Primitives.initial_env_for_builtin_library, Environ.empty_fun_env)

  val initial_cb_for_builtin_library =
    CB (Parser.initial_pB_for_builtin_library,
        Basis.initial_basis_for_builtin_library,
        initial_cgb_for_builtin_library)

  val initial_cgb_for_normal_file =
    CB (Parser.initial_pB,
        Basis.initial_basis,
        non_ml_defineable_cgb)

  val BasisTypes.BASIS(_, _, _, _, initial_env_for_normal_file) = Basis.initial_basis

  val initial_compiler_basis = initial_cgb_for_normal_file

  val empty_env =
    CB(Parser.empty_pB, Basis.empty_basis, Environ.empty_top_env)

  val empty_string_map = NewMap.empty (op < : string * string -> bool, op =)

  val empty_debug_info = Debugger_Types.empty_information

  (* this codegen basis will not cope with code including exceptions *)

  fun diagnostic (level, output_function) =
    diagnostic_output level
      (fn verbosity => "TopLevel " :: (output_function verbosity))

  fun diagnose_simple str = diagnostic_output 1 (fn i => [str])

  fun augment_cb (CB(p, t, c), CB(p', t', c')) =
    CB (Parser.augment_pB (p, p'),
        Basis.basis_circle_plus_basis(t, t'),
        Environ.augment_top_env(c, c'))

  fun error_wrap filename error_info =
    Info.wrap error_info
      (Info.FATAL, Info.RECOVERABLE, !error_output_level,
       Info.Location.FILE filename)

  (* The require_table maps module names to pair of module_names with
     pairs of a stamp count and the stamps for that module.  I have no
     idea why the module name is stored in the range of the map as well
     as the domain. *)
  fun do_subrequires
        options
        (first, project, require_table, _, _, nil) =
    (project, require_table)
  |   do_subrequires
        options
        (first, project, require_table, pervasive, 
         location,
         {mod_name = name, time} :: cons) =
      let
        val _ =
          diagnostic (3,
          fn _ => ["do_subrequires of ", name, ", pervasive = ",
                   if pervasive then "true\n" else "false\n"])
        val is_pervasive_file = pervasive orelse first

        val module_id =
          ModuleId.from_mo_string (name, location)

        val module_name_string = OS.Path.mkCanonical(ModuleId.string module_id)
      in
        case NewMap.tryApply'(require_table, module_name_string) of
          SOME _ =>
            do_subrequires options
            (false, project, require_table, pervasive, location, cons)
        | _ =>
            let
              val (consistency, stamps) =
                case Project.get_object_info (project, module_id)
                of SOME
                     {stamps,
                      consistency = Project.DEPEND_LIST cons, ...} =>
                  (cons, stamps)
                |  NONE =>
                  Crash.impossible
                    ("No object info for `" ^ module_name_string ^ "'")

              (* do_subrequires is called recursively on the consistency
                 info, to ensure that their stamps are allowed for. *)
              val (project, require_table) =
                do_subrequires options
                (true, project, require_table, is_pervasive_file,
                 location,
                 consistency)

              val stamp_count = Stamp.read_counter ()

              val _ = Stamp.reset_counter (stamp_count + stamps)

              val module_name_string =
                ModuleId.string
                  (Project.get_name (project, module_id))

              val req_info = (module_name_string, stamp_count, stamps)
            in
              do_subrequires
                options
                (false, project,
                 NewMap.define(require_table, module_name_string, req_info),
                 pervasive, location, cons)
            end
      end

  fun compile_require
      error_info
      (module_id, project, pervasive, location, require_table,
       counters as stamps, debug_info) =
    Timer.xtime
    ("Require",
     !print_timings,
     fn () =>
     let
       val root = ModuleId.string module_id
       val _ = diagnostic (2, fn _ => ["requireDec ", root])

       val (mo_str, mo_stamp) =
         case Project.get_object_info (project, module_id) of
           SOME {file, time_stamp, ...} => (file, time_stamp)
         | NONE =>
             Crash.impossible
               ("Required object file `" ^ root ^ "' in project "
                ^ (Project.get_project_name project) ^ " not found")

       val _ = diagnostic (2, fn _ => ["found mo: ", mo_str])

       val {parser_env, type_env=t_env, lambda_env,
            mod_name, consistency, stamps, ...} =
          Encapsulate.input_all mo_str
          handle Encapsulate.BadInput message =>
            Info.error' error_info  (Info.FATAL, Info.Location.UNKNOWN, message)

      fun error_wrap error_info =
        Info.wrap error_info
          (Info.FATAL, Info.RECOVERABLE, !error_output_level,
            location)

       val (project, require_table) =
         error_wrap 
           error_info
           do_subrequires
           (true, project, require_table, pervasive, location, consistency)

       (* note that counters have already been bumped up by *)
       (* do_subrequires *)

       val stamp_count = Stamp.read_counter ()

       val req_info = (mod_name, stamp_count, stamps)

       val mod_name = OS.Path.mkCanonical mod_name;
       val require_table =
         case NewMap.tryApply' (require_table, mod_name) of
           SOME _ => require_table
         | _ =>
             NewMap.define(require_table, mod_name, req_info)

       val (parser_env, lambda_env, t, _) =
         Encapsulate.decode_all
         {parser_env=parser_env,
          lambda_env=lambda_env,
          type_env=t_env,
          file_name=mod_name,
          sub_modules=require_table,
          decode_debug_information=false,
          pervasive_env=initial_env_for_normal_file}

       val _ = Stamp.reset_counter (stamp_count + stamps)

       val (top_env, decls) =
         LambdaModule.unpack
         (lambda_env,
          LambdaTypes.APP
            (LambdaTypes.BUILTIN Pervasives.LOAD_STRING,
             ([LambdaTypes.SCON (Ident.STRING mod_name, NONE)],[]),
             NONE))
     in
       (project, require_table,
        [{mod_name = mod_name,
          time = mo_stamp}],
          (* This is where the entry for the require list is made *)
        decls, CB(parser_env, t, top_env))
     end)

  fun compile_dependents error_info ([], 
         project, location, pervasive, require_table, requires,
         decls, req_cb,_,_) =
    (project, require_table, requires, decls, req_cb)
    | compile_dependents error_info (m::t,
         project, location, pervasive, require_table, requires,
         decls, req_cb, counters, debug_info) =
        let val (project, require_table, requires',
                 decls', req_cb') =
              compile_require error_info
                 (m, project, pervasive, 
                  location,
                  require_table, counters, debug_info)
         in compile_dependents error_info (t, 
               project, location, pervasive, require_table, 
               requires @ requires', 
               decls @ decls', augment_cb(req_cb, req_cb'), counters, debug_info)
        end

  (* compile_program takes a token stream and an initial compiler
   basis (which should be constructed from the included files) and
   returns a lambda expression and a final compiler basis.
   The cb contains those vars and strs declared in the
   stream, with names giving the indices into the tuple *)

  fun compile_program (error_info,
                       Options.OPTIONS({listing_options =
                                        Options.LISTINGOPTIONS listing_options,
                                        print_options,extension_options,
                                        compat_options,
                                        compiler_options=Options.COMPILEROPTIONS
                                        {generate_debug_info,debug_variables,
                                         generate_moduler,
                                         intercept,
                                         opt_leaf_fns, opt_handlers,
                                         opt_tail_calls,opt_self_calls,
                                         local_functions,
					 print_messages,
                                         mips_r4000,
                                         sparc_v7,...}}),
         project, module_id, ts, 
         initial, initial_require_table, initial_requires, initial_decls,
         pervasive) =
    let
      val mod_path = ModuleId.path module_id
      val Options.COMPATOPTIONS{old_definition,...} = compat_options
      val _ =
        diagnostic (2,
          fn _ => ["compile_program called with mod_path = `",
		   ModuleId.path_string mod_path, "'\n"])

      val options =
        Options.OPTIONS({listing_options = Options.LISTINGOPTIONS listing_options,
                         print_options = print_options,
                         extension_options = extension_options,
                         compat_options = compat_options,
                         compiler_options=Options.COMPILEROPTIONS
                         {generate_debug_info = generate_debug_info,
                          debug_variables =
                          debug_variables orelse generate_moduler,
                          generate_moduler = false,
                          intercept = false,
			  interrupt = false,
                          opt_handlers = opt_handlers,
                          opt_leaf_fns = opt_leaf_fns,
                          opt_tail_calls = opt_tail_calls,
                          opt_self_calls = opt_self_calls,
                          local_functions = local_functions,
			  print_messages = print_messages,
                          mips_r4000 = mips_r4000,
                          sparc_v7 = sparc_v7}})
      val filename = Lexer.associated_filename ts

      fun error_wrap error_info =
        Info.wrap error_info
          (Info.FATAL, Info.RECOVERABLE, !error_output_level,
           Info.Location.FILE filename)


      (* compile_topdec takes a path plus the env so far and delivers *)
      (* requires, the code, the updated initial env and *)
      (* the result of this compilation *)

      fun compile_topdec
	    (arg as (project, pervasive, mod_path, stamp_info,
		     cb1 as CB(p, t, c), cb2 as CB(p', t', c'), parse, eof,
		     counters as stamps, debug_info, had_topdec)) =
	let
	  val parse_env = Parser.augment_pB(p, p')
	  val (topdec, p'') =
            Timer.xtime(
	      "Parsing",
	      !print_timings,
	      (fn () => error_wrap error_info parse parse_env)
	    )
	  val _ = diagnose_simple "Parsing complete"
	in
	  (case topdec of
	    Absyn.REQUIREtopdec (root, location) =>
	      if had_topdec then
		Info.error'
		error_info
		(Info.FATAL, location, concat ["Too late for require statement"])
	      else
                (project, stamp_info, [],
		 empty_cb, counters, debug_info, false)

	  | Absyn.STRDECtopdec(Absyn.SEQUENCEstrdec [], _) =>
	     (if eof() then
		let
		  val stamp_count = Stamp.read_counter ()

		  val stamp_info = case stamp_info of
		    NONE => SOME stamp_count
		  |_ => stamp_info
		in
		  (project, stamp_info, [], 
		   empty_cb, counters, debug_info, true)
		end
	      else
                 compile_topdec
		   (project, pervasive, mod_path, stamp_info, 
		    cb1, cb2, parse, eof, counters,debug_info, true))
	  | _ =>
	      let
		val CB(p, t, c) = augment_cb(cb1, cb2)
		val stamp_count = Stamp.read_counter ()

		val stamp_info = case stamp_info of
		  NONE => SOME stamp_count
		|_ => stamp_info

		val t' = Timer.xtime
		  ("Type-checking ", !print_timings,
		   fn () => error_wrap
		   error_info
		   Mod_Rules.check_topdec
		   (options,true, topdec,t, Mod_Rules.BASIS t)
		   )

		val _ = Basis.reduce_chains t'
		val _ =
		  if (#show_absyn listing_options) then
		    (Info.listing_fn
		     error_info
		     (3, fn stream => TextIO.output(stream, "The abstract syntax\n"));
		     Info.listing_fn
		     error_info
		     (3, fn stream =>
		      TextIO.output(stream,
                        TopdecPrint.topdec_to_string options topdec));
		     Info.listing_fn
		     error_info
		     (3, fn stream => TextIO.output(stream, "\n"))
		     )
		  else ()

		val _ = diagnose_simple"Typechecking complete"
		val stamp_count = Stamp.read_counter () - stamp_count

		val (c', _, declarations,debug_info') =
                  Timer.xtime (
		    "Lambda translation",
		    ! print_timings,
                    fn () => error_wrap
			       error_info
			       Lambda.trans_top_dec
			         (options, topdec, c, Environ.empty_denv,
				  debug_info,
				  Basis.basis_circle_plus_basis (t, t'), true)
		  )

		val _ = diagnose_simple"Lambda translation complete"
	      in
		(project, stamp_info, 
                 declarations, CB(p'',t',c'),
		 stamps + stamp_count,
                 debug_info', true)
	      end)
	end	

      (* compile_topdecs takes unit and compiles all the
       topdecs remaining in the input stream, returning a
       (reverse-ordered) list of the declarations and a compiler basis
       which does not include the initial compiler basis *)

      fun compile_topdecs'
	(project, mod_path, stamp_info, code,
	 initial_cb, compiled_cb, parse, eof, counters,
	 debug_info, had_topdec) =
        let
          val (project, stamp_info, 
               declarations, comp_cb,
               counters, debug_info, had_topdec) =
            compile_topdec
	      (project, pervasive, mod_path, stamp_info,
	       initial_cb, compiled_cb, parse, eof, counters, debug_info,
	       had_topdec)

          val compiled_cb' = augment_cb(compiled_cb, comp_cb)
          val code' = code @ declarations
        in
          if eof () then
            (project, stamp_info, code',
	     compiled_cb', counters,debug_info)
          else
            compile_topdecs'
	      (project, mod_path, stamp_info, code',
               initial_cb, compiled_cb', parse, eof,
	       counters, debug_info, had_topdec)
        end

      fun eof () = Lexer.eof ts
      val initial_counters = 0

      fun parse error_info pb = Parser.parse_topdec error_info (options,ts, pb)

      val (project, stamp_info, require_table, reqs_list, decls_list,
	   CB(pbasis, basis, top_env), counters, debug_info) =
        if eof () then
	  let
	    val stamp_count = Stamp.read_counter ()
	  in
            print "_toplevel: eof\n";
	    (project, SOME stamp_count,
	     empty_string_map, [], 
             [], empty_cb, initial_counters,
	     empty_debug_info)
	  end
	else
          let val dependents = 
                  Project.get_requires(project, module_id)
              val dependents = 
                  if pervasive 
                  then dependents 
                  else 
                    (*
                    ModuleId.perv_from_require_string
                      (Io.pervasive_library_name, Info.Location.UNKNOWN) 
                    :: *)
                    dependents 

              val (project, require_table, requires,
                   declarations, req_cb) =
                  compile_dependents error_info (dependents, 
                     project,
                    Info.Location.FILE filename,
                     true, initial_require_table,
                     initial_requires,initial_decls,initial,
                     initial_counters, empty_debug_info)

              val (project, stamp_info, code',
                   compiled_cb', counters,debug_info) =
                  compile_topdecs'
                     (project, mod_path, NONE,  
                      declarations, req_cb,
                      empty_cb, parse, eof, initial_counters,
                      empty_debug_info, false) 
	   in 
              (project, stamp_info, require_table, requires, code',
               compiled_cb', counters,debug_info) 
           end

      val (top_env'', lambda_exp') =
        LambdaModule.pack (top_env, decls_list)

    in
      (project, stamp_info, require_table, reqs_list, lambda_exp',
       CB (pbasis, basis, top_env''), counters,debug_info)
    end (* of compile_program *)

  fun do_input (error_info,
                options as Options.OPTIONS
                {listing_options = Options.LISTINGOPTIONS listing_options,
                 print_options,
                 compiler_options=
                 Options.COMPILEROPTIONS{generate_debug_info,
                                         debug_variables,
                                         generate_moduler,...},
                 ...},
                project, module_id, input_fn, filename, pervasive,
                { require_table = initial_require_table,
                  requires = initial_requires,
                  declarations = initial_decls,
                  compiler_basis = initial_cb,
                  lvar_count = initial_lvar,
                  stamp_count = initial_stamp_count}) =
    let
      val module_str = ModuleId.string module_id

      val _ =
        diagnostic (2,
          fn _ => ["do_input called on `", ModuleId.string module_id, "'\n"])

      val builtin = pervasive andalso 
	              ModuleId.eq(module_id, Io.builtin_library_id)

      fun error_wrap error_info =
        Info.wrap
 	  error_info
	  (Info.FATAL, Info.RECOVERABLE, !error_output_level,
	   Info.Location.FILE module_str)

      val mod_path = ModuleId.path module_id

      val _ = LambdaTypes.reset_counter initial_lvar

      val ts =
        let
          val stream_name =
            if pervasive then "<Pervasive>"
            else filename
        in
          Lexer.mkTokenStream (input_fn, stream_name)
        end

      val _ = Stamp.push_counter()
      val _ = Stamp.reset_counter initial_stamp_count 
    in
      let
	val _ = diagnostic_output 3 (fn _ => ["Cleaning refs in precompiled basis"])
	val _ = let val CB(_,basis,_) = initial_cb
                 in Encapsulate.clean_basis basis end
	(* Set all refs for encoding back to zero *)
	val _ = diagnostic_output 3 (fn _ => ["Cleaned refs in precompiled basis"])
	
	val _ =
	  diagnostic_output 3
	    (fn _ => ["Stamp reset to " ^
		      Int.toString(Stamp.read_counter()) ^ "\n"])

        (* Compile up to lambda translation *)
	val (project, stamp_info, require_table, requires, lambda_exp,
	     cb' as CB(parser_env, type_basis, top_env),
	     stamp_count,debug_information) =
	  compile_program (error_info, options, project,
			   module_id, ts, 
                           initial_cb, initial_require_table, 
                           initial_requires, initial_decls,
                           pervasive)

        (* Need to hack in the final counts of tynames etc. *)

        val stamps =
          case stamp_info of
	    SOME stamps => stamps
          | _ => Crash.impossible "Garbled stamp info"

        val final_stamp_count = Stamp.read_counter ()

        val require_list =
          ("", stamps,final_stamp_count - stamps)
	  :: NewMap.range require_table

	val src_info = Project.get_source_info (project, module_id)

	val src_time =
	  case src_info
	  of SOME (_, time) => time
	  |  NONE =>
	    Crash.impossible
	      ("Can't find source time for `" ^ filename ^ "'")

	val _ =
	  if (#show_lambda listing_options) then
	    (Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "The unoptimised lambda code\n"));
	     Info.listing_fn error_info
	     (3, fn stream =>
	      LambdaPrint.output_lambda options (stream, lambda_exp)))
	  else ()

	val opt_lambda_exp =
	  if (!do_lambda_opt) then
	    Timer.xtime("LambdaOptimiser",
			!print_timings,
			fn () => LambdaOptimiser.optimise options lambda_exp)
	  else
	    lambda_exp

	val _ = diagnose_simple ("Lambda optimisation complete")
	val _ =
	  if (#show_opt_lambda listing_options) then
	    (Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "The optimised lambda code\n"));
	     Info.listing_fn error_info
	     (3, fn stream =>
	      LambdaPrint.output_lambda options (stream, opt_lambda_exp)))
	  else ()

        val top_env = Environ.simplify_topenv (top_env,opt_lambda_exp)

	val _ =
	  if (#show_environ listing_options) then
	    (Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "The environment\n"));
	     Info.listing_fn error_info
	     (3, EnvironPrint.printtopenv print_options top_env);
	     Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "\n")))
	  else ()

	val (the_mir_code,debugger_information) =
	  Timer.xtime("Mir_Cg",
		      ! print_timings,
		      fn () => error_wrap
		      error_info
		      Mir_Cg.mir_cg
		      (options, opt_lambda_exp,
		       module_str, debug_information)
		      )

	val _ = diagnose_simple"Mir translation complete"

	val _ =
	  if #show_mir listing_options then
	    (Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "The unoptimised intermediate code\n"));
	     Info.listing_fn error_info (3, MirPrint.print_mir_code the_mir_code))
	  else
	    ()
        val make_debugging_code = generate_debug_info (* For the moment *)
	val the_optimised_code =
	  Timer.xtime("MirOptimiser", ! print_timings,
		      fn () => MirOptimiser.optimise (the_mir_code,make_debugging_code));

	val _ = diagnose_simple"Mir optimisation complete"
	val _ =
	  if #show_opt_mir listing_options then
	    (Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "The optimised intermediate code\n"));
	     Info.listing_fn error_info (3, MirPrint.print_mir_code the_optimised_code))
	  else
	    ()

	val ((the_machine_code,debugger_information), code_list_list) =
	  let
	    val assign = MirOptimiser.machine_register_assignments
	  in
	    Timer.xtime("Mach_Cg",
			! print_timings,
			fn () => error_wrap
			error_info
			Mach_Cg.mach_cg
			(options, the_optimised_code,
			 (#gc assign, #non_gc assign, #fp assign),
			 debugger_information)
			)
	  end

	val _ = diagnose_simple"Machine code translation complete"

	val _ =
	  if #show_mach listing_options then
	    (Info.listing_fn
	     error_info
	     (3, fn stream => TextIO.output(stream, "The final machine code\n"));
	     Info.listing_fn error_info (3, MachPrint.print_mach_code code_list_list))
	  else
	    ()

	val mo_name =
	  if pervasive then
	    Project.pervasiveObjectName module_id
	  else
	    Project.objectName
	      (error_info, Info.Location.FILE module_str)
	      (project, module_id)

	val top_env =
	  if builtin then
	    if Primitives.check_builtin_env
		 {error_fn =
		    fn s =>
		      Info.error
			error_info
			(Info.RECOVERABLE, Info.Location.FILE module_str, s),
		  topenv = top_env}
	    then
	      (Print.print "*** Changing top level environment\n";
	       after_builtin_cgb)
	    else
              Info.error'
                error_info
                (Info.FATAL, Info.Location.FILE module_str,
		 "Builtin library doesn't match pervasives")
	  else
	    top_env

        (* We explicitly set the debug info to nothing even if we aren't
	   supposed to be generating it *)
	val _ =
	  Timer.xtime
	    ("Outputting", !print_timings,
	     fn () =>
	       (Encapsulate.output_file
		  (debug_variables orelse generate_moduler)
		  {filename = mo_name,
                   code = the_machine_code, parser_env = parser_env,
                   type_basis = type_basis,
                   debug_info =
		     if generate_debug_info then
		       debugger_information
		     else
		       empty_debug_info,
                   require_list = require_list,
		   lambda_env = top_env,
                   stamps = stamp_count,
		   mod_name = ModuleId.string module_id,
		   time_stamp = src_time,
                   consistency = requires}))
	  handle IO.Io _ =>
	    Info.error'
	      error_info
	      (Info.FATAL, Info.Location.FILE module_str,
	       "Can't create object file `" ^ mo_name ^ "'\n");

	val new_mo_time = FileTime.modTime mo_name
	(* Now output the .S files. Later this will produce .o from .mo *)
        (* Disabled until work restarts on DLL development *)
	(* val _ = Object_Output.output_object_code
  	     (Object_Output.ASM, module_id, mo_name, project)
	     (Encapsulate.input_code mo_name) *)

	val _ =
	  Project.set_object_info
	  (project, module_id,
	   SOME {file = mo_name,
		 file_time = new_mo_time,
		 time_stamp = src_time,
		 stamps = stamp_count,
		 consistency = Project.DEPEND_LIST requires})
      in
	Stamp.pop_counter();
	project
      end
      handle exn =>
        (Stamp.pop_counter();
         raise exn)
    end


  fun compile_file''
	error_info
	(options as Options.OPTIONS
	 {compiler_options = Options.COMPILEROPTIONS
	  {print_messages, ...}, ...}, 
         project, module_id, pervasive,
         precompiled_context) =
    Timer.xtime
    ("Compilation", !print_timings,
     fn () =>
     let
       val source_info = Project.get_source_info (project, module_id)

       val file_name =
	 case source_info
	 of SOME (file_name, _) => file_name
	 |  NONE =>
	   Crash.impossible
	     ("No source info while compiling `"
	      ^ ModuleId.string module_id ^ "'")

       val _ =
	 if print_messages then
	   Print.print ("Compiling " ^ file_name ^ "\n")
	 else ()

       val instream =
         TextIO.openIn file_name
         handle IO.Io{name, function, cause} =>
           Info.error'
	     error_info
	     (Info.FATAL, Info.Location.UNKNOWN,
	      "Io error in compile_file: " ^ name)

       val module_str = ModuleId.string module_id

       val result =
         do_input (error_info, options, project, module_id,
		   fn _ => TextIO.inputN(instream, 4096), file_name, pervasive,
                   precompiled_context)
         handle exn => (TextIO.closeIn instream; raise exn)
     in
       TextIO.closeIn instream;
       result
     end)

  fun check_pervasive_objects_exist(error_info, location, project) =
    let
      val units = Project.list_units project
      fun check_one_unit(string, module_id) =
	case Project.get_object_info(project, module_id) of
	  NONE => Info.error
	    error_info
	    (Info.FATAL, location, "Missing pervasive object file `" ^ string ^ "'")
	| _ => ()
    in
      Lists.iterate check_one_unit units
    end

  type precompiled_context =
    { 
      require_table: (string, (string * int * int)) NewMap.map,
      requires: {mod_name: string, time: MLWorks.Internal.Types.time} list,
      declarations: LambdaTypes.binding list,
      compiler_basis: compiler_basis,
      lvar_count: int,
      stamp_count: int
    }

  fun precompile error_info (project, is_pervasive, dependents)
      : precompiled_context =
    let val initial_cb = 
          if is_pervasive 
          then initial_cb_for_builtin_library
          else initial_cgb_for_normal_file

        val dependents' = 
          if is_pervasive 
          then dependents 
          else
            let val pervasive_dependent = 
              (Project.initialize (error_info, Info.Location.UNKNOWN),
               ModuleId.perv_from_require_string
                 (Io.pervasive_library_name, Info.Location.UNKNOWN))
            in
              pervasive_dependent :: dependents
            end

        fun precompile_dependents ([], 
               location, pervasive, require_table, requires,
               decls, req_cb,_,_) =
              let val final_count = Stamp.read_counter()
                  val final_lvar = LambdaTypes.read_counter()
                  val ctxt : precompiled_context =
                     { require_table = require_table,
                       requires = requires, 
                       declarations = decls, 
                       compiler_basis = req_cb, 
                       lvar_count = final_lvar, 
                       stamp_count = final_count }
               in Stamp.pop_counter();
                  ctxt
              end
          | precompile_dependents ((project,m)::t,
               location, pervasive, require_table, requires,
               decls, req_cb, counters, debug_info) =
              let val (_, require_table, requires',
                       decls', req_cb') =
                    compile_require error_info
                       (m, project, pervasive, 
                        location,
                        require_table, counters, debug_info)
               in precompile_dependents (t, 
                     location, pervasive, require_table, 
                     requires @ requires', 
                     decls @ decls', augment_cb(req_cb, req_cb'), 
                     counters, debug_info)
              end

     in
       case dependents of
         [] => ()
       | _ => 
         ( print "Precompiling ";
           app (fn (_,m) => print(ModuleId.string m ^ " ")) dependents;
           print "\n" );
       Stamp.push_counter();
       Stamp.reset_counter Basis.pervasive_stamp_count;
       LambdaTypes.init_LVar ();

       precompile_dependents (
         dependents',
         Info.Location.UNKNOWN,
         true, empty_string_map,
                     [],[],initial_cb,
                     0, empty_debug_info)
    end

    fun get_precompiled_context (project, pervasive, error_info) =
      let 
        val precompiled_context = ref NONE
      in 
        fn () =>
          case !precompiled_context of
            NONE => 
              let val dependents =
                    Project.get_external_requires project
                  val context = 
                    precompile error_info (project, pervasive, dependents)
               in precompiled_context := SOME context; context end
          | SOME context => context
      end


  fun compile_file error_info options filenames =
    let
      val location = Info.Location.FILE "<batch compiler:compile-file>"

      val modules = map OS.Path.file filenames

      val init_project = Project.initialize (error_info, location)

      val _ = check_pervasive_objects_exist(error_info, location, init_project)

      val precompiled_context = 
        get_precompiled_context(init_project, false, error_info)

      fun compile_one ((project, status_map), module) =
	let
	  fun do_compile_one mod_id =
	    let
              val (project, status_map) =
                Project.read_object_dependencies
                  (Info.make_default_options (), location)
                  (project, mod_id, status_map);

	      val project =
	        compile_file''
                  error_info
	          (options, project, mod_id, false,
                   precompiled_context());
	    in
	      (project, status_map)
	    end
	in
	  do_compile_one (ModuleId.from_host (module, location))
	end
    in
      ignore(Lists.reducel
	compile_one
	((init_project, Project.empty_map), modules));
      ()
    end

  fun recompile_file error_info options filenames =
    let
      val location = Info.Location.FILE "<batch compiler:recompile-file>"

      val modules = map OS.Path.file filenames

      val init_project = Project.initialize (error_info, location)

      val _ = check_pervasive_objects_exist(error_info, location, init_project)

      val precompiled_context = 
        get_precompiled_context(init_project, false, error_info)

      fun recompile_one
	    ((project, depend_map, compile_map), module) =
	let
	  fun compile_one (proj, m) =
	    compile_file''
              error_info
	      (options, proj, m, false,
               precompiled_context());

	  fun do_recompile_one mod_id =
	    let
              val (project, depend_map) =
                Project.read_dependencies
                  (Info.make_default_options (), location)
                  (project, mod_id, depend_map);

	      val (out_of_date, compile_map) =
	        Project.check_compiled'
	          (Info.make_default_options (), location)
	          (project, mod_id)
	          ([], compile_map)

	      val project =
	        Lists.reducel compile_one (project, out_of_date);

	      val status_map =
	        Lists.reducel Project.mark_compiled (compile_map, out_of_date)
	    in
	      (project, depend_map, compile_map)
	    end
	in
	  do_recompile_one (ModuleId.from_host (module, location))
	end
    in
      ignore(Lists.reducel
	recompile_one
	((init_project, Project.empty_map, Project.visited_pervasives),
	 modules));
      print"Up to date\n"
    end

  fun recompile_pervasive error_info options =
    let
      val location = Info.Location.FILE "<batch compiler:compile-pervasive>"
      val project = Project.initialize (error_info, location)

      val precompiled_context = 
        get_precompiled_context(project, true, error_info)()

      fun context_for module_id = 
        if ModuleId.eq(module_id, Io.builtin_library_id)
        then precompiled_context
        else
          let val {require_table, requires, declarations, compiler_basis, 
                   lvar_count, stamp_count} = precompiled_context
           in {require_table = require_table, requires = requires,
               declarations = declarations,
               compiler_basis = initial_cgb_for_normal_file,
               lvar_count = lvar_count, stamp_count = stamp_count}
          end

      val out_of_date =
	Project.check_perv_compiled
	(error_info, location)
	project

      fun compile_one (proj, m) =
	compile_file''
	error_info
	(options, proj, m, true, context_for m);
    in
      ignore(Lists.reducel compile_one (project, out_of_date));
      print"Up to date\n"
    end

  fun check_dependencies error_info options filenames =
    let
      val location = Info.Location.FILE "<batch compiler:check-dependencies>"

      val modules = map OS.Path.file filenames

      val project = Project.initialize (error_info, location)

      fun check_one
	    ((project, out_of_date, depend_map, compile_map),
	     module) =
	let
	  fun do_check_one mod_id =
	    let
              val (project, depend_map) =
                Project.read_dependencies
                  (Info.make_default_options (), location)
                  (project, mod_id, depend_map)

	      val (out_of_date_now, compile_map) =
	        Project.check_compiled'
	          (Info.make_default_options (), location)
	          (project, mod_id)
	          (out_of_date, compile_map)
	    in
	      (project, out_of_date_now, depend_map, compile_map)
	    end
	in
	  do_check_one (ModuleId.from_host (module, location))
	end

      val (_, out_of_date, _, _) =
	Lists.reducel
	  check_one
	  ((project, [], Project.empty_map, Project.visited_pervasives),
	   modules)

      fun print_one m = print(ModuleId.string m ^ "\n")
    in
      case out_of_date
      of [] =>
	print"No files to recompile\n"
      |  _ =>
        app print_one out_of_date
    end

  fun dump_objects error_info options filename =
    let
      val location = Info.Location.FILE "<batch compiler:dump objects>"

      val initProject =
	Project.fromFileInfo
	  (error_info, location)
	  (Project.initialize (error_info, location))

      val project =
	Project.map_dag (Project.update_dependencies (error_info, location))
                        initProject

      val units = Project.list_units project
      val targets = 
          ( map (fn t => Lists.assoc(
                           OS.Path.base(OS.Path.mkCanonical t), units))
                (Project.currentTargets project) )
          handle _ => []

      val units' = map #2 units

      fun requires m =
        Lists.filterp 
          (fn m' => Lists.exists (fn m'' => ModuleId.eq(m', m'')) units')
          (Project.get_requires(project, m))

      fun topsort targets = 
        let fun sort([],    visited) = visited 
              | sort(x::xs, visited) =
                  sort(xs, 
                       if Lists.exists (fn x' => ModuleId.eq(x, x')) visited 
                       then visited 
                       else x :: sort(requires x, visited))
         in sort(targets, [])
        end;

      fun reverse l =
        let fun rev([], r) = r
              | rev(h::t, r) = rev(t, h::r)
         in rev(l, [])
        end

      val units = reverse(topsort targets)

    in
      let val stream = TextIO.openOut filename      
       in app (fn m => TextIO.output(stream, ModuleId.string m ^ ".mo\n"))
              units;
          TextIO.closeOut stream
      end
      handle IO.Io _ =>
               Info.error'
	       error_info
	       (Info.FATAL, location,
	         "Can't create dump file `" ^ filename ^ "'\n")
    end

  fun list_objects error_info options filenames =
    let
      val location = Info.Location.FILE "<batch compiler:list-objects>"

      val modules = map OS.Path.file filenames

      val project = Project.initialize (error_info, location)

      fun check_one
	    ((project, out_of_date, depend_map),
	     module) =
	let
	  fun do_check_one mod_id =
	    let
	      (* Use Project.read_dependencies, not
		 Project.read_object_dependencies, because the latter
		 reads only the source information for the first file.
		 (Possibly that behaviour should be improved). *)

              val (project, depend_map) =
                Project.read_dependencies
                  (Info.make_default_options (), location)
                  (project, mod_id, depend_map)

	      val out_of_date_now =
	        Project.allObjects
	          (Info.make_default_options (), location)
	          (project, mod_id)
	    in
	      (project, out_of_date_now @ out_of_date, depend_map)
	    end
	in
	  do_check_one (ModuleId.from_host (module, location))
	end

      val (_, out_of_date, _) =
	Lists.reducel
	  check_one
	  ((project, [], Project.empty_map),
	   modules)

      fun print_one m = print(ModuleId.string m ^ "\n")
    in
      case out_of_date
      of [] =>
	print"No files to recompile\n"
      |  _ =>
        app print_one out_of_date
    end

  fun build_targets_for (error_info, options, location) project =
      let
        val initProject =
   	  Project.update_dependencies (error_info, location) project

        val precompiled_context = 
          get_precompiled_context(initProject, false, error_info)

        fun recompile_one
	      ((project, depend_map, compile_map), module) =
	  let
	    fun compile_one (proj, m) =
	        compile_file''
                  error_info
	          (options, proj, m, false,
                   precompiled_context());

	    fun do_recompile_one mod_id =
	      let
                val (project, depend_map) =
                  Project.read_dependencies
                    (Info.make_default_options (), location)
                    (project, mod_id, depend_map);

	        val (out_of_date, compile_map) =
	          Project.check_compiled'
	            (Info.make_default_options (), location)
	            (project, mod_id)
	            ([], compile_map)

	        val project =
	          Lists.reducel compile_one (project, out_of_date);

	        val status_map =
	          Lists.reducel Project.mark_compiled (compile_map, out_of_date)
	      in
	        (project, depend_map, compile_map)
	      end
	  in
	    do_recompile_one (ModuleId.from_host (OS.Path.file module, location))
	  end

        val project' = 
          #1(Lists.reducel
              recompile_one
	      ((initProject, Project.empty_map, Project.visited_pervasives),
	       Project.currentTargets project))
      in
        project'
      end

  fun build error_info options _ =
    let
      val location = Info.Location.FILE "<batch compiler:build>"
      val initProject =
	Project.fromFileInfo
	  (error_info, location)
	  (Project.initialize (error_info, location))
    in
      ignore(Project.map_dag 
        (build_targets_for (error_info, options, location)) initProject);
      print"Up to date\n"
    end


  fun show_build_targets_for (error_info, options, location) project =
    let
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
                  (Info.make_default_options (), location)
                  (project, mod_id, depend_map)

	      val (out_of_date_now, compile_map) =
	        Project.check_compiled'
	          (Info.make_default_options (), location)
	          (project, mod_id)
	          (out_of_date, compile_map)
	    in
	      (project, out_of_date_now, depend_map, compile_map)
	    end
	in
	  do_check_one (ModuleId.from_host (OS.Path.file module, location))
	end

      val (project', out_of_date, _, _) =
	Lists.reducel
	  check_one
	  ((initProject, [], Project.empty_map, Project.visited_pervasives),
	   Project.currentTargets initProject)

      val name = Project.get_project_name project
      fun print_one m = print(ModuleId.string m ^ "\n")
    in
      case out_of_date
      of [] =>
	print ("No files to recompile for " ^ name ^ "\n")
      |  _ =>
        ( print ("Files to recompile for " ^ name ^ ":\n");
          app print_one out_of_date );
      project'
    end

  fun show_build error_info options _ =
    let
      val location = Info.Location.FILE "<batch compiler:show_build>"
      val initProject =
	Project.fromFileInfo
	  (error_info, location)
	  (Project.initialize (error_info, location))
    in
      ignore(
        Project.map_dag 
          (show_build_targets_for (error_info, options, location)) initProject);
      ()
    end

  fun compile_file'
	error_info
	(options, project, []) = project
    | compile_file'
	error_info
	(options, project, module_ids) =

     let val precompiled_context = 
           get_precompiled_context(project, false, error_info) 

         fun compile_one (proj, m) =
            compile_file''
              error_info
              (options, proj, m, false, precompiled_context()) 

         val module_ids' = 
               Lists.filterp 
                 (fn m => Project.module_id_in_project (project, m))
                 module_ids
      in
        Lists.reducel compile_one (project, module_ids')
     end
end












