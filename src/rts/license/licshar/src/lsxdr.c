/*
 $Log: lsxdr.c,v $
 Revision 1.12  1999/01/04 09:03:09  jamesr
 [Bug #30447]
 modifications for NT

 * Revision 1.11  1994/05/23  14:10:35  chrism
 * add routines to release rpc memory
 *
 * Revision 1.10  1994/05/17  21:50:35  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
  1993-Oct-8-16:29 chrism
 	convert all longs to int32s for alpha
  1993-Apr-30-12:55 john
 	fix nested comment - clipper acc does not take it
 1993-Apr-19-17:24 chrism
   	remove users_in - now using a request_in
 1993-Feb-4-15:24 chrism
	changing to version 2
1992-Nov-17-12:11 chrism = changed rpc.h to local file for DEC
1992-Nov-6-12:10 chrism = added time field to node_info
1992-Nov-2-14:40 chrism = added ls_users
1992-Oct-16-13:23 chrism = adding std types
1992-Oct-7-12:27 chrism = Created
*/

#include "rpcwrap.h"
#include "lsrpc.h"
#include "lserver.h"
#include "lshared.h"
#include "lsadm.h"


#ifdef UNIX
bool_t xdr_ls_challenge_in(XDR *xdrs, ls_challenge_in *objp)
{
  if (!xdr_u_int(xdrs, &objp->reserved)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->secret)) {
    return (FALSE);
  }
  if (!xdr_bytes(xdrs, (char **)&objp->data.data_val, (u_int *)&objp->data.data_len, 16)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_challenge_out(XDR *xdrs, ls_challenge_out *objp)
{
  if (!xdr_opaque(xdrs, objp->data, 16)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_node_info(XDR *xdrs, ls_node_info *objp)
{
  if (!xdr_u_int(xdrs, &objp->hostid)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->iaddr)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->pid)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->time)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_domain(XDR *xdrs, ls_domain *objp)
{
  if (!xdr_array(xdrs, (char **)&objp->members.addr, 
                 (u_int *)&objp->members.size, ~0, 
                 sizeof(uint32), xdr_u_int)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->state)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->ncontacts)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->who)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->master)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_hqn_state(XDR *xdrs, ls_hqn_state *objp)
{
  if (!xdr_array(xdrs, (char **)&objp->domlist.dom, (u_int *)&objp->domlist.len, ~0, sizeof(ls_domain), xdr_ls_domain)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_request_in(XDR *xdrs, ls_request_in *objp)
{
  if (!xdr_string(xdrs, &objp->license_system, 64)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->publisher_name, 64)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->product_name, 64)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->product_version, 32)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->units_required)) {
    return (FALSE);
  }
  if (!xdr_ls_node_info(xdrs, &objp->node)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->flags)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->log_comment, ~0)) {
    return (FALSE);
  }
  if (!xdr_ls_challenge_in(xdrs, &objp->challenge)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_request_out(XDR *xdrs, ls_request_out *objp)
{
  if (!xdr_u_int(xdrs, &objp->status)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->units)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->handle)) {
    return (FALSE);
  }
  if (!xdr_pointer(xdrs, (char **)&objp->domain, sizeof(ls_domain), xdr_ls_domain)) {
    return (FALSE);
  }
  
  if (!xdr_ls_challenge_out(xdrs, &objp->challenge)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_update_in(XDR *xdrs, ls_update_in *objp)
{
  if (!xdr_u_int(xdrs, &objp->handle)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->units_consumed)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->units_required)) {
    return (FALSE);
  }
  if (!xdr_ls_node_info(xdrs, &objp->node)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->log_comment, ~0)) {
    return (FALSE);
  }
  if (!xdr_ls_challenge_in(xdrs, &objp->challenge)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_update_out(XDR *xdrs, ls_update_out *objp)
{
  if (!xdr_u_int(xdrs, &objp->status)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->units_available)) {
    return (FALSE);
  }
  if (!xdr_ls_challenge_out(xdrs, &objp->challenge)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_release_in(XDR *xdrs, ls_release_in *objp)
{
  if (!xdr_u_int(xdrs, &objp->handle)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->units)) {
    return (FALSE);
  }
  if (!xdr_ls_node_info(xdrs, &objp->node)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->log_comment, ~0)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_query_in(XDR *xdrs, ls_query_in *objp)
{
  if (!xdr_u_int(xdrs, &objp->handle)) {
    return (FALSE);
  }
  if (!xdr_ls_node_info(xdrs, &objp->node)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->infotype)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->bufsize)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_query_out(XDR *xdrs, ls_query_out *objp)
{
  if (!xdr_u_int(xdrs, &objp->status)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->value)) {
    return (FALSE);
  }
  if (!xdr_bytes(xdrs, (char **)&objp->data.data_val, (u_int *)&objp->data.data_len, ~0)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_verify_data(XDR *xdrs, ls_verify_data *objp)
{
  if (!xdr_int(xdrs, &objp->who)) {
    return (FALSE);
  }
  if (!xdr_pointer(xdrs, (char **)&objp->data, sizeof(ls_hqn_state), xdr_ls_hqn_state)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_msg_out(XDR *xdrs, ls_msg_out *objp)
{
  if (!xdr_u_int(xdrs, &objp->status)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->msg, ~0)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_users_out(XDR *xdrs, ls_users_out *objp)
{
  if (!xdr_u_int(xdrs, &objp->status)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->users.users_val, (u_int *)&objp->users.users_len, ~0, sizeof(licensep), xdr_licensep)) {
    return (FALSE);
  }
  return (TRUE);
}

void free_ls_request_out( ls_request_out *ptr)
{
  if( ptr ){
    xdr_free( xdr_ls_request_out, ptr );
    debug1( "freed ls_request_out" );
  }
}

void free_ls_update_out( ls_update_out *ptr )
{
  if( ptr ){
    xdr_free( xdr_ls_update_out, ptr );
    debug1( "freed ls_update_out" );
  }
}

void free_ls_query_out( ls_query_out *ptr)
{
  if( ptr ){
    xdr_free( xdr_ls_query_out, ptr );
    debug1( "freed ls_query_out" );
  }
}

void free_ls_msg_out( ls_msg_out *ptr )
{
  if( ptr ){
    xdr_free( xdr_ls_msg_out, ptr );
    debug1( "freed ls_msg_out" );
  }
}

void free_ls_users_out( ls_users_out *ptr )
{
  if( ptr ){
    xdr_free( xdr_ls_users_out, ptr );
    debug1( "freed ls_users_out" );
  }
}

void free_ls_verify_data( ls_verify_data *ptr )
{
  if( ptr ){
    xdr_free( xdr_ls_verify_data, ptr );
    debug1( "freed ls_verify_data" );
  }
}
#endif
