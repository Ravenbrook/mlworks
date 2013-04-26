(* _absynprint.sml the signature *)
(*
$Log: absynprint.sml,v $
Revision 1.7  1996/08/05 17:53:39  andreww
[Bug #1521]
propagating changes made to typechecker/_types.sml
(pass options rather than just print_options)

 * Revision 1.6  1995/08/31  12:22:50  jont
 * Add option to print location info when unparsing patterns
 *
Revision 1.5  1993/03/04  12:15:34  matthew
>> and Type and Structure types.
Options & Info changes

Revision 1.4  1992/11/26  13:16:00  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.3  1991/11/21  15:58:18  jont
Added copyright message

Revision 1.2  91/11/19  12:16:16  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:02:13  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  10:56:06  colin
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

(* This module provides functions for printing the abstract syntax
structure defined in absyn.sml. The printing technique is via
S-Expressions (which simplifies the conversion functions and allows
pretty-printing) *)

require "absyn";
require "../main/options";

signature ABSYNPRINT =
  sig
    structure Absyn : ABSYN
    structure Options: OPTIONS
      
    type 'a Sexpr

    val detreeTy  : Options.options  -> Absyn.Ty  -> string Sexpr
    val detreePat : Options.options  -> Absyn.Pat -> string Sexpr
    val detreeDec : Options.options  -> Absyn.Dec -> string Sexpr
    val detreeExp : Options.options  -> Absyn.Exp -> string Sexpr

    val printTy  : Options.options -> Absyn.Ty  -> string 
    val printPat : Options.options -> Absyn.Pat -> string 
    val printDec : Options.options -> Absyn.Dec -> string 
    val printExp : Options.options -> Absyn.Exp -> string 

    val unparseTy  : Options.print_options -> Absyn.Ty  -> string
    val unparsePat : bool -> Options.print_options -> Absyn.Pat -> string
    val unparseExp : Options.print_options -> Absyn.Exp -> string
  end
