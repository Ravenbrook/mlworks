/* $HopeName: $
 *
 * $Log: lsadm.h,v $
 * Revision 1.14  1999/01/04 09:02:56  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.13  1994/05/17  21:51:43  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Nov-12-17:16 chrism
  	define LS_ADM_NO_ROOT for controllable root access and
  	debugging
   1993-Nov-11-13:46 chrism
  	add admin call for id
   1993-Oct-8-16:05 chrism
  	convert all longs to int32s for alpha
   1993-Sep-30-14:31 chrism
  	add log flags to server_data structure and change debug flag
  	to LOG flag
 1993-Jul-21-11:04 chrism
   	declare setwait
 1993-Jul-20-14:30 chrism
   	add function prototypes
 1993-Feb-9-15:45 chrism
	add user locks, user and group levels
 1993-Feb-4-15:20 chrism
	changing to version 2
1992-Nov-17-12:00 chrism = changed rpc.h to local file for DEC
1992-Nov-12-12:18 chrism = LS_ADMF_PERMIT
1992-Nov-2-13:53 chrism = added more functions
1992-Oct-23-15:02 chrism = Created

*/

#ifndef _LSADM_H
#define _LSADM_H

#include "rpc.h"
#include "lserver.h"

/* server index flag for master server */

#define LS_ADM_MASTER 0xffffffff
#define LS_ADM_ANY    0xfffffffe

/* Flag OR'd with the function type to disable root requirement */

#define LS_ADMF_UN_ROOT		0x4000

/* function/return types */

#define LS_ADMT_STATUS		0
#define LS_ADMF_PRODUCT		1
#define LS_ADMF_USERS		2
#define LS_ADMF_SERVER		3
#define LS_ADMF_SET_POLICY  	4
#define LS_ADMF_LOG		5
#define LS_ADMF_FREE		6
#define LS_ADMF_TIMEOUT		7
#define LS_ADMF_LOCK		8
#define LS_ADMF_UNLOCK		9
#define LS_ADMF_LTOF		10
#define LS_ADMF_FTOL		11
#define LS_ADMF_EXCLUDE		12
#define LS_ADMF_UNEXCLUDE	13
#define LS_ADMF_PERMITS		14
#define LS_ADMF_VALUE		15
#define LS_ADMF_ADDUSRLIC	16
#define LS_ADMF_REMUSRLIC	17
#define LS_ADMF_ADDUSRLEV	18
#define LS_ADMF_REMUSRLEV	19
#define LS_ADMF_ADDGRPLEV	20
#define LS_ADMF_REMGRPLEV	21
#define LS_ADMF_ID		22

/* function macro for debugging */
#ifndef DEBUG
#define serv_op( op ) (op)
#else
#define serv_op( op ) ((op) | LS_ADMF_UN_ROOT)
#endif

/* returned status values */

#define LS_ADM_OK		0
#define LS_ADM_NOT_ROOT		1
#define LS_ADM_BAD_PRODUCT	2
#define LS_ADM_BADFUNC		3
#define LS_ADM_NOT_MASTER	4
#define LS_ADM_BAD_SERVER	5
#define LS_ADM_NOT_ALLOWED  	6
#define LS_ADM_BAD_LICENSE	7
#define LS_ADM_BAD_CRASHT	8
#define LS_ADM_NOMEM		9
#define LS_ADM_FIXLOCK		10
#define LS_ADM_BAD_LOCK		11
#define LS_ADM_BADFCOUNT	12
#define LS_ADM_BADNCOUNT	13
#define LS_ADM_FIXNCOUNT	14
#define LS_ADM_BAD_EXC		15
#define LS_ADM_BAD_USER		16
#define LS_ADM_BAD_USRLEV	17
#define LS_ADM_BAD_GRPLEV	18

/* rpc structure definitions */

#ifdef UNIX
bool_t xdr_ls_admin_in(XDR *xdrs, ls_admin_in *objp);
bool_t xdr_ls_server_data(XDR *xdrs, ls_server_data *objp);
bool_t xdr_ls_product_data(XDR *xdrs, ls_product_data *objp);
bool_t xdr_ls_admin_out(XDR *xdrs, ls_admin_out *objp);
bool_t xdr_license(XDR *xdrs,license *objp);

bool_t xdr_level(XDR *xdrs, level *objp);
bool_t xdr_licensep(XDR *xdrs,licensep *objp);
bool_t xdr_ls_users_out(XDR *xdrs, ls_users_out *objp);

#define ls_admin ((uint32)7)
extern ls_admin_out *ls_admin_1(ls_admin_in *in, struct svc_req *rq);
#endif

#endif
