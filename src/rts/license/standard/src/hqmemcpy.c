/*
$HopeName: HQNc-standard!src:hqmemcpy.c(trunk.6) $

$Log: hqmemcpy.c,v $
Revision 1.7  2002/04/22 15:05:41  miker
[Bug #25083]
HqMemCpy_Assert() is only for assert builds

 * Revision 1.6  2000/11/24  14:08:13  miker
 * [Bug #23773]
 * Port for Mac OS X
 *
 * Revision 1.5  1999/12/02  16:49:13  jonw
 * [Bug #22841]
 * Fix warnings (and hence the Jam build).
 *
 * Revision 1.4  1998/01/13  17:28:31  jonw
 * [Bug #20913]
 * Rejig the conditional compilation stuff since the last version broke the Alpha
 * builds of gui SW. Try to make sure direct calls to bcopy get the system version
 * if available, and only the bcopy herein in very controlled circumstances.
 *
 * Revision 1.3  1998/01/12  18:01:59  jonw
 * [Bug #20913]
 * Move bcopy definitions here so that products which don't include the coreskin
 * (e.g. SWprod_flatout) still link properly. The argument is that memory copying
 * routines are at a lower level even than the OS layer of the framework - really
 * this constitutes Hqn-specific overrides to the runtime library.
 *
 * Revision 1.2  1998/01/09  14:42:58  jonw
 * [Bug #20913]
 * Dosiest of the dosy bugs.
 *
 * Revision 1.1  1998/01/08  17:03:41  jonw
 * new unit
 * [Bug #20913]
 * New file for standardised memory-copying routines.
 *
*/

/* hqmemcpy.c */

#include "hqmemcpy.h"
#include "caching.h"

STATIC void scpyf( register uint8 *s1 , register uint8 *s2 , int32 count ) ;
STATIC void scpyb( register uint8 *s1 , register uint8 *s2 , int32 count ) ;

/* For non-overlapping blocks in assert builds. Asserts that the blocks
 * don't overlap.
 */

#ifdef ASSERT_BUILD
void HqMemCpy_Assert( void *s1 , void *s2 , int32 count )
{
  int32 delta = ( char * )s1 - ( char * )s2 ;
  
  if ( delta > 0 ) {
    if ( delta < count )
      HQFAIL( "HqMemCpy called with overlapping blocks.\n" ) ;
    else
      HqMemCpy_Raw( s1 , s2 , count ) ;
  }
  else if ( delta < 0 ) {
    if ( -delta < count )
      HQFAIL( "HqMemCpy called with overlapping blocks.\n" ) ;
    else
      HqMemCpy_Raw( s1 , s2 , count ) ;
  }
  /* else delta == 0 so the copy's a no-op. */
}
#endif

/* A wrapper for bcopy implementations which aren't overlap safe. Calls scpyf
 * or scpyb below in the case of an overlap, HqMemCpy otherwise.
 */

void bcopy_safe( char *s2 , char *s1 , int32 count )
{
  int32 delta = s1 - s2 ;
  
  if ( delta > 0 ) {
    if ( delta < count )
      scpyb(( uint8 * )s1 , ( uint8 * )s2 , count ) ;
    else
      HqMemCpy( s1 , s2 , count ) ;
  }
  else if ( delta < 0 ) {
    if ( -delta < count )
      scpyf(( uint8 * )s1 , ( uint8 * )s2 , count ) ;
    else
      HqMemCpy( s1 , s2 , count ) ;
  }
  /* else delta == 0 so the copy's a no-op. */
}

#if defined( MACINTOSH )
#ifndef MACOSX

#include <Memory.h>

/* ---------------------------------------------------------------------------
   routine:             bcopy                 author:             Andy Edwards
   creation date:       07-Oct-1991           last modification:  ##-###-####
   description:
   
   Not the fastest block copy, but it'll do for the moment.
   NB it's guaranteed when blocks overlap, so replace it with the same.
   Parameter list to match generic prototypes. [owen Oct 2, 95]
   It _is_ the fastest block copy according to my tests.. [jonw Jan 9, 98]
--------------------------------------------------------------------------- */

void bcopy( char * s, char * d, int32 l )
{
  HQASSERT(( l >= 0 ), "bcopy: length negative" ) ;
  HQASSERT((s != 0 || l == 0), "bcopy: s NULL and length non-zero");
  HQASSERT((d != 0 || l == 0), "bcopy: d NULL and length non-zero");
  
  if ( l == 0 )
    return ;

  BlockMoveData(( void * )s, ( void * )d, ( Size )l );
}

