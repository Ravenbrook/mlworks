(* lambdaprint.sml the signature *)
(*
$Log: lambdaprint.sml,v $
Revision 1.19  1997/05/22 12:49:32  jont
[Bug #30090]
Replace MLWorks.IO with TextIO where applicable

 * Revision 1.18  1996/11/14  15:28:39  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.17  1996/08/06  11:39:26  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml (essentially
 * just passing options rather than print_options).
 *
 * Revision 1.16  1996/04/30  16:07:31  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.15  1995/12/04  12:17:15  matthew
 * Simplifying
 *
Revision 1.14  1993/03/04  12:39:43  matthew
Options & Info changes

Revision 1.13  1993/02/01  16:21:21  matthew
Added sharing constraints

Revision 1.12  1992/11/26  20:01:40  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.11  1992/07/20  14:32:56  clive
string_of_tag not used so removed

Revision 1.10  1992/07/10  15:24:42  davida
Added string_of_tag for printing tags.

Revision 1.9  1992/07/09  15:02:46  davida
Added print_types flag.

Revision 1.8  1992/06/16  11:22:01  davida
Faster printing scheme.

Revision 1.7  1991/09/11  15:18:52  davida
Changed from string_of_info to print_info

Revision 1.6  91/09/10  15:44:59  davida
Added string_of_info function

Revision 1.5  91/08/07  12:50:03  davida
Added flag to allow APP(FN ...) to be displayed as Let .. In ..

Revision 1.4  91/08/06  12:03:38  davida
Changed name of lambda-expression -> string function to
something more logical, and added a function to print
out big lambda expressions, which doesn't generate
intermediate strings.

Revision 1.3  91/07/19  16:45:06  davida
New version using custom pretty-printer

Revision 1.2  91/06/11  16:55:21  jont
Abstracted out the types from the functions

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

require "../basis/__text_io";

require "lambdatypes";
require "../main/options";

signature LAMBDAPRINT = 
sig

  structure LambdaTypes : LAMBDATYPES
  structure Options : OPTIONS

  val output_lambda    : Options.options ->
			   TextIO.outstream * LambdaTypes.LambdaExp ->
			   unit
  (* output to std_out *)
  val print_lambda     : Options.options -> LambdaTypes.LambdaExp -> unit 

  (* use only for small lambda-expressions in debugging messages *)
  val string_of_lambda : LambdaTypes.LambdaExp -> string

  val print_var : LambdaTypes.LVar -> string
  val print_exp : LambdaTypes.LambdaExp -> string
  val pds : LambdaTypes.program -> string
  val pde : LambdaTypes.LambdaExp -> string

end
