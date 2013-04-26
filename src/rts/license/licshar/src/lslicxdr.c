/* $HopeName: $
 *
 * $Log: lslicxdr.c,v $
 * Revision 1.6  1999/01/04 09:03:08  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.5  1994/05/17  21:50:41  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Oct-8-16:27 chrism
        convert all longs to int32s for alpha
 1993-Feb-4-15:23 chrism
        changing to version 2
1992-Nov-17-12:10 chrism = changed rpc.h to local file for DEC
1992-Oct-29-17:21 chrism = Created

*/

#include "rpcwrap.h"
#include "lsrpc.h"
#include "lsadm.h"


#ifdef UNIX

/* These routines are shared by the server, the admin utility and clients */

bool_t xdr_licensep(XDR *xdrs,licensep *objp)
{
  if (!xdr_pointer(xdrs, (char **)objp, sizeof(license), xdr_license)) {
    return (FALSE);
  }
  return (TRUE);
}

bool_t xdr_license(XDR *xdrs, license *objp)
{
  if (!xdr_addrs(xdrs, &objp->node)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->flags)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->inode)) {
    return (FALSE);
  }
  if (!xdr_int(xdrs, &objp->uid)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->pid)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->start)) {
    return (FALSE);
  }
  if (!xdr_u_int(xdrs, &objp->last)) {
    return (FALSE);
  }
  return (TRUE);
}

#endif
