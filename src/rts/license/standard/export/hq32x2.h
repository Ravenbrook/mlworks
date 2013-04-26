#ifndef __HQ32X2_H__
#define __HQ32X2_H__

/*
 * $HopeName: HQNc-standard!export:hq32x2.h(trunk.5) $
 * FrameWork '64 bit type' Interface
 *
 * $Log: hq32x2.h,v $
 * Revision 1.6  2000/01/07 14:03:00  peter
 * [Bug #22908]
 * Get it right
 *
 * Revision 1.5  2000/01/07  13:56:45  peter
 * [Bug #22908]
 * Supply missing word in Hq32x2FromU32x2.
 *
 * Revision 1.4  1998/08/11  17:00:43  wayneb
 * [Bug #30359]
 * mark with extern C
 *
 * Revision 1.3  1997/02/05  14:44:53  nickr
 * [Bug #7883]
 * Add some missing HqU32x2 operations
 *
 * Revision 1.2  1997/01/30  17:44:30  luke
 * [Bug #20078]
 * add unsigned 64-bit type
 *
 * Revision 1.1  1996/12/23  11:17:07  luke
 * new unit
 * [Bug #20078]
 * create
 *
 *
 *  ------ former life: HQNgui_core!export/fw32x2.h ------
 * Revision 1.2  1996/09/02  13:36:43  nickr
 * [Bug #7883]
 * add more functions
 *
 * Revision 1.1  1996/08/30  08:47:27  miker
 * new unit
 * [Bug #7883]
 * New unit
 *
 *
 */

/*
 * Implements a signed 64 bit type, akin to an int64.
 * and an unsigned 64 bit type, akin to a uint64.
 *
 * Getting a 64 bit integer on all our compiler/platform combinations
 * is extremely difficult, and sometimes it's not supported at all. This
 * implementation allows 64 bit integers to be faked where performance is
 * not critical.
 */

