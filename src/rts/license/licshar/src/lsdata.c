/* $HopeName: $
 *
 * $Log: lsdata.c,v $
 * Revision 1.7  1999/01/04 09:03:07  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.6  1994/05/17  21:50:39  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
 1993-Feb-4-15:17 chrism
        changing to version 2
1992-Nov-12-12:20 chrism = added more server secrets
1992-Nov-2-14:39 chrism = removed serv_data
1992-Oct-16-13:23 chrism = adding std types
1992-Oct-7-13:36 chrism = Created

*/
/* lsdata.c - data required by server and by createpermit */
#include "std.h"
#include "permit.h"

uint32 server_secrets[ N_SERVER_SECRETS ] = {
  0xef648bb2,
  0x12a4d618,
  0x9f0bc7ef,
  0x8987c403,
  0x21fedcba,
  0xea2e3cca,
  0x33641b92,
  0x6a03e444,
  0x865544e3,
  0x49f92299,
  0xc90ab393,
  0x2f900389,
  0x3222daec,
  0xdcde2fd2,
  0x88837a3f,
  0xfa1d0a32,
  0x1353a7da,
  0xcafd1829,
  0xd9be79ea,
  0xbdf9b928
};
