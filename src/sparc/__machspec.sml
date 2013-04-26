(*   ==== MACHINE SPECIFICATION ====
 *              STRUCTURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __machspec.sml,v $
 *  Revision 1.10  1997/01/02 15:35:15  matthew
 *  Deleting Lists structure
 *
 * Revision 1.9  1995/12/27  15:54:42  jont
 * Remove __option
 *
Revision 1.8  1994/07/29  15:27:01  matthew
Need Lists structure

Revision 1.7  1993/08/16  09:51:50  daveb
Removed spurious ".sml" from require declarations.

 *  Revision 1.6  1992/11/21  19:36:44  jont
 *  Removed pervasives
 *  
 *  Revision 1.5  1992/09/15  11:04:16  clive
 *  Checked and corrected the specification for the floating point registers
 *  
 *  Revision 1.4  1992/01/03  15:38:30  richard
 *  Added Option module to dependencies.
 *  
 *  Revision 1.3  1991/11/14  16:48:08  jont
 *  Changed require of pervasives.sml to require of __pervasives.sml
 *  
 *  Revision 1.2  91/11/12  16:53:09  jont
 *  Added Pervasives to the parameter list
 *  
 *  Revision 1.1  91/10/07  11:48:14  richard
 *  Initial revision
 *)


require "../utils/__crash";
require "../utils/__set";
require "__machtypes";
require "_machspec";


structure MachSpec_ = MachSpec(
  structure MachTypes = MachTypes_
  structure Set = Set_
  structure Crash = Crash_
)
