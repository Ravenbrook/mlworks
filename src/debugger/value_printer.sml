(* value_printer.sml the signature *)
(*
$Log: value_printer.sml,v $
Revision 1.28  1995/10/19 15:47:39  matthew
Correcting misspelling of abbreviate.

Revision 1.27  1995/10/13  22:59:53  brianm
Adding extra control for abbreviated strings - needed in printing labels
in the Graphical Inspector, which uses stringify_value eventually.

Revision 1.26  1995/01/10  10:39:52  matthew
Rationalizing debugger

Revision 1.25  1994/02/28  06:47:28  nosa
Changed null type function handling to accomodate Monomorphic debugger decapsulation.

Revision 1.24  1994/02/23  12:39:27  daveb
Adding function to find the name of a function.

Revision 1.23  1993/12/09  19:27:41  jont
Added copyright message

Revision 1.22  1993/05/06  12:07:47  matthew
stringify_value now takes just a print_options object

Revision 1.21  1993/04/02  13:42:08  matthew
Removed Debugger_Types

Revision 1.20  1993/03/11  10:48:38  matthew
Signature revisions

Revision 1.19  1993/03/08  16:07:55  matthew
Options & Info changes

Revision 1.18  1993/02/09  10:12:38  matthew
Typechecker structure changes

Revision 1.17  1993/02/04  17:18:18  matthew
Added sharing.

Revision 1.16  1992/11/27  14:13:47  clive
default_print_descriptor now deleted

Revision 1.15  1992/11/20  12:32:00  clive
Added print_exn_details

Revision 1.14  1992/10/06  16:29:42  clive
Changes for the use of new shell

Revision 1.13  1992/09/09  13:08:29  clive
Added switches t the value-printer to control depth of printing etc

Revision 1.12  1992/09/03  09:17:05  clive
Added functionality to the value_printer

Revision 1.11  1992/08/28  09:33:47  clive
Added the shape function

Revision 1.10  1992/08/26  19:03:11  richard
Rationalisation of the MLWorks structure.

Revision 1.9  1992/08/26  09:37:50  clive
More support for the definition of print functions

Revision 1.8  1992/08/18  16:27:08  richard
 Changed coercion and the ml_value type in the pervasive environment.

Revision 1.7  1992/08/17  13:19:53  clive
Various improvements

Revision 1.6  1992/08/13  12:37:42  clive
Neatening up, plus changes due to lower level sharing changes

Revision 1.5  1992/07/14  08:55:41  clive
toplevel_value_printer moved to this file

Revision 1.4  1992/06/29  11:33:17  clive
Some minor printing changes

Revision 1.3  1992/06/25  15:48:50  clive
Debugger.MlObject changed to jont's ml_value

Revision 1.2  1992/06/25  09:18:02  clive
Added a simplified function for toplevel printing

Revision 1.1  1992/06/22  15:19:54  clive
Initial revision

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
*)

require "../main/options";

signature VALUE_PRINTER =
  sig
    structure Options : OPTIONS

    type TypeBasis
    type Type
    type DebugInformation

    val stringify_value :  bool ->
     (Options.print_options * 
      MLWorks.Internal.Value.T * 
      Type  *
      DebugInformation)
      -> string

    val function_name : ('a -> 'b) -> string
    (* function_name f; returns the string encoding the name of the
       function in the closure.  This is usually the identifier followed
       by the location.  The result is suitable for referencing the
       debug_info table, for example.  *)

    val string_abbreviation : string ref (* needed by Graphical Inspector *)
  end
