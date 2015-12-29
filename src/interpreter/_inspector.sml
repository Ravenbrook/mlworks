(* tty inspector
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: _inspector.sml,v $
 * Revision 1.20  1997/09/18 15:41:58  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.19  1997/05/22  13:56:17  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.18  1996/11/08  13:52:44  matthew
 * [Bug #1672]
 * Adding handler for LookupValid exn
 *
 * Revision 1.17  1996/10/09  14:42:12  io
 * moving String from toplevel
 *
 * Revision 1.16  1996/08/06  15:29:47  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_scheme.sml and _types.sml
 *
 * Revision 1.15  1996/05/01  10:20:12  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.14  1995/05/25  10:37:53  daveb
 * Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.13  1995/04/28  12:15:39  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.12  1995/02/14  14:06:24  matthew
 *  Lexer structure changes
 *  
 *  Revision 1.11  1994/09/26  09:25:36  matthew
 *  Change to Basis.lookup_val
 *  
 *  Revision 1.10  1994/05/05  10:11:11  daveb
 *  Basis.lookup_val now has an extra argument.
 *  Also added sharing constraint.
 *  
 *  Revision 1.9  1994/02/28  06:52:25  nosa
 *  Boolean indicators for Modules Debugger and Monomorphic debugger decapsulation.
 *  
 *  Revision 1.8  1994/02/23  17:36:13  matthew
 *  Added function to inspect a dynamic value
 *  
 *  Revision 1.7  1993/08/12  20:09:23  nosa
 *  lookup_val now returns runtime_instance for polymorphic debugger.
 *  
 *  Revision 1.6  1993/05/18  18:46:52  jont
 *  Removed integer parameter
 *  
 *  Revision 1.5  1993/05/06  13:12:05  matthew
 *  Removed printer_descriptors
 *  
 *  Revision 1.4  1993/04/21  15:50:43  matthew
 *  Got working with new InspectorValues
 *  
 *  Revision 1.3  1993/04/20  10:24:51  matthew
 *  Renamed Inspector_Values to InspectorValues
 *  
 *  Revision 1.2  1993/04/01  12:10:05  matthew
 *  Changed interface to InspectorValues.
 *  This is currently broken
 *  
 *  Revision 1.1  1993/03/12  15:24:58  matthew
 *  Initial revision
 *  
 *)

require "^.basis.__text_io";
require "../utils/lists";

require "../interpreter/incremental";
require "../typechecker/basis";
require "../typechecker/types";
require "../interpreter/inspector_values";
require "../main/user_options";
require "../interpreter/shell_types";
require "../debugger/value_printer";

require "inspector";

functor Inspector (
  structure Lists : LISTS
  structure Incremental : INCREMENTAL
  structure UserOptions : USER_OPTIONS
  structure Basis : BASIS
  structure Types : TYPES
  structure InspectorValues : INSPECTOR_VALUES
  structure ValuePrinter : VALUE_PRINTER
  structure ShellTypes : SHELL_TYPES
                     
  sharing Incremental.InterMake.Inter_EnvTypes.EnvironTypes.LambdaTypes.Ident =
          Basis.BasisTypes.Datatypes.Ident
  sharing Basis.BasisTypes.Datatypes = Types.Datatypes =
          Incremental.Datatypes
  sharing ValuePrinter.Options = UserOptions.Options = Types.Options =
          Incremental.InterMake.Compiler.Options = ShellTypes.Options
    
  sharing type UserOptions.user_tool_options = ShellTypes.user_options
  sharing type ValuePrinter.DebugInformation =
               Incremental.InterMake.Compiler.DebugInformation
  sharing type Basis.BasisTypes.Datatypes.Type = InspectorValues.Type =
               ValuePrinter.Type
  sharing type Types.Options.options = InspectorValues.options
  sharing type Basis.BasisTypes.Basis = Incremental.InterMake.Compiler.TypeBasis
  sharing type ShellTypes.Context = Incremental.Context
) : INSPECTOR =
  struct
    structure Incremental = Incremental
    structure Ident = Basis.BasisTypes.Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure Inter_EnvTypes = Incremental.InterMake.Inter_EnvTypes
    structure Options = Inter_EnvTypes.Options

    type Context = Incremental.Context
    type ShellData = ShellTypes.ShellData

    type Type = Types.Datatypes.Type

    fun get_name () = "it"

    fun printname (Ident.VAR s) = Symbol.symbol_name s
      | printname (Ident.CON s) = Symbol.symbol_name s
      | printname (Ident.EXCON s) = Symbol.symbol_name s
      | printname (Ident.TYCON' s) = Symbol.symbol_name s

    (* This should evaluate an arbitrary expression *)
    fun lookup_name (name,context) =
      let
        val tycontext = Basis.basis_to_context (Incremental.type_basis context)
        val valid = Ident.VAR(Symbol.find_symbol name)
        val valtype =
	  #1(Basis.lookup_val (Ident.LONGVALID (Ident.NOPATH, valid),
                               tycontext,
                               Ident.Location.FILE "Inspector", 
                               false))
        val mlval = Inter_EnvTypes.lookup_val(valid,Incremental.inter_env context)
      in
        (mlval,valtype)
      end

    val show_them =
      Lists.iterate
      (fn (tag,string) => 
       print(concat [tag,": ",string,"\n"]))

    (* This should be shared with _inspector_tool *)

    fun getreps (item as (value,ty),subitems,shelldata) =
      let
        val options = ShellTypes.get_current_options shelldata
        val Options.OPTIONS{print_options,...} = options
        val debug_info = Incremental.debug_info (ShellTypes.get_current_context shelldata)

        fun print_value (object,ty) =
          ValuePrinter.stringify_value false (print_options,
                                              object,
                                              ty,
                                              debug_info)

        val print_type = Types.print_type options
      in
        ((print_value item,print_type ty),
         map (fn (x,y) => (x,print_value y)) subitems)
      end

    fun lookup (tag,list) =
      Lists.assoc(tag,list)

    fun inspect (arg as (valtype,mlval),stack,shelldata) =
      let
        val options = ShellTypes.get_current_options shelldata
        val subobjects = InspectorValues.get_inspector_values options false arg
        val ((valuestring,typestring),items) = getreps (arg,subobjects,shelldata)
        fun show_help () =
          print (concat (["Commands:\n",
                           " p        - inspect the object containing this one\n",
                           " q        - quit the inspector\n",
                           " <field name> - inspect the named field\n",
                           " ?        - print this message\n"]))
        fun doit () =
          let
            val _ = print("Value: " ^ valuestring ^ "\n")
            val _ = print("Type: " ^ typestring ^ "\n")
            val _ = show_them items;
            val _ = print "Inspector> "
            val _ = TextIO.flushOut TextIO.stdOut;
          in
            case rev (explode (getOpt (TextIO.inputLine(TextIO.stdIn), ""))) of
              [] => ()
            | (_::tagl) =>
                let
                  val tag = implode (rev tagl)
                in
                  case tag of
                    "q" => ()
                  | "?" => (show_help (); doit())
                  | "p" => (case stack of [] => doit () | (arg'::stack') => inspect(arg',stack',shelldata))
                  | _ =>  inspect (lookup (tag,subobjects),arg::stack,shelldata)
                      handle Lists.Assoc => (print("Enter ? for help\n");
                                             doit())
                end
          end
      in
        doit ()
      end

    fun inspect_value (typed_object,shelldata) =
      (print "Entering TTY inspector - enter ? for help\n"; 
       inspect (typed_object,[],shelldata))

    fun inspect_it (shelldata) =
      let
        val name = get_name ()
        val typed_object = lookup_name (name,ShellTypes.get_current_context shelldata)
      in
        print "Entering TTY inspector - enter ? for help\n";
        inspect (typed_object,[],shelldata)
      end
    handle Basis.LookupValId valid =>
      print ("Error: variable " ^ printname valid ^ " not defined\n")

  end
