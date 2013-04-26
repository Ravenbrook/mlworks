/*
 $Log: lsapi.c,v $
 Revision 1.36  1998/09/05 12:51:42  yeh
 [Bug #5354]
 destroy the AUTH structure which is made by authunix_create_default

 * Revision 1.35  1997/12/17  19:15:33  martin
 * [Bug #1]
 * Excessive use of int8 pointers means we need excessive casting for strings alas.
 *
 * Revision 1.34  1996/09/10  16:57:21  martin
 * [Bug #0]
 * Fixed get_clnt_handle to call clnt_destroy if we fail to get the port.
 *
 * Revision 1.33  1994/07/05  11:05:23  chrism
 * ls_initialise should completely set the initial state for LW.
 * All globals set to initial values.
 *
 * Revision 1.32  1994/05/27  10:56:46  chrism
 * add definitions for symbol obfuscation
 *
 * Revision 1.31  1994/05/23  13:36:15  chrism
 * tidy up rpc memory leaks
 *
 * Revision 1.30  1994/05/17  21:52:21  freeland
 * -inserting current code, with Log keyword and downcased #includes
 * 
  1994-May-12-17:03 chrism
 	Check for hqnservers as required rather than all at once in ls_initialise.
	Increase timeout during updates.
  1993-Nov-8-18:02 chrism
 	Put signature array pointer into LSData structure.
  1993-Oct-15-17:29 chrism
 	move unique id calls to uniqueid.c
  1993-Oct-8-16:36 chrism
 	change longs to int32s for alpha - means changes in hqn_ls.h
 	and api doc. All addresses stored in host byte order and
 	convert to network order as required
  1993-Oct-4-14:29 freeland
 	fix silly typo
  1993-Oct-1-21:27 freeland
 	adding error-test for no license yet
  1993-Sep-30-14:52 chrism
 	change unique id under solaris_sparc to normal gethostid -
 	requires ucb lib
  1993-Sep-8-08:00 john
 	use srand48 etc on solaris, like on the snake
  1993-Jun-3-18:13 john
 	make it work on clipper
  1993-Apr-30-12:53 john
 	fix nested comment - clipper acc does not take it
 1993-Apr-20-15:38 chrism
   	correct error in LSQuery caused by last change
 1993-Apr-19-17:17 chrism
   	changed ls_get_users so that works without a licence
 1993-Apr-19-11:22 chrism
   	change licence context details
 1993-Mar-3-18:14 tina
	lint error: lint error: in LSRequest return LS_SUCCESS
 1993-Feb-16-18:19 chrism
	free Handle in ls_release
 1993-Feb-16-15:20 chrism
	changed input params to handle multiple licences
 1993-Feb-15-18:15 chrism
	removed timer on/off routines
 1993-Feb-15-12:28 chrism
	added ls_get_context. Changed return value of ls_initialise
 1993-Feb-5-18:07 harry
	Make Timeout static.
 1993-Feb-4-15:33 chrism
	changing to version 2
1992-Dec-17-14:54 chrism = added ls_get_challenge
1992-Nov-17-18:20 chrism = add uniqueid for snake
1992-Nov-17-13:20 chrism = change random for snake
1992-Nov-17-11:15 chrism = move rpc.h into local file for DEC
1992-Nov-9-14:58 chrism = adding ls_users
1992-Nov-6-12:11 chrism = added time field to node_info
1992-Nov-2-14:55 chrism = added ls_get_status etc
1992-Oct-22-14:20 chrism = changed Sig_index to LS_Sig_Index
1992-Oct-20-12:18 chrism = added std types
1992-Oct-14-16:52 chrism = added timer check routines
1992-Oct-7-17:19 chrism = Created

*/
#include <stdio.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netdb.h>
#include <signal.h>
#include <string.h>
#include "rpc.h"
#include <rpc/pmap_prot.h>
#include "lshide.h"
#include "lsapi.h"
#include "lserver.h"
#include "lshared.h"
#include "lsrpc.h"
#include "permit.h"

#ifdef CLIPPER
#include <sys/time.h>
#endif

/* global variables shared across the rpc interface */

char   LicenceSystem[LS_SERVER_LEN] = "THE HARLEQUIN LICENSE SERVER VERSION 2.0";

