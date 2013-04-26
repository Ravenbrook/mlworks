(* __mir_cg.sml the structure *)
(*
$Log: __mir_cg.sml,v $
Revision 1.44  1996/11/18 15:02:36  matthew
Removing some structures

 * Revision 1.43  1995/08/24  13:21:57  daveb
 * Added BigNum32.
 *
Revision 1.42  1995/05/30  11:01:53  matthew
Removing timer structure

Revision 1.41  1995/02/13  13:54:50  matthew
Adding Options structure

Revision 1.40  1995/02/07  17:20:31  matthew
Removing use of Types structure

Revision 1.39  1994/11/11  17:25:50  jont
Add immediate store operations

Revision 1.38  1994/09/09  17:26:14  jont
Add MachPerv to parameter list

Revision 1.37  1994/06/09  15:56:30  nickh
New runtime directory structure.

Revision 1.36  1993/07/16  12:46:08  jont
Added BigNum parameter

Revision 1.35  1993/06/23  15:25:49  daveb
Removed Primitives structure.

Revision 1.34  1993/05/18  16:35:36  daveb
Removed the Integer structure.

Revision 1.33  1993/03/09  19:30:08  jont
New info stuff

Revision 1.32  1992/11/10  13:54:25  matthew
Changed Error structure to Info

Revision 1.31  1992/11/04  15:46:33  jont
Removed currt_reduce. Added IntBTree

Revision 1.30  1992/10/28  11:37:43  jont
Removed dependence on environ in favour of environtypes

Revision 1.29  1992/09/24  15:29:35  jont
Removed the curry module, it wasn't doing anything

Revision 1.28  1992/08/07  16:52:28  davidt
String structure is now pervasive.

Revision 1.27  1992/08/04  15:07:43  davidt
Removed various redundant arguments.

Revision 1.26  1992/07/20  10:50:38  clive
Added jont's curry_reduce

Revision 1.25  1992/07/06  15:33:31  clive
Added call point information

Revision 1.24  1992/05/13  09:50:33  jont
Added auglambda. Removed mir_data

Revision 1.23  1992/05/05  13:22:59  jont
Added auglambda parameter to functor

Revision 1.22  1992/04/24  15:55:06  jont
Added Mir_Data parameter

Revision 1.21  1992/04/07  19:23:15  jont
Added mir_utils parameter

Revision 1.20  1992/03/27  14:11:48  jont
Added mirprint parameter to functor application for debugging purposes

Revision 1.19  1992/02/11  13:59:13  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.18  1992/01/30  19:00:24  jont
Added string parameter

Revision 1.17  1992/01/21  15:44:54  clive
More work on arrays

Revision 1.16  1992/01/14  12:28:12  jont
Added diagnostic parameter

Revision 1.15  1992/01/07  17:58:26  jont
Added Curry parameter

Revision 1.14  1992/01/06  19:58:39  jont
Added Print parameter

Revision 1.13  1991/11/29  17:15:29  jont
Added tail

Revision 1.12  91/11/27  13:09:04  jont
Removed references to match_utils

Revision 1.11  91/11/05  16:47:31  jont
Added InterProc parameter

Revision 1.10  91/09/26  13:21:24  jont
Added Crash structure

Revision 1.9  91/09/18  12:05:35  jont
Added mirregisters parameter

Revision 1.8  91/09/05  11:08:20  jont
Added __library parameter

Revision 1.7  91/08/23  14:54:25  jont
Added pervasives

Revision 1.6  91/08/13  16:21:50  jont
Added a parameter

Revision 1.5  91/08/09  19:06:41  jont
Added several more structures to the functor argument

Revision 1.4  91/08/01  14:50:41  jont
Added Map and Lists

Revision 1.3  91/07/31  19:21:23  jont
Added integer to functor arguments

Revision 1.2  91/07/30  17:43:44  jont
Added reference to Set

Revision 1.1  91/07/25  18:13:33  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/_diagnostic";
require "../utils/__crash";
require "../utils/__text";
require "../utils/__lists";
require "../utils/__intbtree";
require "../utils/__bignum";
require "../main/__library";
require "../main/__info";
require "../main/__options";
require "../lambda/__lambdaprint";
require "../lambda/__simpleutils";
require "../match/__type_utils";
require "../rts/gen/__implicit";
require "../machine/__machspec";
require "../machine/__machperv";
require "__mirprint";
require "__mirregisters";
require "__mir_utils";
require "__mirtables";
require "_mir_cg";

structure Mir_Cg_ = Mir_Cg(
  structure Diagnostic = Diagnostic(structure Text = Text_)
  structure Crash = Crash_
  structure Lists = Lists_
  structure IntMap = IntBTree_
  structure Info = Info_
  structure Options = Options_
  structure BigNum = BigNum_
  structure BigNum32 = BigNum32_
  structure Library = Library_
  structure LambdaPrint = LambdaPrint_
  structure SimpleUtils = SimpleUtils_
  structure MachSpec = MachSpec_
  structure MachPerv = MachPerv_
  structure MirPrint = MirPrint_
  structure MirRegisters = MirRegisters_
  structure Mir_Utils = Mir_Utils_
  structure MirTables = MirTables_
  structure Implicit_Vector = ImplicitVector_
  structure TypeUtils = TypeUtils_
)
