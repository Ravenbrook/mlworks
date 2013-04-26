/*
 * $HopeName: HQNc-standard!src:hq32x2.c(trunk.6) $
 * FrameWork '64 bit type' Implementation
 *
 * $Log: hq32x2.c,v $
 * Revision 1.7  1999/10/18 11:45:17  luke
 * [Bug #22687]
 * remove warnings
 *
 * Revision 1.6  1997/02/07  11:00:37  nickr
 * [Bug #7883]
 * Remove unused local variable
 *
 * Revision 1.5  1997/02/05  14:44:58  nickr
 * [Bug #7883]
 * Add some missing HqU32x2 operations
 *
 * Revision 1.4  1997/02/03  11:54:26  luke
 * [Bug #20078]
 * correct the macro ONE_SHIFT_LEFT_32
 *
 * Revision 1.3  1997/01/30  17:44:37  luke
 * [Bug #20078]
 * add unsigned 64-bit type
 *
 * Revision 1.2  1997/01/06  18:49:15  luke
 * [Bug #20074]
 * use fabs rather than abs
 *
 * Revision 1.1  1996/12/23  11:17:07  luke
 * new unit
 * [Bug #20078]
 * create
 *
 *
 *
 * --- Former life: HQNgui_core!src/fw32x2.c ---
 * Revision 1.2  1996/09/02  13:36:45  nickr
 * [Bug #7883]
 * add more functions
 *
 * Revision 1.1  1996/08/30  08:47:26  miker
 * new unit
 * [Bug #7883]
 * New unit
 *
 *
 */


/* ----------------------- Includes ---------------------------------------- */

#include "std.h"  /* includes hq32x2.h */


/* ----------------------- Macros ------------------------------------------ */

#define CAN_FIT_IN_INT32(p32x2)  (                       \
 ((p32x2)->high == 0 && (p32x2)->low <= MAXINT) ||       \
 ((p32x2)->high == -1 && (p32x2)->low >= (uint32)MININT) \
)

#define U_CAN_FIT_IN_INT32(pU32x2)  (             \
 (pU32x2)->high == 0 && (pU32x2)->low <= MAXINT   \
)

/* the number 1 << 32 as a double */
#define ONE_SHIFT_LEFT_32  ((double)BIT(31) * 2.0)

/* ----------------------- Functions --------------------------------------- */

/*
 * Conversion to 32 bit value
 */

/* Convert to 32 bit value */
/* Return TRUE <=> value in range */
/* pReturn is unchanged if value is out of range */

int32 Hq32x2ToInt32( Hq32x2 * p32x2, int32 * pReturn )
{
  if (CAN_FIT_IN_INT32(p32x2))
  {
    * pReturn = (int32) p32x2->low;
    return TRUE;
  }

  return FALSE;
}

int32 HqU32x2ToInt32( HqU32x2 * pU32x2, int32 * pReturn )
{
  if ( U_CAN_FIT_IN_INT32( pU32x2 ) )
  {
    *pReturn = (int32) pU32x2->low;
    return TRUE;
  }
  return FALSE;
}


int32 Hq32x2ToUint32( Hq32x2 * p32x2, uint32 * pReturn )
{
  if( p32x2->high == 0 )
  {
    * pReturn = p32x2->low;
    return TRUE;
  }

  return FALSE;
}

int32 HqU32x2ToUint32( HqU32x2 * pU32x2, uint32 * pReturn )
{
  if ( pU32x2->high == 0 )
  {
    *pReturn = pU32x2->low;
    return TRUE;
  }
  return FALSE;
}


/* Force to 32 bit value */
/* Return valid limit if out of range */

int32 Hq32x2BoundToInt32( Hq32x2 * p32x2 )
{
  /* Force to signed 32 bit value */
  if ( CAN_FIT_IN_INT32( p32x2 ) )
   return (int32) p32x2->low;

  return ( p32x2->high >= 0 ) ? MAXINT : MININT;
}

int32 HqU32x2BoundToInt32(HqU32x2 * pU32x2)
{
  if ( U_CAN_FIT_IN_INT32( pU32x2 ) )
    return (int32)pU32x2->low;

  return MAXINT;
}


uint32 Hq32x2BoundToUint32( Hq32x2 * p32x2 )
{
  if ( p32x2->high == 0 ) return p32x2->low;

  /* Force to unsigned 32 bit value */
  return ( p32x2->high > 0 ) ? BITS_ALL : 0;
}

