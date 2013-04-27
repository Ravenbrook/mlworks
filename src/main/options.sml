(*  ==== COMPILER OPTIONS CONTROL ====
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
 *  $Log: options.sml,v $
 *  Revision 1.39  1998/03/02 15:07:22  mitchell
 *  [Bug #70074]
 *  Add depth limit support for signature printing
 *
 * Revision 1.38  1997/05/27  11:13:21  daveb
 * [Bug #30136]
 * Removed early-mips-r4000 option.
 *
 * Revision 1.37  1997/03/25  11:24:00  matthew
 * Renaming R4000 option
 *
 * Revision 1.36  1997/01/21  10:36:26  matthew
 * Adding architecture dependent options
 *
 * Revision 1.35  1997/01/02  14:57:05  matthew
 * Adding local function option
 *
 * Revision 1.34  1996/09/23  11:59:20  andreww
 * [Bug #1605]
 * removing default_overloads flag.  Now subsumed by old_definition.
 *
 * Revision 1.33  1996/07/18  16:47:39  jont
 * Add option to turn on/off compilation messages from intermake
 *
 * Revision 1.32  1996/05/21  13:38:18  daveb
 * Removed some redundant options; moved abstractions from extensions to
 * compatibility options.
 *
 * Revision 1.31  1996/03/19  10:18:37  matthew
 * Adding options for new language definition
 *
 * Revision 1.30  1995/11/17  13:18:36  daveb
 * Removed no_execute.
 *
 *  Revision 1.29  1995/10/25  17:42:53  jont
 *  Add opt_handlers to compiler options
 *
 *  Revision 1.28  1995/06/30  14:59:23  daveb
 *  Added float_precision option to ValuePrinter options.
 *
 *  Revision 1.27  1995/05/23  14:34:52  daveb
 *  Removed the output_lambda option.
 *
 *  Revision 1.26  1995/05/15  14:44:29  matthew
 *  Moving NJ semicolons (or whatever) to extensions
 *
 *  Revision 1.25  1995/05/02  11:42:50  matthew
 *  Removing debug_polyvariables option
 *
 *  Revision 1.24  1995/02/14  12:01:16  matthew
 *  Adding set_no_execute
 *
 *  Revision 1.23  1994/07/29  16:36:31  daveb
 *  Moved preferences into separate structure.
 *
 *  Revision 1.22  1994/07/26  13:46:47  daveb
 *  Added full_menus option.
 *
 *  Revision 1.21  1994/05/05  13:02:33  daveb
 *  Added default_overloads, vector_literals and wildcard_warnings.
 *
 *  Revision 1.20  1994/02/28  05:35:36  nosa
 *  Step and Modules Debugger compiler options.
 *
 *  Revision 1.19  1993/12/17  16:19:06  matthew
 *  Added maximum_str_depth to options.
 *
 *  Revision 1.18  1993/11/04  16:29:11  jont
 *  Added interrupt option
 *
 *  Revision 1.17  1993/10/13  12:22:18  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.16  1993/09/03  10:35:36  nosa
 *  New compiler option debug_polyvariables for polymorphic debugger.

 *  Revision 1.15.1.2  1993/10/12  11:45:58  daveb
 *  Changed print options.
 *
 *  Revision 1.15.1.1  1993/08/23  14:14:53  jont
 *  Fork for bug fixing
 *
 *  Revision 1.15  1993/08/23  14:14:53  richard
 *  Added output_lambda option.
 *
 *  Revision 1.14  1993/08/09  15:52:08  matthew
 *  Added more environment preferences
 *
 *  Revision 1.13  1993/07/13  12:28:03  nosa
 *  new compiler option debug_variables for local and closure variable
 *  inspection in the debugger.
 *
 *  Revision 1.12  1993/06/10  13:13:33  matthew
 *  Added open fixity and fixity spec options
 *
 *  Revision 1.11  1993/05/28  14:10:15  matthew
 *  Added environment options
 *
 *  Revision 1.10  1993/05/18  16:36:46  daveb
 *  Rearranged some of the options.
 *
 *  Revision 1.9  1993/05/14  13:01:50  jont
 *  Added options to control parse treatment of New Jersey style weak type variables
 *
 *  Revision 1.8  1993/05/11  14:52:45  jont
 *  Added make -n type facility
 *
 *  Revision 1.7  1993/04/27  13:49:46  richard
 *  Unified profiling and tracing options into `intercept'.
 *  Removed poly_makestring option.
 *
 *  Revision 1.6  1993/04/22  11:43:13  richard
 *  The editor interface is now implemented directly through
 *  Unix system calls, and is not part of the pervasive library
 *  or the runtime system.
 *
 *  Revision 1.5  1993/04/07  15:33:15  jont
 *  Added editor options
 *
 *  Revision 1.4  1993/04/01  11:05:53  jont
 *  Added compatibility options
 *  
 *  Revision 1.3  1993/03/23  15:48:16  daveb
 *  Added extension options.
 *  
 *  Revision 1.2  1993/03/10  14:35:38  matthew
 *  Signature revisions
 *  
 *  Revision 1.1  1993/03/08  16:19:08  matthew
 *  Initial revision
 *)

(* User definable options structures *)

signature OPTIONS =
  sig
    datatype listing_options =
      LISTINGOPTIONS of {show_absyn      : bool,
                         show_lambda     : bool,
                         show_match      : bool,
                         show_opt_lambda : bool,
                         show_environ    : bool,
                         show_mir        : bool,
                         show_opt_mir    : bool,
                         show_mach       : bool}
    val default_listing_options : listing_options

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
    val default_compiler_options : compiler_options

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

    val default_print_options : print_options

    datatype compat_options =
      COMPATOPTIONS of {nj_op_in_datatype   : bool,
			nj_signatures       : bool,
			weak_type_vars      : bool,
                        fixity_specs        : bool,
                        open_fixity         : bool,
			abstractions 	    : bool,
                        old_definition      : bool}

    val default_compat_options : compat_options

    datatype extension_options =
      EXTENSIONOPTIONS of {require_keyword : bool,
			   type_dynamic : bool
		          }

    val default_extension_options : extension_options

    datatype options = OPTIONS of {listing_options : listing_options,
                                   compiler_options : compiler_options,
                                   print_options : print_options,
                                   compat_options : compat_options,
                                   extension_options : extension_options}

    val default_options : options

  end
