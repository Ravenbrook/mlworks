(*  ==== MIR VIRTUAL REGISTER MODEL ===
 *              STRUCTURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __mirregisters.sml,v $
 *  Revision 1.7  1995/03/17 19:56:46  daveb
 *  Removed unused parameters.
 *
 *  Revision 1.6  1992/02/07  11:25:51  richard
 *  Changed Table to BTree to improve performance.
 *
 *  Revision 1.5  1992/01/03  15:54:32  richard
 *  Added Option module to dependencies.
 *
 *  Revision 1.4  1991/11/29  11:57:05  richard
 *  Tidied up documentation.
 *
 *  Revision 1.3  91/10/15  15:04:07  richard
 *  Added Table Lists and Crash to dependencies.
 *  
 *  Revision 1.2  91/10/09  13:49:05  richard
 *  Added MachSpec to arguments
 *  
 *  Revision 1.1  91/09/18  11:58:32  jont
 *  Initial revision
 *)


require "../utils/__lists";
require "../utils/__crash";
require "../machine/__machspec";
require "__mirtypes";
require "_mirregisters";


structure MirRegisters_ = MirRegisters(
  structure MirTypes = MirTypes_
  structure MachSpec = MachSpec_
  structure Lists = Lists_
  structure Crash = Crash_
)
