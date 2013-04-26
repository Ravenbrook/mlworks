/* $Id: caching.h,v 1.2 2002/03/22 19:24:52 jonw Exp $
 * ==========
 * Macros for platform-specific control of caching. Initially, the cache
 * control macros will be platform named (e.g. PENTIUM_*, ALPHA_*), but this
 * may change if generic mechanisms can be found.
 *
 *    $Log: caching.h,v $
 *    Revision 1.2  2002/03/22 19:24:52  jonw
 *    [Bug #24216]
 *    Kill a Splint warning: avoid an empty 'else' clause.
 *
 * Revision 1.1  1995/10/13  18:50:26  angus
 * new unit
 * [Bug #6584]
 * New file, containing platform-specific macros to control caching. All macros
 * should be defined for all platforms, but should be no-ops on inappropriate
 * platforms.
 *
 */

#ifndef __CACHING_H__
#define __CACHING_H__

#include "platform.h"	/* for machine type definitions */

#if PLATFORM_MACHINE == P_INTEL
/* Cache pre-load macros for Pentium; the Pentium has an 8K two-way set
   associative writeback data cache and an 8K read-only instruction cache,
   with a cache line size of 32 bytes. The cache lines are read and written
   using burst transfer mode, so writing into the cache and then spilling the
   cache line to secondary cache/main memory is quicker than writing through
   to memory. Depending on how the second level cache is organised, it may be
   much faster (and usually is a bit faster) to pre-load a cache line, write
   into the cache line, and then flush the cache. This can give substantial
   performance benefits when writing out large quantities of data.
*/
#define PENTIUM_CACHE_LOAD(address) MACRO_START \
  if ( *((volatile uint8 *)(address)) ) {       \
    EMPTY_STATEMENT() ;                         \
  }                                             \
  else {                                        \
    EMPTY_STATEMENT() ;                         \
  }                                             \
MACRO_END

#else /* ! INTEL */

#define PENTIUM_CACHE_LOAD(address) /* Nothing doing, not a Pentium */

#endif /* ! INTEL */

#endif  /* __CACHING_H__ */