static int8			LSDhostname[] = "hqnserver";

static ls_node_info 		LSNode_data;
static int8 			LSDcurrenthost[ sizeof( LSDhostname) + 4] ;
/* entries in LSHQNs */    
static int32  			LSNhosts = 0;
/* Indices into LSHQNs */
static int32      		Domain_index = 0, Hqns_index = 0;

static uint32			LSHQNs[ MAX_SERVERS ];
static LS_CHALLENGE 		LSChallenge;

/* If the level 3 interface is used this variable must be set to the
 * data of the current licence
 */

LSdata				*LSInfo;



/**********************************************************/


static struct timeval Timeout = { LS_TIMEOUT, 0 };
static struct timeval Update_Timeout = { LS_UPDATE_TIMEOUT, 0 };
struct timeval Retry_Timeout = {LS_RETRY_TIMEOUT, 0};
struct timeval Update_Retry_Timeout = {LS_UPDATE_RETRY_TIMEOUT, 0 };

/* pointers to malloced memory. Freed before next use */
static ls_users_out	*Users_out = NULL;
static ls_msg_out     	*Msg_out = NULL;


/* Request permission from the license server */

LS_STATUS_CODE 
LSRequest(lpLicenseSystem, lpPublisherName, lpProductName, lpVersion, ulUnitsRequired,
			 lpLogComment, lpChallenge, ulHandle)
    uint8 *lpLicenseSystem;
    uint8 *lpPublisherName;
    uint8 *lpProductName;
    uint8 *lpVersion;
    uint32 *ulUnitsRequired;
    uint8 *lpLogComment;
    LS_CHALLENGE  *lpChallenge;
    LS_HANDLE      *ulHandle;
{
    ls_request_in 	request;
    ls_request_out 	*response = NULL;
    int32      		this_idom = Domain_index, this_hqn = Hqns_index;
    uint32		address;
    LSLic_handle	*lic = LSInfo->Handle;


    request.license_system  = (lpLicenseSystem == LS_ANY ? LicenceSystem : (char *)lpLicenseSystem);
    request.publisher_name  = (char *)lpPublisherName;
    request.product_name    = (char *)lpProductName;
    request.product_version = (char *)lpVersion;
    request.units_required  =  *ulUnitsRequired;
    request.log_comment     = (lpLogComment == NULL ? "" : (char *)lpLogComment);
    request.flags	    = 0;

    ls_get_node_info( &LSNode_data );
    request.node = LSNode_data;
    time(&request.node.time);

    request.challenge.reserved	    = lpChallenge->challenge.reserved;
    request.challenge.secret	    = lpChallenge->challenge.secret ^ request.node.time;
    request.challenge.data.data_len = lpChallenge->challenge.size;
    request.challenge.data.data_val = (char *)lpChallenge->challenge.data;

    switch( lic->LSLast_XStatus & 0xff0000 ){
	
    case LSX_LOSTMASTER_TO_N:
	/* server is no longer master. Possible new master is in low byte */
	Domain_index = lic->LSLast_XStatus & 0x00ff;
	break;
    case LSX_LOSTCONTACT:
	/* current server no longer responding - try next in domain */
	Domain_index = (Domain_index + 1) % lic->LSDomainSize;
	break;
    }

    do {
	if( lic->LSDomainSize ){
	    /* I have a stored domain */
	    address = lic->LSDomain[ Domain_index ];
	} else {
	    /* have not yet obtained a domain. Try localhost or next hqnserver */
	    address = LSHQNs[ Hqns_index ];
	}
	    

	if( lic->LSClient )
               {
                auth_destroy (lic->LSClient->cl_auth) ;                    
                    clnt_destroy( lic->LSClient );
              }

	lic->LSClient = get_clnt_handle( address );
	Timeout.tv_sec = LS_TIMEOUT;		/* reset to standard timeout period */

	if( lic->LSClient ){
	    lic->LSClient->cl_auth = authunix_create_default();

	    debugn("Requesting licence from", address);

	    free_ls_request_out( response );
	    response = ls_request_1(&request, lic->LSClient);
	    Retry_Timeout.tv_sec = LS_RETRY_TIMEOUT;
	    request.flags &= ~LRQ_REREQUEST;	/* turn off re-request flag */

	    if( response ){
		
		switch( response->status & 0xff0000){
		case LSX_NEW_MASTER:
		    /* server needs to check for higher servers - rerequest
		     * with longer timeout
		     */
		    request.flags |= LRQ_REREQUEST;
		    Timeout.tv_sec = LS_LONG_TIMEOUT;
		    Retry_Timeout.tv_sec = LS_LONG_RETRY;
		    continue;
		case LSX_TRY_SERVER_N:
		    /* n is in low byte of status. Try again */
		    store_domain( response, lic );
		    Domain_index = response->status & 0x00ff;
		    continue;

		case LSX_TRY_DOMAIN:
		    /* current server only knows about this product. Try new domain */
		    request.flags++;  /* inc number of redirections made */
		    store_domain( response, lic );
		    Domain_index = 0;
		    continue;
		    
 		case LSX_SUCCESS:
		    store_domain( response, lic );
		    *ulHandle = response->handle ^ request.node.time;
		    *ulUnitsRequired = response->units;
		    debugn("Handle is", *ulHandle);    
		    lpChallenge->response.size = (uint32)LS_SIG_LEN;
		    bcopy(response->challenge.data, (char*)lpChallenge->response.data, (int)LS_SIG_LEN);
		    lic->LS_Current_Server = address;
		    /* increase timeout now that have contacted valid server */
		    clnt_control( lic->LSClient, CLSET_TIMEOUT, &Update_Timeout );
		    clnt_control( lic->LSClient, CLSET_RETRY_TIMEOUT, &Update_Retry_Timeout );
		    free_ls_request_out( response );
		    return lic->LSLast_XStatus = LS_SUCCESS;
		    
		default:
		    /* server returned an error condition */
		    *ulHandle = response->handle;
		    lpChallenge->response.size = 0;
		    lic->LSLast_XStatus = response->status;
		    free_ls_request_out( response );
		    return lic->LSLast_XStatus  & 0xff00ffff;
		}
	    } else {
		debug1( "request failed");
                auth_destroy (lic->LSClient->cl_auth) ;
		clnt_destroy( lic->LSClient );
		lic->LSClient = 0;		
	    }
	} else {
	    debugn( "couldn't contact server", address);
	}
	/* if all possible server hosts have been tried return error */
	if ( lic->LSDomainSize ){
	    Domain_index = (Domain_index + 1) % lic->LSDomainSize;
	    if( Domain_index == this_idom)
		/* return NoAuthorisation because at least one server was available */
		return lic->LSLast_XStatus = LS_NOAUTHORIZATIONAVAILABLE;
	} else {
	    if( LSNhosts ){
		++Hqns_index;
		ls_find_server( Hqns_index );
		Hqns_index %= LSNhosts;
	    }
	    if( Hqns_index == this_hqn ) return lic->LSLast_XStatus = LS_LICENSESYSNOTAVAILABLE;
	}
    } while(1);
    return LS_SUCCESS ; /* this should never be reached */
}    



