(*  ==== Non GC REGISTER COLOURER ====
 *             STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  -------------
 *  $Log: __nongccolourer.sml,v $
 *  Revision 1.12  1998/08/27 12:17:27  jont
 *  [Bug #70040]
 *  Modify register colourer to use stack colourer only if requested from machspec
 *
 * Revision 1.11  1997/04/24  15:40:47  jont
 * [Bug #20007]
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.10  1997/01/22  16:01:52  jont
 * Adding corrupted_by_callee to functor parameter
 *
 * Revision 1.9  1995/12/27  15:51:30  jont
 * Remove __option
 *
 *  Revision 1.8  1995/05/30  11:08:55  matthew
 *  Adding debugging_available value
 *
 *  Revision 1.7  1993/10/11  13:21:03  jont
 *  Added option parameter
 *
 *  Revision 1.6  1993/05/18  14:45:25  jont
 *  Removed Integer parameter
 *
 *  Revision 1.5  1992/11/03  14:11:36  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.4  1992/10/05  13:15:34  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.3  1992/06/19  10:53:35  richard
 *  Added instance_name and available temporaries parameters.
 *
 *  Revision 1.2  1992/06/08  14:28:22  richard
 *  Added allocation order for registers.
 *
 *  Revision 1.1  1992/06/04  15:02:49  richard
 *  Initial revision
 *
 *)


require "../utils/__lists";
require "../utils/__crash";
require "../utils/__smallintset";
require "../utils/__text";
require "../utils/_diagnostic";
require "../machine/__machspec";
require "__mirtypes";
require "__mirregisters";
require "_registercolourer";


structure NonGCColourer_ =
  RegisterColourer
  (structure Lists = Lists_
   structure Crash = Crash_
   structure IntSet = SmallIntSet_
   structure Register = MirTypes_.NonGC
   structure Diagnostic = Diagnostic (structure Text = Text_)
   structure MachSpec = MachSpec_
     
   val instance_name = Text_.from_string "NonGC"

   val allocation_order = #non_gc MirRegisters_.allocation_order
   val allocation_equal = #non_gc MirRegisters_.allocation_equal

   val preassigned      = #non_gc MirRegisters_.preassigned
   val corrupted_by_callee = #non_gc MirRegisters_.corrupted_by_callee
   val available        = #non_gc MirRegisters_.general_purpose
   val debugging_available        = #non_gc MirRegisters_.debugging_general_purpose
   val temporaries	= #non_gc MirRegisters_.temporary
   val reserved_but_preferencable = #non_gc MirRegisters_.gp_for_preferencing
   val debugger_reserved_but_preferencable = #non_gc MirRegisters_.debugging_gp_for_preferencing)
