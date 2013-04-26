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
 * Copyright (c) 1997 Harlequin Ltd.
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
