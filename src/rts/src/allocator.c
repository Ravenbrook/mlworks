/*  ==== ML VALUE HEAP ALLOCATION ====
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
 *  Implementation
 *  --------------
 *  The allocation functions attempt to allocate space by simply
 *  incrementing the value of ml_state.heap_start, just as an ML program
 *  would.  If this takes the heap_start over the heap_limit the garbage
 *  collector is called.
 *
 *  Revision Log
 *  ------------
 *  $Log: allocator.c,v $
 *  Revision 1.16  1998/07/29 13:12:02  jont
 *  [Bug #20133]
 *  Modify to use GC_HEAP_REAL_LIMIT
 *
 * Revision 1.15  1998/04/23  13:23:43  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.14  1997/10/21  12:42:51  daveb
 * [Bug #30259]
 * Merging from MLWorks_10r3:
 * ALLOCATE_STATIC has to multiply its parameter by sizeof(mlval).
 *
 * Revision 1.13  1997/10/14  12:22:20  jont
 * [Bug #70014]
 * Fix bad parameter to ALLOCATOR_INITIALIZE under debugging runtime
 *
 * Revision 1.12  1997/08/19  15:13:51  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.11  1996/12/19  10:05:16  stephenb
 * [Bug #1791]
 * ALLOCATE+ALLOCATE_STATIC: wrap the macro bodies in do { ... } while (0)
 * to avoid binding problems.
 *
 * Revision 1.10  1996/02/13  16:05:25  jont
 * Add a type cast to remove compilation warnings from Visual C
 *
 * Revision 1.9  1995/09/09  14:56:28  brianm
 * Reversion to version 1.7.
 *
 * Revision 1.8  1995/09/09  00:51:32  brianm
 * Word32 string repn. needs an extra byte to allow correct bit-wise access.
 *
 * Revision 1.7  1995/08/08  09:56:56  matthew
 * Changing representation of word32's to strings
 *
 * Revision 1.6  1995/04/03  11:20:12  brianm
 * Adding allocate_word32.
 *
 * Revision 1.5  1995/03/01  16:15:50  nickb
 * Add static object allocation.
 *
 * Revision 1.4  1994/09/21  12:24:02  brianm
 * Since X call can return NULL for a null string (a touch naughty), so
 * added check to ml_string for NULL pointer case.
 *
 * Revision 1.3  1994/08/11  11:19:02  matthew
 * Adding allocate_vector
 *
 * Revision 1.2  1994/06/09  14:32:08  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:57:02  nickh
 * new file
 *
 *  Revision 1.25  1994/01/28  17:22:10  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.24  1993/03/23  15:20:57  jont
 *  Changed allocation of bytearrays to be ref tagged
 *
 *  Revision 1.23  1992/09/08  14:30:47  richard
 *  Added `allocate_multiple'.
 *
 *  Revision 1.22  1992/08/24  14:41:09  richard
 *  Added allocate_bytearray.
 *
 *  Revision 1.21  1992/08/24  08:05:14  richard
 *  Added allocate_bytearray.
 *
 *  Revision 1.20  1992/08/05  17:18:54  richard
 *  Added allocate_code().
 *
 *  Revision 1.19  1992/07/30  11:19:17  richard
 *  Added static_string.  Corrected use of MLPTR().
 *
 *  Revision 1.18  1992/07/23  11:22:45  richard
 *  `ml_string' now takes a const char *.
 *
 *  Revision 1.17  1992/07/14  08:20:13  richard
 *  Added allocate_array() and allocate_weak_array().
 *
 *  Revision 1.16  1992/06/30  16:16:26  richard
 *  Reworked to use declarations in storeman.h.
 *
 *  Revision 1.15  1992/03/11  14:25:25  richard
 *  Tidied up and increased level of diagnostic messages.
 *
 *  Revision 1.14  1992/03/05  09:20:30  richard
 *  Caused allocate_record to zero out the padding word in the case of
 *  an unaligned record length.
 *
 *  Revision 1.13  1992/02/26  11:46:23  richard
 *  Corrected calls to the gc() to pass sizes in bytes, not words.
 *
 *  Revision 1.12  1992/01/08  16:55:34  richard
 *  Sorted out the malformatted diagnostics.
 *
 *  Revision 1.11  1991/12/20  16:59:20  richard
 *  Reworked allocate_record() and changed diagnostic output
 *  to use DIAGNOSTIC so that it can be switched on and off.
 *
 *  Revision 1.10  91/12/17  16:55:32  nickh
 *  oops.
 *
 *  Revision 1.9  91/12/17  16:02:29  nickh
 *  rewrote to remove bugs, but return to gc-calling style. Note that declaring
 *  and retracting roots is now in gc.c
 *
 *  Revision 1.5  91/11/11  18:00:23  jont
 *  Added allocate_real
 *
 *  Revision 1.4  91/10/29  14:54:12  davidt
 *  Changed allocation routines to call the garbage collector if they
 *  run out of free space. They should now behave exactly as a ML
 *  program behaves when allocating stuuf on the heap.
 *
 *  Revision 1.3  91/10/23  15:40:44  davidt
 *  Now uses ml_state.heap_start and ml_state.heap_limit to allocate
 *  on the ML heap.
 *
 *  Revision 1.2  91/10/21  09:20:02  davidt
 *  Changed the types of declare_root and retract_root so that the
 *  garbage collector is free to move the root objects (updating
 *  their new values using the address provided).
 *
 *  Revision 1.1  91/10/18  16:13:23  davidt
 *  Initial revision
 */


