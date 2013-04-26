/* $HopeName: $
 *
 * $Log: permit.h,v $
 * Revision 1.8  1999/01/04 09:03:02  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.7  1994/12/01  12:36:26  chrism
 * [Bug #3625]
 * \nDone verifying.
 * \\nchange MAX_LICENCES to something reasonable
 *
 * Revision 1.6  1994/05/17  21:51:24  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Oct-8-16:31 chrism
        change hide_index to return uint32*
   1993-Sep-29-16:44 chrism
        correct return type of buildname for gcc
   1993-Sep-9-12:20 chrism
        declare perror routines
   1993-Sep-9-12:10 chrism
        declare perror routines
   1993-Sep-9-11:54 chrism
        change read_permit, read_server_permit and read_product_permit
        to return int for error checking
 1993-Mar-3-17:41 chrism
        change return type of getenv to char*
 1993-Feb-9-15:47 chrism
        added user locking and access levels
 1993-Feb-4-15:19 chrism
        changing to version 2
1992-Nov-12-12:19 chrism = added read_pfiles
1992-Nov-5-13:06 chrism = changed makepermit prototypes. added KEY values for
1992-Nov-5-13:06 chrism + hqn_ep etc
1992-Nov-2-16:44 chrism = removed date policy - now obligatory
1992-Nov-2-15:20 chrism = added policies and routines for multiple permits
1992-Oct-19-14:58 chrism = added readuhex
1992-Oct-16-18:18 chrism = added check_aliases
1992-Oct-16-13:47 chrism = added std types
1992-Oct-8-19:42 chrism = add comments
1992-Oct-7-14:47 chrism = Created

*/
/* permit.h */

#ifndef __PERMIT_H
#define __PERMIT_H

#include "std.h"      /* uint32 */
#include "fwfile.h"   /* FwFile */
#include "fwstring.h" /* FwStrRecord */
#include "fwstream.h" /* FwObj */

#include "lstruct.h"  /* assorted ls structures */
#include "lsrpc_st.h" /* more ls structures */

/* number of standard directories where server looks for permit */

#define NSTDIRS 5

/* Policy Flags */

#define POL_GRAB_CRASH          1
#define POL_1_PER_NODE          1 << 1
#define POL_TIME_LIMIT          1 << 2
#define POL_LOCKS_NOLIMIT       1 << 3
#define POL_LOCKS_NO_FLOAT      1 << 4
#define POL_LOCK_PRIORITY       1 << 5
#define POL_USERS_VISIBLE       1 << 6
#define POL_USER_LOCKS          1 << 7
#define POL_ACCESS_LEVEL        1 << 8

#define POLFIX_GRAB_CRASH       POL_GRAB_CRASH << 16
#define POLFIX_1_PER_NODE       POL_1_PER_NODE << 16
#define POLFIX_TIME_LIMIT       POL_TIME_LIMIT << 16
#define POLFIX_LOCKS_NOLIMIT    POL_LOCKS_NOLIMIT << 16
#define POLFIX_LOCKS_NO_FLOAT   POL_LOCKS_NO_FLOAT << 16
#define POLFIX_LOCK_PRIORITY    POL_LOCK_PRIORITY << 16
#define POLFIX_USERS_VISIBLE    POL_USERS_VISIBLE << 16
#define POLFIX_USER_LOCKS       POL_USER_LOCKS << 16
#define POLFIX_ACCESS_LEVEL     POL_ACCESS_LEVEL << 16


#define MAX_BUF_SIZE 1024 * 4
#define MAX_LINE_LEN 128
#define MAX_FILENAME 256
#define N_SERVER_SECRETS 20
#define MAX_CHALVALS 128

#define MAX_SERVERS 20
#define MAX_LICENSES 10000
#define CRYPTLEN 25
/* for version 1.1 only */
#define LOCKLEN 2 * 24 + 1

#define MAX_PROD_ID 12

/**** These Keys are used by hqn_ep to hide the product secrets  ****/

