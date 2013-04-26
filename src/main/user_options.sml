(*  User-visible options.
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
 *  $Log: user_options.sml,v $
 *  Revision 1.50  1998/04/23 13:42:06  johnh
 *  [Bug #30229]
 *  group compiler options to allow more flexibility.
 *
 * Revision 1.49  1998/03/20  16:03:38  jont
 * [Bug #30090]
 * Modify to use TextIO instead of MLWorks.IO
 *
 * Revision 1.48  1998/03/02  15:07:22  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.47  1997/10/01  16:29:02  jkbrook
 * [Bug #20088]
 * Merging from MLWorks_11:
 * SML'96 should be SML'97
 *
 * Revision 1.46  1997/05/27  11:13:25  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.45  1997/03/25  11:50:03  matthew
 * Renaming R4000 option
 *
 * Revision 1.44  1997/01/21  10:40:14  matthew
 * Adding architecture dependent options
 *
 * Revision 1.43  1997/01/02  15:02:14  matthew
 * Adding local_functions option
 *
 * Revision 1.42  1996/09/23  12:02:44  andreww
 * [Bug #1605]
 * removing default_overloads flag.  Now subsumed by old_definition.
 *
 * Revision 1.41  1996/07/18  17:22:32  jont
 * Add option to turn on/off compilation messages from intermake
 *
 * Revision 1.40  1996/05/22  12:46:11  daveb
 * Combined Local Variable and Debugging modes.
 *
 * Revision 1.39  1996/05/21  14:25:49  daveb
 * Renaming modes.
 *
 * Revision 1.38  1996/05/20  12:36:40  daveb
 * Added functions to set and clear particular user options, including modes.
 *
 * Revision 1.37  1996/05/01  09:40:12  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.36  1996/03/19  10:45:04  matthew
 * Adding "old_definition" option
 *
 * Revision 1.35  1996/02/29  14:01:02  matthew
 * Adding facility to save to stream
 *
 * Revision 1.34  1995/11/17  13:47:13  daveb
 * Removed no_execute.
 *
 *  Revision 1.33  1995/10/25  18:02:29  jont
 *  Adding opt_handlers compiler option
 *
 *  Revision 1.32  1995/06/30  15:39:16  daveb
 *  Added float_precision option to ValuePrinter options.
 *   .
 *
 *  Revision 1.31  1995/06/01  11:31:40  daveb
 *  Divided user options into per-tool options and per-context options.
 *
 *  Revision 1.30  1995/05/15  14:46:31  matthew
 *  Renaming nj_semicolons
 *
 *  Revision 1.29  1995/05/02  11:53:18  matthew
 *  Removing debug_polyvariables option
 *
 *  Revision 1.28  1995/03/13  12:16:46  daveb
 *  Added set_context and sense_context.
 *
 *  Revision 1.27  1995/03/09  21:21:00  daveb
 *  Added sensitivity options.
 *
 *  Revision 1.26  1994/08/01  14:07:18  daveb
 *  Moved preferences into separate structure.
 *
 *  Revision 1.25  1994/07/26  13:47:10  daveb
 *  Added full_menus option.
 *
 *  Revision 1.24  1994/05/05  16:12:44  daveb
 *  Added default_overloads.
 *
 *  Revision 1.23  1994/02/28  05:35:34  nosa
 *  Step and Modules Debugger compiler options.
 *
 *  Revision 1.22  1993/12/17  16:16:56  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.21  1993/12/01  17:04:50  io
 *  Added max_num_errors
 *
 *
 *  Revision 1.19  1993/11/04  16:29:20  jont
 *  Added interrupt option
 *
 *  Revision 1.18  1993/10/13  14:51:56  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.17  1993/09/03  10:39:38  nosa
 *  New compiler option debug_polyvariables for polymorphic debugger.
 *
 *  Revision 1.16.1.2  1993/10/12  14:15:03  daveb
 *  Changed print options.
 *
 *  Revision 1.16.1.1  1993/08/23  14:14:53  jont
 *  Fork for bug fixing
 *
 *  Revision 1.16  1993/08/23  14:14:53  richard
 *  Added output_lambda option.
 *
 *  Revision 1.15  1993/08/10  16:06:54  matthew
 *  Added update function list component to user_options type
 *
 *  Revision 1.14  1993/08/09  15:36:55  matthew
 *  Added more environment preferences
 *
 *  Revision 1.13  1993/07/13  14:22:46  nosa
 *  new compiler option debug_variables for local and closure variable
 *  inspection in the debugger.
 *
 *  Revision 1.12  1993/06/10  13:21:09  matthew
 *  Added open fixity and fixity spec options
 *
 *  Revision 1.11  1993/05/19  09:52:12  daveb
 *  Rearranged some of the options.
 *
 *  Revision 1.10  1993/05/14  13:04:52  jont
 *  Added options to control parse treatment of New Jersey style weak type variables
 *
 *  Revision 1.9  1993/05/11  14:53:52  jont
 *  Added option to control make -n type facility
 *
 *  Revision 1.8  1993/04/27  13:49:42  richard
 *  Unified profiling and tracing options into `intercept'.
 *  Removed poly_makestring option.
 *
 *  Revision 1.7  1993/04/22  11:43:10  richard
 *  The editor interface is now implemented directly through
 *  Unix system calls, and is not part of the pervasive library
 *  or the runtime system.
 *
 *  Revision 1.6  1993/04/07  15:35:25  jont
 *  Added editor options
 *  
 *  Revision 1.5  1993/04/01  13:41:12  jont
 *  Added compatibility options
 *  
 *  Revision 1.4  1993/03/23  15:46:59  daveb
 *  Added require_keyword and type_dynamic options.
 *  
 *  Revision 1.3  1993/03/10  14:33:09  matthew
 *  Removed new_xxx_options functions
 *  
 *  Revision 1.2  1993/03/05  11:58:36  matthew
 *  Options & Info changes
 *  
 *  Revision 1.1  1993/03/01  15:19:08  daveb
 *  Initial revision
 *)

require "../main/options";
require "../basis/__text_io";

signature USER_OPTIONS =
sig
  structure Options: OPTIONS
  
  (* There are two sorts of options.  Context-specific options are stored in
     MotifContexts (defined in motif_utils).  Tool-specific options are
     stored in each tool.  Global options (preferences) are defined in
     the eponymous file. *)

  datatype user_context_options = USER_CONTEXT_OPTIONS of
    ({generate_interceptable_code:                   bool ref,
      generate_debug_info:                           bool ref,
      generate_variable_debug_info:                  bool ref,
      generate_moduler:                              bool ref,
      generate_interruptable_code:                   bool ref,
      optimize_handlers:			     bool ref,
      optimize_leaf_fns:                             bool ref,
      optimize_tail_calls:                           bool ref,
      optimize_self_tail_calls:                      bool ref,
      local_functions:                               bool ref,
      print_messages:                                bool ref,
      mips_r4000:                                    bool ref,
      sparc_v7:                                      bool ref,
      require_keyword:		                     bool ref,
      type_dynamic:		                     bool ref,
      abstractions:		                     bool ref,
      nj_op_in_datatype:	                     bool ref,
      nj_signatures:		                     bool ref,
      fixity_specs:                                  bool ref,
      open_fixity:                                   bool ref,
      weak_type_vars:		                     bool ref,
      old_definition:		                     bool ref}
    * (unit -> unit) list ref)

  datatype user_tool_options = USER_TOOL_OPTIONS of
    ({show_fn_details:                               bool ref,
      show_exn_details:                              bool ref,
      maximum_seq_size:                              int ref,
      maximum_string_size:                           int ref,
      maximum_depth:                                 int ref,
      maximum_ref_depth:                             int ref,
      maximum_str_depth:                             int ref,
      maximum_sig_depth:                             int ref,
      float_precision:                               int ref,
      show_id_class:                                 bool ref,
      show_eq_info:                                  bool ref,
      show_absyn:                                    bool ref,
      show_match:                                    bool ref,
      show_environ:                                  bool ref,
      show_lambda:                                   bool ref,
      show_opt_lambda:                               bool ref,
      show_mir:                                      bool ref,
      show_opt_mir:                                  bool ref,
      show_mach:                                     bool ref,
      show_debug_info:                               bool ref,
      show_timings:                                  bool ref,
      show_print_timings:                            bool ref,
      set_selection:		                     bool ref,
      sense_selection:		             	     bool ref,
      set_context:		                     bool ref,
      sense_context:		             	     bool ref}
    * (unit -> unit) list ref)

  val make_user_context_options: Options.options -> user_context_options
  val make_user_tool_options: Options.options -> user_tool_options

  val update_user_context_options: user_context_options -> unit
  val update_user_tool_options: user_tool_options -> unit

  val select_compatibility: user_context_options -> unit
  val select_sml'97: user_context_options -> unit
  val select_sml'90: user_context_options -> unit

  val select_quick_compile: user_context_options -> unit
  val select_optimizing: user_context_options -> unit
  val select_debugging: user_context_options -> unit

  val is_sml'97: user_context_options -> bool
  val is_compatibility: user_context_options -> bool
  val is_sml'90: user_context_options -> bool
  val is_debugging: user_context_options -> bool
  val is_optimizing: user_context_options -> bool
  val is_quick_compile: user_context_options -> bool

  val new_options: user_tool_options * user_context_options -> Options.options
  val new_print_options: user_tool_options -> Options.print_options

  val copy_user_context_options: user_context_options -> user_context_options
  val copy_user_tool_options: user_tool_options -> user_tool_options

  val save_to_stream : user_context_options * TextIO.outstream -> unit
  val set_from_list : user_context_options * (string * string) list -> unit
end;