#include "allocator.h"
#include "diagnostic.h"
#include "state.h"
#include "utils.h"
#include "values.h"
#include "gc.h"

#include <string.h>
#include <stddef.h>
#include <assert.h>

#define ALLOCATE(p, words)                      \
do { 						\
  size_t w = ((words)+1u) & ~1u;		\
						\
  p = GC_HEAP_START;				\
  GC_HEAP_START += w;				\
  if(GC_HEAP_START >= GC_HEAP_REAL_LIMIT)		\
  {						\
    gc(w * sizeof(mlval), MLUNIT);		\
    p = GC_RETURN;				\
  }						\
} while (0)

#define ALLOCATE_STATIC(p, words)               \
do { 						\
  size_t w = ((words)+1u) & ~1u;		\
						\
  struct ml_static_object *result = make_static_object(w * sizeof(mlval)); \
  result->forward = &creation->statics;		\
  result->back = creation->statics.back;	\
  result->forward->back = result;		\
  result->back->forward = result;		\
   p = &result->object[0];			\
} while (0)

#ifdef DEBUG

/* A macro to preinitialise memory for improved debugging */
#define ALLOCATOR_INITIALIZE(ptr, words)        \
do {                                            \
  mlval *p = (ptr);                             \
  size_t w = (size_t)(words);                   \
  while(w --)                                   \
    *p++ = DEAD;                                \
} while (0)

#else

#define ALLOCATOR_INITIALIZE(ptr, words) do { } while(0)

#endif

/*  == Allocate a record ==
 *
 *  Records of size 2 are headerless, and are aligned differently to others.
 *  (See primary tags in values.h for details.)
 */

mlval allocate_record(size_t nr_fields)
{
  mlval *record;

  if(nr_fields == 2)
  {
    ALLOCATE(record, 2);

    DIAGNOSTIC(5, "Allocate pair  : New ml_heap 0x%lx", GC_HEAP_START, 0);
    DIAGNOSTIC(5, "               : Tagged value 0x%lx", MLPTR(PAIRPTR, record), 0);
    ALLOCATOR_INITIALIZE(record, nr_fields);

    return(MLPTR(PAIRPTR, record));
  }
  else
  {
    ALLOCATE(record, nr_fields+1);

    record[0] = MAKEHEAD(RECORD, nr_fields);

    /* Make sure the extra word added for alignment purposes is scannable by */
    /* the garabge collector. */
    if(!(nr_fields & 1))
      record[nr_fields+1] = 0;

    DIAGNOSTIC(5, "Allocate record: Fields 0x%lx", nr_fields, 0);
    DIAGNOSTIC(5, "               : Header 0x%lx", MAKEHEAD(RECORD,nr_fields), 0);
    DIAGNOSTIC(5, "               : New ml_heap 0x%lx", GC_HEAP_START, 0);
    DIAGNOSTIC(5, "               : Tagged value 0x%lx", MLPTR(POINTER, record), 0);
    ALLOCATOR_INITIALIZE(record+1, nr_fields);

    return(MLPTR(POINTER, record));
  }
}


