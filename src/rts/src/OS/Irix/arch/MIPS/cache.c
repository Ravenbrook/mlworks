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
 *  $Id: cache.c,v 1.1 1994/11/09 16:58:46 nickb Exp $
 */

#include "cache.h"

#include <sys/cachectl.h>

extern void cache_flush(void *where, size_t how_much)
{
  cacheflush(where, (int)how_much, BCACHE);
}