/* Release previously acquired license */

LS_STATUS_CODE 
LSRelease(ulHandle, lpTotUnits, lpLogComment)
	LS_HANDLE ulHandle;
	uint32 lpTotUnits;
	uint8 *lpLogComment;
{
    ls_release_in release;
    LS_STATUS_CODE *status;
    LSLic_handle   *lic = LSInfo->Handle;
    
    release.handle = ulHandle;
    release.units = lpTotUnits;
    release.node = LSNode_data;
    release.log_comment = (lpLogComment == NULL ? "" : (char *) lpLogComment);

    if( status = ls_release_1( &release, lic->LSClient )) {
	if( *status == LS_SUCCESS){
	    /* free handle only if successful */
	    free( lic );
	    return LS_SUCCESS;
	}
	return (lic->LSLast_XStatus = *status) & 0xff00ffff;
    }
    lic->LSLast_XStatus = LSX_LOSTCONTACT | LS_LICENSESYSNOTAVAILABLE;
    return LS_LICENSESYSNOTAVAILABLE;
}



LS_STATUS_CODE
LSUpdate( ulHandle, ulTotUnitsConsumed, lpNewUnitsRequired, lpLogComment, lpChallenge)
    LS_HANDLE		ulHandle;
    uint32 		ulTotUnitsConsumed;
    int32		*lpNewUnitsRequired;
    uint8		*lpLogComment;
    LS_CHALLENGE	*lpChallenge;
{
    ls_update_in	update;
    ls_update_out	*response;
    LSLic_handle   	*lic = LSInfo->Handle;
    LS_STATUS_CODE	result;

    update.handle = ulHandle;
    update.units_consumed = ulTotUnitsConsumed;
    update.units_required = *lpNewUnitsRequired;
    update.node = LSNode_data;
    time( &update.node.time );
    update.log_comment     = (lpLogComment == NULL ? "" : (char *)lpLogComment);
    
    update.challenge.reserved	    = lpChallenge->challenge.reserved;
    update.challenge.secret	    = lpChallenge->challenge.secret ^ update.node.time;
    update.challenge.data.data_len = lpChallenge->challenge.size;
    update.challenge.data.data_val = (char *)lpChallenge->challenge.data;

    if( response = ls_update_1( &update, lic->LSClient)){
	
	*lpNewUnitsRequired = response->units_available;
	lic->LSLast_XStatus = response->status;
	if( response->status == LS_SUCCESS){
	    lpChallenge->response.size = (uint32)LS_SIG_LEN;
	    response->challenge.data[0] ^= update.node.time;
	    bcopy(response->challenge.data, (char*)lpChallenge->response.data, (int)LS_SIG_LEN);
	    result = LS_SUCCESS;
	} else if( (response->status & 0xff0000) == LSX_LOSTMASTER_TO_N){
	    result = LS_LICENSETERMINATED;
	} else {
	    result = response->status & 0xff00ffff;
	}
	free_ls_update_out( response );
	return result;
    }
    debug1("Update lost contact with server");
    lic->LSLast_XStatus = LSX_LOSTCONTACT | LS_LICENSESYSNOTAVAILABLE;
    return LS_LICENSESYSNOTAVAILABLE;
}