mlval allocate_vector(size_t nr_fields)
{
  mlval *vector;

  {
    ALLOCATE(vector, nr_fields+1);

    vector[0] = MAKEHEAD(RECORD, nr_fields);

    /* Make sure the extra word added for alignment purposes is scannable by */
    /* the garabge collector. */
    if(!(nr_fields & 1))
      vector[nr_fields+1] = 0;

    DIAGNOSTIC(5, "Allocate vector: Fields 0x%lx", nr_fields, 0);
    DIAGNOSTIC(5, "               : Header 0x%lx", MAKEHEAD(RECORD,nr_fields), 0);
    DIAGNOSTIC(5, "               : New ml_heap 0x%lx", GC_HEAP_START, 0);
    DIAGNOSTIC(5, "               : Tagged value 0x%lx", MLPTR(POINTER, vector), 0);
    ALLOCATOR_INITIALIZE(vector+1, nr_fields);

    return(MLPTR(POINTER, vector));
  }
}


/*  == Allocate a string ==  */

mlval allocate_string(size_t length)
{
  mlval *string;

  ALLOCATE(string, WLENGTH(length)+1);

  string[0] = MAKEHEAD(STRING,length);

  DIAGNOSTIC(5, "Allocate string: Size in bytes 0x%lx", length, 0);
  DIAGNOSTIC(5, "               : Wrote header 0x%lx", MAKEHEAD(STRING,length), 0);
  DIAGNOSTIC(5, "               : New ml_heap 0x%lx", GC_HEAP_START, 0);
  DIAGNOSTIC(5, "               : Tagged pointer 0x%lx", MLPTR(POINTER, string), 0);

  return(MLPTR(POINTER, string));
}

mlval allocate_bytearray(size_t length)
{
  mlval *bytearray;

  ALLOCATE(bytearray, WLENGTH(length)+1);

  bytearray[0] = MAKEHEAD(BYTEARRAY, length);

  DIAGNOSTIC(5, "Allocate bytearray: Size in bytes 0x%lx", length, 0);
  DIAGNOSTIC(5, "                  : Wrote header 0x%lx", MAKEHEAD(BYTEARRAY,length), 0);
  DIAGNOSTIC(5, "                  : New ml_heap 0x%lx", GC_HEAP_START, 0);
  DIAGNOSTIC(5, "                  : Tagged pointer 0x%lx", MLPTR(POINTER, bytearray), 0);

  return(MLPTR(REFPTR, bytearray));
}


/*  == Allocate a code vector ==  */

mlval allocate_code(size_t length)
{
  mlval *code;

  ALLOCATE(code, length+1);

  code[0] = MAKEHEAD(CODE, length);

  if(!(length & 1))
    code[length+1] = 0;

  DIAGNOSTIC(5, "Allocate code: Size in words 0x%X", length, 0);
  DIAGNOSTIC(5, "             : Header 0x%X", MAKEHEAD(CODE, length), 0);
  DIAGNOSTIC(5, "             : New ml_heap 0x%X", GC_HEAP_START, 0);
  DIAGNOSTIC(5, "             : Tagged pointer 0x%X", MLPTR(POINTER, code), 0);

  /* initialize the ancillary ptr */
  ALLOCATOR_INITIALIZE(code+1, 1);

  return(MLPTR(POINTER, code));
}


/*  == Allocate an array ==  */

mlval allocate_array(size_t length)
{
  mlval *array;
  union ml_array_header *entry;

  ALLOCATE(array, length+3);
  entry = (union ml_array_header *)array;

  entry->the.header  = MAKEHEAD(ARRAY, length);
  entry->the.forward = (union ml_array_header *)MLINT(1);
  entry->the.back    = (union ml_array_header *)MLINT(0);

  if(!(length & 1))
    array[length+3] = 0;

  DIAGNOSTIC(5, "Allocate array: Length 0x%X", length, 0);
  DIAGNOSTIC(5, "              : Header 0x%X", array[0], 0);
  DIAGNOSTIC(5, "              : New heap 0x%X", GC_HEAP_START, 0);
  DIAGNOSTIC(5, "              : Tagged value 0x%X", MLPTR(REFPTR, array), 0);

  ALLOCATOR_INITIALIZE(array+3, length);

  return(MLPTR(REFPTR, array));
}


