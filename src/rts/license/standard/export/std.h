#ifndef STD_H
#define STD_H

/*
$HopeName: HQNc-standard!export:std.h(trunk.27) $

$Log: std.h,v $
Revision 1.28  1998/06/22 14:00:58  andy
[Bug #21616]
Remove obsolete defines of PS3 COLOR & PS3 RENDER.

Revision 1.27  1998/03/31  14:39:40  davide
[Bug #21298]
switch to PS3_COLOR builds

Revision 1.26  1997/02/05  14:45:05  nickr
[Bug #7883]
Make ANSI BITS_ALL long

Revision 1.25  1997/01/22  10:13:04  nickr
[Bug #7883]
BIT constants should be unsigned

Revision 1.24  1996/12/23  11:12:45  luke
[Bug #20078]
file position and extents require 64 bits

Revision 1.23  1996/08/23  12:15:20  nickr
[Bug #7883]
add BIT macros

Revision 1.22  1996/07/03  10:29:03  steveb
[Bug #7872]
Define min and max in here.

Revision 1.21  1995/07/24  10:26:47  nickr
[Bug #6209]
add NUM_ARRAY_ITEMS

Revision 1.20  1995/06/19  11:05:11  paulb
[Bug #5811]
Remove VOLATILE - the changes for bug 5621 make it unnecessary

Revision 1.19  1994/12/08  20:41:30  dstrauss
[Bug #4569]
Warnings reduction: add include of warnings.h
Also, put #endif for _STD_H_ at the end of the file where it
belongs.

Revision 1.18  1994/09/07  15:20:42  paulb
[Bug #4161]
Add VOLATILE definition

Revision 1.17  1994/07/25  14:39:56  steveb
[Bug 3929] Get rid of STRUCT_ASSIGN.

Revision 1.16  1994/06/19  08:55:56  freeland
-inserting current code, with Log keyword and downcased #includes

 1994-May-17-13:31 andrewi
	[Task number: 3784]
	define ASSERTable expression to check assumptions such as
	sizeof(int32) and other typedefs
 1994-Apr-14-16:22 paulb
	[Task number: 3585]
	Add hqassert.h, and EMPTY_STATEMENT
 1993-Apr-23-10:05 derekk
	Only define STATIC if it isn't already defined
 1993-Apr-20-19:12 cindy
	sort out change history stuff (again)
      1993-Apr-20-19:11 cindy
   	sort out change history stuff
      1993-Apr-19-16:47 luke
     	put define for STATIC in here
1992-Jun-19-14:19 daniel = get STRUCT_ASSIGN right
1992-Jun-19-14:00 daniel = NO_STRUCT_ASSIGN #define
1992-May-18-14:21 davidg = re-order headers to prevent re-definition of NULL
1992-May-18-14:21 davidg + on MACINTOSH
1992-May-6-13:09 luke = NULL casts
1992-Apr-30-13:56 paulh = Ad MACRO_START, MACRO_END definitions
1992-Apr-28-21:44 paulh = Arrange for prototypes of the "standard" functions
1992-Apr-28-21:44 paulh + to be defined.
1992-Feb-25-17:41 paulh = Protect against multiple inclusion

*/
/*
 *	Standard header file to be included by all products
 */

/* ----------------------- Includes ---------------------------------------- */

#include "platform.h" 
#include "proto.h"
#include "osprotos.h"   /* This must be before hqtypes.h */
#include "hqtypes.h"    /* platform.h must be inluded before this file */
#include "hq32x2.h"
#include "hqassert.h"
#include "warnings.h"


/* ----------------------- Macros ------------------------------------------ */

#ifndef MACRO_START
#define MACRO_START do {
#ifndef lint
#define MACRO_END } while(0)
#else
extern int lint_flag;
#define MACRO_END } while (lint_flag)
#endif
#endif

#ifndef EMPTY_STATEMENT
#define EMPTY_STATEMENT() MACRO_START MACRO_END
#endif

/*
 * Some debuggers ignore static variables/functions - to get a debugable
 * version of a particluar file, declare STATIC to be nothing at the top of it.
 */
#ifndef	STATIC
#define STATIC static

/*  Define an expression that can be used with HQASSERT to check that
    all assumptions/preconditions are satisfied on any given target
    platform.  Since some conditions can't be tested at preprocessor
    time (most notably sizeof(..) values), the expression must be
    used in a runtime expression like HQASSERT. */
#define STD_H_CHECK \
	(HQTYPES_H_CHECK)  /* && with any others as necessary */

#endif	/* !STATIC */

/*
 * Definitions of min, max.
 */
#ifdef MIN
#undef MIN
#endif

#ifdef MAX
#undef MAX
#endif

#ifdef min
#undef min
#endif

#ifdef max
#undef max
#endif

#define min(a,b) ( ((a) < (b)) ? (a) : (b) )
#define max(a,b) ( ((a) > (b)) ? (a) : (b) )


#define NUM_ARRAY_ITEMS( _array_ ) \
 ( sizeof( _array_ ) / sizeof( (_array_)[ 0 ] ) )


/* Bitwise operations, assuming 2s complement, preferably unsigned
 * bits are numbered from 0, from the least significant bit.
 */

/* The number of bits in a byte */
#define BITS_BYTE 8

/* The number of bits in an integer type */
#define BITS( _type_ ) ( sizeof( _type_ ) * BITS_BYTE )

/* _i_th bit, k&r version cannot be evaluated by preprocessor eg #if */
#ifdef USE_TRADITIONAL
#define BIT( _i_ ) ( ( (uint32) 0x1 ) << (_i_) )
#else
#define BIT( _i_ ) ( ( 0x1u ) << (_i_) )
#endif

/* all bits set, k&r version cannot be evaluated by preprocessor eg #if */
#ifdef USE_TRADITIONAL
#define BITS_ALL ( ~ (uint32) 0x0 )
#else
#define BITS_ALL ( ~ 0x0ul )
#endif

/* bits from _i_ onwards inclusively, ie half open interval ( _i_,  ] */
#define BITS_STARTING_AT( _i_ ) ( BITS_ALL << ( _i_ ) )

/* bits below i exclusively, ie half open interval [ 0, _i_ ) */
#define BITS_BELOW( _i_ ) ( ~ BITS_STARTING_AT( _i_ ) )

/* bits in half open interval [ _i_, _j_ ) */
#define BITS_FROM_TO_BEFORE( _i_, _j_ ) \
 ( BITS_STARTING_AT( _i_ ) & BITS_BELOW( _j_ ) )


/* Masks to the least significant bit set */
#define BIT_FIRST_SET(_n_) ( ((uint32) (_n_)) & ~( ((uint32) (_n_)) - 1 ) )

#define BIT_FIRST_CLEAR(_n_) ( BIT_FIRST_SET( ~(_n_) ) )

#define BIT_AT_MOST_ONE_SET(_n_) ( (_n_) == BIT_FIRST_SET(_n_) )

#define BIT_EXACTLY_ONE_SET(_n_) ( (_n_) != 0 && BIT_AT_MOST_ONE_SET(_n_) )

#endif  /* _STD_H_ */

/* eof std.h */