/**** LSQueryLicense deals with byte streams therefore data and context
 **** are always transmitted in network byte order and need to be
 **** converted to host ordering if actually non-char arrays
 */

LS_STATUS_CODE
LSQueryLicense( ulHandle, ulInformation, lpInfoBuffer, ulBufferSize)
    LS_HANDLE  		ulHandle;
    uint32 		ulInformation;
    void		*lpInfoBuffer;
    uint32		ulBufferSize;
{
    ls_query_in		query;
    ls_query_out	*response;
    int8		*cptr = lpInfoBuffer;
    uint32		ulsize;
    LSLic_handle   	*lic = LSInfo->Handle;
    LS_STATUS_CODE 	result;
    
    query.handle = ulHandle;
    query.infotype = ulInformation;
    query.bufsize = ulBufferSize;
    query.node = LSNode_data;

    if( response = ls_query_1( &query, lic->LSClient)){
	if( response->status == LS_SUCCESS){
	    switch( ulInformation ){
	    case LS_INFO_DATA:
		/* data count is in HOST order */
		bcopy( (char*)&response->data.data_len, (char *)cptr, sizeof( int32 ));
		cptr += sizeof(int32); /* NO BREAK */
	    case LS_LICENSE_CONTEXT:
		bcopy(response->data.data_val, (char *)cptr, (int) response->data.data_len);
		break;
	    case LS_INFO_SYSTEM:
		strcpy( (char *)cptr, response->data.data_val);
		break;
	    case LS_INFO_UPDATE_PERIOD:
		bcopy( (char*)&response->value, (char *)cptr, (int) sizeof(uint32));
		break;
	    default:
		result = lic->LSLast_XStatus = LS_BAD_INDEX ;
	    }
	    result =  lic->LSLast_XStatus = LS_SUCCESS;
	} else {
	    result =  (lic->LSLast_XStatus = response->status) & 0xff00ffff;
	}
	free_ls_query_out( response );
	return result;
    }
    debug1("Query lost contact with server");
    lic->LSLast_XStatus = LSX_LOSTCONTACT | LS_LICENSESYSNOTAVAILABLE;
    return LS_LICENSESYSNOTAVAILABLE;
}

/*------------------------------------------------------------------------*/

