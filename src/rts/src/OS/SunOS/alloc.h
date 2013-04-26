/* Copyright (C) 1996 Harlequin Ltd.
 *
 * Description
 * -----------
 *
 * See ../../alloc.h
 *
 * This overrides ../../alloc.h to provide explicit prototypes for
 * the functions provided by ../../alloc.c because the SunOS headers
 * don't contain the correct prototypes.
 *
 * Revision Log
 * ------------
 *
 * $Log: alloc.h,v $
 * Revision 1.1  1996/07/31 12:00:25  stephenb
 * new unit
 *
 */


#ifndef alloc_h
#define alloc_h

#include <stddef.h>		/* size_t */

extern void * calloc(size_t number, size_t size);
extern void   free(void *p);
extern void * malloc(size_t size);
extern void * realloc(void *p, size_t size);

#endif
