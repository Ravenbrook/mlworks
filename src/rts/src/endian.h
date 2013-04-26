/*
 * endian.h
 * Handle endian change requirements.
 * $Log: endian.h,v $
 * Revision 1.2  1994/06/09 14:34:28  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:59:56  nickh
 * new file
 *
 * Revision 1.4  1992/03/17  14:27:25  richard
 * Changed error behaviour.
 *
 * Revision 1.3  1991/10/21  09:34:20  davidt
 * change_endian now changes a number of words (this is so that we can
 * call change_endian on a complete piece of code).
 *
 * Revision 1.2  91/10/17  16:21:42  davidt
 * Moved MAGIC_ENDIAN into objectfile.h and tidied up a bit,
 * including doing the renaming of types to come into line
 * with the rest of the run-time system.
 * 
 * Revision 1.1  91/05/14  11:07:03  jont
 * Initial revision
 * 
 * Copyright (c) 1991 Harlequin Ltd.
 */

#ifndef endian_h
#define endian_h

#include "types.h"

#include <stddef.h>

/*
 * Check if we need to change endian.
 */

extern int find_endian(word magic);

/*
 * Change the endianness of a number of words.
 */

extern void change_endian(word *words, size_t length);

#endif