void
ls_chalchk( lsd )
    LSdata *lsd;
{
    LSLic_handle *lic = lsd->Handle;
    uint32 buf[4];
    uint32 *sigp = lic->LS_Sigs[ lic->LSIsecret % lsd->Nchals ];
    uint8 *sig1 = LSChallenge.response.data;
    uint8 *sig2 = (uint8*) buf;
    int32 *data = &lsd->Data[1];
    int8 result = 1;
    int32 x;
    
    sigp += ((lic->LSIsecret >> 8) & 0x3) * 4;
    for( x = 0; x < 4; ++x )
	buf[x] = sigp[x];

    hton4l( buf );

    for( x = LS_SIG_LEN; x--;)
	result &= (*sig1++ == *sig2++);

    if( ! result ){
	debug1( "CHALLENGE MISMATCH!");
	for( x = lsd->Ndata; x--; ++data)
	    /* flip bits if error */
	    *data = ~*data;
    }
}

void
store_domain( response, lic )
    ls_request_out *response;
    LSLic_handle *lic;
{
    lic->LSDomainSize = response->domain->members.size;
    bcopy( (char*)response->domain->members.addr, (char*)lic->LSDomain, lic->LSDomainSize * sizeof(uint32));
}
	

/*
*------------------------------------------------------------------------*
* level 1 interface
*------------------------------------------------------------------------*
*/


/* Create a LSLic_handle for this product. Get localhost's address
 * and store in LSHQN array as first entry. Return TRUE or an error code.
 */

int32
ls_initialise( lsd )
    LSdata *lsd;
{
    int8 	hostname[ MAX_MACHINE_NAME];
    struct hostent *host;
    uint32	   *addr = LSHQNs;
    LSLic_handle   *lic;

    /* LSInfo may change if multiple licences, but if only one, as is normally
     * the case, then this initialises it and if using level 3 routines it
     * doesn't have to be set explicitly
     */
    LSInfo = lsd; 

    if( ! (lic = lsd->Handle = (LSLic_handle*) malloc( sizeof( LSLic_handle))))
	return LS_INIT_NO_MEM;

    /* local host is always tried first */
    gethostname( hostname, MAX_MACHINE_NAME);
    host = gethostbyname( (char *)hostname );
    if( host->h_length > sizeof( int32 )){
	return LS_INIT_BAD_ADDR;
    }
    bcopy( host->h_addr_list[0], (char*)addr, host->h_length );

    /* store all addresses in HOST byte order */
    *addr = ntohl( *addr );

    /* Have localhost address so LSNhosts is one */
    LSNhosts = 1 ;
    /* Initialise indices into LSHQNs array (for LW) */
    Domain_index = 0;
    Hqns_index = 0;
    /* Initialise pointers to malloced memory (for LW) */
    Users_out = NULL;
    Msg_out = NULL;
    
    lic->LSLast_XStatus = LS_LICENSESYSNOTAVAILABLE;
    lic->LSDomainSize = 0;
    lic->LSHandle = LSX_NOHANDLE;
    lic->LSClient = 0;
    return 1;
}



int
ls_get_license( lsd )
    LSdata *lsd;
{
    uint32 dumy;
    int32 x;
    int32 *data = lsd->Data;

#if defined(snake) || defined(Solaris)
    srand48( time(&dumy));
#else
    srandom( time(&dumy));
#endif
    /* set data to some negative values */
    *data++ = lsd->Ndata * sizeof(int32);
    for( x = lsd->Ndata; x--;) *data++ = dumy++ | 0xc57fe019;

    /* set pointer to signatures */
    lsd->Handle->LS_Sigs = lsd->Sig_Index;
    
    if( ls_do_request( lsd )){
	if( ls_get_data( lsd )){
	    ls_chalchk( lsd );
	    return 1;
	}
	ls_release_lic( lsd );
    }
    return 0;
}



int
ls_update_lic( lsd )
    LSdata *lsd;
{
    int32 res = ls_do_update( lsd );
    ls_chalchk( lsd );
    return res;
}


int
ls_release_lic( lsd )
    LSdata *lsd;
{
    uint32 units = 1;
    LSLic_handle *lic = lsd->Handle;
    

    if( lic && lic->LSHandle != LSX_NOHANDLE){
	LSInfo = lsd;
	lic->LSStatus = LSRelease( lic->LSHandle, units, (int8*)NULL);
	return lic->LSStatus == LS_SUCCESS;
    }
    return 1;
}



