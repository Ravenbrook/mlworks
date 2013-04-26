#ifndef __HQMEMCMP_H__
#define __HQMEMCMP_H__
/* $HopeName$
 * $Id: hqmemcmp.h,v 1.7 2001/03/03 06:01:23 angus Exp $
 *
 * Interface to scmp string utility
 */

int32 HqMemCmp(register uint8 *s1, int32 ln1,
               register uint8 *s2, int32 ln2) ;

/*
$Log: hqmemcmp.h,v $
Revision 1.7  2001/03/03 06:01:23  angus
[Bug #11565]
Change scmp to HqMemCmp, and move function into HQNc-standard. Remove unused
headers, and change used ones to hqmemcmp.h

Revision 1.6  2001/02/11  07:09:50  angus
[Bug #11531]
Adjust headers, formatting

Revision 1.5  1998/01/08  17:30:39  jonw
[Bug #20913]
Moving calls to scpy, scpyf and scpyb over to the new HqMemCpy or HqMemMove.

Revision 1.4  1995/10/13  19:05:48  angus
[Bug #6584]
Change scpy to scpyf for guaranteed order copying, and call out to skin for
optimised bcopy instead of using (possibly sub-optimal) scpy.

Revision 1.3  1994/11/30  19:50:11  sarah
[Bug #4569]
Protect against multiple inclusions.

Revision 1.2  1994/06/19  11:05:23  freeland
-inserting current code, with Log keyword and downcased #includes

 1993-Apr-21-13:03 derekk
	Created in v20
*/

#endif /* protection for multiple inclusion */
