(*
 * $Log: simpleutils.sml,v $
 * Revision 1.7  1997/05/09 11:15:54  matthew
 * Adding substitution functions
 *
 * Revision 1.6  1997/01/06  16:37:41  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.5  1996/12/02  12:11:03  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.4  1995/08/11  12:14:46  daveb
 * Replaced LambdaTypes.Option with MLWorks.Option.
 *
 * Revision 1.3  1994/10/12  09:32:03  matthew
 * Changed simpletypes unit name
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
 *)

require "lambdatypes";

signature SIMPLEUTILS =
  sig
    structure LambdaTypes : LAMBDATYPES
    val occurs : LambdaTypes.LVar * LambdaTypes.LambdaExp -> bool
    val freevars : LambdaTypes.LambdaExp * LambdaTypes.LVar list -> LambdaTypes.LVar list
    val vars_of : LambdaTypes.LambdaExp -> LambdaTypes.LVar list
    val linearize : LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp
    val is_atomic : LambdaTypes.LambdaExp -> bool
    val is_simple : LambdaTypes.LambdaExp -> bool
    val switchable_exp : LambdaTypes.LambdaExp -> bool
    val safe : LambdaTypes.LambdaExp -> bool
    val safe_elim : LambdaTypes.LambdaExp -> bool
    val safe_cse : LambdaTypes.LambdaExp -> bool
    val get_arity : LambdaTypes.Primitive -> int
    val insert_as_needed : 
      (LambdaTypes.LVar * 
       LambdaTypes.VarInfo ref option * 
       LambdaTypes.LambdaExp) list 
      * LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp
    val schedule : LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp
    val size_less : LambdaTypes.LambdaExp * int * bool -> bool
    val exp_eq : LambdaTypes.LambdaExp * LambdaTypes.LambdaExp -> bool
    val wrap_lets : 
      LambdaTypes.LambdaExp * 
      (LambdaTypes.LVar * LambdaTypes.VarInfo ref option * LambdaTypes.LambdaExp) list -> 
      LambdaTypes.LambdaExp
    val unwrap_lets : 
      LambdaTypes.LambdaExp -> 
      (LambdaTypes.LVar * LambdaTypes.VarInfo ref option * LambdaTypes.LambdaExp) list * 
      LambdaTypes.LambdaExp

    val subst : 
      (LambdaTypes.LVar -> LambdaTypes.LambdaExp) * LambdaTypes.LambdaExp ->
      LambdaTypes.LambdaExp

    val function_lvars : LambdaTypes.LambdaExp -> LambdaTypes.LVar list
    val is_fp_builtin : LambdaTypes.Primitive -> bool
  end
