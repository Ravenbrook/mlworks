/* $HopeName: $
 *
 * $Log: lsapi.h,v $
 * Revision 1.25  1999/01/04 09:02:57  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.24  1994/05/27  10:59:41  chrism
 * add lshide.h to obscure symbols
 *
 * Revision 1.23  1994/05/17  21:51:31  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
  1994-May-12-17:03 chrism
        update has a longer timeout 
  1993-Nov-8-18:03 chrism
        Put signature array pointer into LSData structure.
  1993-Oct-8-16:08 chrism
        convert all longs to int32s for alpha
  1993-Oct-8-16:08 chrism
        convert all longs to int32s for alpha
  1993-Apr-30-12:55 john
        fix nested comment - clipper acc does not take it
 1993-Apr-19-11:26 chrism
        change LS_CONTEXT_SIZE
 1993-Mar-8-15:32 chrism
        added LSX_MAX_STATUS
 1993-Feb-16-15:25 chrism
        changed routines to allow handling of multiple licences
 1993-Feb-15-12:30 chrism
        added ls_get_context and LS_CONTEXT_SIZE
 1993-Feb-9-15:46 chrism
        added user locking and access levels
 1993-Feb-4-16:39 chrism
        changing PROGRAM number
 1993-Feb-4-15:22 chrism
        changing to version 2
1992-Nov-17-12:09 chrism = changed rpc.h to local file for DEC
1992-Nov-9-14:48 chrism = added LSX_USERS_OFF
1992-Nov-9-14:46 chrism = added LSX_USERS_OFF
1992-Nov-3-14:46 harry = Add rpc.h
1992-Nov-2-14:36 chrism = added extra error codes
1992-Oct-19-16:40 chrism = added PROGRAMNUMBER
1992-Oct-16-13:23 chrism = adding std types
1992-Oct-14-17:01 chrism = add comments
1992-Oct-8-19:41 chrism = moved extended status's to here
1992-Oct-7-14:47 chrism = Created

*/

#include "lshide.h"
#include "std.h"
#include "ls.h"
#include "rpc.h"
#include "permit.h"

#ifndef LSAPI_H
#define LSAPI_H

typedef union {
  struct {
    uint32 reserved;    /* must be zero */
    uint32 secret;      /* which secret (1-4) */
    uint32 size;           /* 4-LS_MAX_CHAL_DATA */
    uint8 data[LS_MAX_CHAL_DATA];       /* size is really previous field */
  } challenge;
  struct {
    uint32 size;
    uint8 data[LS_SIG_LEN];
  } response;
} LS_CHALLENGE;

/* Client side handle to a licence */

typedef struct {
#ifdef UNIX
  /* RPC client handle */
  CLIENT      *LSClient;
#endif
  uint32      LSDomainSize;
  uint32      LSDomain[ MAX_SERVERS ];
  LS_HANDLE   LSHandle;
  LS_STATUS_CODE LSStatus;
  LS_STATUS_CODE LSUpStatus;
  LS_STATUS_CODE LSLast_XStatus;
  int32       LSIsecret;
  uint32      LS_Current_Server;
  uint32      **LS_Sigs;
} LSLic_handle;


/* Client side data interface */

typedef struct {
  int8        *LicenseSystem;
  int8        *PublisherName;
  int8        *ProductName;
  int8        *VersionString;
  int32       Nchals;
  uint32      *Chalvals;
  int32       Ndata;
  int32       *Data;
  uint32      UpPeriod; /* in seconds */
  LSLic_handle *Handle;
  uint32      **Sig_Index;
} LSdata;

/* Client side interface to users information */

typedef struct {
  struct {
    uint32          ls_res1;        /* reserved */
    uint32          ls_iaddr;       /* internet address */
  } ls_host;
  uint32              ls_flags;       /* type flags */
  int32               ls_res2;        /* reserved  */
  int32               ls_uid;         /* user id */
  uint32              ls_res3;        /* reserved */
  uint32              ls_start;       /* time licence taken (output of time()) */
  uint32              ls_res4;        /* reserved */
} LSlicence;

typedef struct {
  uint32              ls_ulen;        /* len of ls_ulist = total available licences */
  LSlicence           **ls_ulist;     /* free licences have NULL entries */
} LSusers;
    


        
/* Constants */

#define PROGRAMNUMBER           1236            /* RPC program index */

#define LS_DEFAULT_UNITS        0xFFFFFFFF      /* units to consume up to LS */
#define LS_ANY                  0               /* Use any license service provider */
#define LS_USE_LAST             0x0800FFFF      /* return message for last error */

/* standard timeout periods */

#define LS_TIMEOUT              4
#define LS_RETRY_TIMEOUT        2               /* try twice */
#define LS_UPDATE_TIMEOUT               8
#define LS_UPDATE_RETRY_TIMEOUT         4       /* try twice */

/* long timeouts when waiting for server to check others */

#define LS_LONG_TIMEOUT         60
#define LS_LONG_RETRY           10

/* Amount of data return by LS_LICENSE_CONTEXT in *int32s*
 * NB first int32 is number of bytes returned
 */

#define  LS_CONTEXT_SIZE        5


/* Standard API Status codes */

