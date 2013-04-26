(* _lambdasub.sml the functor *)
(*
 * Lambda Optimiser: _lambdasub.sml
 * sub-functions for lambda modules.
 *
 * $Log: _lambdasub.sml,v $
 * Revision 1.83  1996/10/31 15:36:18  io
 * moving String from toplevel
 *
 * Revision 1.82  1995/12/22  17:20:13  jont
 * Remove references to option structure
 * in favour of MLWorks.Option
 *
 * Revision 1.81  1995/12/04  12:23:16  matthew
 * Simplifying
 *
 * Revision 1.80  1995/08/11  16:50:48  daveb
 * Replaced uses of LambdaTypes.Option with MLWorks.Option.
 *
 * Revision 1.79  1995/03/01  13:05:23  matthew
 * cout -s lambda/lambdasub.sml
 * Removing old lambda optimizer stuff
 *
 * Revision 1.78  1994/10/13  11:14:11  matthew
 * Use pervasive Option.option for return values in NewMap
 *
 * Revision 1.77  1994/10/10  09:43:00  matthew
 * Lambdatypes changes
 *
 * Revision 1.76  1994/09/19  12:43:02  matthew
 * Abstraction of debug information in lambdatypes
 *
 * Revision 1.75  1994/08/19  12:53:11  jont
 * Improve shiftable by adition of shiftable_list
 *
 * Revision 1.74  1994/07/19  13:51:02  matthew
 * Functions and applications take a list of parameters
 *
 * Revision 1.73  1994/02/16  14:22:31  jont
 * Removed all raises of BadCallToNoCheckSub, making result equal to original
 * I think there is some longstanding optimiser bug still here somewhere,\nto do with not finding the right number of occurrences of a var for\nsubstitution, but finding that will have to wait.
 *
 * Revision 1.72  1993/10/11  18:10:29  jont
 * Improved occurs by expanding out the Lists.exists calls.
 *
 * Revision 1.71  1993/10/05  12:35:22  jont
 * Improved substitute_once to avoid checking before starting, it wouldn't
 * have been called if nothing was to be done.
 *
 *Revision 1.70  1993/09/22  13:38:50  nosa
 *FNs now passed closed-over type variables and
 *stack frame-offset for runtime-instance for polymorphic debugger.
 *
Revision 1.69  1993/07/15  09:14:18  nosa
Types of constructors LET and LETREC have changed for
local and closure variable inspection in the debugger.

Revision 1.68  1993/05/13  11:38:30  jont
Modified substitute_once to look before copying except when
a substitution is known to be in a particular expression.
produce a 20% speed up in lambda optimisation on _actionfunctions

Revision 1.67  1993/03/10  15:59:49  matthew
Signature revisions

Revision 1.66  1993/03/03  17:27:07  jont
Removed LVar_eq in favour of polymorphic equality

Revision 1.65  1993/03/01  14:46:49  matthew
Added MLVALUE lambda exp

Revision 1.64  1992/12/24  12:15:45  clive
Stopped optimising switch info inconsistently

Revision 1.63  1992/12/22  10:14:40  matthew
Removed polymorphic equality on SCONs

Revision 1.62  1992/12/18  16:51:41  clive
In rename the substitution forced a new variable for the bindings
causing problems later in the substitution

Revision 1.61  1992/12/10  17:29:14  jont
Minor improvements in sub in subsititute_at_most_once or whatever it is.

Revision 1.60  1992/11/09  15:43:44  clive
Added some LETREC optimisation

Revision 1.59  1992/11/05  15:04:42  jont
Reworked substitute_n_occurences to be a bit more efficient

Revision 1.58  1992/10/26  17:32:21  daveb
Minor changes to support the new type of SWITCHes.

Revision 1.57  1992/09/22  13:18:17  clive
Changes for the newhashtables

Revision 1.56  1992/09/21  11:58:26  clive
Changed hashtables to a single structure implementation

Revision 1.55  1992/09/15  15:22:07  clive
Got rid of handles involving hash tables

Revision 1.54  1992/08/26  12:59:18  jont
Removed some redundant structures and sharing

Revision 1.53  1992/07/28  08:54:41  clive
Modified to use the new hashtables

Revision 1.52  1992/07/22  12:24:26  clive
Wrote routines to try to substitute exactly n times without going inside letrec and fn

Revision 1.51  1992/07/17  13:44:41  clive
Changed eta_abstract to take an extra type annotation

Revision 1.50  1992/07/06  17:39:50  davida
Restored functionality of is_in_evaluation_set.

Revision 1.49  1992/07/03  14:42:48  davida
Added LET constructor and new slot to APP.

Revision 1.48  1992/07/02  09:59:20  davida
Fixed accidental use of NJ "List" structure instead
of our "Lists".

Revision 1.46  1992/06/23  09:40:55  clive
Added an annotation slot to HANDLE

Revision 1.45  1992/06/22  14:17:10  davida
Missing case and improvements for alpha_convertible.

Revision 1.44  1992/06/18  14:18:21  davida
Fixed fault in previous rev, more code tweaking.

Revision 1.43  1992/06/17  15:37:04  davida
Various efficiency improvements.

Revision 1.42  1992/06/16  16:03:09  clive
LambdaExp is no longer an equality type, so replaced calls to = with LS.lambda_equality

Revision 1.41  1992/06/03  14:33:14  clive
Added type annotations to FNexp

Revision 1.40  1992/04/28  18:36:39  jont
Added require _hashtable

Revision 1.39  1992/04/23  12:12:01  clive
Added some more customised utility functions

Revision 1.38  1992/04/13  14:16:44  clive
First version of the profiler


 * Copyright (c) 1991 Harlequin Ltd.
 *)

