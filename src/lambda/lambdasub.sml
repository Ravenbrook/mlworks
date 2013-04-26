(* lambdasub.sml  - sub-functions for lambda modules *)

(*  Copyright (c) 1991 Harlequin Ltd.  *)

require "lambdatypes";

signature LAMBDASUB =
  sig 
    structure LT  : LAMBDATYPES

    val wrap_lets :
      LT.LambdaExp * (LT.LVar * LT.LambdaExp) list -> LT.LambdaExp
    val unwrap_lets :
      LT.LambdaExp -> (LT.LVar * LT.LambdaExp) list * LT.LambdaExp
    val apply_one_level :
      (LT.LambdaExp -> LT.LambdaExp) -> LT.LambdaExp -> LT.LambdaExp
    val occurs               : LT.LVar * LT.LambdaExp -> bool      
    val eta_abstract :
      LT.LambdaExp * string * LT.Type ref  -> LT.LambdaExp
  end;

(*
$Log: lambdasub.sml,v $
Revision 1.39  1995/12/04 12:26:32  matthew
Simplifying

Revision 1.38  1995/02/28  14:07:22  matthew
Removing old lambda optimizer stuff

Revision 1.37  1993/05/28  10:28:01  nosa
structure Option.

Revision 1.36  1993/03/10  15:59:24  matthew
Signature revisions

Revision 1.35  1992/11/09  15:47:41  clive
Added some LETREC optimisation

Revision 1.34  1992/08/26  12:30:26  jont
Removed some redundant structures and sharing

Revision 1.33  1992/07/24  13:24:32  clive
Modified to use the new hashtables

Revision 1.32  1992/07/22  12:04:32  clive
Wrote routines to try to substitute exactly n times without going inside letrec and fn

Revision 1.31  1992/07/17  13:47:37  clive
Changed eta_abstract to take an annotation

Revision 1.30  1992/07/03  07:41:58  davida
Simplified the types of a few functions.

Revision 1.29  1992/06/25  09:44:11  davida
Added occurs function.

Revision 1.28  1992/06/15  16:12:09  clive
LambdaExp is no longer an equality type, so replaced calls to = with LS.lambda_equality

Revision 1.27  1992/06/11  09:08:03  clive
Added type annotations to FNexp

Revision 1.26  1992/04/23  12:10:58  clive
Speed improvement

Revision 1.25  1992/04/13  14:28:22  clive
First version of the profiler

Revision 1.24  1992/02/12  11:08:38  jont
Added substitute_list function, used by both _curry and _optimise_cse

Revision 1.23  1992/01/29  17:49:00  clive
Added a function is_in_evaluation_set so that we don't have to
generate the evaluation_set and then test to see if something is in it
which proved to be a very expensive operation

Revision 1.22  1991/11/14  17:00:59  jont
Added eta_abstract function for general use

Revision 1.21  91/10/23  11:55:29  davidt
Added new functions apply_innermost_with_context
and apply_outermost_with_context.

Revision 1.20  91/10/22  17:40:07  davidt
Took out the crappy inclusion of Lists.

Revision 1.19  91/10/22  16:09:15  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.18  91/10/09  10:30:57  davidt
Took out most of Jon's utility functions (they are now in the
List structure).

Revision 1.17  91/09/10  13:43:09  davida
Changed type of substitute, added substitute_fresh

Revision 1.16  91/09/06  13:05:03  davida
List utility functions removed.

Revision 1.15  91/08/15  14:05:34  davida
New / altered functions.

Revision 1.14  91/08/14  13:05:54  davida
removed set_of_lvars, changed bounds_and_frees to include
variables bound by LETREC's.

Revision 1.13  91/08/13  16:04:04  davida
Added sub-expression substitution function "replace_subexpr"

Revision 1.12  91/08/09  14:03:21  davida
New functions added

Revision 1.11  91/08/06  14:20:09  davida
Altered selects_on_var for 2nd phase, temporarily.

Revision 1.10  91/08/02  15:55:03  davida
Added function size_of_expr to count number
sub expressions in an expression.

Revision 1.9  91/07/31  14:43:05  davida
Added whnf

Revision 1.8  91/07/30  16:45:29  davida
Added some more functions, fiddled with some old ones.

Revision 1.7  91/07/29  16:00:18  davida
Changed is_expansive to is_shiftable, added unwrap_apps.

Revision 1.6  91/07/25  17:57:18  jont
Added require for set to prevent future grief

Revision 1.5  91/07/25  13:07:30  davida
Added new functions.

Revision 1.4  91/07/24  13:00:16  davida
Altered form of is_expansive and added set_of_selects

Revision 1.3  91/07/22  12:54:15  jont
Moved some general purpose functions in from _lambda

Revision 1.2  91/07/16  17:23:48  davida
Added new functions set_of_lvars and is_expansive.

Revision 1.1  91/07/15  16:11:56  davida
Initial revision

*)