LSusers *
ls_get_users( lsd )
    LSdata *lsd;
{
    ls_request_in 	request;
    LSLic_handle	*lic = lsd->Handle;

    /* send a request so that server can locate an appropriate permit
     * if we don't have a valid licence yet.
     */
    request.license_system  = LicenceSystem;
    request.publisher_name  = (char *)lsd->PublisherName;
    request.product_name    = (char *)lsd->ProductName;
    request.product_version = (char *)lsd->VersionString;
    request.units_required  =  0;
    request.node = LSNode_data;
    request.log_comment     = "";
    request.flags	    = (uint32) lic->LSHandle; /* may not be valid */
    request.challenge.data.data_len = 0;


    /* NB LSClient MUST be a valid handle therefore ls_get_licence must have been
     * called before this so that we have located a server holding a permit
     */

    if( lic->LSClient == 0 ){
	debug1("ls_get_users: bad client handle");
	return (LSusers*) 0;
    }
    /* if called previously free last users data */
    free_ls_users_out( Users_out );
    
    if( Users_out = ls_users_1( &request, lic->LSClient )){ 
	if( Users_out->status == LS_SUCCESS )
	    return (LSusers*) &Users_out->users;
	else {
	    lic->LSLast_XStatus = Users_out->status;
	    return (LSusers*) 0;
	}
	
    }
    debug1("ls_get_users lost contact with server");
    lic->LSLast_XStatus = LSX_LOSTCONTACT | LS_LICENSESYSNOTAVAILABLE;
    return (LSusers*) 0;
}    
    

int8 *
ls_status( lsd )
    LSdata *lsd;
{
    int8 *msg;
    LSLic_handle *lic = lsd->Handle;
    
    debugn( "status is", lic->LSLast_XStatus );
    
    if( lic->LSLast_XStatus == LS_SUCCESS )
	return (int8*) 0;

    if( msg = ls_get_status( lic->LSLast_XStatus, lsd ))
	return msg;

    return (int8 *)"server failed during status check";
}
    

/*
*------------------------------------------------------------------------*
* level 2 interface
*------------------------------------------------------------------------*
*/


int
ls_do_request( lsd )
    LSdata *lsd;
{
    uint32 units = 1;
    LSLic_handle *lic = lsd->Handle;
    
    ls_set_challenge( lsd );

    LSInfo = lsd;
    lic->LSStatus = LSRequest(lsd->LicenseSystem,
			lsd->PublisherName,
			lsd->ProductName,
			lsd->VersionString,
			&units,
			(int8*) NULL,
			&LSChallenge,
			&lic->LSHandle);
    
    ls_dmy_chalchk( lsd );

    return ( lic->LSStatus == LS_SUCCESS );
}




int
ls_get_data( lsd )
    LSdata *lsd;
{
    LSLic_handle *lic = lsd->Handle;
    int len;

    LSInfo = lsd;
    if( (lic->LSStatus = LSQueryLicense( lic->LSHandle, (uint32)LS_INFO_DATA,
			      (void*)lsd->Data, lsd->Ndata * sizeof(int32))) == LS_SUCCESS){
	/* NB LSQueryLicense returns data in network byte order - except first entry which
	 * is the byte count
	 */
	for( len = 1; len <= lsd->Ndata; ++len )
	    lsd->Data[len] = ntohl( lsd->Data[len] );
	
	lic->LSStatus = LSQueryLicense( lic->LSHandle, (uint32)LS_INFO_UPDATE_PERIOD,
				  (void*)&lsd->UpPeriod, sizeof(int32));
	
	lsd->UpPeriod *= 60; /* convert to seconds */
    }

    return ( lic->LSStatus == LS_SUCCESS);
}


int
ls_get_context( buff, lsd )
    uint32  *buff;
    LSdata *lsd;
{
    LSLic_handle *lic = lsd->Handle;
    int len;
    
    LSInfo = lsd;
    if( (lic->LSStatus = LSQueryLicense( lic->LSHandle, (uint32)LS_LICENSE_CONTEXT,
			      (int8*)buff, LS_CONTEXT_SIZE * sizeof(int32))) == LS_SUCCESS){
	/* context is return in network byte order */
	for( len = 0; len < LS_CONTEXT_SIZE; ++len )
	    buff[len] = ntohl( buff[len] );
    }

    return ( lic->LSStatus == LS_SUCCESS);
}