#endif /* ! MACOSX */
#endif /* defined( MACINTOSH ) */

#if defined( NO_BCOPY ) || defined( WIN32 )

/* ---------------------------------------------------------------------------
   routine:             bcopy                 author:             Andy Edwards
   creation date:       07-Oct-1991           last modification:  ##-###-####
   description:

   Copy a block of memory from one place to another. This routine is pretty
   good for most architectures, but should be checked for performance when
   porting to a new architecture. If the compiler supports in-lined memcpy,
   and it is faster than this routine (this is not always the case), then
   change platform.h to define USE_INLINE_MEMCPY.
--------------------------------------------------------------------------- */

void bcopy(char *s, char *d, int l)
{
  HQASSERT(l >= 0, "bcopy: length negative");
  HQASSERT(s != 0 || l == 0, "bcopy: s NULL and length non-zero");
  HQASSERT(d != 0 || l == 0, "bcopy: d NULL and length non-zero");

  /* Sometimes, we actually try the stupid operation of copying things on top
     of themselves. It would be nice to get rid of these, but it's not totally
     practicable at the moment. *sigh*. */
  if ( s == d )
    return ;

  /* Note that unlike the Unix version of bcopy, this version *does not*
     guarantee that it works with overlapping blocks. Hence the following
     assert. */
  HQASSERT(s + l <= d || d + l <= s, "bcopy: blocks overlap") ;

#ifdef USE_INLINE_MEMCPY
  memcpy((void *)d, (const void *)s, (size_t)l) ;
#else /* ! USE_INLINE_MEMCPY */
  if ( l >= 11 ) {
    register uint32 *toptr, *fromptr ;
    register uint32 nw ;

    /* Do bytes until destination is 32-bit aligned; note that it's better to
       align destination rather than source on most machines, to reduce write
       cycles; read caching tends to be more effective. */
    switch ( (int32)d & 3 ) {
    case 1:
      *d++ = *s++ ; l-- ;
    case 2:
      *d++ = *s++ ; l-- ;
    case 3:
      *d++ = *s++ ; l-- ;
    }

    toptr = (uint32 *)d ;
    nw = l >> 2 ;

#ifndef Unaligned_32bit_access
    switch ( (int32)s & 3 ) {
    case 0: /* Same pointer alignment */
#endif /* ! Unaligned_32bit_access */
      {
	fromptr = (uint32 *)s ;

	while ( nw >= 8 ) {
	  PENTIUM_CACHE_LOAD(toptr + 7) ;
	  toptr[ 0 ] = fromptr[ 0 ] ;
	  toptr[ 1 ] = fromptr[ 1 ] ;
	  toptr[ 2 ] = fromptr[ 2 ] ;
	  toptr[ 3 ] = fromptr[ 3 ] ;
	  toptr[ 4 ] = fromptr[ 4 ] ;
	  toptr[ 5 ] = fromptr[ 5 ] ;
	  toptr[ 6 ] = fromptr[ 6 ] ;
	  toptr[ 7 ] = fromptr[ 7 ] ;
	  toptr += 8 ;
	  fromptr += 8 ;
	  nw -= 8 ;
	}

	while ( nw ) {
	  *toptr++ = *fromptr++ ;
	  nw -= 1 ;
	}
  
	s = (char *)fromptr ;
	d = (char *)toptr ;
	l &= 3 ;		/* Let switch clean up remaining bytes */
      }
#ifndef Unaligned_32bit_access
      break ;
    case 1: /* 32-bit reads and writes, out of phase with alignment */
      {
	register uint32 ping, pong ;

	fromptr = (uint32 *)(s - 1) ;	/* aligned read pointer */

	/* guaranteed dereference, because src ptr is 1/4 way between
	   fromptr[0] and fromptr[1] at this point, with more than 1 word
	   to transfer */
	ping = *fromptr ;

	while ( nw >= 8 ) {
#ifdef highbytefirst
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping << 8) | (pong >> 24) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong << 8) | (ping >> 24) ;
	  pong = fromptr[ 3 ] ;
	  toptr[ 2 ] = (ping << 8) | (pong >> 24) ;
	  ping = fromptr[ 4 ] ;
	  toptr[ 3 ] = (pong << 8) | (ping >> 24) ;
	  pong = fromptr[ 5 ] ;
	  toptr[ 4 ] = (ping << 8) | (pong >> 24) ;
	  ping = fromptr[ 6 ] ;
	  toptr[ 5 ] = (pong << 8) | (ping >> 24) ;
	  pong = fromptr[ 7 ] ;
	  toptr[ 6 ] = (ping << 8) | (pong >> 24) ;
	  ping = fromptr[ 8 ] ;
	  toptr[ 7 ] = (pong << 8) | (ping >> 24) ;
#else /* ! highbytefirst */
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping >> 8) | (pong << 24) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong >> 8) | (ping << 24) ;
	  pong = fromptr[ 3 ] ;
	  toptr[ 2 ] = (ping >> 8) | (pong << 24) ;
	  ping = fromptr[ 4 ] ;
	  toptr[ 3 ] = (pong >> 8) | (ping << 24) ;
	  pong = fromptr[ 5 ] ;
	  toptr[ 4 ] = (ping >> 8) | (pong << 24) ;
	  ping = fromptr[ 6 ] ;
	  toptr[ 5 ] = (pong >> 8) | (ping << 24) ;
	  pong = fromptr[ 7 ] ;
	  toptr[ 6 ] = (ping >> 8) | (pong << 24) ;
	  ping = fromptr[ 8 ] ;
	  toptr[ 7 ] = (pong >> 8) | (ping << 24) ;
#endif /* ! highbytefirst */
	  toptr += 8 ;
	  fromptr += 8 ;
	  nw -= 8 ;
	}

	while ( nw >= 2 ) {
#ifdef highbytefirst
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping << 8) | (pong >> 24) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong << 8) | (ping >> 24) ;
#else /* ! highbytefirst */
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping >> 8) | (pong << 24) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong >> 8) | (ping << 24) ;
#endif /* ! highbytefirst */
	  toptr += 2 ;
	  fromptr += 2 ;
	  nw -= 2 ;
	}

	s = (char *)fromptr + 1 ;
	d = (char *)toptr ;
	l &= 7 ;		/* Let switch clean up remaining bytes */
      }
      break ;
    case 2: /* 32-bit reads and writes out of phase with alignment */
      {
	register uint32 ping, pong ;

	fromptr = (uint32 *)(s - 2) ;	/* aligned read pointer */

	/* guaranteed dereference, because src ptr is 1/2 way between
	   fromptr[0] and fromptr[1] at this point, with more than one word
	   to transfer. */
	ping = *fromptr ;

	while ( nw >= 8 ) {
#ifdef highbytefirst
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping << 16) | (pong >> 16) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong << 16) | (ping >> 16) ;
	  pong = fromptr[ 3 ] ;
	  toptr[ 2 ] = (ping << 16) | (pong >> 16) ;
	  ping = fromptr[ 4 ] ;
	  toptr[ 3 ] = (pong << 16) | (ping >> 16) ;
	  pong = fromptr[ 5 ] ;
	  toptr[ 4 ] = (ping << 16) | (pong >> 16) ;
	  ping = fromptr[ 6 ] ;
	  toptr[ 5 ] = (pong << 16) | (ping >> 16) ;
	  pong = fromptr[ 7 ] ;
	  toptr[ 6 ] = (ping << 16) | (pong >> 16) ;
	  ping = fromptr[ 8 ] ;
	  toptr[ 7 ] = (pong << 16) | (ping >> 16) ;
