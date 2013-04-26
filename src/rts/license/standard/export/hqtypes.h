/*  
$Log: hqtypes.h,v $
Revision 1.20  2002/04/18 15:03:47  jonw
[Bug #25083]
New build regime for profiling: enable assertions and traces only when
ASSERT_BUILD is defined, rather than the old cop-out ! RELEASE_BUILD.

Revision 1.19  2002/03/22  19:25:00  jonw
[Bug #24216]
Couch MININT definition in less obtuse terms (fixes Splint warning).
Shifting a negative number left has undefined results, strictly.

Revision 1.18  2002/01/14  14:11:08  miker
[Bug #24702]
Add C++ variant of NULL define

Revision 1.17  1997/10/14  10:09:03  mikew
[Bug #50043]
Change index from real macros to take integer array size.

Revision 1.16  1997/10/10  13:16:45  mikew
[Bug #50043]
Add macros for indexing arrays from float and double ranges with rounding.

Revision 1.15  1996/05/21  18:33:39  pbarada
[Bug #7644]
Rework CAST_TO_* macros to haved signed/unsigned variants.

Revision 1.14  1994/12/08  20:46:41  dstrauss
[Bug #4569]
Add CAST_TO_... macros.

Revision 1.13  1994/08/03  15:29:58  nickr
correct include types

Revision 1.12  1994/06/19  08:55:59  freeland
-inserting current code, with Log keyword and downcased #includes

 1994-May-16-19:04 andrewi
	[Task number: 3784]
	fix definition of [u]int32 for 16-bit compilers (eg. MSVC), and define
	an expression (for use with HQASSERT) to test that all typedef's are
	correct.
 1994-May-16-14:37 nickr
	[Task number: 3632]
	change definition of MININT to avoid compiler warnings
 1994-Apr-20-18:58 paulb
	[Task number: 3632]
	Fix the definition of MININT
 1993-Apr-29-15:37 paulb
	Change the definition of MININT so that compilers don't give a
	"unary minus applied to unsigned" error
1992-Nov-4-15:48 john = move MININT definition to somewhere more central than
1992-Nov-4-15:48 john + v20:render.c
1992-Nov-4-15:28 john = move MAXINT definition to somewhere more central than
1992-Nov-4-15:28 john + v20:render.c
1992-Sep-10-17:12 richardk = signed is now #defd out by platform.h
1992-Sep-1-15:25 derekk = add HAS_SIGNED if signed type modifier exists
1992-May-1-13:54 paulh = Define NULL, if not already defined
1992-Jan-21-17:29 bear = Make TRUE & FALSE available here so we only include
1992-Jan-21-17:29 bear + swvalues.h, not headers (all the interpreter header
1992-Jan-21-17:29 bear + files) for other components (eg Macintosh gui).
1991-Jun-28-12:59 davide = Created

*/
/* ----------------------------------------------------------------------------
   header file:         value              author:              Andrew Cave
   creation date:       21_Aug-1987        last modification:   ##-###-####
   description:
 
           This header file simply defines the real data type.

---------------------------------------------------------------------------- */

#ifndef HQTYPES_H
#define HQTYPES_H

#include "platform.h"

/*  Detect 16-bit compiler: only used for IBMPC's targetting DOS.
    The macro M_I86 is apparently predefined by most 16-bit DOS compilers. */
#if defined(IBMPC) && defined(M_I86)

typedef	signed	 char 			int8;
typedef	signed	 int			int16;
typedef	signed	 long			int32;

typedef unsigned char			uint8;
typedef unsigned int			uint16;
typedef	unsigned long			uint32;

#else

typedef	signed	 char 			int8;
typedef	signed	 short			int16;
typedef	signed	 int			int32;

typedef unsigned char			uint8;
typedef unsigned short			uint16;
typedef unsigned int			uint32;

#endif


#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

#ifndef NULL
#ifdef __cplusplus
/* Define NULL as 0 for C++ to allow 'SomeType * p = NULL' */
#define NULL (0)
#else
/* Define NULL as (void*)0 for C to limit usage to pointers */
#define NULL ((void*)0)
#endif
#endif

#ifndef MAXINT
#define MAXINT 0x7fffffff
#define MININT 0x80000000
#endif

/*  Define an HQASSERT-able expression to check that the definitions
    in this file are correct.  Can't be done by preprocessor, because
    sizeof() is not necessarily understood by CPP. */
#define HQTYPES_H_CHECK \
	((sizeof(int8)   == 1) && \
	 (sizeof(int16)  == 2) && \
	 (sizeof(int32)  == 4) && \
	 (sizeof(uint8)  == 1) && \
	 (sizeof(uint16) == 2) && \
	 (sizeof(uint32) == 4) && \
	 (MININT+MAXINT == -1) && \
	 (1))   /* end of expression marker */