int
ls_do_update( lsd )
    LSdata *lsd;
{
    LSLic_handle *lic = lsd->Handle;  
    uint32 units = 1;
    
    ls_set_challenge( lsd );
    
    LSInfo = lsd;
    lic->LSUpStatus = LSUpdate( lic->LSHandle, units, (int32*)&units, (int8*)NULL, &LSChallenge);
    
    ls_dmy_chalchk( lsd );

    return (lic->LSUpStatus == LS_SUCCESS);
}

LS_CHALLENGE *
ls_get_challenge( secret, chalval, lsd )
    uint32 *secret, *chalval;
    LSdata *lsd;
{
    LSLic_handle *lic = lsd->Handle;  
    *secret = (uint32) ((lic->LSIsecret >> 8) & 0x3);
    *chalval = (uint32) (lic->LSIsecret % lsd->Nchals);
    return &LSChallenge;
}


uint32
ls_status_val( lsd )
    LSdata *lsd;
{
    return lsd->Handle->LSStatus;
}

uint32
ls_upstatus_val( lsd )
    LSdata *lsd;
{
    return lsd->Handle->LSUpStatus;
}

uint32
ls_xstatus_val( lsd )
    LSdata *lsd;
{
    return lsd->Handle->LSLast_XStatus;
}


int8 *
ls_get_status( status, lsd )
    LS_STATUS_CODE status;
    LSdata *lsd;
{
    LS_STATUS_CODE xstatus = status & 0xff0000;

    switch( status & 0xff00ffff){
    case LS_LICENSESYSNOTAVAILABLE:
	switch( xstatus ){
	case LSX_LOSTCONTACT:
	    return (int8 *)"current licence server not responding";
	default:
	    return (int8 *)"unable to contact any licence server";
	}

    case LS_NO_NETWORK:
	return (int8 *)"network unavailable";

    case LS_NOAUTHORIZATIONAVAILABLE:
	if( xstatus == 0 ) return (int8 *)"no licences on available servers";

    }
    /* free any previous message */
    free_ls_msg_out( Msg_out );
    
    if( Msg_out = ls_message_1( &status, lsd->Handle->LSClient )){
	return (int8 *)Msg_out->msg;
    }
    debug1("ls_get_status lost contact with server");
    lsd->Handle->LSLast_XStatus = LSX_LOSTCONTACT | LS_LICENSESYSNOTAVAILABLE;
    return (int8*) 0;    
	
}

/*------------------------------------------------------------------------*/


CLIENT *
ls_get_client( lsd )
    LSdata *lsd;
{
    return lsd->Handle->LSClient;
}

uint32
ls_current_server( lsd )
    LSdata *lsd;
{
    return lsd->Handle->LS_Current_Server;
}


void
ls_set_challenge( lsd )
    LSdata *lsd;
{
    uint32 challenge;
    LSLic_handle *lic = lsd->Handle;
    int8 *data = (int8*)&challenge;
    
#if defined(snake) || defined(Solaris)
    lic->LSIsecret = lrand48();
#else
    lic->LSIsecret = random();
#endif

    LSChallenge.challenge.reserved = 0;
    LSChallenge.challenge.secret = (lic->LSIsecret >> 8) & 0x3;
    LSChallenge.challenge.size = 4;
    challenge = lsd->Chalvals[ lic->LSIsecret % lsd->Nchals];
    challenge = htonl( challenge );
    LSChallenge.challenge.data[0] = *data++;
    LSChallenge.challenge.data[1] = *data++;
    LSChallenge.challenge.data[2] = *data++;
    LSChallenge.challenge.data[3] = *data++;    
}

	
void
ls_dmy_chalchk( lsd )
    LSdata *lsd;
{
    static int8 junk[ LS_SIG_LEN ] = { 34, 90, 101, 5, 2, 127, 71, 24,
				       72, 70, 1, 1, 113, 66, 69, 35 };
    uint8 *sig1 = LSChallenge.response.data;
    int8 *sig2 = junk;
    int32 *data = &lsd->Data[1];
    int32 x;
    int8 dumy = 0;
    static int32 neverzero = 0x3789aaa4;

    for( x = LS_SIG_LEN; x--; ){
	dumy ^= *sig1++;
	dumy ^= *sig2++;
    }
    if( ! (dumy || neverzero)){
	/* never performed */
	for( x = lsd->Ndata; x--;)
	    *data++ ^= 0x453423bb;
    }
}



