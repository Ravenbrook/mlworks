/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 *
 * Description
 * -----------
 *
 * See ../../alloc.h
 *
 * This overrides ../../alloc.h since there are some peculiarities
 * in the Linux 1.2.8 <stdlib.h> file.  Firstly, unless MALLOC_0_RETURNS_NULL
 * is defined, then you get an error about two versions of __gnu_malloc
 * being defined.  Secondly, the header file #defines malloc to be __gnu_malloc
 * which is not what we want.  So the following tries to cure these problems.
 *
 * Revision Log
 * ------------
 *
 * $Log: alloc.h,v $
 * Revision 1.1  1996/08/20 13:16:34  stephenb
 * new unit
 * Creating this file fixes bug 1555.
 *
 * Revision 1.1  1996/07/31  12:00:25  stephenb
 * new unit
 *
 */


#ifndef alloc_h
#define alloc_h

#define MALLOC_0_RETURNS_NULL
#include <stdlib.h>		/* malloc, calloc, realloc, free */

#undef malloc
#undef realloc

#endif