#define EPKEY1 0x389add0c
#define EPKEY2 0x102faa47
#define EPKEY3 0x2cba9646
#define EPKEY4 0x7f46838a

/**** These are part of the data in the permit for hqn_mp ****/

#define PKEY1  0x19DF33BD
#define PKEY2  0x5AF314B3
#define PKEY3  0x7AC068CE
#define PKEY4  0x6B53959C

/**** These are used by hqn_mp to obtain the EPKEYS to obtain the real secrets ****/

#define MPKEY1 (EPKEY1 ^ PKEY1)
#define MPKEY2 (EPKEY2 ^ PKEY2)
#define MPKEY3 (EPKEY3 ^ PKEY3)
#define MPKEY4 (EPKEY4 ^ PKEY4)

typedef struct {
  int8   id[ MAX_PROD_ID + 1 ];
  int8   *pub, *prod, *vers;
  uint32 secret[4];
  int32  done;
} prod_data;

typedef struct {
  addrs        node;          /* hostid only set if in pfile or sent */
  ls_hqn_state data;          /* domains and associated state */
  char         *name;          /* primary name of this hqnserver */
} hqnserver;

/* permit_block holds permit data temporarily while reading files */

typedef struct {
  FwObj       *input;                 /* input stream */
  pfiledat    *pf;                    /* -> data on current permitfile */
  int32       pfindex;                /* index of permitfile being read */
  hqnserver   *me;                    /* -> host details and domains */
 
  FwStrRecord buff;                   /* holds complete text for signature */
  uint32      domainbuf[ MAX_SERVERS + 1 ]; /* temp buff for domain */
  /* these _really are_ uint8's and not characters */
  uint8       sindex[sizeof(uint32)*4];       /* holds secret indices */
  uint8       *sindexp;               /* -> current index in sindex */
  int32       nproducts;              /* n products in permit file */
  int32       nservers;               /* size of domain */
  FwRawByte   *publisher;             /* -> start of permit strings */
  int32       publen, prodlen, verslen; /* lengths of strings in buff */
  int32       in_domain;              /* true if current host is in domain */
  uint32      domain;                 /* domain index of current permitfile */
} permit_block;

/* createpermit routines */

/* TODO ansify */

/* these shouldn't really be in licshar */

/* int             make_permit();
int32           readnlines();
char            *buildname();
void            readable();
void            set_indices();
void            output_lock();
uint32          *hide_index();
uint32          *hidesec();
prod_data       *readproducts();
void            usage();
prod_data       *find_product(); */


/* readpermit routines */

/* char    *getenv(); */

void    read_pfiles(void);
int     read_permit( FwObj * pDataStream, int32 pfindex, FwStrRecord* pName);
int     read_server_permit(permit_block *pb);
int     read_product_permit(permit_block *pb);
int32   store_permit(permit_block *pb, int8 *buf_ptr);
void    store_expermit(permit_block *pb);
void    ignore_permit(permit_block *pb);
uint32  set_domain(permit_block *pb);
int     found_previously( permit_block *pb, uint32 *p);
int     match_file_id( permit_block *pb, uint32 p );
void    link_permit(uint32 p, int32  index);
        
int     unread(FwRawByte *cp1, uint32 *lp1, uint32 *lp2, uint32  version);
void    unreadlock();
void    unhide_index( uint32 *buf, uint8  *index);
void    last_pferror(void);
int     pferror(int32 pfindex, int32 errnum);
int     pferror_msg();
int     pferror_val(int32 pfindex, int32 errnum,  int32 val);

int32   readsnumber(FwTextString str);
uint32  readunumber(FwTextString str);
uint32  readuhex(FwTextString str);
uint32  readdate(char *str);

void    *reallocmemq(void *ptr, uint32 n);
void    *allocmemq( uint32 n);
void    freememq(void *ptr);

void    mem_err(void);
void    checkpos( FwTextString s1, FwTextString s2);

#endif


