(*  ==== MIR ANNOTATED PROCEDURE TYPE ====
 *               STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __mirprocedure.sml,v $
 *  Revision 1.7  1995/05/30 11:00:49  matthew
 *  Removing Timer structure
 *
 *  Revision 1.6  1995/03/17  20:05:19  daveb
 *  Removed unused parameters.
 *
 *  Revision 1.5  1993/05/18  14:34:12  jont
 *  Removed Integer parameter
 *
 *  Revision 1.4  1992/06/17  10:42:12  richard
 *  Added Timer structure to parameters.
 *
 *  Revision 1.3  1992/05/26  14:05:01  richard
 *  Added RegisterPack as a parameter to functor.
 *
 *  Revision 1.2  1992/04/27  12:45:55  richard
 *  Added Integer structure.
 *
 *  Revision 1.1  1992/02/20  15:10:50  richard
 *  Initial revision
 *
 *)


require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/_diagnostic";
require "__mirprint";
require "__mirtables";
require "__registerpack";
require "_mirprocedure";


structure MirProcedure_ = MirProcedure (
  structure Diagnostic =
    Diagnostic (structure Text = Text_)
  structure MirTables = MirTables_
  structure MirPrint = MirPrint_
  structure Lists = Lists_
  structure Crash = Crash_
  structure RegisterPack = RegisterPack_
)
