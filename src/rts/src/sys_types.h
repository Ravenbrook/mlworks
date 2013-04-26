/*  ==== SYSTEM SPECIFIC TYPES ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This contains useful system specific type definitions.  Seperate definitions
 *  for each system are given by ifdef's.  Each ifdef defines the same collection 
 *  of system specific types.
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: sys_types.h,v $
 *  Revision 1.3  1995/07/06 23:42:39  brianm
 *  Minor corrections ...
 *
 * Revision 1.2  1995/07/05  21:27:23  brianm
 * Interim version for impl. of libml.c
 *
 * Revision 1.1  1995/07/05  14:46:04  brianm
 * new unit
 * New file.
 *
 *
 */

#ifndef sys_types_h
#define sys_types_h


/* === SYSTEM SPECIFIC TYPES ===

   This file defines a collection of types for each system.  Each system
   defines the same collection of typenames (without exception).  For clarity,
   the typenames required are listed here - with their intended meaning:

      uint8     --- unsigned 8-bit  numbers
      uint16    --- unsigned 16-bit numbers
      uint32    --- unsigned 32-bit numbers

   In each case, operations over these types is not guaranteed.

*/


/* At present, no distinct systems specified - so no ifdef's */
 
typedef unsigned char     uint8;
typedef unsigned short    uint16;
typedef unsigned int      uint32;

#endif