/* CAST_SIGNED_TO_UINT8, CAST_SIGNED_TO_INT8,
 *   CAST_SIGNED_TO_UINT16, CAST_SIGNED_TO_INT16
 *
 * CAST_UNSIGNED_TO_UINT8, CAST_UNSIGNED_TO_INT8,
 *   CAST_UNSIGNED_TO_UINT16, CAST_UNSIGNED_TO_INT16
 *
 * Macros to stuff a <large> int(or unsigned int) into a smaller one,
 * and complain (assert) if it doesn't fit.
 * The RELEASE_BUILD versions of these macros just do the casts.
 * The primary use of these is to keep compilers from complaining about
 * implied casts in the code, but at the same time to check for
 * range overflows.
 *
 * Example:
 *            extern int32 value;
 *	      extern uint16 value2;
 *            uint8 local;
 *            int8 local2;
 *
 *            local = CAST_SIGNED_TO_UINT8(value);
 *            local2 = CAST_UNSIGNED_TO_INT8(value2);
 */

/* supply simple cover macros for the original macros. As people edit the code,
 * pleas change from the old names (CAST_TO_*) to the new names
 * (CAST_SIGNED_TO_*) */
#define CAST_TO_UINT8(x) CAST_SIGNED_TO_UINT8(x)
#define CAST_TO_INT8(x) CAST_SIGNED_TO_INT8(x)
#define CAST_TO_UINT16(x) CAST_SIGNED_TO_UINT16(x)
#define CAST_TO_INT16(x) CAST_SIGNED_TO_INT16(x)

/*
 * Macros to map a real number in the range [0,1] to an array index in the
 * range [0,r-1] (i.e. an array with r elements). The macros round to the
 * nearest integer.
 */
#define INDEX_FROM_FLOAT(r, x)  ((int32)((float)((r) - 1)*(x) + 0.5f))
#define INDEX_FROM_DOUBLE(r, x) ((int32)((double)((r) - 1)*(x) + 0.5))

#if ! defined( ASSERT_BUILD ) /* { */

#define CAST_SIGNED_TO_UINT8(x)  (uint8) (x)
#define CAST_SIGNED_TO_INT8(x)   (int8)  (x)
#define CAST_SIGNED_TO_UINT16(x) (uint16)(x)
#define CAST_SIGNED_TO_INT16(x)  (int16) (x)
#define CAST_UNSIGNED_TO_UINT8(x)  (uint8) (x)
#define CAST_UNSIGNED_TO_INT8(x)   (int8)  (x)
#define CAST_UNSIGNED_TO_UINT16(x) (uint16)(x)
#define CAST_UNSIGNED_TO_INT16(x)  (int16) (x)


#else /* defined( ASSERT_BUILD ) } { */

#define SMALLEST_UINT8  ((int32) 0 )
#define LARGEST_UINT8   ((int32) 255)
#define SMALLEST_INT8   ((int32) -128)
#define LARGEST_INT8    ((int32) 127)

#define SMALLEST_UINT16 ((int32)  0 )
#define LARGEST_UINT16  ((int32) 65535)
#define SMALLEST_INT16  ((int32) -32768)
#define LARGEST_INT16   ((int32) 32767)

#define CAST_SIGNED_TO_UINT8(x) \
   (uint8)(((int32)(x) < SMALLEST_UINT8 || (int32)(x) > LARGEST_UINT8) ? \
      HQFAIL("Overflow while casting to uint8"), (x) : (x))

#define CAST_SIGNED_TO_INT8(x) \
   (int8)(((int32)(x) < SMALLEST_INT8 || (int32)(x) > LARGEST_INT8) ? \
      HQFAIL("Overflow while casting to int8"), (x) : (x))

#define CAST_SIGNED_TO_UINT16(x) \
   (uint16)(((int32)(x) < SMALLEST_UINT16 || (int32)(x) > LARGEST_UINT16) ? \
      ( HQFAIL("Overflow while casting to uint16")), (x) : (x))

#define CAST_SIGNED_TO_INT16(x) \
   (int16)(((int32)(x) < SMALLEST_INT16 || (int32)(x) > LARGEST_INT16) ? \
      HQFAIL("Overflow while casting to int16"), (x) : (x))

/* Same for unsigned values */
#define CAST_UNSIGNED_TO_UINT8(x) \
   (uint8)(((int32)(x) > LARGEST_UINT8) ? \
      HQFAIL("Overflow while casting to uint8"), (x) : (x))

#define CAST_UNSIGNED_TO_INT8(x) \
   (int8)(((int32)(x) > LARGEST_INT8) ? \
      HQFAIL("Overflow while casting to int8"), (x) : (x))

#define CAST_UNSIGNED_TO_UINT16(x) \
   (uint16)(((int32)(x) > LARGEST_UINT16) ? \
      HQFAIL("Overflow while casting to uint16"), (x) : (x))

#define CAST_UNSIGNED_TO_INT16(x) \
   (int16)(((int32)(x) > LARGEST_INT16) ? \
      HQFAIL("Overflow while casting to int16"), (x) : (x))

#endif /* ! defined( ASSERT_BUILD ) } */

#endif /* HQTYPES_H */
/* end of standard hqtypes.h */


