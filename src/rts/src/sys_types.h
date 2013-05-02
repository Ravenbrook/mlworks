/*  ==== SYSTEM SPECIFIC TYPES ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