uint32 HqU32x2BoundToUint32( HqU32x2 * pU32x2 )
{
  if ( pU32x2->high == 0 )
   return pU32x2->low;

  return BITS_ALL;
}


int32 Hq32x2AssertToInt32( Hq32x2 * p32x2 )
{
  /* Force to signed 32 bit value */
  if ( CAN_FIT_IN_INT32( p32x2 ) )
    return (int32) p32x2->low;

  HQFAIL( "Hq32x2 out of range for int32" );

  return ( p32x2->high >= 0 ) ?  MAXINT : MININT;
}

int32 HqU32x2AssertToInt32( HqU32x2 * pU32x2 )
{
  if ( U_CAN_FIT_IN_INT32( pU32x2 ) )
    return (int32)pU32x2->low;

  HQFAIL( "HqU32x2 out of range for int32" );

  return MAXINT;
}


uint32 Hq32x2AssertToUint32( Hq32x2 * p32x2 )
{
  if ( p32x2->high == 0 ) return p32x2->low;

  HQFAIL( "Hq32x2 out of range for uint32" );

  /* Force to unsigned 32 bit value */
  return ( p32x2->high > 0 ) ? BITS_ALL : 0;
}

uint32 HqU32x2AssertToUint32( HqU32x2 * pU32x2 )
{
  if ( pU32x2->high == 0 )
   return pU32x2->low;

  HQFAIL( "HqU32x2 out of range for uint32" );

  return BITS_ALL;
}


/*
 * Conversion to and from double values
 */

void Hq32x2FromDouble( Hq32x2 * p32x2, double dbl )
{
  double d = fabs(dbl);

  p32x2->low = (uint32)fmod(d, ONE_SHIFT_LEFT_32);

  d = floor(d / ONE_SHIFT_LEFT_32);
  p32x2->high = (int32)d;

  if (dbl < 0) {
    /* flip the sign of p32x2 */
    p32x2->low = ~p32x2->low;
    p32x2->high = ~p32x2->high;
    p32x2->low++;
    if (p32x2->low == 0)
      p32x2->high++;
  }
}

void HqU32x2FromDouble(HqU32x2 * pU32x2, double dbl)
{
  pU32x2->low = (uint32)fmod(dbl, ONE_SHIFT_LEFT_32);

  dbl = floor(dbl / ONE_SHIFT_LEFT_32);
  pU32x2->high = (uint32)dbl;
}


double Hq32x2ToDouble( Hq32x2 * p32x2 )
{
  int32  sign = 1;
  uint32 low;
  int32  high;

  low = p32x2->low;
  high = p32x2->high;

  if (high < 0) {
    if (high == MININT && low == 0) {
      /* this is a special case - the 64-bit equivalent of MININT. */
      return ldexp(-1.0, 63);
    } else {
      /* flip the number positive first */
      sign = -1;
      low = ~low;
      high = ~high;
      low++;
      if (low == 0)
        high++;
    }
  }
  return ((double)low + ldexp((double)high, 32)) * (double)sign;
}


double HqU32x2ToDouble(HqU32x2 * pU32x2)
{
  return (double)pU32x2->low + ldexp((double)pU32x2->high, 32);
}

/*
 * Unary functions on a 64 bit value
 */

int32 Hq32x2Sign( Hq32x2 * p32x2 )
{
  return ( p32x2->high != 0 )
   ? ( ( p32x2->high > 0 ) ? +1 : -1 )
   : ( ( p32x2->low != 0 ) ? +1 : 0 );
}

uint32 HqU32x2Sign( HqU32x2 * pU32x2 )
{
  return ( pU32x2->low == 0 && pU32x2->high == 0 ) ? 0 : 1;
}


/*
 * Binary functions on two Hq32x2
 */

void Hq32x2Add( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, Hq32x2 * p32x2B )
{
  uint32        low1 = p32x2A->low;
  int32         high1 = p32x2A->high;
  uint32        low2 = p32x2B->low;
  int32         high2 = p32x2B->high;
  uint32        low;
  int32         carry;
  
  low = low1 + low2;
  carry = (low < low1) ? 1 : 0;
  
  p32x2Result->low = low;
  p32x2Result->high = high1 + high2 + carry;
}

void HqU32x2Add(HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, HqU32x2 * pU32x2B )
{
  uint32        low1 = pU32x2A->low;
  uint32        high1 = pU32x2A->high;
  uint32        low2 = pU32x2B->low;
  uint32        high2 = pU32x2B->high;
  uint32        low;
  uint32        carry;
  
  low = low1 + low2;
  carry = (low < low1) ? 1 : 0;
  
  pU32x2Result->low = low;
  pU32x2Result->high = high1 + high2 + carry;
}