#else /* ! highbytefirst */
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping >> 16) | (pong << 16) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong >> 16) | (ping << 16) ;
	  pong = fromptr[ 3 ] ;
	  toptr[ 2 ] = (ping >> 16) | (pong << 16) ;
	  ping = fromptr[ 4 ] ;
	  toptr[ 3 ] = (pong >> 16) | (ping << 16) ;
	  pong = fromptr[ 5 ] ;
	  toptr[ 4 ] = (ping >> 16) | (pong << 16) ;
	  ping = fromptr[ 6 ] ;
	  toptr[ 5 ] = (pong >> 16) | (ping << 16) ;
	  pong = fromptr[ 7 ] ;
	  toptr[ 6 ] = (ping >> 16) | (pong << 16) ;
	  ping = fromptr[ 8 ] ;
	  toptr[ 7 ] = (pong >> 16) | (ping << 16) ;
#endif /* ! highbytefirst */
	  toptr += 8 ;
	  fromptr += 8 ;
	  nw -= 8 ;
	}

	while ( nw >= 2 ) {
#ifdef highbytefirst
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping << 16) | (pong >> 16) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong << 16) | (ping >> 16) ;
#else /* ! highbytefirst */
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping >> 16) | (pong << 16) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong >> 16) | (ping << 16) ;
#endif /* ! highbytefirst */
	  toptr += 2 ;
	  fromptr += 2 ;
	  nw -= 2 ;
	}

	s = (char *)fromptr + 2 ;
	d = (char *)toptr ;
	l &= 7 ;		/* Let switch clean up remaining bytes */
      }
      break ;
    case 3: /* 32-bit reads and writes out of phase with alignment */
      {
	register uint32 ping, pong ;

	fromptr = (uint32 *)(s - 3) ;	/* aligned read pointer */

	/* guaranteed dereference, because src ptr is 3/4 way between
	   fromptr[0] and fromptr[1] at this point, with more than 1 word
	   to transfer */
	ping = *fromptr ;

	while ( nw >= 8 ) {
#ifdef highbytefirst
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping << 24) | (pong >> 8) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong << 24) | (ping >> 8) ;
	  pong = fromptr[ 3 ] ;
	  toptr[ 2 ] = (ping << 24) | (pong >> 8) ;
	  ping = fromptr[ 4 ] ;
	  toptr[ 3 ] = (pong << 24) | (ping >> 8) ;
	  pong = fromptr[ 5 ] ;
	  toptr[ 4 ] = (ping << 24) | (pong >> 8) ;
	  ping = fromptr[ 6 ] ;
	  toptr[ 5 ] = (pong << 24) | (ping >> 8) ;
	  pong = fromptr[ 7 ] ;
	  toptr[ 6 ] = (ping << 24) | (pong >> 8) ;
	  ping = fromptr[ 8 ] ;
	  toptr[ 7 ] = (pong << 24) | (ping >> 8) ;
