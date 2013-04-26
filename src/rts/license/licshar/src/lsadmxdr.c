/* $HopeName: $
 *
 * $Log: lsadmxdr.c,v $
 * Revision 1.13  1999/01/04 09:03:06  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.12  1994/05/23  14:10:15  chrism
 * add routines to release rpc memory
 *
 * Revision 1.11  1994/05/17  21:50:44  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Nov-11-13:47 chrism
        add xdr call for LS_ADMF_ID in xdr_ls_admin_out
   1993-Oct-8-16:07 chrism
        convert all longs to int32s for alpha
   1993-Sep-30-14:34 chrism
        add fields to pfiledat so that can get back error conditions
 1993-Feb-9-15:46 chrism
        add user locks, user and group levels
 1993-Feb-4-15:16 chrism
        changing to version 2
1992-Nov-17-12:01 chrism = changed rpc.h to local file for DEC
1992-Nov-12-12:20 chrism = added value field to admin_out
1992-Nov-2-14:47 chrism = added fields to ls_product_data
1992-Oct-20-17:43 chrism = Created

*/
#include "rpcwrap.h"
#include "lserver.h"
#include "lsadm.h"

#ifdef UNIX

bool_t xdr_ls_admin_in(XDR *xdrs, ls_admin_in *objp)
{
  if (!xdr_u_int(xdrs, &objp->func)) {
    return (FALSE);
  }
  if (!xdr_vector(xdrs, (char *)objp->data, 4, sizeof(uint32), xdr_u_int)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_addrs(XDR *xdrs, addrs *objp)
{
  if (!xdr_u_int(xdrs, &objp->hostid)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->iaddr)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_locknode( XDR *xdrs, locknode *objp)
{
  if (!xdr_addrs(xdrs, &objp->addr)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->nlic)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_pfiledat(XDR *xdrs, pfiledat *objp)
{
  if (!xdr_u_int(xdrs, &objp->permit_id)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->version)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->lockstring, ~0)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->path, ~0)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->errcode)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->value)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_level(XDR *xdrs, level *objp)
{
  if (!xdr_int(xdrs, &objp->id)) {
    return (FALSE);
  }
  if (!xdr_u_short(xdrs, &objp->level)) {
    return (FALSE);
  }
  return (TRUE);
}


bool_t xdr_ls_server_data(XDR *xdrs, ls_server_data *objp)
{
  if (!xdr_string(xdrs, &objp->license_system, 64)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nservers)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nproducts)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nexproducts)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->logflags)) {
    return (FALSE);
  }
  if (!xdr_pointer(xdrs, (char **)&objp->state, sizeof(ls_hqn_state), xdr_ls_hqn_state)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->pfiles.pfiles_val, (u_int *)&objp->pfiles.pfiles_len, ~0, sizeof(pfiledat), xdr_pfiledat)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_product_data(XDR *xdrs, ls_product_data *objp)
{
  if (!xdr_bytes(xdrs, (char **)&objp->pub.pub_val, (u_int *)&objp->pub.pub_len, 64)) {
    return (FALSE);
  }
  if (!xdr_bytes(xdrs, (char **)&objp->prod.prod_val, (u_int *)&objp->prod.prod_len, 64)) {
    return (FALSE);
  }
  if (!xdr_bytes(xdrs, (char **)&objp->vers.vers_val, (u_int *)&objp->vers.vers_len, 32)) {
    return (FALSE);
  }
  if (!xdr_string(xdrs, &objp->pfile, ~0)) {
    return (FALSE);
  }
  if (!xdr_pointer(xdrs, (char **)&objp->domain, sizeof(ls_domain), xdr_ls_domain)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->policy)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nlocklic)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nlockleft)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nflotlic)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->nflotleft)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->start)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->end)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->crashout)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->timeout)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->nodes.nodes_val, (u_int *)&objp->nodes.nodes_len, ~0, sizeof(locknode), xdr_locknode)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->exc.exc_val, (u_int *)&objp->exc.exc_len, ~0, sizeof( uint32), xdr_u_int)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->user.user_val, (u_int *)&objp->user.user_len, ~0, sizeof(int32), xdr_int)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->ulev.ulev_val, (u_int *)&objp->ulev.ulev_len, ~0, sizeof(level), xdr_level)) {
    return (FALSE);
  }
  if (!xdr_array(xdrs, (char **)&objp->glev.glev_val, (u_int *)&objp->glev.glev_len, ~0, sizeof(level), xdr_level)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_ls_admin_out(XDR *xdrs, ls_admin_out *objp)
{
  if (!xdr_int(xdrs, &objp->type)) {
    return (FALSE);
  }
  switch (objp->type) {
  case LS_ADMF_ID:
  case LS_ADMT_STATUS:
    if (!xdr_int(xdrs, &objp->ls_admin_out_u.status)) {
      return (FALSE);
    }
    break;
  case  LS_ADMF_PRODUCT:
    if (!xdr_ls_product_data(xdrs, &objp->ls_admin_out_u.product)) {
      return (FALSE);
    }
    break;
  case LS_ADMF_USERS:
    if (!xdr_array(xdrs, (char **)&objp->ls_admin_out_u.users.users_val, (u_int *)&objp->ls_admin_out_u.users.users_len, ~0, sizeof(licensep), xdr_licensep)) {
      return (FALSE);
    }
    break;
  case  LS_ADMF_SERVER:
    if (!xdr_ls_server_data(xdrs, &objp->ls_admin_out_u.server)) {
      return (FALSE);
    } 
    break;
  case LS_ADMF_VALUE:
    if (!xdr_u_int(xdrs, &objp->ls_admin_out_u.value)) {
      return (FALSE);
    }
    break;
                
  default:
    return (FALSE);
  }
  return (TRUE);
}

void free_ls_admin_out( ls_admin_out *ptr)
{
  if( ptr ){
    xdr_free( xdr_ls_admin_out, ptr );
  }
}
#endif
