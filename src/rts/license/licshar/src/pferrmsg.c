/* $HopeName: $
 *
 * $Log: pferrmsg.c,v $
 * Revision 1.3  1999/01/04 09:03:10  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.2  1994/05/17  21:50:50  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Sep-10-14:45 chrism
        Created in licshar

*/

#include "lserver.h"
#include "fwstring.h"

/* Error messages on reading permit files - shared between
 * hqn_lsd and hqn_lsa
 */

/*const FwTextString SeeSupplier = FWSTR_TEXTSTRING("Please contact your permit supplier");*/

#define SeeSupplier FWSTR_TEXTSTRING("Please contact your permit supplier")

char *Pferrormsg[ PER_MAX - PER_START + 1] = {
  FWSTR_TEXTSTRING("Bad server data before line"),      /* 100 */
  FWSTR_TEXTSTRING("No host with Internet address on line"),    /* 101 */
  SeeSupplier,                                          /* 102 */
  FWSTR_TEXTSTRING("Bad permit data before line"),      /* 103 */
  SeeSupplier,                                          /* 104 */
  FWSTR_TEXTSTRING("Missing or bad input at line"),     /* 105 */
  FWSTR_TEXTSTRING("Bad server Internet address line"), /* 106 */
  SeeSupplier,                                          /* 107 */
  FWSTR_TEXTSTRING("Bad date format in line"),          /* 108 */
  SeeSupplier,                                          /* 109 */
  FWSTR_TEXTSTRING("Server checksum error in line"),    /* 110 */
  FWSTR_TEXTSTRING("Permit checksum error in line"),    /* 111 */
  SeeSupplier,                                          /* 112 */
  FWSTR_TEXTSTRING("Bad number format in line"),        /* 113 */
  FWSTR_TEXTSTRING("Invalid version in line"),          /* 114 */
  FWSTR_TEXTSTRING("Too many servers in domain:"),      /* 115 */
  FWSTR_TEXTSTRING("Server has no hqnserver alias on line"),    /* 116 */
  FWSTR_TEXTSTRING("Bad unique ID in permit. Should be:"),      /* 117 */
  FWSTR_TEXTSTRING("Bad locked node Internet address line"),    /* 118 */
};
