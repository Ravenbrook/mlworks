(*  ==== STATIC STACK ALLOCATOR ====
 *             STRUCTURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __stackallocator.sml,v $
 *  Revision 1.10  1994/08/16 14:47:56  matthew
 *  Update requires
 *
 *  Revision 1.9  1993/05/18  14:53:46  jont
 *  Removed Integer parameter
 *
 *  Revision 1.8  1992/04/23  10:51:57  jont
 *  Added require __text
 *
 *  Revision 1.7  1992/03/05  10:58:25  richard
 *  Changed MirTables to MirProcedure.
 *
 *  Revision 1.6  1992/02/11  13:17:14  richard
 *  Changed the application of the Diagnostic functor to take the Text
 *  structure as a parameter.  See utils/diagnostic.sml for details.
 *
 *  Revision 1.5  1991/12/11  15:07:20  richard
 *  Changed dependencies following rewrite of the functor.
 *
 *  Revision 1.4  91/12/05  13:20:55  richard
 *  Tidied up documentation.
 *  
 *  Revision 1.3  91/11/19  16:00:58  richard
 *  Changed debugging output to use the Diagnostic module, which
 *  prevents the debugging output strings being constructed even
 *  if they aren't printed.
 *  
 *  Revision 1.2  91/11/07  16:18:26  richard
 *  Minor changes to imported modules.
 *  
 *  Revision 1.1  91/10/29  11:58:46  richard
 *  Initial revision
 *)


require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "__mirprocedure";
require "__mirprint";
require "_stackallocator";


structure StackAllocator_ = StackAllocator (
  structure MirPrint = MirPrint_
  structure Crash = Crash_
  structure Lists = Lists_
  structure MirProcedure = MirProcedure_
  structure Diagnostic = Diagnostic ( structure Text = Text_ )
)
