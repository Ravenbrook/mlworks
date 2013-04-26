/*  ==== PERVASIVE BYTEARRAYS ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: bytearrays.c,v $
 *  Revision 1.11  1998/02/23 17:58:15  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.10  1996/08/19  11:02:49  daveb
 * [Bug #1551]
 * Made to_string and from_string preserve terminating null characters.
 *
 * Revision 1.9  1996/06/04  10:24:10  nickb
 * Reset bytearray_root when raising Substring.
 *
 * Revision 1.8  1995/07/24  11:09:28  matthew
 * Fixing problem with substring
 *
 * Revision 1.7  1995/04/17  13:43:10  brianm
 * Added a peek_memory operation.
 *
 * Revision 1.6  1995/04/03  12:51:07  brianm
 * Adding num_to_word32() word32_to_num().
 * Updating to use allocate_word32() and CWORD32().
 * Made code I had added more GC-safe by moving allocation to
 * end of functions.
 *
 * Revision 1.5  1995/03/24  19:16:54  brianm
 * Adding address operation for static bytearrays.
 *
 * Revision 1.4  1995/03/09  17:47:26  brianm
 * Adding make_static_bytearray
 *
 * Revision 1.3  1995/03/08  10:37:25  brianm
 * Added static_from_string - a version of `from_string' for
 * static bytearrays.
 *
 * Revision 1.2  1994/06/09  14:48:48  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:21:41  nickh
 * new file
 *
 *  Revision 1.4  1993/03/25  16:21:38  jont
 *  Modified use of HEADER for ARRAYHEADER as byte arrays are now ref tagged
 *
 *  Revision 1.3  1993/03/23  15:27:01  jont
 *  Tiny modification
 *
 *  Revision 1.2  1993/02/01  14:49:21  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.1  1992/10/26  13:05:35  richard
 *  Initial revision
 *
 */

#include <string.h>

#include "bytearrays.h"
#include "mltypes.h"
#include "values.h"
#include "exceptions.h"
#include "allocator.h"
#include "environment.h"
#include "gc.h"
#include "words.h"


static mlval bytearray_root;

static mlval make_static_bytearray(mlval argument)
{
  size_t length;
  mlval result;

  length = CINT(argument);
  result = allocate_static_bytearray(length);
  return(result);
}

static mlval static_address_of(mlval argument)
{
  unsigned val;
  int   array, offset;
  mlval result;

  array   = (int)CBYTEARRAY(FIELD(argument,0)); /* must be static bytearray */
  offset  = (int)CINT(FIELD(argument,1));

  val     = (unsigned)(array + offset);

  result  = allocate_word32();
  num_to_word32(val,result);

  return(result);
}

static mlval peek_memory(mlval argument)
{
  unsigned addr, target, start;
  int offset, size, length;
  mlval array;

  addr    = (unsigned)word32_to_num(FIELD(argument,0));

  array   = FIELD(argument,1);
  length  = LENGTH(ARRAYHEADER(array));
  target  = (unsigned)CBYTEARRAY(array);

  offset  = (int)CINT(FIELD(argument,2));
  size    = (int)CINT(FIELD(argument,3));

  /* Check array bounds ... */
  if ((0 > offset) || (0 > size) || (offset >= length) || (offset + size > length))
    exn_raise_string(perv_exn_ref_value, "peek : array bounds");

  if (size == 0) return(MLUNIT);

  start = (unsigned)(target + offset);

  /* Check for overlapping regions ... */
  if ((start <= addr) && (addr < start + size))
    exn_raise_string(perv_exn_ref_value, "peek : overlap");

  if ((addr <= start) && (start < addr + size))
    exn_raise_string(perv_exn_ref_value, "peek : overlap");

  /* Copy non-overlapping regions ... */
  memcpy((void *)start, (void *)addr, (size_t)size);

  return(MLUNIT);
}


/* to_string assumes that the bytearray is null-terminated. */
static mlval to_string(mlval argument)
{
  size_t length = LENGTH(ARRAYHEADER(argument));
  mlval result;

  result = allocate_string(length);
  memcpy(CSTRING(result), CBYTEARRAY(argument), length);

  return(result);
}

static mlval from_string(mlval argument)
{
  size_t length = LENGTH(GETHEADER(argument));
  mlval result;

  result = allocate_bytearray(length);
  memcpy(CBYTEARRAY(result), CSTRING(argument), length);

  return(result);
}

static mlval static_from_string(mlval argument)
{
  size_t length = LENGTH(GETHEADER(argument));
  mlval result;

  result = allocate_static_bytearray(length);
  memcpy(CBYTEARRAY(result), CSTRING(argument), length);

  return(result);
}

static mlval substring(mlval argument)
{
  int start = CINT(FIELD(argument,1));
  int length = CINT(FIELD(argument,2));
  int bound;
  mlval result;

  bytearray_root = FIELD(argument, 0);
  bound = LENGTH(ARRAYHEADER(bytearray_root));

  if(start < 0 || length < 0 || start > bound || start+length > bound) {
    bytearray_root = MLUNIT;
    exn_raise(perv_exn_ref_substring);
  }

  result = allocate_string((size_t) (length+1));
  memcpy(CSTRING(result), CBYTEARRAY(bytearray_root) + start, (size_t) length);
  CSTRING(result)[length] = '\0';
  bytearray_root = MLUNIT;

  return(result);
}


void bytearrays_init()
{
  bytearray_root = MLUNIT;
  declare_root(&bytearray_root, 0);

  env_function("make static bytearray",        make_static_bytearray);
  env_function("static bytearray address of",  static_address_of);
  env_function("bytearray peek memory",        peek_memory);
  env_function("bytearray to string",          to_string);
  env_function("bytearray from string",        from_string);
  env_function("static bytearray from string", static_from_string);
  env_function("bytearray substring",          substring);
}
