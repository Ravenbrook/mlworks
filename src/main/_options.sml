(*  ==== COMPILER OPTIONS CONTROL ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: _options.sml,v $
 *  Revision 1.47  1998/04/24 11:29:54  johnh
 *  [Bug #30229]
 *  local_functions set to false by default.
 *
 * Revision 1.46  1998/03/03  08:49:41  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.45  1997/10/10  09:19:19  daveb
 * [Bug #30280]
 *
 * No longer compile for R3000 by default on MIPS.
 *
 * Revision 1.44  1997/05/27  11:12:58  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.43  1997/04/23  10:43:01  daveb
 * [Bug #30040]
 * Turned on local function optimisation by default.
 *
 * Revision 1.42  1997/04/01  09:20:15  daveb
 * [Bug #1995]
 * Changed the default setting of the MIPS-specific compiler options back to
 * the most general values, so that we can build and distribute images on the
 * R3000.
 *
 * Revision 1.41  1997/03/25  11:24:32  matthew
 * Platform specific compiler options changes
 *
 * Revision 1.40  1997/01/24  14:25:27  matthew
 * Adding architecture dependent options
 *
 * Revision 1.39  1997/01/02  14:59:02  matthew
 * Adding local function option
 *
 * Revision 1.38  1996/09/23  11:59:43  andreww
 * [Bug #1605]
 * removing default_overloads flag.  Now subsumed by old_definition.
 *
 * Revision 1.37  1996/07/18  16:56:57  jont
 * Add option to turn on/off compilation messages from intermake
 *
 * Revision 1.36  1996/05/21  13:37:44  daveb
 * Removed some redundant options; moved abstractions from extensions to
 * compatibility options.
 *
 * Revision 1.35  1996/03/19  10:58:09  matthew
 * Adding options for new language definition
 *
 * Revision 1.34  1995/11/17  13:18:51  daveb
 * Removed no_execute.
 *
 *  Revision 1.33  1995/10/30  11:28:36  jont
 *  Add opt_handlers to compiler options
 *
 *  Revision 1.32  1995/06/30  15:01:31  daveb
 *  Added float_precision option to ValuePrinter options.
 *
 *  Revision 1.31  1995/05/23  14:35:10  daveb
 *  Removed the output_lambda option.
 *
 *  Revision 1.30  1995/05/15  14:43:44  matthew
 *  Moving NJ semicolons (or whatever) to extensions
 *
 *  Revision 1.29  1995/05/02  11:43:09  matthew
 *  Removing debug_polyvariables option
 *
 *  Revision 1.28  1995/02/14  12:02:18  matthew
 *  Adding set_no_execute
 *
 *  Revision 1.27  1994/07/29  16:39:49  daveb
 *  Moved preferences into separate structure.
 *
 *  Revision 1.26  1994/07/26  13:39:04  daveb
 *  Added full_menus option.
 *
 *  Revision 1.25  1994/05/05  13:03:24  daveb
 *  Adding overloading options.
 *
 *  Revision 1.24  1994/02/28  05:44:38  nosa
 *  Step and Modules Debugger compiler options.
 *
 *  Revision 1.23  1993/12/17  16:19:30  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.22  1993/11/04  16:29:15  jont
 *  Added interrupt option
 *
 *  Revision 1.21  1993/10/13  11:43:43  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.20  1993/10/08  15:58:37  matthew
 *  Bug fixes
 *
 *  Revision 1.19  1993/09/03  10:36:01  nosa
 *  New compiler option debug_polyvariables for polymorphic debugger.
 *
 *  Revision 1.18.1.3  1993/10/13  11:42:02  daveb
 *  Changed print options.
 *
 *  Revision 1.18.1.2  1993/10/06  16:17:36  matthew
 *  Set default for print_exn_details to false
 *
 *  Revision 1.18.1.1  1993/08/23  14:17:06  jont
 *  Fork for bug fixing
 *
 *  Revision 1.18  1993/08/23  14:17:06  richard
 *  Added output_lambda option.
 *
 *  Revision 1.17  1993/08/09  15:50:59  matthew
 *  Added more environment preferences
 *
 *  Revision 1.16  1993/07/14  09:23:15  nosa
 *  new compiler option debug_variables for local and closure variable
 *  inspection in the debugger.
 *
 *  Revision 1.15  1993/06/11  13:28:17  matthew
 *   Changed defaults for fixity_specs and open_fixity to false
 *
 *  Revision 1.14  1993/06/10  13:13:22  matthew
 *  Added open fixity and fixity spec options
 *
 *  Revision 1.13  1993/05/28  14:10:56  matthew
 *  > Added environment options
 *
 *  Revision 1.12  1993/05/25  10:41:14  matthew
 *  Changed default for abstractions to true
 *
 *  Revision 1.11  1993/05/18  16:37:17  daveb
 *  Rearranged some of the options.
 *
 *  Revision 1.10  1993/05/14  13:02:01  jont
 *  Added options to control parse treatment of New Jersey style weak type variables
 *
 *  Revision 1.9  1993/05/13  16:26:48  jont
 *  Changed default for op_in_datatype to true
 *
 *  Revision 1.8  1993/05/11  14:53:18  jont
 *  Added option to control make -n type facility
 *
 *  Revision 1.7  1993/04/27  13:49:44  richard
 *  Unified profiling and tracing options into `intercept'.
 *  Removed poly_makestring option.
 *
 *  Revision 1.6  1993/04/22  11:42:41  richard
 *  The editor interface is now implemented directly through
 *  Unix system calls, and is not part of the pervasive library
 *  or the runtime system.
 *
 *  Revision 1.5  1993/04/07  15:41:59  jont
 *  Added editor options
 *
 *  Revision 1.4  1993/04/01  11:15:31  jont
 *  Added compatibility options
 *  
 *  Revision 1.3  1993/03/23  15:56:35  daveb
 *  Added extension options.
 *  
 *  Revision 1.2  1993/03/10  14:35:52  matthew
 *  Added compat_options
 *  options now a tagged record rather than tuple.
 *  
 *  Revision 1.1  1993/03/08  16:19:22  matthew
 *  Initial revision
 *)

require "options";

(* These options objects contain only the options that are user modifiable *)

functor Options () : OPTIONS =
  struct
    datatype listing_options =
      LISTINGOPTIONS of {show_absyn      : bool,
                         show_lambda     : bool,
                         show_match      : bool,
                         show_opt_lambda : bool,
                         show_environ    : bool,
                         show_mir        : bool,
                         show_opt_mir    : bool,
                         show_mach       : bool}

    val default_listing_options =
      LISTINGOPTIONS {show_absyn = false,
                      show_lambda = false,
                      show_match = false,
                      show_opt_lambda = false,
                      show_environ = false,
                      show_mir = false,
                      show_opt_mir = false,
                      show_mach = false}

    datatype compiler_options =
      COMPILEROPTIONS of {generate_debug_info            : bool,
                          debug_variables                : bool,
                          generate_moduler               : bool,
                          intercept		         : bool,
			  interrupt                      : bool,
                          opt_handlers                   : bool,
                          opt_leaf_fns                   : bool,
                          opt_tail_calls                 : bool,
                          opt_self_calls                 : bool,
                          local_functions                : bool,
			  print_messages		 : bool,
                          (* Architecture options.  If we have too many of *)
                          (* these, then another mechanism would be *)
                          (* desirable *)
                          mips_r4000                     : bool,
                          sparc_v7                       : bool}


    val default_compiler_options =
      COMPILEROPTIONS {generate_debug_info = false,
                       debug_variables = false,
                       generate_moduler = false,
                       intercept = false,
		       interrupt = false,
                       opt_handlers = false,
                       opt_leaf_fns = true,
                       opt_tail_calls = true,
                       opt_self_calls = true,
                       local_functions = false,
		       print_messages = true,
                       mips_r4000 = true,
                       sparc_v7 = false}

    datatype print_options =
      PRINTOPTIONS of {maximum_seq_size : int,
                       maximum_string_size : int,
                       maximum_ref_depth : int,
                       maximum_str_depth : int,
                       maximum_sig_depth : int,
                       maximum_depth : int,
		       float_precision : int,
                       print_fn_details : bool,
                       print_exn_details : bool,
                       show_id_class: bool,
                       show_eq_info : bool
                       }

    val default_print_options =
      PRINTOPTIONS {maximum_seq_size = 10,
                    maximum_string_size = 255,
                    maximum_ref_depth = 3,
                    maximum_str_depth = 2,
                    maximum_sig_depth = 1,
                    maximum_depth = 7,
		    float_precision = 10,
                    print_fn_details = false,
                    print_exn_details = false,
                    show_eq_info = false,
                    show_id_class = false}

    datatype extension_options =
      EXTENSIONOPTIONS of {require_keyword : bool,
			   type_dynamic : bool}

    val default_extension_options =
      EXTENSIONOPTIONS {require_keyword = true,
		        type_dynamic = false}

    datatype compat_options =
      COMPATOPTIONS of {nj_op_in_datatype   : bool,
			nj_signatures       : bool,
			weak_type_vars      : bool,
                        fixity_specs        : bool,
                        open_fixity         : bool,
			abstractions        : bool,
                        old_definition      : bool}

    val default_compat_options =
      COMPATOPTIONS {nj_op_in_datatype = false,
		     nj_signatures = false,
		     weak_type_vars = false,
                     fixity_specs = false,
                     open_fixity = false,
		     abstractions = false,
                     old_definition = false}

    datatype options = OPTIONS of {listing_options : listing_options,
                                   compiler_options : compiler_options,
                                   print_options : print_options,
                                   extension_options : extension_options,
                                   compat_options : compat_options}

    val default_options = OPTIONS {listing_options = default_listing_options,
                                   compiler_options = default_compiler_options,
                                   print_options = default_print_options,
                                   extension_options = default_extension_options,
                                   compat_options = default_compat_options}

  end
