/* Copyright (C) 1996 Harlequin Ltd.
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
