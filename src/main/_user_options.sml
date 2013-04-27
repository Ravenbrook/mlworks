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
 *
 *  $Log: _user_options.sml,v $
 *  Revision 1.57  1998/04/24 15:35:32  johnh
 *  [Bug #30229]
 *  Group compiler options to allow more flexibility.
 *
 * Revision 1.56  1998/03/20  15:57:48  jont
 * [Bug #30090]
 * Modify to use TextIO instead of MLWorks.IO
 *
 * Revision 1.55  1998/03/03  09:54:51  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.54  1998/02/19  17:16:47  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.53  1997/10/01  16:31:47  jkbrook
 * [Bug #20088]
 * Merging from MLWorks_11:
 * SML'96 should be SML'97
 *
 * Revision 1.52  1997/05/27  11:13:16  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.51  1997/03/25  11:25:38  matthew
 * Renaming R4000 option
 *
 * Revision 1.50  1997/01/21  10:44:55  matthew
 * Adding architecture dependent options
 *
 * Revision 1.49  1997/01/02  15:26:17  matthew
 * Adding local_functions option
 *
 * Revision 1.48  1996/11/06  11:29:18  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.47  1996/09/23  12:01:30  andreww
 * [Bug #1605]
 * removing default_overloads flag.  Now subsumed by old_definition.
 *
 * Revision 1.46  1996/07/18  17:26:29  jont
 * Add option to turn on/off compilation messages from intermake
 *
 * Revision 1.45  1996/05/22  16:51:26  daveb
 * Made is_debugging check that var_info is set.
 *
 * Revision 1.44  1996/05/22  12:47:30  daveb
 * Combined Local Variable and Debugging modes.
 *
 * Revision 1.43  1996/05/21  14:26:27  daveb
 * Renaming modes.
 *
 * Revision 1.42  1996/05/20  17:48:49  daveb
 * Added a comment or two.
 *
 * Revision 1.41  1996/05/20  14:50:43  daveb
 * Added functions to set and clear particular user options, including modes.
 *
 * Revision 1.40  1996/05/01  09:42:23  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.39  1996/04/29  15:00:35  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.38  1996/03/19  10:20:07  matthew
 * Adding "old_definition" option
 *
 * Revision 1.37  1996/02/29  14:13:20  matthew
 * Adding facility to save to stream
 *
 * Revision 1.36  1995/11/17  13:45:45  daveb
 * Removed no_execute.
 *
 *  Revision 1.35  1995/10/25  18:05:41  jont
 *  Adding opt_handlers compiler option
 *
 *  Revision 1.34  1995/06/30  15:38:45  daveb
 *  Added float_precision option to ValuePrinter options.
 *
 *  Revision 1.33  1995/05/26  10:19:46  daveb
 *  Divided user options into per-tool options and per-context options.
 *
 *  Revision 1.32  1995/05/15  14:48:22  matthew
 *  cout -s main/user_options.sml
 *  Renameing nj_semicolons
 *
 *  Revision 1.31  1995/05/02  11:53:41  matthew
 *  Removing debug_polyvariables option
 *
 *  Revision 1.30  1995/03/13  12:21:17  daveb
 *  Added set_context and sense_context.
 *
 *  Revision 1.29  1995/03/09  21:27:05  daveb
 *  Added sensitivity options.
 *
 *  Revision 1.28  1995/02/14  12:08:31  matthew
 *  Change option debug to generate_debug_info
 *
 *  Revision 1.27  1994/08/01  14:43:07  daveb
 *  Moved preferences to separate structure.
 *
 *  Revision 1.25  1994/05/05  16:11:37  daveb
 *  Added default_overloads, vector_literals, and wildcard_warnings.
 *
 *  Revision 1.24  1994/02/28  08:33:56  nosa
 *  Step and Modules Debugger compiler options.
 *
 *  Revision 1.23  1993/12/17  16:18:32  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.22  1993/12/01  15:12:33  io
 *  Added max_num_errors
 *
 *  Revision 1.21  1993/11/04  16:35:57  jont
 *  Added interrupt option
 *
 *  Revision 1.20  1993/10/13  14:54:52  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.20  1993/10/13  12:24:30  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.19  1993/09/03  10:38:26  nosa
 *  New compiler option debug_polyvariables for polymorphic debugger.

 *  Revision 1.18.1.2  1993/10/12  13:54:59  daveb
 *  Changed print options.
 *
 *  Revision 1.18.1.1  1993/08/23  14:14:54  jont
 *  Fork for bug fixing
 *
 *  Revision 1.18  1993/08/23  14:14:54  richard
 *  Added output_lambda option.
 *
 *  Revision 1.17  1993/08/10  16:11:17  matthew
 *  Added update function list component to user_options type
 *
 *  Revision 1.16  1993/08/09  15:53:00  matthew
 *  Added more environment preferences
 *
 *  Revision 1.15  1993/07/13  14:37:15  nosa
 *  new compiler option debug_variables for local and closure variable
 *  inspection in the debugger.
 *
 *  Revision 1.14  1993/06/11  09:02:23  matthew
 *  Fixed typo
 *
 *  Revision 1.13  1993/06/10  13:17:33  matthew
 *  Added open fixity and fixity spec options
 *
 *  Revision 1.12  1993/05/28  14:13:07  matthew
 *  environment_options = new_environment_options user_options
 *
 *  Added environment options
 *
 *  Revision 1.11  1993/05/19  09:51:40  daveb
 *  Rearranged some of the options.
 *
 *  Revision 1.10  1993/05/14  12:23:14  jont
 *  Added options to control parse treatment of New Jersey style weak type variables
 *
 *  Revision 1.9  1993/05/11  14:55:48  jont
 *  Added option to control make -n type facility
 *
 *  Revision 1.8  1993/04/27  13:49:40  richard
 *  Unified profiling and tracing options into `intercept'.
 *  Removed poly_makestring option.
 *
 *  Revision 1.7  1993/04/22  11:43:06  richard
 *  The editor interface is now implemented directly through
 *  Unix system calls, and is not part of the pervasive library
 *  or the runtime system.
 *
 *  Revision 1.6  1993/04/07  15:44:15  jont
 *  Added editor options
 *
 *  Revision 1.5  1993/04/01  13:52:41  jont
 *  Added compatibility options
 *  
 *  Revision 1.4  1993/03/23  16:43:17  daveb
 *  Added require_keyword and type_dynamic options.
 *  
 *  Revision 1.3  1993/03/10  14:37:07  matthew
 *  Added compat options
 *  Changed options to be record not tuple
 *  
 *  Revision 1.2  1993/03/05  12:01:23  matthew
 *  Options & Info changes
 *  
 *  Revision 1.1  1993/03/01  16:11:55  daveb
 *  Initial revision
 *)

require "../basis/__int";
require "../basis/__text_io";
require "../utils/lists";

require "options";
require "user_options";

functor UserOptions (
  structure Options: OPTIONS
  structure Lists: LISTS
): USER_OPTIONS =
struct
  structure Options = Options

  datatype user_context_options = USER_CONTEXT_OPTIONS of
    ({generate_interceptable_code:                    bool ref,
      generate_debug_info:                            bool ref,
      generate_variable_debug_info:                   bool ref,
      generate_moduler:                               bool ref,
      generate_interruptable_code:                    bool ref,
      optimize_handlers:			      bool ref,
      optimize_leaf_fns:                              bool ref,
      optimize_tail_calls:                            bool ref,
      optimize_self_tail_calls:                       bool ref,
      local_functions:                                bool ref,
      print_messages:                                 bool ref,
      mips_r4000:                                     bool ref,
      sparc_v7:                                       bool ref,
      require_keyword:                                bool ref,
      type_dynamic:                                   bool ref,
      abstractions:                                   bool ref,
      nj_op_in_datatype:                              bool ref,
      nj_signatures:                                  bool ref,
      fixity_specs:                                   bool ref,
      open_fixity:                                    bool ref,
      weak_type_vars:                                 bool ref,
      old_definition:		                      bool ref}
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
      set_selection:                                 bool ref,
      sense_selection:                               bool ref,
      set_context:                                   bool ref,
      sense_context:                                 bool ref}
    * (unit -> unit) list ref)

  fun make_user_tool_options
    (Options.OPTIONS
       {listing_options =
          Options.LISTINGOPTIONS
            {show_absyn, show_lambda, show_match, show_opt_lambda,
             show_environ, show_mir, show_opt_mir, show_mach},
        print_options =
          Options.PRINTOPTIONS
            {maximum_seq_size, maximum_string_size, maximum_ref_depth,
             maximum_str_depth, maximum_sig_depth, maximum_depth, float_precision,
	     print_fn_details, print_exn_details, show_id_class, show_eq_info},
        ...}) =
     USER_TOOL_OPTIONS
       ({maximum_seq_size         = ref maximum_seq_size,
         maximum_string_size      = ref maximum_string_size,
         maximum_ref_depth        = ref maximum_ref_depth,
         maximum_str_depth        = ref maximum_str_depth,
         maximum_sig_depth        = ref maximum_sig_depth,
         maximum_depth            = ref maximum_depth,
         float_precision          = ref float_precision,
         show_fn_details          = ref print_fn_details,
         show_exn_details         = ref print_exn_details,
         show_id_class            = ref show_id_class,
         show_eq_info             = ref show_eq_info,
         show_absyn               = ref show_absyn,
         show_match               = ref show_match,
         show_lambda              = ref show_lambda,
         show_environ             = ref show_environ,
         show_opt_lambda          = ref show_opt_lambda,
         show_mir                 = ref show_mir,
         show_opt_mir             = ref show_opt_mir,
         show_mach                = ref show_mach,
         show_debug_info          = ref false,
         show_timings             = ref false,
         show_print_timings       = ref false,
         set_context		  = ref true,
         sense_context	  	  = ref true,
         set_selection		  = ref true,
         sense_selection	  = ref true},
	ref nil)

  fun make_user_context_options
    (Options.OPTIONS
       {compiler_options = Options.COMPILEROPTIONS
          {generate_debug_info, debug_variables, generate_moduler,
	   intercept, interrupt, opt_handlers, opt_leaf_fns, opt_tail_calls,
	   opt_self_calls, local_functions, print_messages, 
           mips_r4000, sparc_v7},
        compat_options = Options.COMPATOPTIONS
          {nj_op_in_datatype,
           nj_signatures, weak_type_vars, fixity_specs, open_fixity,
           abstractions, old_definition},
        extension_options = Options.EXTENSIONOPTIONS
          {require_keyword, type_dynamic},
	...}) =
    USER_CONTEXT_OPTIONS
      ({generate_interceptable_code  = ref intercept,
        generate_debug_info          = ref generate_debug_info,
        generate_variable_debug_info = ref debug_variables,
        generate_moduler  	     = ref generate_moduler,
        generate_interruptable_code  = ref interrupt,
        optimize_handlers            = ref opt_handlers,
        optimize_leaf_fns            = ref opt_leaf_fns,
        optimize_tail_calls          = ref opt_tail_calls,
        optimize_self_tail_calls     = ref opt_self_calls,
        local_functions              = ref local_functions,
        print_messages               = ref print_messages,
        mips_r4000                   = ref mips_r4000,
        sparc_v7                     = ref sparc_v7,
        require_keyword   	     = ref require_keyword,
        type_dynamic		     = ref type_dynamic,
        abstractions		     = ref abstractions,
        old_definition		     = ref old_definition,
        nj_op_in_datatype	     = ref nj_op_in_datatype,
        nj_signatures	  	     = ref nj_signatures,
        fixity_specs                 = ref fixity_specs,
        open_fixity                  = ref open_fixity,
        weak_type_vars	   	     = ref weak_type_vars},
       ref nil)

    fun copy_user_tool_options
	  (USER_TOOL_OPTIONS
	     ({maximum_seq_size, maximum_string_size, maximum_ref_depth,
               maximum_str_depth, maximum_sig_depth, maximum_depth, float_precision,
	       show_fn_details, show_exn_details,
	       show_id_class, show_eq_info, show_absyn, show_match,
	       show_lambda, show_environ, show_opt_lambda, show_mir,
	       show_opt_mir, show_mach, show_debug_info, show_timings,
	       show_print_timings,
	       set_selection, sense_selection, set_context, sense_context},
	      _)) =
      USER_TOOL_OPTIONS
       ({maximum_seq_size         = ref (!maximum_seq_size),
         maximum_string_size      = ref (!maximum_string_size),
         maximum_ref_depth        = ref (!maximum_ref_depth),
         maximum_str_depth        = ref (!maximum_str_depth),
         maximum_sig_depth        = ref (!maximum_sig_depth),
         maximum_depth            = ref (!maximum_depth),
         float_precision          = ref (!float_precision),
         show_fn_details          = ref (!show_fn_details),
         show_exn_details         = ref (!show_exn_details),
         show_id_class            = ref (!show_id_class),
         show_eq_info             = ref (!show_eq_info),
         show_absyn               = ref (!show_absyn),
         show_match               = ref (!show_match),
         show_lambda              = ref (!show_lambda),
         show_environ             = ref (!show_environ),
         show_opt_lambda          = ref (!show_opt_lambda),
         show_mir                 = ref (!show_mir),
         show_opt_mir             = ref (!show_opt_mir),
         show_mach                = ref (!show_mach),
         show_debug_info          = ref (!show_debug_info),
         show_timings             = ref (!show_timings),
         show_print_timings       = ref (!show_print_timings),
         set_context		  = ref (!set_context),
         sense_context	  	  = ref (!sense_context),
         set_selection		  = ref (!set_selection),
         sense_selection	  = ref (!sense_selection)},
        ref nil)

    fun copy_user_context_options
          (USER_CONTEXT_OPTIONS
	    ({generate_interceptable_code, generate_interruptable_code,
	      generate_debug_info, generate_variable_debug_info,
	      generate_moduler,
	      optimize_handlers,
	      optimize_leaf_fns, optimize_tail_calls, optimize_self_tail_calls,
              local_functions,
	      print_messages,
              mips_r4000,sparc_v7,
	      abstractions, old_definition,
	      nj_op_in_datatype, nj_signatures,
              fixity_specs,
              open_fixity,
	      require_keyword,
              type_dynamic,
              weak_type_vars}, _)) =
      USER_CONTEXT_OPTIONS
       ({generate_interceptable_code  = ref (!generate_interceptable_code),
         generate_debug_info          = ref (!generate_debug_info),
         generate_variable_debug_info = ref (!generate_variable_debug_info),
         generate_moduler             = ref (!generate_moduler),
         generate_interruptable_code  = ref (!generate_interruptable_code),
	 optimize_handlers	      = ref (!optimize_handlers),
         optimize_leaf_fns            = ref (!optimize_leaf_fns),
         optimize_tail_calls          = ref (!optimize_tail_calls),
         optimize_self_tail_calls     = ref (!optimize_self_tail_calls),
         local_functions              = ref (!local_functions),
         print_messages               = ref (!print_messages),
         mips_r4000                   = ref (!mips_r4000),
         sparc_v7                     = ref (!sparc_v7),
	 require_keyword   	      = ref (!require_keyword),
	 type_dynamic		      = ref (!type_dynamic),
	 abstractions		      = ref (!abstractions),
	 old_definition		      = ref (!old_definition),
	 nj_op_in_datatype	      = ref (!nj_op_in_datatype),
	 nj_signatures	  	      = ref (!nj_signatures),
         fixity_specs                 = ref (!fixity_specs),
         open_fixity                  = ref (!open_fixity),
	 weak_type_vars	   	      = ref (!weak_type_vars)},
	ref nil)

    fun update_user_context_options user_context_options =
      let
        val USER_CONTEXT_OPTIONS (_, ref update_fns) = user_context_options
      in
        Lists.iterate (fn f => f ()) update_fns
      end

    fun update_user_tool_options user_tool_options =
      let
        val USER_TOOL_OPTIONS (_, ref update_fns) = user_tool_options
      in
        Lists.iterate (fn f => f ()) update_fns
      end

    fun get_user_context_option (f, user_context_options) =
      let
        val USER_CONTEXT_OPTIONS (user_options, _) = user_context_options
      in
        !(f user_options)
      end

    fun set_user_context_option (f, user_context_options) =
      let
        val USER_CONTEXT_OPTIONS (user_options, _) = user_context_options
      in
        (f user_options) := true
      end

    fun clear_user_context_option (f, user_context_options) =
      let
        val USER_CONTEXT_OPTIONS (user_options, _) = user_context_options
      in
        (f user_options) := false
      end

    (* The following functions set the options for each mode.  The
       update function must not be called here: in the GUI it is
       called automatically by the dialog code.  The functions in
       _shell_structure must call it explicitiy. *)
       
    fun select_compatibility user_options =
      (set_user_context_option (#nj_op_in_datatype, user_options);
       set_user_context_option (#nj_signatures, user_options);
       set_user_context_option (#weak_type_vars, user_options);
       set_user_context_option (#abstractions, user_options);
       set_user_context_option (#fixity_specs, user_options);
       set_user_context_option (#open_fixity, user_options);
       set_user_context_option (#old_definition, user_options))

    fun select_sml'97 user_options =
      (clear_user_context_option (#nj_op_in_datatype, user_options);
       clear_user_context_option (#nj_signatures, user_options);
       clear_user_context_option (#weak_type_vars, user_options);
       clear_user_context_option (#abstractions, user_options);
       clear_user_context_option (#fixity_specs, user_options);
       clear_user_context_option (#open_fixity, user_options);
       clear_user_context_option (#old_definition, user_options))

    fun select_sml'90 user_options =
      (clear_user_context_option (#nj_op_in_datatype, user_options);
       clear_user_context_option (#nj_signatures, user_options);
       clear_user_context_option (#weak_type_vars, user_options);
       clear_user_context_option (#abstractions, user_options);
       clear_user_context_option (#fixity_specs, user_options);
       clear_user_context_option (#open_fixity, user_options);
       set_user_context_option (#old_definition, user_options))


    val unset = clear_user_context_option
    val set = set_user_context_option

    fun select_quick_compile user_options = 
      (set (#optimize_leaf_fns, user_options);
       set (#optimize_tail_calls, user_options);
       set (#optimize_self_tail_calls, user_options);
       unset (#generate_interceptable_code, user_options);
       unset (#generate_debug_info, user_options);
       unset (#generate_variable_debug_info, user_options);
       unset (#local_functions, user_options))

    fun select_optimizing user_options =
      (*
      (set_user_context_option (#optimize_handlers, user_options);
      *)
      (set (#optimize_leaf_fns, user_options);
       set (#optimize_tail_calls, user_options);
       set (#optimize_self_tail_calls, user_options);
       unset (#generate_interceptable_code, user_options);
       unset (#generate_debug_info, user_options);
       unset (#generate_variable_debug_info, user_options);
       set (#local_functions, user_options))

    fun select_debugging user_options =
      (set (#generate_interceptable_code, user_options);
       set (#generate_debug_info, user_options);
       set (#generate_variable_debug_info, user_options);
       unset (#optimize_leaf_fns, user_options);
       unset (#optimize_tail_calls, user_options);
       unset (#optimize_self_tail_calls, user_options))

    fun is_sml'97 user_options =
      not (get_user_context_option (#nj_op_in_datatype, user_options)) andalso
      not (get_user_context_option (#nj_signatures, user_options)) andalso
      not (get_user_context_option (#weak_type_vars, user_options)) andalso
      not (get_user_context_option (#open_fixity, user_options)) andalso
      not (get_user_context_option (#fixity_specs, user_options)) andalso
      not (get_user_context_option (#abstractions, user_options)) andalso
      not (get_user_context_option (#old_definition, user_options))

    fun is_compatibility user_options =
      get_user_context_option (#nj_op_in_datatype, user_options) andalso
      get_user_context_option (#nj_signatures, user_options) andalso
      get_user_context_option (#weak_type_vars, user_options) andalso
      get_user_context_option (#open_fixity, user_options) andalso
      get_user_context_option (#fixity_specs, user_options) andalso
      get_user_context_option (#abstractions, user_options) andalso
      get_user_context_option (#old_definition, user_options)

    fun is_sml'90 user_options =
      not (get_user_context_option (#nj_op_in_datatype, user_options)) andalso
      not (get_user_context_option (#nj_signatures, user_options)) andalso
      not (get_user_context_option (#weak_type_vars, user_options)) andalso
      not (get_user_context_option (#open_fixity, user_options)) andalso
      not (get_user_context_option (#fixity_specs, user_options)) andalso
      not (get_user_context_option (#abstractions, user_options)) andalso
      get_user_context_option (#old_definition, user_options)

    val get_uc = get_user_context_option

    fun is_quick_compile user_options = 
      get_uc (#optimize_leaf_fns, user_options) andalso
      get_uc (#optimize_tail_calls, user_options) andalso
      get_uc (#optimize_self_tail_calls, user_options) andalso
      not (get_uc (#generate_debug_info, user_options)) andalso
      not (get_uc (#generate_interceptable_code, user_options)) andalso
      not (get_uc (#generate_variable_debug_info, user_options)) andalso
      not (get_uc (#local_functions, user_options))

    fun is_debugging user_options =
      get_uc (#generate_debug_info, user_options) andalso
      get_uc (#generate_interceptable_code, user_options) andalso
      get_uc (#generate_variable_debug_info, user_options) andalso
      not (get_uc (#optimize_leaf_fns, user_options)) andalso
      not (get_uc (#optimize_tail_calls, user_options)) andalso
      not (get_uc (#optimize_self_tail_calls, user_options))

    fun is_optimizing user_options =
      (*
      get_uc (#optimize_handlers, user_options) andalso
      *)
      get_uc (#optimize_leaf_fns, user_options) andalso
      get_uc (#optimize_tail_calls, user_options) andalso
      get_uc (#optimize_self_tail_calls, user_options) andalso
      not (get_uc (#generate_debug_info, user_options)) andalso
      not (get_uc (#generate_interceptable_code, user_options)) andalso
      not (get_uc (#generate_variable_debug_info, user_options)) andalso
      get_uc (#local_functions, user_options)


    fun new_print_options (USER_TOOL_OPTIONS (r, _)) =
      Options.PRINTOPTIONS
	{print_fn_details    = !(#show_fn_details r),
         print_exn_details   = !(#show_exn_details r),
         maximum_seq_size    = !(#maximum_seq_size r),
         maximum_string_size = !(#maximum_string_size r),
         maximum_ref_depth   = !(#maximum_ref_depth r),
         maximum_str_depth   = !(#maximum_str_depth r),
         maximum_sig_depth   = !(#maximum_sig_depth r),
         maximum_depth       = !(#maximum_depth r),
         float_precision     = !(#float_precision r),
         show_eq_info        = !(#show_eq_info r),
         show_id_class       = !(#show_id_class r) }
      
      
    fun new_compiler_options (USER_CONTEXT_OPTIONS (r, _)) =
      Options.COMPILEROPTIONS
	{generate_debug_info = !(#generate_debug_info r),
         debug_variables     = !(#generate_variable_debug_info r),
         generate_moduler    = !(#generate_moduler r),
         intercept           = !(#generate_interceptable_code r),
	 interrupt           = !(#generate_interruptable_code r),
	 opt_handlers	     = !(#optimize_handlers r),
         opt_leaf_fns        = !(#optimize_leaf_fns r),
         opt_tail_calls      = !(#optimize_tail_calls r),
         opt_self_calls      = !(#optimize_self_tail_calls r),
         local_functions     = !(#local_functions r),
	 print_messages      = !(#print_messages r),
         mips_r4000          = !(#mips_r4000 r),
         sparc_v7            = !(#sparc_v7 r)
         }

    fun new_listing_options (USER_TOOL_OPTIONS (r,_)) =
      Options.LISTINGOPTIONS
	{show_absyn      = !(#show_absyn r),
         show_lambda     = !(#show_lambda r),
         show_match      = !(#show_match r),
         show_opt_lambda = !(#show_opt_lambda r),
         show_environ    = !(#show_environ r),
         show_mir        = !(#show_mir r),
         show_opt_mir    = !(#show_opt_mir r),
         show_mach       = !(#show_mach r)}

    fun new_compat_options (USER_CONTEXT_OPTIONS (r, _)) =
      Options.COMPATOPTIONS
	{old_definition        = !(#old_definition r),
	 nj_op_in_datatype   = !(#nj_op_in_datatype r),
	 nj_signatures       = !(#nj_signatures r),
	 weak_type_vars      = !(#weak_type_vars r),
         fixity_specs        = !(#fixity_specs r),
         open_fixity         = !(#open_fixity r),
	 abstractions        = !(#abstractions r)}
      
    fun new_extension_options (USER_CONTEXT_OPTIONS (r, _)) =
      Options.EXTENSIONOPTIONS
	{type_dynamic       = !(#type_dynamic r),
	 require_keyword    = !(#require_keyword r)}

    fun new_options (user_tool_options, user_context_options) =
      Options.OPTIONS
        {listing_options   = new_listing_options user_tool_options,
         compiler_options  = new_compiler_options user_context_options,
         print_options     = new_print_options user_tool_options,
         extension_options = new_extension_options user_context_options,
         compat_options    = new_compat_options user_context_options
         }

    fun save_to_stream (USER_CONTEXT_OPTIONS (r,_), stream) =
      let
        fun out (name,value) = TextIO.output (stream, name ^ " " ^ value ^ "\n")
        fun write_bool true = "true"
          | write_bool false = "false"
        val write_int = Int.toString
      in
        out ("generate_interceptable_code",write_bool (!(#generate_interceptable_code r)));
        out ("generate_debug_info",write_bool (!(#generate_debug_info r)));
        out ("generate_variable_debug_info",write_bool (!(#generate_variable_debug_info r)));
        out ("generate_moduler",write_bool (!(#generate_moduler r)));
        out ("generate_interruptable_code",write_bool (!(#generate_interruptable_code r)));
        out ("optimize_handlers",write_bool (!(#optimize_handlers r)));
        out ("optimize_leaf_fns",write_bool (!(#optimize_leaf_fns r)));
        out ("optimize_tail_calls",write_bool (!(#optimize_tail_calls r)));
        out ("optimize_self_tail_calls",write_bool (!(#optimize_self_tail_calls r)));
        out ("local_functions",write_bool (!(#local_functions r)));
        out ("require_keyword",write_bool (!(#require_keyword r)));
        out ("type_dynamic",write_bool (!(#type_dynamic r)));
        out ("abstractions",write_bool (!(#abstractions r)));
        out ("old_definition",write_bool (!(#old_definition r)));
        out ("op_in_datatype",write_bool (!(#nj_op_in_datatype r)));
        out ("limited_open",write_bool (!(#nj_signatures r)));
        out ("fixity_specs",write_bool (!(#fixity_specs r)));
        out ("open_fixity",write_bool (!(#open_fixity r)));
        out ("weak_type_vars",write_bool (!(#weak_type_vars r)))
      end

    fun set_from_list (USER_CONTEXT_OPTIONS (r,_),items) =
      let
        fun get_bool "false" = false
          | get_bool _ = true
        fun do_one (component,value) =
          case component of
            "generate_interceptable_code" => (#generate_interceptable_code r) := get_bool value
          | "generate_debug_info" => (#generate_debug_info r) := get_bool value
          | "generate_variable_debug_info" => (#generate_variable_debug_info r) := get_bool value
          | "generate_moduler" => (#generate_moduler r) := get_bool value
          | "generate_interruptable_code" => (#generate_interruptable_code r) := get_bool value
          | "optimize_handlers" => (#optimize_handlers r) := get_bool value
          | "optimize_leaf_fns" => (#optimize_leaf_fns r) := get_bool value
          | "optimize_tail_calls" => (#optimize_tail_calls r) := get_bool value
          | "optimize_self_tail_calls" => (#optimize_self_tail_calls r) := get_bool value
          | "local_functions" => (#local_functions r) := get_bool value
          | "require_keyword" => (#require_keyword r) := get_bool value
          | "type_dynamic" => (#type_dynamic r) := get_bool value
          | "abstractions" => (#abstractions r) := get_bool value
          | "old_definition" => (#old_definition r) := get_bool value
          | "op_in_datatype" => (#nj_op_in_datatype r) := get_bool value
          | "limited_open" => (#nj_signatures r) := get_bool value
          | "fixity_specs" => (#fixity_specs r) := get_bool value
          | "open_fixity" => (#open_fixity r) := get_bool value
          | "weak_type_vars" => (#weak_type_vars r) := get_bool value
          | _ => ()
        fun iterate f [] = ()
          | iterate f (a::b) = (ignore(f a) ; iterate f b)
      in
        iterate do_one items
      end

end