#else /* ! highbytefirst */
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping >> 24) | (pong << 8) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong >> 24) | (ping << 8) ;
	  pong = fromptr[ 3 ] ;
	  toptr[ 2 ] = (ping >> 24) | (pong << 8) ;
	  ping = fromptr[ 4 ] ;
	  toptr[ 3 ] = (pong >> 24) | (ping << 8) ;
	  pong = fromptr[ 5 ] ;
	  toptr[ 4 ] = (ping >> 24) | (pong << 8) ;
	  ping = fromptr[ 6 ] ;
	  toptr[ 5 ] = (pong >> 24) | (ping << 8) ;
	  pong = fromptr[ 7 ] ;
	  toptr[ 6 ] = (ping >> 24) | (pong << 8) ;
	  ping = fromptr[ 8 ] ;
	  toptr[ 7 ] = (pong >> 24) | (ping << 8) ;
#endif /* ! highbytefirst */
	  toptr += 8 ;
	  fromptr += 8 ;
	  nw -= 8 ;
	}

	while ( nw >= 2 ) {
#ifdef highbytefirst
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping << 24) | (pong >> 8) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong << 24) | (ping >> 8) ;
#else /* ! highbytefirst */
	  pong = fromptr[ 1 ] ;
	  toptr[ 0 ] = (ping >> 24) | (pong << 8) ;
	  ping = fromptr[ 2 ] ;
	  toptr[ 1 ] = (pong >> 24) | (ping << 8) ;
#endif /* ! highbytefirst */
	  toptr += 2 ;
	  fromptr += 2 ;
	  nw -= 2 ;
	}

	s = (char *)fromptr + 3 ;
	d = (char *)toptr ;
	l &= 7 ;		/* Let switch clean up remaining bytes */
      }
      break ;
    }
#endif /* ! Unaligned_32bit_access */
  }

  HQASSERT( l < 11, "bcopy finished with too much to do") ;

  switch ( l ) { /* Nobody said I had to be consistent about direction! */
  case 10: d[9] = s[9] ;
  case 9:  d[8] = s[8] ;
  case 8:  d[7] = s[7] ;
  case 7:  d[6] = s[6] ;
  case 6:  d[5] = s[5] ;
  case 5:  d[4] = s[4] ;
  case 4:  d[3] = s[3] ;
  case 3:  d[2] = s[2] ;
  case 2:  d[1] = s[1] ;
  case 1:  d[0] = s[0] ;
  }
