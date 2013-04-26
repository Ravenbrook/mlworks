/*   $Log: md4.h,v $
 *   Revision 1.3  1994/05/17 21:51:15  freeland
 *   -inserting current code, with Log keyword and downcased #includes
 *
1992-Oct-16-13:23 chrism = adding std types
1992-Oct-7-12:35 chrism = Created

*/


#ifndef _MD4_H_
#define _MD4_H_

#include "std.h"

 /*
 ** ********************************************************************
 ** md4.h -- Header file for implementation of                        **
 ** MD4 Message Digest Algorithm                                      **
 ** Updated: 2/13/90 by Ronald L. Rivest                              **
 ** (C) 1990 RSA Data Security, Inc.                                  **
 ** ********************************************************************
 */

 /* MDstruct is the data structure for a message digest computation.
 */
 typedef struct {
   uint32 	buffer[4]; /* Holds 4-word result of MD computation */
   uint8 	count[8]; /* Number of bits processed so far */
   uint32 	done;      /* Nonzero means MD computation finished */
 } MDstruct, *MDptr;

 /* MDbegin(MD)
 ** Input: MD -- an MDptr
 ** Initialize the MDstruct prepatory to doing a message digest
 ** computation.
 */
 extern void MDbegin();

 /* MDupdate(MD,X,count)
 ** Input: MD -- an MDptr
 **        X -- a pointer to an array of unsigned characters.
 **        count -- the number of bits of X to use (an unsigned int).
 ** Updates MD using the first "count" bits of X.
 ** The array pointed to by X is not modified.
 ** If count is not a multiple of 8, MDupdate uses high bits of
 ** last byte.
 ** This is the basic input routine for a user.
 ** The routine terminates the MD computation when count < 512, so
 ** every MD computation should end with one call to MDupdate with a
 ** count less than 512.  Zero is OK for a count.
 */
 extern void MDupdate();

 /* MDprint(MD)
 ** Input: MD -- an MDptr
 ** Prints message digest buffer MD as 32 hexadecimal digits.
 ** Order is from low-order byte of buffer[0] to high-order byte
 ** of buffer[3].
 ** Each byte is printed with high-order hexadecimal digit first.
 */
 extern void MDprint();

 /*
 ** End of md4.h
 */

#endif