#ifdef __cplusplus
extern "C" {
#endif


/* ----------------------- Macros ------------------------------------------ */

/* Conversion from uint32, int32 */

#define Hq32x2FromInt32( p32x2, i32 ) \
MACRO_START \
  ( p32x2 )->high = (( i32 ) < 0) ? -1 : 0; \
  ( p32x2 )->low = (uint32)( i32 ); \
MACRO_END

#define HqU32x2FromInt32( pU32x2, i32 ) \
MACRO_START \
  HQASSERT((i32) >= 0, "HqU32x2FromInt32 out of range"); \
  ( pU32x2 )->high = 0; \
  ( pU32x2 )->low = (int32)( i32 ); \
MACRO_END


#define Hq32x2FromUint32( p32x2, ui32 ) \
MACRO_START \
  ( p32x2 )->high = 0; \
  ( p32x2 )->low = ( ui32 ); \
MACRO_END

#define HqU32x2FromUint32( pU32x2, ui32 ) \
MACRO_START \
  ( pU32x2 )->high = 0; \
  ( pU32x2 )->low = ( ui32 ); \
MACRO_END


#define Hq32x2Max( p32x2 ) \
MACRO_START \
  ( p32x2 )->high = MAXINT; \
  ( p32x2 )->low = BITS_ALL; \
MACRO_END

#define HqU32x2Max( p32x2 ) \
MACRO_START \
  ( p32x2 )->high = BITS_ALL; \
  ( p32x2 )->low = BITS_ALL; \
MACRO_END


#define Hq32x2IsZero( p32x2 ) ((p32x2)->high == 0 && (p32x2)->low == 0)

#define HqU32x2IsZero( pU32x2 ) Hq32x2IsZero( pU32x2 )


#define HqU32x2From32x2(pU32x2, p32x2) \
MACRO_START \
  HQASSERT(Hq32x2Sign(p32x2) >= 0, "HqU32x2From32x2 out of range"); \
  (pU32x2)->low = (p32x2)->low; \
  (pU32x2)->high = (uint32)(p32x2)->high; \
MACRO_END

#define Hq32x2FromU32x2( p32x2, pU32x2) \
MACRO_START \
  HQASSERT( pU32x2->high <= MAXINT, "Hq32x2FromU32x2 out of range"); \
  (p32x2)->low = (pU32x2)->low; \
  (p32x2)->high = (int32)(pU32x2)->high; \
MACRO_END


/* ----------------------- Types ------------------------------------------- */

/* Signed 64 bit integer */
typedef struct Hq32x2
{
  uint32 low;
  int32  high;
} Hq32x2;

/* Unsigned 64 bit integer */
typedef struct HqU32x2
{
  uint32 low;
  uint32 high;
} HqU32x2;


/* ----------------------- Functions --------------------------------------- */

/*
 * conversion to 32 bit value
 */

/* Return TRUE <=> value in range */
/* pReturn is unchanged if value is out of range */
extern int32 Hq32x2ToInt32( Hq32x2 * p32x2, int32 * pReturn );
extern int32 HqU32x2ToInt32( HqU32x2 * pU32x2, int32 * pReturn );

extern int32 Hq32x2ToUint32( Hq32x2 * p32x2, uint32 * pReturn );
extern int32 HqU32x2ToUint32( HqU32x2 * pU32x2, uint32 * pReturn );


/* Force into to 32 bit value range */
/* Return appropriate limit if out of range */
extern int32 Hq32x2BoundToInt32( Hq32x2 * p32x2 );
extern int32 HqU32x2BoundToInt32( HqU32x2 * pU32x2 );

extern uint32 Hq32x2BoundToUint32( Hq32x2 * p32x2 );
extern uint32 HqU32x2BoundToUint32( HqU32x2 * pU32x2 );


/* As Hq32x2BoundTo... but also asserts if bounding done */
extern int32 Hq32x2AssertToInt32( Hq32x2 * p32x2 );
extern int32 HqU32x2AssertToInt32( HqU32x2 * pU32x2 );

extern uint32 Hq32x2AssertToUint32( Hq32x2 * p32x2 );
extern uint32 HqU32x2AssertToUint32( HqU32x2 * pU32x2 );

/*
 * Conversion to and from double values
 */

extern void Hq32x2FromDouble( Hq32x2 * p32x2, double dbl );
extern void HqU32x2FromDouble(HqU32x2 * pU32x2, double dbl);

extern double Hq32x2ToDouble( Hq32x2 * p32x2 );
extern double HqU32x2ToDouble( HqU32x2 * pU32x2 );

/*
 * Unary functions on a 64 bit value
 */

/* -1 <=> *p32x2 < 0, 
 *  0 <=> *p[U]32x2 == 0
 * +1 <=> *p[U]32x2 > 0
 */
extern int32 Hq32x2Sign( Hq32x2 * p32x2 );
extern uint32 HqU32x2Sign( HqU32x2 * pU32x2 );


/*
 * Binary functions on two matching 64 bit values
 * Any of p[U]32x2Result, p[U]32x2A, p[U]32x2B may be the same
 */

/* Result = A + B */
extern void Hq32x2Add
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, Hq32x2 * p32x2B );
extern void HqU32x2Add
 ( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, HqU32x2 * pU32x2B );

/* Result = A - B */
extern void Hq32x2Subtract
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, Hq32x2 * p32x2B );
extern void HqU32x2Subtract
 ( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, HqU32x2 * pU32x2B );

/* -1 <=> A < B, 
 *  0 <=> A == B
 * +1 <=> A > B
 */
extern int32 Hq32x2Compare( Hq32x2 * p32x2A, Hq32x2 * p32x2B );
extern int32 HqU32x2Compare( HqU32x2 * pU32x2A, HqU32x2 * pU32x2B );


/*
 * Binary functions on a 64 bit value and a uint32
 */
extern void Hq32x2AddUint32
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, uint32 ui32 );
extern void HqU32x2AddUint32
 ( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, uint32 ui32 );

extern void Hq32x2SubtractUint32
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, uint32 ui32 );
extern void HqU32x2SubtractUint32
 ( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, uint32 ui32 );

extern int32 Hq32x2CompareUint32( Hq32x2 * p32x2A, uint32 ui32 );
extern int32 HqU32x2CompareUint32( HqU32x2 * pU32x2A, uint32 ui32 );


/*
 * Binary functions on a 64 bit value and a int32
 * The combination of HqU32 and int32 is not implemented yet
 */
extern void Hq32x2AddInt32
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, int32 i32 );

extern void Hq32x2SubtractInt32
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, int32 i32 );

extern int32 Hq32x2CompareInt32( Hq32x2 * p32x2A, int32 i32 );


#ifdef __cplusplus
}
#endif

#endif /* ! __HQ32X2_H__ */

/* eof hq32x2.h */