#endif /* ! USE_INLINE_MEMCPY */
}

#endif /* defined( NO_BCOPY ) || defined( WIN32 ) */

/* ----------------------------------------------------------------------------
   function:            scpyf(..)           author:              Andrew Cave
   creation date:       05-Oct-1987        last modification:   ##-###-####
   arguments:           s1 , s2 , n .
   description:

        This function copies n characters from s2 into s1 .

---------------------------------------------------------------------------- */
STATIC void scpyf( register uint8 *s1 , register uint8 *s2 , int32 count )
{
#ifdef Unaligned_32bit_access
  register int32  r ;

  if ( (r = count & 3) != 0 ) {
    if ( r & 2 ) {
      register uint16 *s161 = (uint16 *)s1 ;
      register uint16 *s162 = (uint16 *)s2 ;
      *s161 = *s162 ;
      s1 += 2 ; s2 += 2 ;
    }
    if ( r & 1 )
      *s1++ = *s2++ ;
    count -= r ;
  }
  if ( count ) {
    register uint32 *s321 = ( uint32 * )s1 ;
    register uint32 *s322 = ( uint32 * )s2 ;
    count >>= 2 ;
    for ( r = count >> 3 ; r != 0 ; r-- ) {
      PENTIUM_CACHE_LOAD(s321 + 7) ;
      s321[ 0 ] = s322[ 0 ] ;
      s321[ 1 ] = s322[ 1 ] ;
      s321[ 2 ] = s322[ 2 ] ;
      s321[ 3 ] = s322[ 3 ] ;
      s321[ 4 ] = s322[ 4 ] ;
      s321[ 5 ] = s322[ 5 ] ;
      s321[ 6 ] = s322[ 6 ] ;
      s321[ 7 ] = s322[ 7 ] ;
      s321 += 8 ; s322 += 8 ;
    }
    switch ( count & 7 ) {	
    case 7: *s321++ = *s322++ ;
    case 6: *s321++ = *s322++ ;
    case 5: *s321++ = *s322++ ;
    case 4: *s321++ = *s322++ ;
    case 3: *s321++ = *s322++ ;
    case 2: *s321++ = *s322++ ;
    case 1: *s321 = *s322 ;
    }
  }
#else
  register int32 n = ( int32 )((uint32)s1 & 3) ;

  if ( count > 31 && n == ( int32 )((uint32)s2 & 3) ) {
    /* This is a 'big' block and the source and destination */
    /* both have the same byte alignment so align to the next 32 bit */
    /* boundary and then do 32 bit copies */
    register uint32 *s321 , *s322 ;

    switch (n) {
    case 1: *s1++ = *s2++ ;
    case 2: *s1++ = *s2++ ;
    case 3: *s1++ = *s2++ ;
      count -= 4 - n ;
    }

    /* no need to check for count > 0 since count > 31 to start! */
    s321 = ( uint32 * )s1 ;
    s322 = ( uint32 * )s2 ;
    while ( count >= 32 ) {
      s321[0] = s322[0] ;
      s321[1] = s322[1] ;
      s321[2] = s322[2] ;
      s321[3] = s322[3] ;
      s321[4] = s322[4] ;
      s321[5] = s322[5] ;
      s321[6] = s322[6] ;
      s321[7] = s322[7] ;
      s321 += 8 ; s322 += 8 ;
      count -= 32 ;
    }
    while ( count >= 4 ) {
      *s321++ = *s322++ ;
      count -= 4 ;
    }
    s1 = ( uint8 * )s321 ;
    s2 = ( uint8 * )s322 ;
  } else {
    while ( count >= 8 ) {
      s1[0] = s2[0] ;
      s1[1] = s2[1] ;
      s1[2] = s2[2] ;
      s1[3] = s2[3] ;
      s1[4] = s2[4] ;
      s1[5] = s2[5] ;
      s1[6] = s2[6] ;
      s1[7] = s2[7] ;
      s1 += 8 ; s2 += 8 ;
      count -= 8 ;
    }
  }

  HQASSERT(count < 8, "Count too large finishing scpyf\n") ;

  switch( count ) {
  case 7 : *s1++ = *s2++ ;
  case 6 : *s1++ = *s2++ ;
  case 5 : *s1++ = *s2++ ;
  case 4 : *s1++ = *s2++ ;
  case 3 : *s1++ = *s2++ ;
  case 2 : *s1++ = *s2++ ;
  case 1 : *s1 = *s2 ;
  }
#endif
}

