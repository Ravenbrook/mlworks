/*
$HopeName: HQNc-standard!export:hqmemcpy.h(trunk.4) $

$Log: hqmemcpy.h,v $
Revision 1.5  2002/05/30 16:28:25  angus
[Bug #11576]
HqMemcpy and HqMemmove are void functions. Reduce Splint warnings

 * Revision 1.4  2002/04/22  15:05:39  miker
 * [Bug #25083]
 * Replace uses of RELEASE_BUILD with ASSERT_BUILD, DEBUG_BUILD as appropriate
 *
 * Revision 1.3  2002/03/22  19:24:56  jonw
 * [Bug #24216]
 * Annotate for Splint.
 *
 * Revision 1.2  1998/01/08  20:03:51  davidg
 * [Bug #20913]
 * fix definition of HqMemMove() when calling bcopy_safe()
 *
 * Revision 1.1  1998/01/08  17:03:41  jonw
 * new unit
 * [Bug #20913]
 * New file for standardised memory-copying routines.
 *
*/

#ifndef __HQMEMCPY_H__
#define __HQMEMCPY_H__

#include "std.h"

/* Two entry points for copying blocks of memory, closely shadowing the ANSI
 * functions memcpy and memmove. In fact on some platforms they map down onto
 * those functions. On others, they call out to the OS, or execute our own
 * optimised routines. The decision of which to use on each platform should be
 * based on careful testing.
 */
 
/* For ScriptWorks core RIP only products, we already have a requirement that
 * the OEM provide an implementation of bcopy. Other products which use these
 * routines and are shipped as a static library on platforms which don't use
 * the ANSI versions will have the same requirement.
 */
 
/* The three preprocessor identifiers USE_INLINE_MEMCPY, USE_INLINE_MEMMOVE and
 * BCOPY_OVERLAP_SAFE may or may not be defined in platform.h. The decision
 * is based on speed tests for the best routine on a given platform and on
 * documentation to determine the overlap safety of bcopy. Debug builds all
 * assert that blocks passed to HqMemCpy don't overlap - hence the need for
 * the wrapper function HqMemCpy_Assert.
 */

void HqMemCpy_Assert(
  /*@notnull@*/ /*@out@*/       void *s1 ,
  /*@notnull@*/ /*@in@*/        void *s2 ,
                                int32 count ) ;
void bcopy_safe(
  /*@notnull@*/ /*@in@*/        char *s2 ,
  /*@notnull@*/ /*@out@*/       char *s1 ,
                                int32 count ) ;

/* HqMemCpy - moves _count bytes from _s2 to _s1. Correct results when the
 *            blocks overlap are not guaranteed.
 */
 

#if defined( USE_INLINE_MEMCPY ) || defined( USE_INLINE_MEMMOVE )
#include <string.h>
#endif

#if defined( USE_INLINE_MEMCPY )
#define HqMemCpy_Raw( _s1 , _s2 , _count ) \
        (void)memcpy(( void * )( _s1 ) , ( void * )( _s2 ) , ( size_t )( _count ))
#else
#define HqMemCpy_Raw( _s1 , _s2 , _count ) \
        bcopy(( char * )( _s2 ) , ( char * )( _s1 ) , ( int )( _count ))
#endif /* defined( USE_INLINE_MEMCPY ) */

#if ! defined( ASSERT_BUILD )
#define HqMemCpy( _s1 , _s2 , _count ) HqMemCpy_Raw( _s1 , _s2 , _count )
#else
#define HqMemCpy( _s1 , _s2 , _count ) \
        HqMemCpy_Assert(( void * )( _s1 ) , ( void * )( _s2 ) , ( int32 )( _count ))
#endif


/* HqMemMove - moves _count bytes from _s2 to _s1, correctly coping with
 *             overlapping blocks.
 */


#if defined( USE_INLINE_MEMMOVE )
#define HqMemMove( _s1 , _s2 , _count ) \
        (void)memmove(( void * )( _s1 ) , ( void * )( _s2 ) , ( size_t )( _count ))
#else
#if defined( BCOPY_OVERLAP_SAFE )
#define HqMemMove( _s1 , _s2 , _count ) \
        bcopy(( char * )( _s2 ) , ( char * )( _s1 ) , ( int )( _count ))
#else
#define HqMemMove( _s1 , _s2 , _count ) \
        bcopy_safe(( char * )( _s2 ) , ( char * )( _s1 ) , ( int32 )( _count ))
#endif /* defined( BCOPY_OVERLAP_SAFE ) */
#endif /* defined( USE_INLINE_MEMMOVE ) */

#endif  /* __HQMEMCPY_H__ */
