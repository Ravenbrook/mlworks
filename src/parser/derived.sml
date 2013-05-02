(* derived.sml the signature *)
(*
$Log: derived.sml,v $
Revision 1.26  1997/05/01 12:51:53  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.25  1996/03/25  12:49:51  matthew
 * Explicit type variables in VALdecs
 *
 * Revision 1.24  1995/12/27  10:44:22  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.23  1995/02/14  12:11:53  matthew
Removing Options structure

Revision 1.22  1994/02/22  01:33:33  nosa
Type function recording for Modules Debugger;
Deleted compiler option debug_polyvariables passing to parser functions.

Revision 1.21  1993/12/08  10:57:34  nickh
Change the types of the withtype functions to take an Info.options.

Revision 1.20  1993/08/13  15:52:54  nosa
structure Options.

Revision 1.19  1993/08/06  13:21:49  matthew
Added location information to matches

Revision 1.18  1993/06/01  08:39:04  nosa
structure Option.

Revision 1.17  1993/03/09  11:16:41  matthew
Options & Info changes
Absyn changes

Revision 1.16  1993/02/23  13:53:49  matthew
Added parser env parameter.  Removed open Datatypes

Revision 1.15  1993/02/08  19:25:02  matthew
ref Nameset removed from FunBind abstract syntax

Revision 1.14  1992/11/19  19:17:31  jont
Removed Info structure from parser, tidied upderived

Revision 1.13  1992/11/05  15:55:52  matthew
Changed Error structure to Info

Revision 1.12  1992/10/09  13:32:52  clive
Tynames now have a slot recording their definition point

Revision 1.11  1992/09/11  11:46:16  matthew
Added generation of local uncurried versions of curried functions.
Also don't generate intermediate functions in uncurried case.

Revision 1.10  1992/09/08  16:32:24  matthew
Improved error messages.

Revision 1.9  1992/09/04  08:56:37  richard
Installed central error reporting mechanism.

Revision 1.8  1992/08/05  16:04:42  jont
Removed some structures and sharing

Revision 1.7  1992/05/19  10:56:56  clive
Added marks to allow position reporting from the typechecker

Revision 1.6  1992/05/01  09:44:40  clive
Added more useful annotations to if,while,case statements to give better info in a stack backtrace

Revision 1.5  1992/04/13  13:29:12  clive
First version of the profiler

Revision 1.4  1991/11/21  16:37:03  jont
Added copyright message

Revision 1.3  91/11/19  12:21:15  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:12:34  jont
Added comments for DRA on functions

Revision 1.2  91/06/27  13:55:18  colin
changed to handle Interface annotations in signature expressions

Revision 1.1  91/06/07  16:18:09  colin
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

(* This module provides (to the parser module) functions to produce
abstract syntax trees for the Derived forms of the ML language, i.e.
those parts of the language which are defined in terms of the Bare
language. The abstract syntax which we use is just that of the Bare
language (which enables us to ensure conformance with the Definition
Semantics, which only deal with the Bare language), so the parser must
convert Derived forms into Bare forms.

For details see Appendix A of the definition.

All of these functions have a very straightforward implementation. *)

require "../basics/absyn";
require "../main/info";
require "parserenv";

signature DERIVED =
  sig

    structure Absyn  : ABSYN
    structure Info : INFO
    structure PE : PARSERENV

    sharing Info.Location = Absyn.Ident.Location
    sharing Absyn.Ident = PE.Ident

    (* generally useful functions *)
    val new_var : unit -> Absyn.Ident.LongValId
    val new_vars : int -> Absyn.Ident.LongValId list

    (* type expressions *)
    val make_tuple_ty : Absyn.Ty list -> Absyn.Ty

    (* expressions *)
    val make_unit_exp : unit -> Absyn.Exp
    val make_tuple_exp : Absyn.Exp list -> Absyn.Exp
    val make_select : Absyn.Ident.Lab * Absyn.Ident.Location.T * string -> Absyn.Exp
    val make_case : Absyn.Exp * (Absyn.Pat * Absyn.Exp * Absyn.Ident.Location.T) list 
      * string * Absyn.Ident.Location.T -> Absyn.Exp
    val make_if : Absyn.Exp * Absyn.Exp * Absyn.Exp * string 
      * Absyn.Ident.Location.T * PE.pE -> Absyn.Exp
    val make_orelse : Absyn.Exp * Absyn.Exp * string 
      * Absyn.Ident.Location.T * PE.pE -> Absyn.Exp
    val make_andalso : Absyn.Exp * Absyn.Exp * string 
      * Absyn.Ident.Location.T * PE.pE -> Absyn.Exp
    val make_sequence_exp : (Absyn.Exp * string 
                             * Absyn.Ident.Location.T) list  -> Absyn.Exp
    val make_while : Absyn.Exp * Absyn.Exp * (string -> string) 
      * Absyn.Ident.Location.T * PE.pE -> Absyn.Exp
    val make_list_exp : (Absyn.Exp list * Absyn.Ident.Location.T * PE.pE) -> Absyn.Exp

    (* patterns *)
    val make_unit_pat : unit -> Absyn.Pat
    val make_tuple_pat : Absyn.Pat list -> Absyn.Pat
    val make_list_pat : Absyn.Pat list * Absyn.Ident.Location.T * PE.pE -> Absyn.Pat


    (* pattern rows *)
    val make_patrow :
      Absyn.Ident.Symbol.Symbol * Absyn.Ty option 
      * Absyn.Pat option * Absyn.Ident.Location.T
      -> Absyn.Ident.Lab * Absyn.Pat
  
    exception FvalBind of string

    (* function value bindings *) 
    val make_fvalbind :
      ((Absyn.Ident.ValId * Absyn.Pat list * Absyn.Exp * Absyn.Ident.Location.T) list 
       * (string -> string) * Info.Location.T) * Info.options
      -> (Absyn.Pat * Absyn.Exp * Absyn.Ident.Location.T) list

    (* declarations *)
    val make_it_strdec :
      Absyn.Exp *
      Absyn.Ident.TyVar Absyn.Set.Set * 
      Absyn.Ident.Location.T * PE.pE ->
      Absyn.TopDec

    val make_fun : 
      (Absyn.Pat * Absyn.Exp * Absyn.Ident.Location.T) list list * 
      Absyn.Ident.TyVar Absyn.Set.Set * Absyn.Ident.TyVar list *
      Absyn.Ident.Location.T  -> Absyn.Dec

    val make_datatype_withtype : 
      Absyn.Ident.Location.T *
      (Absyn.Ident.TyVar list * Absyn.Ident.TyCon * Absyn.Type ref * Absyn.Tyfun ref option * 
       ((Absyn.Ident.ValId * Absyn.Type ref) * Absyn.Ty option) list) list *
      (Absyn.Ident.TyVar list * Absyn.Ident.TyCon * Absyn.Ty * Absyn.Tyfun ref option) list *
      Info.options -> Absyn.Dec

    val make_abstype_withtype : 
      Absyn.Ident.Location.T *
      (Absyn.Ident.TyVar list * Absyn.Ident.TyCon * Absyn.Type ref * Absyn.Tyfun ref option * 
       ((Absyn.Ident.ValId * Absyn.Type ref) * Absyn.Ty option) list) list *
      (Absyn.Ident.TyVar list * Absyn.Ident.TyCon * Absyn.Ty * Absyn.Tyfun ref option) list * Absyn.Dec *
      Info.options -> Absyn.Dec
     
    (* modules *)

    val make_strexp : Absyn.StrDec -> Absyn.StrExp 
      
    val make_funbind : 
      (Absyn.Ident.FunId * Absyn.SigExp * Absyn.StrExp * (Absyn.SigExp * bool) option 
       * Absyn.Ident.Location.T) ->
      (Absyn.Ident.FunId * Absyn.Ident.StrId * Absyn.SigExp * Absyn.StrExp 
       * (Absyn.SigExp * bool) option)
      

  end    
