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
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