void Hq32x2Subtract( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, Hq32x2 * p32x2B )
{
  uint32        low1 = p32x2A->low;
  int32         high1 = p32x2A->high;
  uint32        low2 = p32x2B->low;
  int32         high2 = p32x2B->high;
  uint32        low;
  int32         carry;
  
  low = low1 - low2;
  carry = (low > low1) ? 1 : 0;
  
  p32x2Result->low = low;
  p32x2Result->high = high1 - ( high2 + carry );
}

void HqU32x2Subtract
 ( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, HqU32x2 * pU32x2B )
{
  uint32        low1 = pU32x2A->low;
  uint32        high1 = pU32x2A->high;
  uint32        low2 = pU32x2B->low;
  uint32        high2 = pU32x2B->high;
  uint32        low;
  uint32        carry;
  
  low = low1 - low2;
  carry = (low > low1) ? 1 : 0;
  
  pU32x2Result->low = low;
  pU32x2Result->high = high1 - ( high2 + carry );
}


int32 Hq32x2Compare( Hq32x2 * p32x2A, Hq32x2 * p32x2B )
{
  return ( p32x2A->high != p32x2B->high )
   ? ( ( p32x2A->high > p32x2B->high ) ? +1 : -1 )
   :
   (
     ( p32x2A->low != p32x2B->low )
     ? ( ( p32x2A->low > p32x2B->low ) ? +1 : -1 )
     : 0
   );
}

int32 HqU32x2Compare( HqU32x2 * pU32x2A, HqU32x2 * pU32x2B )
{
  return ( pU32x2A->high != pU32x2B->high )
   ? ( ( pU32x2A->high > pU32x2B->high ) ? +1 : -1 )
   :
   (
     ( pU32x2A->low != pU32x2B->low )
     ? ( ( pU32x2A->low > pU32x2B->low ) ? +1 : -1 )
     : 0
   );
}


/*
 * Binary functions on a 64 bit value and a uint32
 */
void Hq32x2AddUint32( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, uint32 ui32 )
{
  Hq32x2        tmp;

  Hq32x2FromUint32( &tmp, ui32 );
  Hq32x2Add( p32x2Result, p32x2A, &tmp );
}

void HqU32x2AddUint32( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, uint32 ui32 )
{
  HqU32x2       tmp;

  HqU32x2FromUint32( &tmp, ui32 );
  HqU32x2Add( pU32x2Result, pU32x2A, &tmp );
}


void Hq32x2SubtractUint32
 ( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, uint32 ui32 )
{
  Hq32x2        tmp;

  Hq32x2FromUint32( &tmp, ui32 );
  Hq32x2Subtract( p32x2Result, p32x2A, &tmp );
}

void HqU32x2SubtractUint32
 ( HqU32x2 * pU32x2Result, HqU32x2 * pU32x2A, uint32 ui32 )
{
  HqU32x2       tmp;

  HqU32x2FromUint32( &tmp, ui32 );
  HqU32x2Subtract( pU32x2Result, pU32x2A, &tmp );
}


int32 Hq32x2CompareUint32( Hq32x2 * p32x2A, uint32 ui32 )
{
  Hq32x2        tmp;

  Hq32x2FromUint32( &tmp, ui32 );
  return Hq32x2Compare( p32x2A, &tmp );
}

int32 HqU32x2CompareUint32( HqU32x2 * pU32x2A, uint32 ui32 )
{
  HqU32x2        tmp;

  HqU32x2FromUint32( &tmp, ui32 );
  return HqU32x2Compare( pU32x2A, &tmp );
}


/*
 * Binary functions on a 64 bit value and a int32
 */

void Hq32x2AddInt32( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, int32 i32 )
{
  Hq32x2        tmp;

  Hq32x2FromInt32( &tmp, i32 );
  Hq32x2Add( p32x2Result, p32x2A, &tmp );
}


void Hq32x2SubtractInt32( Hq32x2 * p32x2Result, Hq32x2 * p32x2A, int32 i32 )
{
  Hq32x2        tmp;

  Hq32x2FromInt32( &tmp, i32 );
  Hq32x2Subtract( p32x2Result, p32x2A, &tmp );
}


int32 Hq32x2CompareInt32( Hq32x2 * p32x2A, int32 i32 )
{
  Hq32x2        tmp;

  Hq32x2FromInt32( &tmp, i32 );
  return Hq32x2Compare( p32x2A, &tmp );
}



/* eof hq32x2.c */
