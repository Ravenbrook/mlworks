/*  ==== ML VALUE HEAP ALLOCATOR ====
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
 *  This library contains functions which allocate ML objects on the ML
 *  heap.  A garbage collection may be caused by any of the functions, so
 *  any ML pointer values which need to be preserved must be declared as
 *  roots before calling them.  The objects returned are uninitialized; they
 *  must be filled with valid ML values (where applicable) before the next
 *  garbage collection. In the debugging runtime, scannable objects returned
 *  are filled with DEAD, to help identifying uninitialized objects.
 *
 *  Revision Log
 *  ------------
 *  $Log: allocator.h,v $
 *  Revision 1.6  1997/08/19 15:14:10  nickb
 *  [Bug #30250]
 *  Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.5  1995/04/03  11:14:19  brianm
 * Adding allocate_word32.
 *
 * Revision 1.4  1995/03/01  16:03:33  nickb
 * Add static object allocation.
 *
 * Revision 1.3  1994/08/11  11:18:01  matthew
 * Adding allocate_vector
 *
 * Revision 1.2  1994/06/09  14:32:23  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:57:20  nickh
 * new file
 *
 *  Revision 1.17  1992/09/08  13:47:46  richard
 *  Added `allocate_multiple'.
 *
 *  Revision 1.16  1992/08/24  08:05:17  richard
 *  Added allocate_bytearray.
 *
 *  Revision 1.15  1992/08/05  17:10:02  richard
 *  Added allocate_code().
 *
 *  Revision 1.14  1992/07/30  11:13:29  richard
 *  Added static_string().
 *
 *  Revision 1.13  1992/07/23  11:22:48  richard
 *  `ml_string' now takes a const char *.
 *
 *  Revision 1.12  1992/07/14  08:17:07  richard
 *  Added allocate_array() and allocate_weak_array().
 *
 *  Revision 1.11  1992/06/30  09:55:52  richard
 *  Added storeman.h to headers.
 *
 *  Revision 1.10  1992/03/11  14:22:05  richard
 *  Tidied up and improved type abstration.
 *
 *  Revision 1.9  1991/12/17  16:01:42  nickh
 *  removed declare_root and retract_root (these are now in gc.c)
 *
 *  Revision 1.8  91/12/17  14:51:23  richard
 *  Removed argument from allocate_real.
 *  
 *  Revision 1.7  91/11/11  17:12:33  jont
 *  Added allocate_real
 *  
 *  Revision 1.6  91/10/21  09:19:26  davidt
 *  Changed the types of declare_root and retract_root so that the
 *  garbage collector is free to move the root objects (updating
 *  their new values using the address provided).
 *  
 *  Revision 1.5  91/10/18  15:52:52  davidt
 *  Allocation routines for various ML objects.
 *  
 *  Revision 1.4  91/10/17  15:12:44  davidt
 *  Took out all sorts of junk which had gone out of date.
 *  
 *  Revision 1.3  91/05/22  12:11:56  jont
 *  *** empty log message ***
 *  
 *  Revision 1.2  91/05/15  15:27:52  jont
 *  Updated for second revision of load structure
 *  
 *  Revision 1.1  91/05/14  11:06:01  jont
 *  Initial revision
 */

#ifndef allocator_h
#define allocator_h

#include "values.h"

#include <stddef.h>


/*  === ALLOCATE UNINITIALIZED OBJECT ===
 *
 *  The objects allocated by these functions are uninitialized, and so must
 *  be filled in with valid ML values before the next garbage collection or
 *  allocation.
 *
 *  Note:  The size passed to allocate_string() is the entire size,
 *  including the terminating '\0' character, if any.
 *
 */

extern mlval allocate_record(size_t number_of_fields);
extern mlval allocate_vector(size_t number_of_fields);
extern mlval allocate_string(size_t size_in_bytes);
extern mlval allocate_bytearray(size_t size_in_bytes);
extern mlval allocate_code(size_t size_in_words);
extern mlval allocate_real(void);
extern mlval allocate_array(size_t length);
extern mlval allocate_weak_array(size_t length);
extern mlval allocate_word32(void);

/*  === ALLOCATE STATIC OBJECTS ===
 *
 * These are just like the above, but allocate in the static spaces
 * (see mem.h).
 */

extern mlval allocate_static_bytearray(size_t size_in_bytes);

/*  === MAKE ML STRING FROM C STRING ===
 *
 *  Creates an ML string object corresponding to a C string.
 */

extern mlval ml_string(const char *cstring);


/*  === ALLOCATE MULTIPLE OBJECTS ===
 *
 *  This function allocates a block of contiguous memory in one go.  It
 *  attempts to allocate space for `number' objects, each of size `size'
 *  values.  It returns the number of objects available and sets *start to
 *  point at the beginning of the memory.  Guaranteed not to enter the
 *  garbage collector.
 */

extern size_t allocate_multiple(size_t size, size_t number, mlval **start);

#endif
