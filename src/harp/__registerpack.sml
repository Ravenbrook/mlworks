(*  ==== PACK REGISTERS IN A PROCEDURE ====
 *                STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __registerpack.sml,v $
 *  Revision 1.5  1994/09/26 12:33:25  matthew
 *  Adding IntHashTable
 *
 *  Revision 1.4  1994/05/26  11:34:31  richard
 *  Adding parameter to functor.
 *
 *  Revision 1.3  1993/05/18  14:49:36  jont
 *  Removed Integer parameter
 *
 *  Revision 1.2  1992/06/17  13:22:57  richard
 *  Added Integer structure and parameter to decide when to apply
 *  full analysis.
 *
 *  Revision 1.1  1992/05/27  11:17:49  richard
 *  Initial revision
 *
 *)


require "../utils/__inthashtable";
require "../utils/__text";
require "../utils/_diagnostic";
require "../utils/__crash";
require "../utils/__lists";
require "__mirtables";
require "__mirregisters";
require "__mirprint";

require "_registerpack";


structure RegisterPack_ =
  RegisterPack (structure Diagnostic = Diagnostic (structure Text = Text_)
                structure Crash = Crash_
                structure Lists = Lists_
                structure IntHashTable = IntHashTable_
                structure MirTables = MirTables_
                structure MirRegisters = MirRegisters_
                structure MirPrint = MirPrint_

                val full_analysis_threshold = 500)
