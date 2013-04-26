/*
 $Log: uniqueid.c,v $
 Revision 1.7  1999/01/04 09:03:11  jamesr
 [Bug #30447]
 modifications for NT

 * Revision 1.6  1995/03/22  13:40:11  nick
 * [Bug #9999]
 * close sockets which dec/alpha open in etherid()
 *
 * Revision 1.5  1994/05/17  21:50:52  freeland
 * -inserting current code, with Log keyword and downcased #includes
 * 
  1993-Dec-9-13:43 chrism
        [Bug number: 1919] add unique id for rs6000
  1993-Oct-18-14:51 chrism
        correct error conditions for both server and client library
  1993-Oct-15-17:28 chrism
        move unique id calls to here
  1993-Oct-15-17:12 chrism
        Created in licshar


*/

/* uniquid.c - routines for obtaining unique id numbers on various platforms */

#include <stdio.h>

#ifdef UNIX
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include "rpc.h"
#include <string.h>
#include <errno.h>
#if defined( alpha ) || defined( dec )
#include <sys/ioctl.h>
#include <net/if.h>
#endif
#endif

#include "ls.h"
#include "lserver.h"
#include "lshared.h"

uint32 getdongleid()
{
#ifdef WIN32
  /* TODO - get unique ID from dongle */
  return 42;
  /* return 0x5586086e; */
#endif
#ifdef UNIX
  HQFAIL_AT_COMPILE_TIME();
#endif
#ifdef MAC
  HQFAIL_AT_COMPILE_TIME();
#endif
}

#ifdef UNIX

#ifdef snake
uint32
getunameid()
{
  struct utsname info;
  uint32         id;

  if( uname( &info ) < 0){
    debug1("uname failed");
    return 0;
  }
  if( sscanf( info.idnumber, "%u", &id) != 1){
    debug1("unable to get uname id" );
    return 0;
  }
  return id;
}
#endif

#ifdef rs6000
uint32 getunameid()
{
  struct xutsname info;

  if( unamex( &info ) < 0){
    debug1("unamex failed");
    return 0;
  }
  return (uint32) info.nid;
}       

#endif

#if defined( alpha ) || defined( dec )

/* get the hardware ethernet address. NB address is 6 bytes but we use
 * only least signif 4 bytes. Assume this is nework order for alpha?
 * The default device should be ln0?
 */

uint32 get_etheraddr();

uint32 etherid()
{
  int    nisocket ;
  struct ifconf  ifc;
  char   buf[ 1000 ];  /* arbitrary sized buffer ??? */
  int    len;
  uint32 id ;
    
  /* create socket */
  if( (nisocket = socket (AF_INET, SOCK_DGRAM, 0 )) >= 0 ){
    /* setup buffer for config info */
    ifc.ifc_len = sizeof( buf );
    ifc.ifc_buf = buf;
        
    if( ioctl( nisocket, SIOCGIFCONF, &ifc ) >= 0  ){
      /* now have list of devices - we want ln0 by preference? */
            
      for( len = 0; len <  ifc.ifc_len/sizeof( struct ifreq ); ++len ){
        if( ! strcmp( "ln0", (ifc.ifc_req[len]).ifr_name )){
          /* we have an ln0 in the list */
          if( id = get_etheraddr( nisocket, (ifc.ifc_req[len]).ifr_name )) {
            close (nisocket) ;    /* nick 22Mar95 */
            return id;
          }
        }
      }
      /* Couldn't get ln0 address therefore get first that works */
      for( len = 0; len <  ifc.ifc_len/sizeof( struct ifreq ); ++len ){
        if( id = get_etheraddr( nisocket, (ifc.ifc_req[len]).ifr_name )){
          debug1( "etherid found none-ln0 address"); 
          close (nisocket) ;      /* nick 22Mar95 */
          return id;
        }
      }
    }
  }
       
  /* nothing worked */
  debug1( "etherid failed to get a unique id" );
  if (nisocket >= 0 ){                    /* nick 22Mar95 */
    close (nisocket) ; 
  }
  return 0;
}

uint32 get_etheraddr( int soc, char *name)
{
  struct ifdevea ni_addr ;
  uint32 id = 0;
  
  strcpy( ni_addr.ifr_name, name );
  if( ioctl( soc, SIOCRPHYSADDR, &ni_addr) >= 0 ) {
    /* assume address is in network order - get low 4 bytes and return in host byte order */
    bcopy( (char*) &ni_addr.default_pa[2], (char*) &id, 4 );
  }
  return (ntohl(id));
}

#endif

#if 0
/* solaris is using gethostid at the moment - should be ok */

#ifdef Solaris
uint32 getunameid()
{
  char info[SYSINFO_BUF_SIZE];
  uint32         id;

  if( sysinfo(SI_HW_SERIAL, info, SYSINFO_BUF_SIZE) < 0){
    debug1("sysinfo failed");
    return 0;

  }

  /* Actually, the "serial number" passed back is not guaranteed to
     be all numeric, according to the manual on Solaris.
     */

  if( sscanf( info, "%u", &id) != 1){
    debug1("getunameid failed to get a unique id" );
    id = 0;
  }
    
  return id;
}
#endif
#endif
#endif