STATIC void scpyb( register uint8 *s1 , register uint8 *s2 , int32 count )
{
#ifdef Unaligned_32bit_access
  register int32 r ;

  s1 += count ;
  s2 += count ;
  if ( (r = count & 3) != 0 ) {
    if ( r & 2 ) {
      register uint16 *s161, *s162 ;
      s1 -= 2 ; s2 -= 2 ;
      s161 = (uint16 *)s1 ;
      s162 = (uint16 *)s2 ;
      *s161 = *s162 ;
    }
    if ( r & 1 )
      *--s1 = *--s2 ;
    count -= r ;
  }
  if ( count ) {
    register uint32 *s321 = ( uint32 * )s1 ;
    register uint32 *s322 = ( uint32 * )s2 ;
    count >>= 2 ;
    for ( r = count >> 3 ; r != 0 ; r-- ) {
      s321 -= 8 ; s322 -= 8 ;
      PENTIUM_CACHE_LOAD(s321) ;
      s321[7] = s322[7] ;
      s321[6] = s322[6] ;
      s321[5] = s322[5] ;
      s321[4] = s322[4] ;
      s321[3] = s322[3] ;
      s321[2] = s322[2] ;
      s321[1] = s322[1] ;
      s321[0] = s322[0] ;
    }
    switch( count & 7 ) {
    case 7 : *--s321 = *--s322 ;
    case 6 : *--s321 = *--s322 ;
    case 5 : *--s321 = *--s322 ;
    case 4 : *--s321 = *--s322 ;
    case 3 : *--s321 = *--s322 ;
    case 2 : *--s321 = *--s322 ;
    case 1 : *--s321 = *--s322 ;
    }
  }
#else
  register int32 n ;

  s1 += count ;
  s2 += count ;

  n = ( int32 )((uint32)s1 & 3) ;

  if ( count > 31 && n == ( int32 )((uint32)s2 & 3) ) {
    /* This is a 'big' block and the source and destination */
    /* both have the same byte alignment so align to the next 32 bit */
    /* boundary and then do 32 bit copies */
    register uint32 *s321 , *s322 ;

    switch (n) {
    case 3: *--s1 = *--s2 ;
    case 2: *--s1 = *--s2 ;
    case 1: *--s1 = *--s2 ;
      count -= n ;
    }

    /* no need to check for count > 0 since count > 31 to start! */
    s321 = ( uint32 * )s1 ;
    s322 = ( uint32 * )s2 ;
    while ( count >= 32 ) {
      s321 -= 8 ; s322 -= 8 ;
      s321[7] = s322[7] ;
      s321[6] = s322[6] ;
      s321[5] = s322[5] ;
      s321[4] = s322[4] ;
      s321[3] = s322[3] ;
      s321[2] = s322[2] ;
      s321[1] = s322[1] ;
      s321[0] = s322[0] ;
      count -= 32 ;
    }
    while ( count >= 4 ) {
      *--s321 = *--s322 ;
      count -= 4 ;
    }
    s1 = ( uint8 * )s321 ;
    s2 = ( uint8 * )s322 ;
  } else {
    while ( count >= 8 ) {
      s1 -= 8 ; s2 -= 8 ;
      s1[7] = s2[7] ;
      s1[6] = s2[6] ;
      s1[5] = s2[5] ;
      s1[4] = s2[4] ;
      s1[3] = s2[3] ;
      s1[2] = s2[2] ;
      s1[1] = s2[1] ;
      s1[0] = s2[0] ;
      count -= 8 ;
    }
  }

  HQASSERT(count < 8, "Count too large finishing scpyb\n") ;

  switch( count ) {
  case 7 : *--s1 = *--s2 ;
  case 6 : *--s1 = *--s2 ;
  case 5 : *--s1 = *--s2 ;
  case 4 : *--s1 = *--s2 ;
  case 3 : *--s1 = *--s2 ;
  case 2 : *--s1 = *--s2 ;
  case 1 : *--s1 = *--s2 ;
  }
#endif
}

/* end of hqmemcpy.c */
