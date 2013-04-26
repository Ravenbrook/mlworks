(*  ==== LIVE VARIABLE ANALYSIS ====
 *	       STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __mirvariable.sml,v $
 *  Revision 1.10  1994/09/13 16:09:16  matthew
 *  Added IntHashTable
 *
 *  Revision 1.9  1994/08/16  14:50:56  matthew
 *  Update requires
 *
 *  Revision 1.8  1992/06/22  11:50:35  richard
 *  Added MirRegisters to parameters.
 *
 *  Revision 1.7  1992/06/04  07:57:49  richard
 *  Added RegisterAllocator parameter.
 *
 *  Revision 1.6  1992/02/27  11:06:46  richard
 *  Added register structures as instances of VirtualRegister.
 *
 *)
require "../utils/__lists";
require "../utils/__crash";
require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__inthashtable";
require "__mirprint";
require "__mirtables";
require "__mirregisters";
require "__registerallocator";
require "_mirvariable";


structure MirVariable_ = MirVariable(
  structure Lists = Lists_
  structure Crash = Crash_
  structure Diagnostic = Diagnostic( structure Text = Text_ )
  structure IntHashTable = IntHashTable_
  structure MirPrint = MirPrint_
  structure MirTables = MirTables_
  structure MirRegisters = MirRegisters_
  structure RegisterAllocator = RegisterAllocator_
)
