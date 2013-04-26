(* __mirtypes.sml the structure *)
(*
$Log: __mirtypes.sml,v $
Revision 1.16  1996/11/28 13:45:11  matthew
Removing source parameter from virtual register

 * Revision 1.15  1996/11/06  11:07:56  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.14  1996/04/29  14:45:52  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.13  1995/12/27  15:51:20  jont
 * Remove __option
 *
Revision 1.12  1995/03/17  20:17:06  daveb
Removed redundant parameters to applications of VirtualRegister

Revision 1.11  1994/09/13  10:55:37  matthew
Added RuntimeEnv structure

Revision 1.10  1993/07/29  14:44:22  nosa
Debugger Environments for local and closure variable inspection
 in the debugger;
structure Option.

Revision 1.9  1993/05/18  14:57:06  jont
Removed Integer parameter

Revision 1.8  1992/10/29  17:37:34  jont
Added Map structure for mononewmaps to allow efficient implementation
of lookup tables for integer based values

Revision 1.7  1992/06/29  08:09:45  clive
Added type annotation information at application points

Revision 1.6  1992/06/10  18:29:54  jont
Added requires for _counter and __crash

Revision 1.5  1992/06/02  09:13:22  richard
Added SmallIntSet parameters to VirtualRegister functors.

Revision 1.5  1992/05/28  12:57:34  richard
Added SmallIntSet parameters to VirtualRegister functors.

Revision 1.4  1992/05/18  14:17:00  richard
Changed calls to VirtualRegister functor to provide naming information.

Revision 1.3  1992/02/27  15:35:19  richard
Parameterised MirTypes functor with virtual register
structures.

Revision 1.2.1.1  1992/02/27  15:35:19  richard
This version of MirTypes supplied monomorphic virtual register sets
as abstract types.

Revision 1.2  1991/10/03  10:42:26  jont
Added Set parameter

Revision 1.1  91/07/25  14:17:16  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basis/__int";

require "../utils/_counter";
require "../utils/__set";
require "../utils/__text";
require "../utils/__crash";
require "../basics/__ident";
require "../utils/__lists";
require "../utils/__intbtree";
require "../utils/_smallintset";
require "../utils/_intsetlist";
require "../debugger/__debugger_types";
require "_virtualregister";
require "_mirtypes";

local

  fun text_prefix s =
    let
      val t = Text_.from_string s
    in
      fn i => Text_.concatenate (t, Text_.from_string (Int.toString i))
    end

  fun string_prefix s i = s ^ Int.toString i

  structure GC_ =
    VirtualRegister (structure Text = Text_
		     structure Map = IntBTree_
                     val int_to_text = text_prefix "GC"
                     val int_to_string = string_prefix "GC"
                     structure IntSet =
                       IntSetList (
                                   structure Text = Text_
                                   val int_to_text = int_to_text)
                     structure SmallIntSet =
                       SmallIntSet (structure Text = Text_
                                    structure Crash = Crash_
                                    structure Lists = Lists_
                                    val int_to_text = int_to_text))

  structure NonGC_ =
    VirtualRegister (structure Text = Text_
		     structure Map = IntBTree_
                     val int_to_text = text_prefix "NonGC"
                     val int_to_string = string_prefix "NonGC"
                     structure IntSet =
                       IntSetList (
                                   structure Text = Text_
                                   val int_to_text = int_to_text)
                     structure SmallIntSet =
                       SmallIntSet (structure Text = Text_
                                    structure Crash = Crash_
                                    structure Lists = Lists_
                                    val int_to_text = int_to_text))

  structure FP_ =
    VirtualRegister (structure Text = Text_
		     structure Map = IntBTree_
                     val int_to_text = text_prefix "FP"
                     val int_to_string = string_prefix "FP"
                     structure IntSet =
                       IntSetList (
                                   structure Text = Text_
                                   val int_to_text = int_to_text)
                     structure SmallIntSet =
                       SmallIntSet (structure Text = Text_
                                    structure Crash = Crash_
                                    structure Lists = Lists_
                                    val int_to_text = int_to_text))

in

  structure MirTypes_ = MirTypes(
    structure GC = GC_
    structure NonGC = NonGC_
    structure FP = FP_
    structure Map = IntBTree_
    structure Counter = Counter ()
    structure Set = Set_
    structure Ident = Ident_
    structure Text = Text_
    structure Debugger_Types = Debugger_Types_
  )

end
