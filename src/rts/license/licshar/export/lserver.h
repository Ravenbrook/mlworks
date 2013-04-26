/*
 $Log: lserver.h,v $
 Revision 1.19  1999/01/04 09:02:58  jamesr
 [Bug #30447]
 modifications for NT

 * Revision 1.18  1994/05/23  14:06:19  chrism
 * add definition for routines to release rpc memory
 *
 * Revision 1.17  1994/05/17  21:51:47  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
  1993-Oct-8-16:09 chrism
        add LOWBYTEFIRST for alpha
  1993-Sep-30-14:38 chrism
        added error field to pfiledat. added logging level flags.
        changed CHECK_INTERNAL to 2 minutes. added PER_START/MAX for
        new error handling and logging.
  1993-Sep-3-11:54 chrism
        add comments to error codes
  1993-Jul-21-17:17 chrism
        change timeout periods
  1993-Jun-3-17:29 john
        make it work on clipper
  1993-Apr-30-12:54 john
        fix nested comment - clipper acc does not take it
 1993-Apr-19-17:25 chrism
        remove users_in - now using a request_in
 1993-Mar-8-15:34 chrism
        changed check period
 1993-Mar-8-15:33 chrism
        added CHECK_INTERVAL and VFY_RETRY
 1993-Feb-9-15:46 chrism
        added user locking and access levels
 1993-Feb-4-15:23 chrism
        changing to version 2
1992-Nov-12-12:19 chrism = added destroy_all and read_pfiles
1992-Nov-9-14:51 chrism = added comments
1992-Nov-2-14:22 chrism = added user structures
1992-Oct-23-16:34 chrism = structures transmitted
1992-Oct-16-12:57 chrism = adding std types
1992-Oct-14-16:28 chrism = adding comments
1992-Oct-7-13:42 chrism = Created

*/
/* lserver.h */

#ifndef _LSERVER_H
#define _LSERVER_H

#ifdef UNIX

#ifndef CLIPPER
#include <syslog.h>
#endif
#include <stdio.h>

#endif

#ifdef WIN32
#endif

#include "std.h"
#include "ls.h"
#include "lsrpc.h"
#include "permit.h"


/*-----------------------------------------------------------------*/
/* System logging defines */

#ifdef DEBUG
/* don't log anything */
#define LS_LOG_LEVEL LOG_EMERG
#else
/* normally log everything upto LOG_INFO */
#define LS_LOG_LEVEL LOG_INFO
#endif

#define SLOG_SYS_WARN   1
#define SLOG_SYS_INFO   1<<1
#define SLOG_ADMIN      1<<2
#define SLOG_LICENCE    1<<3
#define SLOG_PROD_STR   1<<4
#define SLOG_MACH_NAM   1<<5
#define SLOG_MACH_ADR   1<<6
#define SLOG_USER_NAM   1<<7
#define SLOG_USER_UID   1<<8
#define SLOG_ERR_EXT    1<<9
#define SLOG_DEBUG      1<<10

extern uint32 Log_Type;

/*-----------------------------------------------------------------*/

/* Timing values - coordination of system is sensitive to these values
 * Be careful if changing them.
 */

#define DEFAULT_TIME_LIMIT 60 * 60 /* secs */
#define VFY_TIMEOUT     4       /* total time for verify call */
#define VFY_RETRY       1       /* time between retries ie 4 attempts */
#define VFY_INTERVAL    4       /* Interval at which find_master is called */
#define CHECK_INTERVAL  2 * 60  /* Interval at which periodic_check is called */

/*-----------------------------------------------------------------*/

/* domain states */

#define DOM_MASTER      0x10
#define DOM_VERIFIED    0x1
#define DOM_WAS_MASTER  0x100 

/*-----------------------------------------------------------------*/
/* server state */

#define SRV_HACKED      0x2

/*-----------------------------------------------------------------*/
/* Licence request flags */

#define LRQ_REDIRECTED  0x2     /* allow two redirected requests */
#define LRQ_REREQUEST   0x4     /* set by client when instructed to retry */

/*-----------------------------------------------------------------*/
/* read permit/suspicious error codes */