require "^.basis.__list";
require "lambdatypes";
require "lambdasub";

functor LambdaSub(
  structure LambdaTypes : LAMBDATYPES
) : LAMBDASUB =
struct
  structure Set = LambdaTypes.Set;
      
  structure LT = LambdaTypes;        (* A short name for clarity! *)
  structure Ident = LT.Ident

  (* Unwrap Lets -- NB! Only removes real lets. *)

  fun unwrap_lets expr =
   let 
     fun unwl(acc, LT.LET((var,info,bind),body)) = 
       unwl((var,bind)::acc,body)
       | unwl(acc, expr) = (rev acc, expr)
   in
     unwl([],expr)
   end

  (* Wrap Lets *)  

  fun wrap_lets (expression, vas) = 
    let
      fun nest ((var,arg),body) = LT.LET((var, NONE, arg),body)
    in
      foldl nest expression (rev vas)
    end

  (* This shouldn't really be needed *)
  (*  Eta-abstraction over some expression. *)
  (*  Generates a new lambda-variable. *)

  fun eta_abstract (le,annotation,ty) =
    let
      val lvar = LT.new_LVar()
    in
      LT.FN([lvar], LT.APP(le, [LT.VAR lvar], SOME(ty)),
	    annotation,LT.null_type_annotation,LT.internal_funinfo)
    end

  val LVar_eq = op=

  (* Optionally apply a function to an optional argument *)

  fun apopt f (SOME x) = SOME (f x)
    | apopt _ NONE     = NONE

  (* quick occurrence check: does the variable occur or not? *)

  fun occurs (lvar, expression) =
    let
      fun occurs(LT.VAR lv) = LVar_eq (lv, lvar)
	| occurs(LT.FN(_, le,_,_,_)) = occurs le
	| occurs(LT.LET((lv,_,lb),le)) = occurs lb orelse occurs le
	| occurs(LT.LETREC(lv_list, le_list, le)) =
	  (occurs le orelse List.exists occurs le_list)
	| occurs(LT.APP(le, lel,_)) = (occurs le orelse List.exists occurs lel)
	| occurs(LT.SCON _) = false
	| occurs(LT.MLVALUE _) = false
	| occurs(LT.INT _) = false
	| occurs(LT.SWITCH(le, info, tag_le_list, leo)) =
	  (occurs le orelse
	   occurs_opt leo orelse
	   List.exists occurs_tag tag_le_list)
	| occurs(LT.STRUCT (le_list,_)) = List.exists occurs (le_list)
	| occurs(LT.SELECT(_, le)) = occurs le
	| occurs(LT.RAISE (le)) = occurs le
	| occurs(LT.HANDLE(le, le',_)) = (occurs le orelse occurs le')
	| occurs(LT.BUILTIN _) = false

      and occurs_opt(NONE) = false
	| occurs_opt(SOME le) = occurs le

      and occurs_tag (tag, le) =
	(case tag of
	   LT.EXP_TAG le' => occurs le' orelse occurs le
	 | _ => occurs le)
    in
      occurs expression
    end

  (*         - - - - Generalised Recursion Schemes - - - -         *)

  (*
   * Recursively apply a function to a lambda-expression and its
   * sub-expressions, either innermost or outermost terms first, building
   * an isomorphic lambda-expression.  Innermost is AOR, outermost is like
   * AOR but applies the  function to the largest term first. The
   * with_context functions also pass the enclosing lambda expression as
   * an argument to the function.
   *)

  fun apply_one_level appsub = 
    let 
      fun apply_tagval (LT.EXP_TAG tagexp, value) =
        (LT.EXP_TAG (appsub tagexp), appsub value)
        | apply_tagval (tagexp, value) =
          (tagexp, appsub value)

      fun apply (le as LT.VAR _) = le
        | apply (LT.FN(lvl, le,x,ty,instance)) = LT.FN (lvl, appsub le,x,ty,instance) 
        | apply (LT.LET((lv,info,lb),le)) = LT.LET((lv,info,appsub lb),appsub le)
        | apply (LT.LETREC(lvl, lel, le)) =
          LT.LETREC (lvl, map appsub lel, appsub le)
        | apply (LT.APP(p, q, annotation)) = 
          LT.APP(appsub p, map appsub q, annotation)
        | apply (le as LT.SCON _) = le
        | apply (le as LT.MLVALUE _) = le
        | apply (le as LT.INT _) = le
        | apply (LT.SWITCH(le, info, clel, leo)) = 
          LT.SWITCH
          (appsub le,
           info,
           map apply_tagval clel,
           apopt appsub leo)
        | apply (LT.STRUCT (lel,ty)) = LT.STRUCT (map appsub lel,ty)
        | apply (LT.SELECT (fld, le)) = LT.SELECT (fld, appsub le)
        | apply (LT.RAISE (le)) = LT.RAISE (appsub le)
        | apply (LT.HANDLE (le1, le2,annotation)) = LT.HANDLE (appsub le1, 
                                                               appsub le2,
                                                               annotation)
        | apply (le as LT.BUILTIN _) = le
    in
      apply
    end

end (* of functor *)


