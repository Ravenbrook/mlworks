(*  ==== INITIAL BASIS :  GENERAL ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __general.sml,v $
 *  Revision 1.6  1997/03/20 10:30:17  andreww
 *  [Bug #1431]
 *  Removing out of date code comment.
 *
 * Revision 1.5  1996/10/22  10:15:57  andreww
 * [Bug #1682]
 * removed General from MLWorks.General
 * ,
 *
 * Revision 1.4  1996/07/03  11:32:06  andreww
 * Making top-level.
 *
 * Revision 1.3  1996/05/08  14:59:19  jont
 * Update to latest revision
 *
 * Revision 1.2  1996/04/23  13:05:35  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:26:40  jont
 * new unit
 *
 *  Revision 1.2  1995/03/31  13:47:55  brianm
 *  Adding options operators to General ...
 *
 * Revision 1.1  1995/03/16  20:57:36  brianm
 * new unit
 * New file.
 *
 * Revision 1.1  1995/03/08  16:23:04  brianm
 * new unit
 *
 *)
require "general";


(* this structure already exists at toplevel. File kept for compatibility
   with code that was written when it didn't.*)

structure General:GENERAL = General
