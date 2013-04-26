
(*
 * Lambda-Calculus Optimisation: lambdaoptimiser
 * Main Control Module
 *
 * Copyright (c) 1991 Harlequin Ltd.
 *)

require "lambdatypes";
require "../main/options";

signature LAMBDAOPTIMISER = 
  sig
    structure LambdaTypes : LAMBDATYPES
    structure Options : OPTIONS
    val optimise : Options.options -> LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp
    val simple_beta_reduce : LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp
  end;

(*
$Log: lambdaoptimiser.sml,v $
Revision 1.22  1995/05/12 15:11:29  matthew
Removing redundant controls

Revision 1.21  1993/05/18  10:55:11  jont
Added a ref to control maximum size of expression for which we
optimise until done

Revision 1.20  1993/05/11  12:38:07  jont
Made optimise take the full Options.options

Revision 1.19  1993/03/04  12:56:33  matthew
Options & Info changes

Revision 1.18  1993/02/01  17:59:27  matthew
Added sharing constraints

Revision 1.17  1992/11/26  19:41:45  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.16  1992/07/24  13:35:46  clive
Modified to use the new hashtables

Revision 1.15  1992/07/03  07:48:38  davida
Added check validity switch.

Revision 1.14  1991/10/22  14:20:09  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.13  91/09/16  11:20:01  davida
Added turn_on_all, turn_off_all.

Revision 1.12  91/09/13  12:25:10  davida
Removed report switch, added timing.

Revision 1.11  91/09/11  12:10:31  davida
Added new display flags

Revision 1.10  91/09/10  14:52:14  davida
Removed redundant heuristic parameter

Revision 1.9  91/09/09  15:21:29  davida
New restructured sources.

Revision 1.8  91/09/04  11:14:21  davida
Added simple beta reduce function for export.

Revision 1.7  91/08/22  12:44:34  davida
Removed test-output flags from signature.  These
are no-longer refs, so that the debug code can be
left in, but we can compile a release version of
the compiler and a debug version: release version
will have dead code removed, hopefully.

Revision 1.6  91/08/06  15:09:32  davida
Removed sub-structure Set.

Revision 1.5  91/08/02  10:02:49  davida
Removed superfluous argument from top-level optimise
function, at last!

Revision 1.4  91/07/30  12:54:33  davida
Added diagnostic-output switches.

Revision 1.3  91/07/15  16:13:10  davida
Updated for new module LambdaSub

Revision 1.2  91/07/10  13:49:45  davida
Now has correct set of requires(!)

Revision 1.1  91/07/08  16:02:23  davida
Initial revision

*)

