/* $HopeName$
 * $Id: hqmemcmp.c,v 1.12 2001/03/03 06:01:25 angus Exp $
 *
 * String utility functions. Currently only string comparison.
 */

#include "std.h"
#include "hqmemcmp.h"

/* ----------------------------------------------------------------------------
   function:            HqMemCmp(..)       author:              Andrew Cave
   creation date:       05-Oct-1987        last modification:   ##-###-####
   arguments:           s1 , ln1 , s2 , ln2 .
   description:

     This function lexically compares two strings of the given lengths, and
     returns :
       -ve    if s1 < s2       0    if s1 == s2       +ve    if s1 > s2 .

---------------------------------------------------------------------------- */
int32 HqMemCmp(register uint8 *s1, int32 ln1, register uint8 *s2, int32 ln2)
{
  register uint8 *limit ;

  if ( ln1 < ln2 )
    limit = s1 + ln1 ;
  else
    limit = s1 + ln2 ;

  while  ( s1 < limit && *s1 == *s2 ) {
    ++s1 ; ++s2 ;
  }

  if ( s1 < limit )
    return ( *s1 - *s2 ) ;
  else
    return ( ln1 - ln2 ) ;
}

/*  
$Log: hqmemcmp.c,v $
Revision 1.12  2001/03/03 06:01:25  angus
[Bug #11565]
Change scmp to HqMemCmp, and move function into HQNc-standard. Remove unused
headers, and change used ones to hqmemcmp.h

Revision 1.11  2001/02/11  07:10:05  angus
[Bug #11531]
Adjust headers and formatting

Revision 1.10  1998/01/08  17:40:32  jonw
[Bug #20913]
Moving calls to scpy, scpyf and scpyb over to the new HqMemCpy or HqMemMove.

Revision 1.9  1997/10/10  10:19:31  jonw
[Bug #20913]
Add some traces (off by default) to detect when scpyb or scpyf
is being called with non-overlapping blocks, in which case they
may be less than optimal. We might do something about this later.

Revision 1.8  1996/02/29  10:25:38  angus
[Bug #7596]
Performance improvements; replace unrolled loop postincrements with constant
offset addressing.

Revision 1.7  1995/10/13  19:05:58  angus
[Bug #6584]
Change scpy to scpyf for guaranteed order copying, and call out to skin for
optimised bcopy instead of using (possibly sub-optimal) scpy.

Revision 1.6  1994/06/19  11:02:45  freeland
-inserting current code, with Log keyword and downcased #includes

 1993-Dec-14-10:37 angus
	[Bug number: 3208] Fixing overlapping copy in scpy
 1993-May-25-11:16 paulb
	Merge in change to scpy made at Seybold
 1993-Apr-27-12:57 gary
	spring clean
 1993-Apr-21-15:00 davide
	spring clean - rename include of strings.h
 1993-Apr-21-13:04 derekk
	General code tidy up. Add functio prototypes et cetera
 1993-Apr-1-19:04 andy
	change optimisation so it is faster for 486 & no slower on
	other platforms
1992-Sep-7-06:07 davidg = optimise scpy() for large blocks - 25% faster on
1992-Sep-7-06:07 davidg + sparc
1992-Apr-24-19:36 davidg = Optimise scpyb() to be as fast as scpy()
1992-Mar-7-14:59 andy = proper defines for Macintosh
1990-Feb-14-15:30 jcgs: fixing comments

*/
