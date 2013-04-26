/* Copyright (C) 1997 Harlequin Ltd
 *
 * Constants to do with the MLWorks registration mechanism
 *
 * $Log: mlw_mklic.h,v $
 * Revision 1.3  1998/07/17 14:49:06  jkbrook
 * [Bug #30436]
 * Update editions for new scheme
 *
 * Revision 1.2  1998/06/04  16:38:01  jkbrook
 * [Bug #30411]
 * Handle free copies of MLWorks
 *
 * Revision 1.1  1997/08/29  15:12:33  jkbrook
 * new unit
 * Modified from register.h for inclusion in generic SHA compound
 *
 * Revision 1.8  1997/08/05  14:14:57  jkbrook
 * [Bug #30223]
 * Shortening license codes by using base 36 for date elements and
 * reducing CHECK_CHARS from 10 to 8
 *
 * Revision 1.7  1997/08/04  12:25:05  jkbrook
 * [Bug #20072]
 * Adding edition info (e.g., student, personal) to licensing
 *
 * Revision 1.6  1997/08/01  14:10:18  jkbrook
 * [Bug #20073]
 * Added datatype license_check_result for more flexible reporting
 * of license checking/validation results.
 *
 * Revision 1.5  1997/08/01  13:34:46  jkbrook
 * [Bug #30223]
 * Shorten license codes by removing number
 *
 * Revision 1.4  1997/07/24  16:38:14  jkbrook
 * [Bug #20077]
 * Adding an install-by date
 *
 * Revision 1.3  1997/07/22  16:22:46  jkbrook
 * [Bug #20077]
 * License expiry should be to the nearest day
 *
 * Revision 1.2  1996/11/21  16:13:54  jont
 * [Bug #1802]
 * Include ansi.h to get around defective SunOS header files
 *
 * Revision 1.1  1996/11/19  14:04:55  jont
 * new unit
 * Interface between registerer and license code in MLWorks
 *
 *
 */

#ifndef mlw_mklic_h
#define mlw_mklic_h

/* this is used for conversion of edition input for v1.1 and v2.0b0 */

enum old_edition {OLD_BETA, OLD_PERSONAL, OLD_STUDENT};

/* this is used for conversion of edition input in v2.0c0 onwards */

enum edition {ENTERPRISE, PERSONAL, PROFESSIONAL};

/* Users are given their license name and a 15-character check string.  The
 * last 3 characters of this string are the expiry date, in the format 
 * dmy in base 36.
 * The 3 characters before that are the install-by date (also dmy base 36).
 * The 1 character before that encodes the edition.
 * The first 8 characters are the last 8 characters
 * of the result of hashing the name, edition, installation and expiry dates.
 * DATE_CHARS gives the number of characters used for the dates
 * as they appear in the license codes etc., IP_DATE_CHARS
 * gives the number of characters in dates input to mlw_mklic.
 */

/* for v1.1 onwards */
/* in v1.1 onwards DATE_CHARS are input in decimal (ddmmyy) and converted 
   to base 36 
*/

#define CHECK_CHARS 8
#define IP_DATE_CHARS 6
#define DATE_CHARS 3
#define EDITION_CHARS 1

/* for v1.0 */
/* in v1.0 DATE_CHARS are kept in decimal throughout (mmyy) */

#define V1_CHECK_CHARS 10
#define V1_DATE_CHARS 4

#endif
