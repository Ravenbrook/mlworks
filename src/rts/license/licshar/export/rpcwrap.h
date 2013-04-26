/* $HopeName: $
 *
 * $Log: rpcwrap.h,v $
 * Revision 1.1  1999/01/04 09:45:04  jamesr
 * new unit
 * [Bug #30447]
 * add
 *
 * Revision 1.5  1994/09/08  11:08:09  sarah
 * [Bug #4151]
 * Define _BSD_COMPAT on SGI4K5 - needed to get struct timeval defined
 *
 * Revision 1.4  1994/05/17  21:51:52  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Oct-9-14:57 chrism
        correct comments
    1993-Oct-8-16:31 chrism
   	add PORTMAP for solaris
1992-Nov-17-11:13 chrism = Created

*/

/** protection against multiple inclusion of rpc system stuff ***/

#ifndef __RPC_STUFF_H
#define __RPC_STUFF_H


#ifdef UNIX

#ifdef Solaris
#define PORTMAP
#endif

#ifdef SGI4K5
#define _BSD_COMPAT 1
#endif

/* include standard UNIX rpc stuff */
#include <rpc/rpc.h>

#endif

#ifdef WIN32

#endif

#endif
