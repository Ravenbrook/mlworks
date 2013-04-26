/* $HopeName: $
 *
 * $Log: lsrpc.h,v $
 * Revision 1.13  1999/01/04 09:03:01  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.12  1994/05/23  14:09:42  chrism
 * add definition for routines to release rpc memory
 *
 * Revision 1.11  1994/05/17  21:51:17  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Oct-8-16:28 chrism
  	convert all longs to int32s for alpha
 1993-Feb-4-15:19 chrism
	changing to version 2
1992-Nov-17-12:10 chrism = changed rpc.h to local file for DEC
1992-Nov-6-12:10 chrism = added time field to node_info
1992-Nov-2-14:27 chrism = added ls_users
1992-Oct-19-16:46 chrism = added PROGRAMNUMBER
1992-Oct-16-13:23 chrism = add std types
1992-Oct-7-12:36 chrism = Created

*/

/* lsrpc.h - data structures and declarations for rpc routines
*   (created initially by rpcgen)
*/

#ifndef _LSRPC_H
#define _LSRPC_H

#include "rpc.h"
#include "lsapi.h"
#include "lstruct.h"
#include "lsrpc_st.h"

#define LICENSEWORKS ((uint32) PROGRAMNUMBER)
#define LICENSEWORKS_VERSION ((uint32)1)

#ifdef UNIX

/* UNIX RPC stuff */

bool_t xdr_ls_challenge_in(XDR *xdrs, ls_challenge_in *objp);
bool_t xdr_ls_challenge_out(XDR *xdrs, ls_challenge_out *objp);
bool_t xdr_ls_node_info(XDR *xdrs, ls_node_info *objp);
bool_t xdr_ls_domain(XDR *xdrs, ls_domain *objp);
bool_t xdr_ls_hqn_state(XDR *xdrs, ls_hqn_state *objp);
bool_t xdr_ls_request_in(XDR *xdrs, ls_request_in *objp);
bool_t xdr_ls_request_out(XDR *xdrs, ls_request_out *objp);
bool_t xdr_ls_update_in(XDR *xdrs, ls_update_in *objp);
bool_t xdr_ls_update_out(XDR *xdrs, ls_update_out *objp);
bool_t xdr_ls_release_in(XDR *xdrs, ls_release_in *objp);
bool_t xdr_ls_query_in(XDR *xdrs, ls_query_in *objp);
bool_t xdr_ls_query_out(XDR *xdrs, ls_query_out *objp);
bool_t xdr_ls_verify_data(XDR *xdrs, ls_verify_data *objp);
bool_t xdr_ls_msg_out(XDR *xdrs, ls_msg_out *objp);

#define ls_request ((uint32)1)
extern ls_request_out *ls_request_1(ls_request_in  *request, struct svc_req *rq);

#define ls_update ((uint32)2)
extern ls_update_out *ls_update_1(ls_update_in *update, struct svc_req *rq);

#define ls_query ((uint32)3)
extern ls_query_out *ls_query_1(ls_query_in *query, struct svc_req *rq);

#define ls_release ((uint32)4)
extern uint32 *ls_release_1(ls_release_in  *release, struct svc_req *rq);

#define ls_verify ((uint32)5)
extern ls_verify_data *ls_verify_1(ls_verify_data *in, struct svc_req *rq);

#define ls_message ((uint32)6)
extern ls_msg_out *ls_message_1( LS_STATUS_CODE *in, struct svc_req *rq);

#define ls_users ((uint32)8)

#define ls_ping ((uint32)9)
extern int32 *ls_ping_1(int32 *in);

void free_ls_request_out(ls_request_out *ptr);
void free_ls_update_out(ls_update_out *ptr);
void free_ls_query_out(ls_query_out *ptr);
void free_ls_msg_out(ls_msg_out *ptr);
void free_ls_users_out(ls_users_out *ptr);
void free_ls_verify_data(ls_verify_data *ptr);
void free_ls_admin_out(ls_admin_out *ptr);

#endif

#endif
