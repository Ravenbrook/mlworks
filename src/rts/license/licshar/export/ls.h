/* $HopeName: $
 *
 * $Log: ls.h,v $
 * Revision 1.8  1999/01/04 09:02:56  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.7  1997/11/14  17:01:43  daveb
 * [Bug #30314]
 * Linux is little-endian too.
 *
 * Revision 1.6  1994/05/17  21:51:33  freeland
 * -inserting current code, with Log keyword and downcased #includes
 * 
   1994-May-9-15:48 chrism
  	port to dec mips
   1993-Oct-8-16:04 chrism
  	add LOWBYTEFIRST for alpha, change longs to int32s
 1993-Feb-4-15:15 chrism
	changing to version 2
1992-Oct-16-13:22 chrism = add std types
1992-Oct-14-17:08 chrism = add comments
1992-Oct-8-16:52 chrism = Created

*/

/* ls.h - definitions required by server and client routines */

#ifndef _LS_H_
#define _LS_H_

#define LS_SERVER_LEN 64
#define LS_PUBLISHER_LEN 64
#define LS_PRODUCT_LEN 64
#define LS_VERSION_LEN 32
#define LS_MAX_CHAL_DATA 16   /* NB Must be less than MAX_CHUNK */
#define LS_MAX_SECRETS 4
#define LS_SIG_LEN 16

/* define these rather than typedef to simplify xdr routines */

#define LS_STATUS_CODE uint32  /* result of LSAPI function call */
#define LS_HANDLE uint32       /* identifies a "license context" */

#endif















