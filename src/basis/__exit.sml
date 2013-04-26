(* Copyright (C) 1996 Harlequin Ltd.
 *
 * See exit.sml for documentation.
 *
 * Revision Log
 * ------------
 *
 * $Log: __exit.sml,v $
 * Revision 1.9  1999/05/27 10:17:45  johnh
 * [Bug #190553]
 * Fix require statements to make bootstrap compiler work.
 *
 *  Revision 1.8  1999/04/22  09:44:02  daveb
 *  Removed the equality attribute from the status type; added isSuccess.
 *
 *  Revision 1.7  1999/03/11  15:22:28  daveb
 *  [Bug #190523]
 *  Added fromStatus.
 *
 *  Revision 1.6  1998/05/26  13:56:24  mitchell
 *  [Bug #30413]
 *  Define exit structure in terms of the pervasive exit structure
 *
 *  Revision 1.5  1998/02/19  16:16:10  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.4  1997/10/08  09:59:48  johnh
 *  [Bug #20101]
 *  Add signature constraint.
 *
 *  Revision 1.3  1997/10/07  14:50:11  johnh
 *  [Bug #30226]
 *  Set a reference  in pervasive to store the exit function to call when
 *  the executable exits normally.
 *
 *  Revision 1.2  1996/05/09  14:58:15  stephenb
 *  Fix the definition of terminate so the C function actually gets called!
 *
 *  Revision 1.1  1996/04/17  15:27:39  stephenb
 *  new unit
 *  Moved from main so that the files can be distributed as part
 *  of the basis.
 *
 *  Revision 1.1  1996/04/17  15:27:39  stephenb
 *  new unit
 *  Provide an OS independent way of terminating MLWorks.
 *
 *
 *)

require "exit";
require "../system/__os_exit";

structure Exit_ : EXIT = OSExit;
