(*  Utilities for shell etc.
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
 *  $Log: shell_utils.sml,v $
 *  Revision 1.48  1998/10/30 16:20:41  jont
 *  [Bug #70198]
 *  Add functions to make dlls and exes from a project
 *
 * Revision 1.47  1998/05/19  11:49:24  mitchell
 * [Bug #50071]
 * Add support for force compiles and loads
 *
 * Revision 1.46  1998/05/07  09:19:24  mitchell
 * [Bug #50071]
 * Add support for touch_all_sources
 *
 * Revision 1.45  1998/01/29  16:05:48  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.44.2.4  1997/12/03  13:30:07  daveb
 * [Bug #30017]
 * Rationalised Shell.Project commands:
 * Removed touch_source_file.
 * Added {,show_}{compile,load}_targets.
 * Made load/compile functions take strings instead of module_ids, and
 * explicit location values.
 *
 * Revision 1.44.2.3  1997/12/02  16:30:47  daveb
 * [Bug #30071]
 * Removed functions for loading from source files.
 *
 * Revision 1.44.2.2  1997/11/26  11:37:10  daveb
 * [Bug #30071]
 * The action queue is no more, so ShellUtils.use_{file,string} and
 * ShellUtils.read_dot_mlworks no longer take queue functions.
 *
 * Revision 1.44.2.1  1997/09/11  20:54:42  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.44  1997/05/01  12:39:47  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.43  1997/03/19  13:13:40  matthew
 * Adding use function
 *
 * Revision 1.42  1996/08/15  12:59:22  daveb
 * [Bug #1519]
 * Added value_from_history_entry.
 *
 * Revision 1.41  1996/08/06  14:33:59  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_scheme.sml and _types.sml
 *
 * Revision 1.40  1996/05/20  12:12:21  daveb
 * Moved preferences_file_name to new save_image module.
 *
 * Revision 1.39  1996/05/08  11:16:24  daveb
 * Added Info.options argument to use_file.
 *
 * Revision 1.38  1996/05/03  11:49:36  daveb
 * Removed the ShellUtils.Error exception.
 *
 * Revision 1.37  1996/04/23  12:46:46  daveb
 * show_source no longer returns a destroy function.
 * Added some comments.
 *
 * Revision 1.36  1996/04/09  16:41:09  daveb
 * Added preferences argument to load_source, load_file and use_file, because
 * UserContext.process_result now requires this.
 *
 * Revision 1.35  1996/03/25  15:38:41  daveb
 * Added delete_from_project.
 * Modified types of some other functions to suit Incremental.match_*_path.
 *
 * Revision 1.34  1996/03/19  12:23:35  daveb
 * Added check_load_file.
 *
 * Revision 1.33  1996/03/11  10:33:31  daveb
 * Removed compile_string and default_dynamic.
 *
 * Revision 1.32  1996/02/29  12:23:41  matthew
 * Adding preference_file_name function
 *
 * Revision 1.31  1996/02/01  16:02:01  daveb
 * Removed commented-out save function.
 *
 *  Revision 1.30  1996/01/22  11:19:15  daveb
 *  Removed history functions (replaced by more complete functionality in
 *  gui_utils).
 *
 *  Revision 1.29  1996/01/17  17:12:46  matthew
 *  Adding value_from_user_context function
 *
 *  Revision 1.28  1995/12/04  11:41:37  daveb
 *  InterMake and Incremental now use Projects.
 *
 *  Revision 1.27  1995/10/20  10:09:59  daveb
 *  Added show_source.
 *
 *  Revision 1.26  1995/10/17  10:36:35  matthew
 *  Simplifying tracing interface.
 *
 *  Revision 1.25  1995/07/13  10:10:17  matthew
 *  Adding compile functions for use by evaluator.
 *
 *  Revision 1.24  1995/06/14  12:19:52  daveb
 *  Removed redundant Context parameter from edit functions.
 *
 *  Revision 1.23  1995/06/05  14:11:02  daveb
 *  make_file and load_file now take a user_options argument, for passing
 *  to process_result.
 *
 *  Revision 1.22  1995/05/25  17:23:07  daveb
 *  add_history_item now takes user_preferences instead of user_options.
 *
 *  Revision 1.21  1995/04/27  15:18:30  matthew
 *  Removing exception EditObject
 *  
 *  Revision 1.20  1995/04/21  13:59:20  daveb
 *  touch_compile_module and touch_compile_file now take a filename
 *  argument for use in location information in the event of errors.
 *  
 *  Revision 1.19  1994/08/02  10:03:22  daveb
 *  Added editable function.
 *  
 *  Revision 1.18  1994/07/29  16:12:46  daveb
 *  Moved preferences out of Options structure.
 *  
 *  Revision 1.17  1994/06/21  14:23:19  daveb
 *  Replaced Context Refs by user_contexts.  Replaced the Context argument
 *  of the Error exception with a list of new modules, for updating the
 *  user_context appropriately.
 *  
 *  Revision 1.16  1994/03/30  18:45:44  daveb
 *  Added touch_compile_module and touch_compile_file.
 *  
 *  Revision 1.15  1994/03/25  16:02:39  daveb
 *  Revised functions to work with ActionQueue.with_source_path.
 *  
 *  Revision 1.14  1994/03/17  17:04:08  matthew
 *  Added edit_file and check_make_file
 *  
 *  Revision 1.13  1994/03/14  16:40:54  matthew
 *  Added untrace function
 *  
 *  Revision 1.12  1994/01/28  16:27:46  matthew
 *  Improvements to error locations
 *  
 *  Revision 1.11  1994/01/06  16:16:02  matthew
 *  Added load_file
 *  
 *  Revision 1.10  1993/10/08  16:23:14  matthew
 *  Merging in bug fixes
 *  
 *  Revision 1.9  1993/09/03  13:12:21  jont
 *  Added save_file function
 *  
 *  Revision 1.8.1.2  1993/10/07  12:55:12  matthew
 *  Added object_editable, object_traceable, find_common_completion,
 *  trim_history_string and add_history_item
 *  
 *  Revision 1.8.1.1  1993/08/25  14:49:58  jont
 *  Fork for bug fixing
 *  
 *  Revision 1.8  1993/08/25  14:49:58  matthew
 *  Return quit function from ShellUtils.edit_string etc.
 *  
 *  Revision 1.7  1993/08/24  12:15:11  matthew
 *  Added message function parameter to trace
 *  
 *  Revision 1.6  1993/07/14  16:53:29  daveb
 *  make_file and use_file now take strings (representing moduleids) instead
 *  of filenames.
 *  
 *  Revision 1.5  1993/06/16  16:23:20  matthew
 *  Added edit_object and trace functions
 *  
 *  Revision 1.4  1993/05/27  14:43:55  matthew
 *  Added error_info param to eval
 *  Added function get_completions
 *  
 *  Revision 1.3  1993/05/12  14:20:35  matthew
 *  Added make, use and eval functions
 *  
 *  Revision 1.2  1993/05/11  16:15:37  matthew
 *  Added make_file, parse_absolute and (commented out) eval
 *  
 *  Revision 1.1  1993/04/30  10:57:02  matthew
 *  Initial revision
 *  
 *
 *)

require "../main/options";
require "../main/info";

signature SHELL_UTILS =
  sig
    structure Info : INFO
    structure Options : OPTIONS

    type preferences
    type user_preferences
    type UserOptions
    type user_context
    type history_entry
    type Context
    type Type
    type ShellData
    type Project

    exception EditFailed of string

    (* The following functions invoke the editor on the location passed as
       an argument (either as the type, a string representation thereof,
       or a code vector containing the location).  If the editor is not
       linked by a socket or DDE, the function returned will destroy it. *)
    val edit_location : Info.Location.T * preferences -> (unit -> unit)
    val edit_source : string * preferences -> (unit -> unit)
    val edit_object : MLWorks.Internal.Value.T * preferences -> (unit -> unit)

    (* edit_file just takes a file name *)
    val edit_file : string * preferences -> (unit -> unit)

    (* show_source is similar to edit_source, but only succeeds if the
       editor is linked via a socket or DDE.  The caller can use the
       File Viewer tool if show_source fails. *)
    val show_source : string * preferences -> unit

    (* uneditable filenames (e.g. listeners) are of the form "<...>" *)
    val editable : Info.Location.T -> bool
    val object_editable : MLWorks.Internal.Value.T -> bool

    val trace : MLWorks.Internal.Value.T -> unit

    val untrace : MLWorks.Internal.Value.T -> unit

    val object_traceable : MLWorks.Internal.Value.T -> bool

    val object_path: string * Info.Location.T -> string 
                     (* source-file-name * location -> object-path *)

    val force_compile: 
      Info.Location.T * Options.options  -> Info.options -> string -> unit
    val force_compile_all: 
      Info.Location.T * Options.options  -> Info.options -> unit

    val delete_from_project: string * Info.Location.T -> unit

    (* Just makes the executable required to call the project dll for the given target *)
    val make_exe_from_project :
      Info.Location.T *
      Info.options *
      string * string list ->
      unit

    (* Makes the dll/so from a project *)
    val make_dll_from_project :
      Info.Location.T *
      Info.options *
      string * string list ->
      unit

    (* Compile/load files *)

    val compile_file :
      Info.Location.T * Options.options  -> Info.options -> string -> unit

    val show_compile_file :
      Info.Location.T * (string -> unit) -> Info.options -> string -> unit

    val load_file :
      user_context *
      Info.Location.T *
      Options.options *
      preferences *
      (string -> unit) ->
      Info.options -> string ->
      unit

    val show_load_file :
      Info.Location.T * (string -> unit) ->
      Info.options -> string ->
      unit


    (* Compile/load targets *)

    val compile_targets :
      Info.Location.T * Options.options  -> Info.options -> unit

    val show_compile_targets :
      Info.Location.T * (string -> unit) -> Info.options -> unit

    val load_targets :
      user_context *
      Info.Location.T *
      Options.options *
      preferences *
      (string -> unit) ->
      Info.options -> 
      unit

    val show_load_targets :
      Info.Location.T * (string -> unit) ->
      Info.options -> unit

    (* Use functions *)

    val use_file : ShellData * (string -> unit) * string -> unit
    val use_string : ShellData * (string -> unit) * string -> unit


    (* Type Dynamic *)

    exception NotAnExpression

    val eval :
      Info.options ->
      string *
      Options.options *
      Context ->
      (MLWorks.Internal.Value.T * Type)

    val print_value :
      (MLWorks.Internal.Value.T * Type) *
      Options.print_options * 
      Context ->
      string

    val print_type :
      Type * Options.options * Context -> string

    val get_completions :
      string * Options.options * Context -> (string * string list)

    val find_common_completion : string list -> string

    val lookup_name :
      string * Context * (MLWorks.Internal.Value.T * Type)
      -> (MLWorks.Internal.Value.T * Type)

    val value_from_history_entry :
      history_entry * Options.options ->
      (string * (MLWorks.Internal.Value.T * Type)) option

    val value_from_user_context :
      user_context * UserOptions ->
      (string * (MLWorks.Internal.Value.T * Type)) option

    val read_dot_mlworks: ShellData -> unit
  end
