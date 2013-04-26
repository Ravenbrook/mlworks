(* __lambdaoptimiser the structure *)
(*
 * Lambda-Calculus Optimisation: __lambdaoptimiser
 * Main Control Module
 *)
(*
$Log: __lambdaoptimiser.sml,v $
Revision 1.23  1998/01/30 09:37:40  johnh
[Bug #30326]
Merge in Project Workspace changes.

 * Revision 1.22.2.2  1997/11/20  17:08:50  daveb
 * [Bug #30326]
 *
 * Revision 1.22.2.1  1997/09/11  20:55:28  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.22  1997/05/09  11:17:32  matthew
 * Adding Hashtable structure
 *
 * Revision 1.21  1996/11/14  15:53:32  matthew
 * Testing with local function stuff
 *
 * Revision 1.20  1996/10/04  13:19:49  matthew
 * [Bug #1634]
 *
 * Tidying up
 *
 * Revision 1.19  1996/04/30  15:19:44  matthew
 * Integer changes
 * ,
 *
 * Revision 1.18  1995/07/19  15:51:08  jont
 * Add scons parameter
 *
Revision 1.17  1995/05/31  09:54:04  matthew
Moving definition of SimpleLambda_ into here

Revision 1.16  1995/03/02  12:29:17  matthew
Commented out requires of old optimiser

Revision 1.15  1994/10/11  12:52:07  matthew
Uncommented use of new optimizer

Revision 1.14  1994/09/23  15:32:38  matthew
Added (commented out) use of new optimizer

Revision 1.13  1993/05/18  15:48:38  jont
Removed integer parameter

Revision 1.12  1992/07/09  11:22:12  davida
Removed OptimiseLib parameter.

Revision 1.11  1992/03/27  13:36:59  jont
Added Print and Integer parameters to functor.

Revision 1.10  1992/01/31  11:49:26  clive
Modified to use the new timer module

Revision 1.9  1991/11/22  17:35:13  jont
Removed opens

Revision 1.8  91/10/22  18:25:23  davidt
Now builds using Lists structure.

Revision 1.7  91/09/13  12:09:18  davida
Added timing function.

Revision 1.6  91/09/06  09:46:09  davida
New version to cope with re-organised sources.

Revision 1.5  91/08/06  15:01:57  davida
Added new functor parameter for optimise sub-functions.

Revision 1.4  91/07/30  12:43:52  davida
Added extra functor parameters

Revision 1.3  91/07/15  16:08:20  davida
Updated for new module LambdaSub

Revision 1.2  91/07/10  13:48:48  davida
Now has correct set of requires(!)

Revision 1.1  91/07/08  16:46:40  davida
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__inthashtable";
require "../utils/__hashtable";
require "../utils/__bignum";
require "../utils/__mlworks_timer";
require "../main/__pervasives";
require "../basics/__scons";
require "../main/__options";
require "__lambdaflow";
require "__lambdaprint";
require "__transsimple";
require "__simpleutils";

require "_simplelambda";

structure LambdaOptimiser_ =
  SimpleLambda (structure Crash = Crash_
                structure Lists = Lists_
                structure IntHashTable = IntHashTable_
                structure HashTable = HashTable_
                structure Bignum = BigNum_
                structure Timer = Timer_
                structure Scons = Scons_
                structure Options = Options_
                structure Pervasives = Pervasives_
                structure TransSimple = TransSimple_
                structure SimpleUtils = SimpleUtils_
                structure LambdaFlow = LambdaFlow_
                structure LambdaPrint = LambdaPrint_
                  )
