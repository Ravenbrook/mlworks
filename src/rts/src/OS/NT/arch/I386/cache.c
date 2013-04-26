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
 *  $Id: cache.c,v 1.1 1995/01/20 17:07:16 jont Exp $
 */

#include "cache.h"

extern void cache_flush(void *where, size_t how_much)
{
/* Nothing is necessary for intel machines, which have unified caches. */
}
