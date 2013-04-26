/*  ==== CACHE CONTROL ====
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  cache_flush(start,length) flushes the instruction cache from start
 *  to start+length. This is required whenever creating or moving
 *  executable code.
 *
 *  $Id: cache.h,v 1.1 1994/11/09 17:04:25 nickb Exp $
 */

#ifndef cache_h
#define cache_h

#include <stddef.h> /* for size_t */

extern void cache_flush(void *where, size_t how_much);

#endif
