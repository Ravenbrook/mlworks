(* toplevel.sml the signature *)
(*
 * $Log: toplevel.sml,v $
 * Revision 1.71  1999/02/09 09:50:01  mitchell
 * [Bug #190505]
 * Support for precompilation of subprojects
 *
 * Revision 1.70  1999/02/05  11:56:12  mitchell
 * [Bug #190504]
 * Add ability to dump units in dependency order
 *
 * Revision 1.69  1998/01/27  17:51:28  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.68.10.2  1997/09/17  15:43:09  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.68.10.1  1997/09/11  20:56:25  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.68  1995/12/05  11:12:26  daveb
 * Modified type of compile_file' to support Project Tool.
 *
Revision 1.67  1995/09/05  16:28:39  jont
Add sml_cache to interface for compile_file' to improve finding
of .mo files

Revision 1.66  1995/05/26  14:35:35  matthew
Removing show_absyn etc.  These are now redundant.

Revision 1.65  1995/04/05  14:09:58  matthew
Removed some redundant values

Revision 1.64  1994/09/27  09:59:05  matthew
Improved caching of module ids

Revision 1.63  1994/03/21  15:09:01  daveb
added compile_module.

Revision 1.62  1994/02/01  15:23:49  daveb
Changed FileNameCache to ModuleCache.

Revision 1.61  1993/09/27  14:46:54  jont
Merging in bug fixes

Revision 1.60.1.2  1993/09/27  11:17:28  jont
changed comile_file' to take and return a pervasive mo cache.

Revision 1.60.1.1  1993/08/28  16:37:06  jont
Fork for bug fixing

Revision 1.60  1993/08/28  16:37:06  daveb
Changed type of compile_file to take a list of strings, so that caches can
be preserved between each compilation (I haven't implemented this yet).
Changed type of compile_file' to take a filename cache and a module id
instead of a file.

Revision 1.59  1993/08/23  14:15:29  richard
Added output_lambda option.

Revision 1.58  1993/08/09  16:40:42  daveb
Added a compile_pervasive function.  Removed pervasive_library_dir.
Changed the type of compile to take a moduleid instead of a string.

Revision 1.57  1993/06/25  10:10:09  daveb
Removed show_match.

Revision 1.56  1993/04/13  15:12:25  matthew
Exposed lambda optimisation switches

Revision 1.55  1993/03/11  12:37:40  matthew
Signature revisions

Revision 1.54  1993/03/09  12:57:38  matthew
Options & Info changes

Revision 1.53  1993/02/08  19:42:10  matthew
Typechecker structure changes

Revision 1.52  1993/02/01  16:34:58  matthew
Changed sharing.

Revision 1.51  1993/01/04  15:12:27  jont
Added show_mach to allow toplevel printing of machine code

Revision 1.50  1992/12/08  20:28:12  jont
Removed a number of duplicated signatures and structures

Revision 1.49  1992/12/08  12:13:25  jont
Removed the references for doing profiling etc, no longer used

Revision 1.48  1992/12/02  15:56:43  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.47  1992/12/02  14:04:12  jont
Modified to remove redundant info signatures

Revision 1.46  1992/11/27  17:31:05  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.45  1992/11/19  19:17:40  jont
Removed Info structure from parser, tidied upderived

Revision 1.44  1992/11/17  18:06:00  matthew
Changed Error structure to Info

Revision 1.43  1992/11/03  17:00:35  richard
Added a cache of consistency information to compile_file.

Revision 1.42  1992/10/27  17:07:03  jont
Removed Error from toplevel signature

Revision 1.41  1992/10/12  12:01:05  clive
Tynames now have a slot recording their definition point

Revision 1.40  1992/09/24  06:20:48  richard
Added sharing contraint on Error to signature.

Revision 1.39  1992/09/23  16:43:38  jont
Removed add_fn_names (obsolete)

Revision 1.38  1992/09/16  08:45:36  daveb
show_id_class controls printing of id classes (VAR, CON or EXCON).
show_eq_info controls printing of equality attribute of tycons.

Revision 1.37  1992/09/12  20:18:58  jont
Removed Lexer from toplevel signature

Revision 1.36  1992/09/10  09:17:42  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.
Added `augment'.

Revision 1.35  1992/09/09  10:03:38  clive
Added flag to switch off warning messages in generating recipes

Revision 1.34  1992/09/02  12:23:02  richard
Installed central error reporting mechanism.

Revision 1.33  1992/08/26  17:12:05  jont
Removed some redundant structures and sharing

Revision 1.32  1992/08/26  08:27:51  clive
Propogation of information about exceptions

Revision 1.31  1992/08/24  16:16:18  clive
Added details about leafness to the debug information

Revision 1.30  1992/08/19  19:07:58  davidt
Made changes to allow mo files to be copied.

Revision 1.29  1992/08/17  14:42:18  clive
Exception stop exported so it can be caught

Revision 1.28  1992/08/07  11:41:30  clive
Added the function set_debug_level

Revision 1.27  1992/07/22  16:08:49  jont
Added return of abstract syntax tree to compile_ts

Revision 1.26  1992/07/22  15:20:10  jont
Removed top_level from signature, not required

Revision 1.25  1992/07/14  16:17:26  richard
Removed obsolete memory profiling code.

Revision 1.24  1992/06/18  13:00:25  jont
Modified spec of compile_ts to return lambda expression

Revision 1.23  1992/06/18  09:23:26  davida
Added switch to allow compilation to stop at
lambda, and also display of size of lambda expr.

Revision 1.22  1992/06/16  11:22:25  davida
Added margin ref for lambda printing, so we make huge
listings shorter and fatter.

Revision 1.21  1992/06/15  15:26:16  jont
Modified signature to allow compile_ts to return some code

Revision 1.20  1992/06/12  19:19:37  jont
Added functions to do compiling and return results

Revision 1.19  1992/06/11  10:54:56  clive
Added flags for the recording of debug type information

Revision 1.18  1992/05/14  11:44:21  clive
Added memory profiling flag

Revision 1.17  1992/05/06  12:08:15  jont
Added do_check_bindings bool ref to control the checking of uniqueness
of bound lambda variable names. Default off

Revision 1.16  1992/04/13  15:29:37  clive
First version of the profiler

Revision 1.15  1992/03/17  18:43:02  jont
Added bool ref for add_fn_names to control addition of function names

Revision 1.14  1992/02/20  12:23:45  jont
Added show_match to control printing of match trees

Revision 1.13  1992/02/11  14:26:12  clive
New pervasive library

Revision 1.12  1992/01/31  12:11:59  clive
Added flags to control timing of the various sections

Revision 1.11  1992/01/28  17:57:06  jont
Added do_lambda_opt switch

Revision 1.10  1992/01/21  14:00:06  jont
Removed unnecessary items from signature

Revision 1.9  1992/01/10  16:40:26  jont
Added diagnostic to the signature

Revision 1.8  1991/12/19  16:00:46  jont
Removed compile_program from the spec

Revision 1.7  91/10/02  15:01:30  jont
Added show_mach for final code printing

Revision 1.6  91/09/16  11:12:36  davida
Added show_lambda, show_opt_lambda, show_environ
switches.

Revision 1.5  91/09/04  17:11:55  jont
Added show_opt_mir to control production and printing of optimised
intermediate code

Revision 1.4  91/08/06  12:47:18  davida
Added switch for mir printing too.

Revision 1.3  91/08/06  12:23:50  davida
Added switch for absyn printing so that we can
spot troublesome declarations in large files
with the present parser.

Revision 1.2  91/07/10  14:25:23  jont
Completed to handle initial environment and compile files and strings

Revision 1.1  91/07/09  17:13:32  jont
Initial revision


Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../main/options";
require "../main/info";
require "../utils/diagnostic";
require "../lambda/environtypes";

signature TOPLEVEL =
sig
  structure EnvironTypes : ENVIRONTYPES
  structure Info : INFO
  structure Options : OPTIONS
  structure Diagnostic : DIAGNOSTIC

  type ParserBasis
  type TypeBasis
  type ModuleId

  datatype compiler_basis =
    CB of (ParserBasis * TypeBasis * EnvironTypes.Top_Env)

  val initial_compiler_basis : compiler_basis

  val augment : compiler_basis * compiler_basis -> compiler_basis

  val error_output_level : Info.severity ref

  type Project 

  val compile_file' :
    Info.options ->
    Options.options * Project * ModuleId list ->
    Project

  val check_dependencies: Info.options -> Options.options -> string list -> unit

  val list_objects: Info.options -> Options.options -> string list -> unit

  val dump_objects: Info.options -> Options.options -> string -> unit

  val compile_file: Info.options -> Options.options -> string list -> unit

  val recompile_file: Info.options -> Options.options -> string list -> unit

  val recompile_pervasive: Info.options -> Options.options -> unit

  val build: Info.options -> Options.options -> unit -> unit

  val show_build: Info.options -> Options.options -> unit -> unit

  val print_timings: bool ref

end