#define PER_START       100
#define PER_SLOCK_MATCH 100     /* Server lockstring does not match server data */
#define PER_NO_ADDR     101     /* No host matching internet address */
#define PER_BADCOUNT    102     /* Illegal number of licences on allocation - hacked? */
#define PER_PLOCK_MATCH 103     /* Permit lockstring does not match product data */
#define PER_BADPOLICY   104     /* Illegal policy on allocation - hacked? */
#define PER_BADFILE     105     /* Unexpected EOF or missing keyword in permit */
#define PER_BADIADDR    106     /* Can't convert internet address in domain */
#define PER_CORRUPTDATA 107     /* Lock string error on allocation - hack? */
#define PER_BADDATE     108     /* Bad date format/Illegal date on allocation - hack? */
#define PER_DATE_SYNC   109     /* Bad encryption of N secrets from client - hack? */
#define PER_SRV_CHKSUM  110     /* Checksum error in server lockstrings while reading */
#define PER_PERM_CHKSUM 111     /* Checksum error in permit lockstring while reading */
#define PER_CHECKSUM    112     /* Checksum error when allocating - possible hack */
#define PER_BADNUM      113     /* Can't read a number */
#define PER_VERSION     114     /* Permit file version is wrong */
#define PER_NSERVERS    115     /* Too many servers */
#define PER_ALIAS       116     /* host not aliased to hqnserver */   
#define PER_BAD_ID      117     /* unique id of host doesn't match id in permit file */
#define PER_BADIADDRLN  118     /* Can't convert iaddress for locked node */
#define PER_MAX         118

/*-----------------------------------------------------------------*/

/* Catastrophic system errors */

#define LSYS_BADLICLIST         1000
#define LSYS_VFY_MASTER         1001    /* in ls_verify */
#define LSYS_NO_MASTER          1002
#define LSYS_BAD_ADDR           1003    /* in findserver */
#define LSYS_BAD_INDEX          1004    /* in ls_verify */

/*-----------------------------------------------------------------*/


#ifdef UNIX
extern ls_users_out *ls_users_1();
#endif

/* Version indices into ServerIDs list */

#define SVERSION_1_1    0
#define SVERSION_2_0    1

#ifdef UNIX
bool_t xdr_pfiledat();
#endif

/*----------- following are not transmitted -------------*/


/* a product permit -
 *** NB where indices are used rather than pointers this is because
 *** some data blocks are dynamically reallocated - BEWARE!
*/

#define LP_LASTLINK -1

typedef struct permit{
  uint32      handle;                 /* handle of this permit */
  uint32      pfile;                  /* index into pfile data */
  int32       next;                   /* index of possible other permit
                                       * for this product, else LP_LASTLINK */
  uint32      domain;                 /* index of domain of this product */
  int8        *lockstring;            /* ptr to permit data */
  uint32      isecret;                /* index of secret used to digest data */
  int32       publen, prodlen, verslen; /* string lengths */
  int8        *publisher;             /* pts into permit data string */
  int8        *product;               
  int8        *version;
  uint32      policy;                 /* policy flags */
  int32       nnodefix, nflotfix;     /* original settings */
  int32       nodelic, flotlic;       /* effective number of licenses */
  uint32      end_date, start_date;
  int32       update;                 /* update period in minutes */
  uint32      ndata;                  /* amount of client data in int32s */
  int32       *data_list;             /* ptr to client data */
  uint32      nlockfix;               /* original setting */
  uint32      nlocked;                /* effective locked nodes count */
  locknode    *lock_list;             /* ptr to locked node addresses */
  uint32      secrets[4];             /* secrets for this product */
  int32       tot_lic;                /* total number of licenses */
  license     **lic_list;             /* ptr to licenses allocated */
  int32       nodesleft, flotsleft;   /* counts of licenses out */
  uint32      crashout;               /* update time limit (secs)*/
  uint32      timelimit;              /* max license time (secs)*/
  int32       nexcluded;              /* number of excluded machines */
  uint32      *excluded;              /* ptr to list of excluded hosts */
  int32       nuserlocks;             /* number of user-locked licences */
  int32       *userlocks;             /* ptr to list of locked uid's */
  int32       nuserlevels;            /* number of user/access pairs */
  level       *userlevels;            /* ptr to list of user/access pairs */
  int32       ngrplevels;             /* number of group/access pairs */
  level       *grplevels;             /* ptr to list of group/access pairs */
} permit;



/* Data held on products found in permtfiles but whose domains do not
*  include the current host.
*/

typedef struct {
  char        *publisher;
  char        *product;
  uint32      domain;
  uint32      pfile;
} ex_permit;


#define PERMIT_NONE     0
#define PERMIT_STORED   1
#define PERMIT_EXTERN   2

