/*  === LICENSING ===
 *
 *  Copyright (C) 1998 Harlequin Group plc.
 *
 *  Description
 *  -----------
 *  Centralised location for version information in runtime 
 *
 *  $Log: version.h,v $
 *  Revision 1.2  1998/07/30 15:03:33  jkbrook
 *  [Bug #30456]
 *  Update for 2.0c0
 *
 * Revision 1.1  1998/06/11  19:11:58  jkbrook
 * new unit
 * Start to centralise version information
 *
 *
 */

/* 
   This is currently used to differentiate stored licence files and
   registry entries.  If version is full, then candidate numbers should
   be ignored as licences will need to be reinstalled too often.

   The problem of specifying these things explicitly will disappear 
   when this file represents version info in a simliarly structured 
   way to main/__version.sml.
*/

#define VERSION_STR "2.0"

#define MAJOR_VERSION 2.0