/*  == Allocate a weak array ==
 *
 *  The weak array is placed on the modified list so that the garbage
 *  collector can find it.
 */

mlval allocate_weak_array(size_t length)
{
  mlval *array;
  union ml_array_header *entry;

  ALLOCATE(array, length+3);
  entry = (union ml_array_header *)array;
  entry->the.header  = MAKEHEAD(WEAKARRAY, length);
  entry->the.forward = 0;
  entry->the.back    = GC_MODIFIED_LIST;
  GC_MODIFIED_LIST = entry;;
  
  if(!(length & 1))
    array[length+3] = 0;

  DIAGNOSTIC(5, "Allocate weak array: Length 0x%X", length, 0);
  DIAGNOSTIC(5, "                   : Header 0x%X", array[0], 0);
  DIAGNOSTIC(5, "                   : New heap 0x%X", GC_HEAP_START, 0);
  DIAGNOSTIC(5, "                   : Tagged value 0x%X", MLPTR(REFPTR, array), 0);

  ALLOCATOR_INITIALIZE(array+3, length);

  return(MLPTR(REFPTR, array));
}


/*  == Allocate a real ==
 *
 *  Only double-sized reals are supported at present.
 *  An extra word of padding is inserted before the double itself to ensure
 *  that it is double-aligned.
 */

mlval allocate_real(void)
{
  mlval *bytearray;

  ALLOCATE(bytearray, 4);

  bytearray[0] = MAKEHEAD(BYTEARRAY, sizeof(double) + 4);

  DIAGNOSTIC(5, "Allocate real  : Wrote header 0x%lx", MAKEHEAD(BYTEARRAY,sizeof(double) + 4), 0);
  DIAGNOSTIC(5, "               : New ml_heap 0x%lx", GC_HEAP_START, 0);
  DIAGNOSTIC(5, "               : Tagged pointer 0x%lx", MLPTR(POINTER, bytearray), 0);

  return(MLPTR(POINTER, bytearray));
}

/*  === STATIC BYTEARRAYS === */

mlval allocate_static_bytearray(size_t length)
{
  mlval *bytearray;

  ALLOCATE_STATIC(bytearray,WLENGTH(length)+1);
  bytearray[0] = MAKEHEAD(BYTEARRAY,length);

  DIAGNOSTIC(5, "Allocate static bytearray: Size in bytes 0x%lx", length, 0);
  DIAGNOSTIC(5, "                         : Tagged pointer 0x%lx",
	     MLPTR(POINTER, bytearray), 0);

 return(MLPTR(REFPTR, bytearray));
}


/*  == Allocate a Word32 ==
 *
 *  Word32 objects are strings of (real) length 4.
 *
 */
mlval allocate_word32(void)
{
   return(allocate_string(4));
}


/*  === EMPTY C STRING === */

const char *null_cstring = "";



/*  === MAKE ML STRING FROM C STRING ===  */

mlval ml_string (const char *cstring)
{
  mlval mlstring;

  if (NULL == cstring) { cstring = null_cstring ;};
                       /* e.g. X can return NULL */

  mlstring = allocate_string(strlen(cstring) + 1);
  strcpy(CSTRING(mlstring), cstring);
  return(mlstring);
}


/*  === ALLOCATE MULTIPLE OBJECTS ===  */

size_t allocate_multiple(size_t size, size_t number, mlval **start)
{
  signed long available = (GC_HEAP_REAL_LIMIT - GC_HEAP_START)/size;

  assert(available >= 0);

  available = available > (signed long)number ? number : available;
  *start = GC_HEAP_START;
  GC_HEAP_START = GC_HEAP_START + available * size;
  ALLOCATOR_INITIALIZE(*start, available * size);
  return(available);
}