#define LS_SUCCESS                         0    /* completed successfully */
#define LS_BADHANDLE              0xC8001001    /* handle not valid */
#define LS_INSUFFICIENTUNITS      0xC8001002    /* not enough resources for request */
#define LS_LICENSESYSNOTAVAILABLE 0xC8001003    /* no LS found to do operation */
#define LS_LICENSETERMINATED      0xC8001004    /* resources no longer granted */
#define LS_NOAUTHORIZATIONAVAILABLE 0xC8001005  /* no resources exist for operation */
#define LS_NOLICENSESAVAILABLE    0xC8001006    /* resources exist but are not available */
#define LS_NORESOURCES            0xC8001007    /* not enough resources (e.g memory) */
#define LS_NO_NETWORK             0xC8001008    /* network unavailable */
#define LS_NO_MSG_TEXT            0xC8001009    /* error while retrieving error string */
#define LS_UNKNOWN_STATUS         0xC800100A    /* no message exists for that code */
#define LS_BAD_INDEX              0xC800100B    /* bad index to LSEnum... or LSQuery... */
#define LS_NO_MORE_UNITS          0xC800100C    /* no additional units available*/
#define LS_LICENSE_EXPIRED        0xC800100D    /* maybe due to time restriction */

/*******  FOLLOWING NOT DEFINED IN API DOCUMENT!!! ******* */

#define LS_BUFFER_TOO_SMALL       0xC800100E    /* error from LSQuery */


/* LSQueryLicense information types */

#define LS_INFO_NONE            0               /* Reserved */
#define LS_INFO_SYSTEM          1               /* Return unique ID for LS */
#define LS_INFO_DATA            2               /* Return license data */
#define LS_INFO_UPDATE_PERIOD   3               /* Return interval between LSUpdate calls */
#define LS_LICENSE_CONTEXT      4               /* provide context in LS of handle */


/****** Extended Status Codes - for extra info ******/


#define LSX_SUCCESS             0
#define LSX_BADLICENSESTRING    0x10000         /* Requested server id not compatible */

#define LSX_BADPRODUCT          0x20000         /* product not served and not stored externally */
#define LSX_PERMITOUTOFDATE     0x30000
#define LSX_NOLICENSES          0x40000
#define LSX_BIGPHANDLE          0x50000
#define LSX_BIGLHANDLE          0x60000
#define LSX_BADHANDLE           0x70000
#define LSX_PERMITEXPIRED       0x80000

#define LSX_TOOMANYLICENSES     0xa0000         /* ONEPERNODE policy set */
#define LSX_LOSTLICENSE         0xb0000
#define LSX_LOCKSNOFLOAT        0xc0000         /* no licence because of policy */
#define LSX_NOTVERIFIED         0xd0000         /* domain of product is not verified */
#define LSX_NEW_MASTER          0xe0000         /* current server becoming master */
#define LSX_LOSTCONTACT         0xf0000         /* update failed to contact server */

/* NB low byte is n */
#define LSX_LOSTMASTER_TO_N     0x100000        /* mastership taken over by n */
#define LSX_TRY_SERVER_N        0x110000        /* server is not master, try domain member n */

#define LSX_TRY_DOMAIN          0x120000        /* product not served, try returned domain */

#define LSX_ILLEGAL             0x130000        /* server has detected an illegal state */
#define LSX_NOMEMORY            0x140000        /* No memory could be allocated */
#define LSX_EXCLUDED            0x150000        /* User is on an excluded host */
#define LSX_USERS_OFF           0x160000        /* List users policy is off */
#define LSX_NOACCESS            0x170000        /* User's access level is 0 */

#define LSX_MAX_STATUS          0x17            /* max extended status byte - for log array */

#define LSX_NOHANDLE            0xFFFFFFFF

/* The Harlequin Licence System descriptor. This must match the descriptor
 * held by the licence daemon. The default value will be set automatically
 * by the library routines.
 */

#define HQNLS_VERSION (char*)LS_ANY

/* errors from ls_initialise */

#define LS_INIT_NO_MEM          -1
#define LS_INIT_BAD_ADDR        -2


/****** level 1 interface ******/

int32   ls_initialise();
int32   ls_get_license();
int32   ls_update_lic();
int32   ls_release_lic();
int8    *ls_status();
LSusers *ls_get_users();

/****** level 2 interface ******/

int     ls_do_request();
int     ls_get_data();
int     ls_get_context();
uint32 ls_status_val();
uint32 ls_upstatus_val();
uint32 ls_xstatus_val();
int8   *ls_get_status();

/****** Low Level function calls ******/

/* Request licensing resources needed, and associate them with a handle */

LS_STATUS_CODE LSRequest ();

/* Release licensing resources associated with the handle */

LS_STATUS_CODE LSRelease ();

/* Confirm license details / change units */

LS_STATUS_CODE LS_Update();

/* Get a localised string for a LSAPI error */

LS_STATUS_CODE  LSGetMessage ();


/* Ask for details of license */

LS_STATUS_CODE  LSQueryLicense ();
                                     
/* Enumerate installed LS service providers */

LS_STATUS_CODE  LSEnumProviders ();

/****** other routines ******/

void ls_set_challenge();
void ls_dmy_chalchk();
void ls_chalchk();
void ls_clear_timer();
void ls_restore_timer();
void ls_get_node_info();
int ls_get_date();

#ifdef UNIX
/* returns UNIX RPC client handle */
CLIENT *ls_get_client();
#endif

uint32 ls_current_server();
void store_domain();
int ls_find_server();

#endif