void
ls_get_node_info( node )
    ls_node_info *node;
{
    node->hostid = uniqueid();
    node->iaddr = LSHQNs[0];  /* local host */
    node->pid = getpid();
}

int
ls_find_server( index )
    int32 index;
{
    uint32 *addr;
    struct hostent *host;
    
    if( index >= LSNhosts ){
	/* alias hasn't been found yet */
	if( index >= MAX_SERVERS )
	    return 0;
	sprintf( (char *)LSDcurrenthost, "%s%d", LSDhostname, index);
	if( ! (host = gethostbyname( (char *)LSDcurrenthost ))){
	    /* this alias doesn't exist */
	    return 0;
	}
	addr = &LSHQNs[ index ];
	bcopy( host->h_addr_list[0], (char*) addr, host->h_length );
	*addr = ntohl( *addr );
	++LSNhosts;
    }
    return 1;
}


CLIENT *
get_clnt_handle( addr )
    uint32 addr;
{
    struct sockaddr_in 	server_addr;
    int 		sock = RPC_ANYSOCK; 
    extern struct timeval Timeout;
    u_short		*port;
    CLIENT 		*pmaphandle;
    static struct pmap 	prog = {
			LICENSEWORKS,
			LICENSEWORKS_VERSION,
			IPPROTO_UDP,
			0 };

    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PMAPPORT);
    server_addr.sin_addr.s_addr = htonl(addr);  /* addr is in HOST byte order */

    if( pmaphandle = clntudp_create( &server_addr, PMAPPROG, PMAPVERS, Timeout, &sock )){
	if( port = ls_get_port( &prog, pmaphandle )){
	    clnt_destroy( pmaphandle );
	    if( server_addr.sin_port = htons(*port)){
		sock = RPC_ANYSOCK;
		return clntudp_create( &server_addr, LICENSEWORKS, LICENSEWORKS_VERSION, Timeout, &sock );
	    }
	} else {
	    clnt_destroy( pmaphandle );
	}
    }
    /* can't contact portmapper or prog not registered */
    return (CLIENT*) 0;
}

u_short *
ls_get_port(argp, clnt)
        void *argp;
        CLIENT *clnt;
{
        static u_short res;

        bzero((char *)&res, sizeof(res));
        if (clnt_call(clnt, PMAPPROC_GETPORT, xdr_pmap, argp, xdr_u_short, &res, Timeout) != RPC_SUCCESS) {
                return (NULL);
        }
        return &res;
}



/***** update timer routines (NOT USED)
*    
*    void
*    ls_time_update()
*    {
*        struct itimerval period;
*        uint32 units = 1;
*        
*        ls_set_challenge();
*    
*        LSUpStatus = LSUpdate( LSHandle, units, (int32*)&units, (int8*)NULL, &Challenge);
*        if( LSUpStatus != LS_SUCCESS){
*    	period.it_value.tv_sec = period.it_value.tv_usec = 0;
*    	setitimer( ITIMER_REAL, &period, (struct itimerval*)NULL);
*        }
*    }
*    
*    
*    int
*    ls_set_time_update()
*    {
*        uint32 update;
*        struct itimerval period;
*        
*        LSStatus = LSQueryLicense( LSHandle, (uint32)LS_INFO_UPDATE_PERIOD, (void*)&update, sizeof(update));
*    
*        if( LSStatus != LS_SUCCESS) return 0;
*    
*        period.it_interval.tv_sec = 60 * update;
*        period.it_interval.tv_usec = 0;
*        period.it_value.tv_sec = 60 * update;
*        period.it_value.tv_usec = 0;
*        if(signal( SIGALRM, ls_do_update) >= 0 ){
*    	UpStatus = LS_SUCCESS;
*    	if(setitimer( ITIMER_REAL, &period, (struct itimerval*)NULL) >= 0 )
*    	    return 1;
*        }
*        gen_err1("Error setting update timer");
*    }
*    
*    
**************/

