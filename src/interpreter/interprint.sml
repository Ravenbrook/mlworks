(*  ==== INTERPRETER PRINTER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description 
 *  -----------
 *  The interpreter printer outputs a representation of increments to the
 *  incremental compiler context.  It prints a representation of the
 *  declarations fed to the interpreter.
 *
 *  Revision Log
 *  ------------
 *  $Log: interprint.sml,v $
 *  Revision 1.23  1995/07/13 12:03:51  matthew
 *  Moving identifier type to Ident
 *
 *  Revision 1.22  1995/03/02  12:54:02  daveb
 *  Removed the indentation argument to the strings function.
 *
 *  Revision 1.21  1994/08/09  15:00:12  daveb
 *  Replaced SourceResult argument to strings with a ParserBasis.
 *  Added a comment.
 *
 *  Revision 1.20  1994/07/28  15:39:41  daveb
 *  Removed definitions function.
 *
 *  Revision 1.19  1994/06/17  13:42:05  daveb
 *  Added strings function, for tools that want to use the result strings.
 *
 *  Revision 1.18  1994/05/06  15:35:37  jont
 *  Change type of definitions slightly
 *
 *  Revision 1.17  1993/09/16  11:21:35  nosa
 *  Pass options to InterPrint.definitions instead of print_options.
 *
 *  Revision 1.16  1993/07/29  11:12:12  matthew
 *  Removed error_info parameter from definitions
 *
 *  Revision 1.15  1993/05/06  12:11:47  matthew
 *  Removed printer_descriptor
 *
 *  Revision 1.14  1993/04/02  13:45:07  matthew
 *  Signature changes
 *
 *  Revision 1.13  1993/03/12  11:09:37  matthew
 *  definitions now takes an output function
 *
 *  Revision 1.12  1993/03/09  12:32:03  matthew
 *  Options & Info changes
 *
 *  Revision 1.11  1993/02/09  10:49:20  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.10  1993/02/04  18:30:22  matthew
 *  Changed sharing
 *
 *  Revision 1.9  1992/12/01  17:45:55  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.8  1992/11/30  16:35:55  matthew
 *  Used pervasive streams
 *
 *  Revision 1.7  1992/11/27  19:30:46  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.6  1992/11/26  14:09:59  matthew
 *  Changed to use Stream structure
 *
 *  Revision 1.5  1992/11/20  16:32:24  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.4  1992/11/04  13:42:27  daveb
 *  Added options type to control printing.
 *
 *  Revision 1.3  1992/10/13  14:56:37  richard
 *  Added diagnostics.
 *
 *  Revision 1.2  1992/10/07  15:20:51  richard
 *  Changes related to restructuring of Incremental.
 *
 *  Revision 1.1  1992/10/01  12:02:23  richard
 *  Initial revision
 *
 *)

require "../main/compiler";
require "../utils/diagnostic";

signature INTERPRINT =
  sig
    structure Compiler : COMPILER
    structure Diagnostic  : DIAGNOSTIC

    type Context

    exception Undefined of Compiler.Absyn.Ident.Identifier

    (* Arguments.
	 Context: The current context, used to find the types and values
	   needed when printing.
         Compiler.Options.options: Options
	 Compiler..Absyn.Ident.Identifier list:  The identifiers to be printed
         Compiler.ParserBasis: The increment to the parser basis, used to
           print any fixity declarations.
       Results.
	 A list of the identifiers paired with their printed representations. *)
    val strings :
      Context * Compiler.Options.options
      * Compiler.Absyn.Ident.Identifier list * Compiler.ParserBasis
      -> (Compiler.Absyn.Ident.Identifier * string) list
  end;
