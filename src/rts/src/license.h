/*  === LICENSING ===
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  The license function is a black box which takes care of licensing.
 *
 *  Revision Log
 *  ------------
 *  $Log: license.h,v $
 *  Revision 1.14  1998/08/17 13:32:55  jkbrook
 *  [Bug #50100]
 *  Export license_edition
 *
 * Revision 1.13  1998/07/10  14:19:05  jkbrook
 * [Bug #40435]
 * Add new responses to license errors
 *
 * Revision 1.12  1998/06/11  14:15:22  jkbrook
 * [Bug #30411]
 * Handle free copies of MLWorks
 *
 * Revision 1.11  1998/03/12  14:44:16  jkbrook
 * [Bug #30368]
 * Update version info for 2.0b0
 *
 * Revision 1.10  1998/03/12  14:03:07  jkbrook
 * [Bug #50044]
 * Licence codes should not contain 0 or 1
 * or lower-case letters on input
 *
 * Revision 1.9  1997/09/01  11:23:36  jkbrook
 * [Bug #30227]
 * Moving license_check_result type and specific edition info
 * from register.h since they are not used by mklic
 *
 * Revision 1.8  1997/08/01  15:43:34  jkbrook
 * [Bug #20072]
 * Adding edition info (e.g., student, personal) to licensing
 *
 * Revision 1.7  1997/07/24  16:52:08  jkbrook
 * [Bug #20077]
 * Adding an install-by date
 *
 * Revision 1.6  1997/01/07  13:19:34  jont
 * [Bug #1884]
 * Add a license expired error message
 *
 * Revision 1.5  1996/12/19  12:07:32  jont
 * Add definition of license error string for common use
 *
 * Revision 1.4  1996/10/23  11:18:41  jont
 * Add flag to indicate how to process license failure
 *
 * Revision 1.3  1996/10/17  14:04:45  jont
 * Merging in license server stuff
 *
 * Revision 1.2.3.4  1996/10/15  14:46:01  jont
 * Make license_release extern
 *
 * Revision 1.2.3.3  1996/10/09  12:05:36  nickb
 * interval is no longer extern.
 *
 * Revision 1.2.3.2  1996/10/08  16:13:38  jont
 * Add interface for use by signal handler
 *
 * Revision 1.2.3.1  1996/10/07  16:15:19  hope
 * branched from 1.2
 *
 * Revision 1.2  1994/06/09  14:40:58  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:08:43  nickh
 * new file
 *
 *  Revision 1.1  1992/12/17  17:26:28  richard
 *  Initial revision
 *
 */

#ifndef license_h
#define license_h

#include "hqn_ls.h"
#include "mlw_mklic.h"

/* license_init prepares things for licensing to run. Licensing is
   actually started by a call from ML (so the runtime on its own is
   not licensed. */

extern void license_init(void);

/* refresh_license is called by the timer set up by
 * signal_license_timer (see signals.h). */

extern void refresh_license(void);

/* The license should be released by main when it exits
 * This gets around systems which only allow one atexit function
 */

extern void license_release(void);

/* this type must correspond to that in main/_license.sml */
/* alphabetical order of identifiers must be preserved when
adding new values */

enum license_check_result {EXPIRED,
                           ILLEGAL_CHARS,
                           INSTALLDATE,
                           INTERNAL_ERROR,
                           INVALID,
                           NOT_FOUND,
                           OK,
                           WRONG_EDITION};

extern int license_failure_hang;

extern int act_as_free;

extern enum edition license_edition;

#define LICENSE_ERROR_CONTACT \
  "Contact MLWorks customer license support:\n"\
  "   North and South America, Japan:\n"\
  "     mail mlworks-keys@harlequin.com\n"\
  "   UK, Europe, Australasia, Africa, Asia:\n"\
  "     mail mlworks-keys@harlequin.co.uk"

/* We need two versions of each error message, one for the initial
   license-code entry and validation stage (*REG) and the other for
   the initial check within MLWorks which offers a Personal session
   in the case in which license info has become corrupt but no longer 
   prompts for new info.
*/

#define LICENSE_ERROR_INVALID \
  "Your license is invalid.\n" 

#define LICENSE_ERROR_EXPIRED \
  "Your license has expired.\n" 

#define LICENSE_ERROR_INSTALL \
  "Your license installation date has passed.\n" 

#define LICENSE_ERROR_VERSION \
  "Your license is for a different edition of MLWorks.\n" 

#define LICENSE_ERROR_CHARS \
   "The license code input contains illegal characters\n0 (zero) or 1 (one) or lower-case letters. \nPlease retry.\n" 


#define LICENSE_ERROR_INVALID_REG \
  LICENSE_ERROR_INVALID LICENSE_ERROR_CONTACT

#define LICENSE_ERROR_EXPIRED_REG \
  LICENSE_ERROR_EXPIRED LICENSE_ERROR_CONTACT

#define LICENSE_ERROR_INSTALL_REG \
  LICENSE_ERROR_INSTALL LICENSE_ERROR_CONTACT

#define LICENSE_ERROR_VERSION_REG \
  LICENSE_ERROR_VERSION LICENSE_ERROR_CONTACT

#define LICENSE_ERROR_CHARS_REG \
  LICENSE_ERROR_CHARS LICENSE_ERROR_CONTACT

#endif