/* data on other servers. NB hqnserver 0 is for localhost if used.
*  Hqnserver 1 is element 1 etc. Localhost is only used if server
*  is running on a host that is not aliased.
*/

#define HQNS_NOT_CONTACTED      0xffffffff
#define HQNS_NOT_MEMBER         -1

/* the server permit (1 only) */

typedef struct {
  char        **server_ids;           /* ->list of valid server version id's */
  int32       nhqnservers;            /* total hqnservers + localhost */
  hqnserver   *hqns;                  /* -> list of hqnservers */
  int32       who;                    /* this server's index. 0 is localhost */
  hqnserver   *me;                    /* -> my hqnserver data; */
  int8        *myhost;                /* host name of this server */
  int32       nproducts;              /* number of product permits */
  permit      *licptr;                /* ptr to permits */
  int32       nexproducts;            /* number of externally held permits */
  ex_permit   *exptr;                 /* -> list of external products */
  int32       npfiles;                /* number of permit files used */
  pfiledat    *pfiles;                /* ptr to data on each permit file*/
  uint32      hacked;                 /* not zero = suspicious condition */
} serv_permit;

/*-----------------------------------------------------------------*/
/****** macros ******/

#define is_policy( lp, p ) ((lp)->policy & (p))

/*-----------------------------------------------------------------*/

/***** function prototypes *****/

permit          *find_permit(ls_request_in *req, permit *lp);
ex_permit       *find_expermit(ls_request_in *req);

void            *ls_err_report( void *reply, uint32 errcode, int32 type, 
                                permit *lp, ex_permit *xp, int32  licn);

ls_request_out  *alloc_lic(ls_request_in       *request,
                           permit              *lp,
                           ls_request_out      *reply,
                           uint32              flags,
                           locknode            *pnode);

int             not_master(uint32         flags,
                           ls_domain      *domain,
                           permit         *lp,
                           ls_request_out *reply);

ls_request_out  *other_server(ex_permit   *xp,  ls_request_out *reply);
ls_request_out  *request_licence();
int32           expiry(permit *lp);
uint32          get_date(void);
locknode        *on_locknode( uint32 iaddr, permit *lp);
int32           node_lic_available( permit *lp, locknode *pnode);
locknode        *getfreenode(permit *lp, locknode *pnode);
uint32          access_level(permit *lp);
void            lsys_error(int32 ercode);
void            hackerr();
void            release_lic(license *lic, permit *lp, uint32 handle);
void            delete_product_lics(permit *lp);
void            delete_all_lics(permit *lp,  int32 nprods);
void            destroy_all(serv_permit *sp);
void            free_duds(permit *lp);
void            delete_domains(hqnserver *hqns);
void            delete_domain_lics(uint32 domindex);
void            delete_all_hqns(hqnserver *hqn, int32 n);
permit          *check_product(ls_admin_in  *in, ls_admin_out *out);

#ifdef UNIX
ls_verify_data  *call_verify(ls_verify_data *argp, CLIENT *clnt);
#endif

char            *addr2name( uint32 addr);
char            *uid2name(int32 uid);
char            *gid2name(int32 gid);

void            loglic(int32  pid, 
                       int32  uid,
                       uint32 iaddr,
                       int32  prodn, 
                       int32  licn,
                       uint32 prodlen,
                       char   *prodname,
                       char   *msg);

void            loglic_err( uint32 status,
                            permit      *lp,
                            ex_permit   *xp,
                            int32       licn);

void            adminlog(int32 productn,
                         char *format, char *msg,
                         void *val1, void *val2);

void            adm_status( ls_admin_out *out, uint32 val );
void            unhidesec(permit *lp, uint32 *ret);
void            clear_timer(void);
void            restore_timer(void);
uint32          readpermitvals(permit *lp, uint32 version);
int             slog_set(uint32 lev);
void            set_ids(struct svc_req *rq, ls_node_info *node);

void            validate_domains(int firsttime);
void            find_master(void);
hqnserver       *contact(uint32 addr);
ls_domain       *match_domain(ls_domain *dom, hqnserver *hqn);
hqnserver       *findserver(uint32 addr);
void            copy_domains( hqnserver   *hqns, ls_verify_data *in );
#ifdef UNIX
CLIENT          *get_clnt_handle( uint32 addr);
u_short          *ls_get_port(void *argp, CLIENT *clnt);
#endif
void            install_checker(void);
#endif
