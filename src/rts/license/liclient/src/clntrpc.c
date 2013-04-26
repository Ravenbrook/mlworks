/*
 $Log: clntrpc.c,v $
 Revision 1.11  1994/05/27 10:56:41  chrism
 add definitions for symbol obfuscation

 * Revision 1.10  1994/05/17  21:52:16  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
  1994-May-12-17:03 chrism
 	update has a longer timeout 
  1993-Oct-8-16:36 chrism
 	change longs to int32s for alpha
  1993-Jun-3-18:12 john
 	make it work on clipper
  1993-Jun-3-17:58 john
 	make it work on clipper
  1993-Apr-30-12:54 john
 	fix nested comment - clipper acc does not take it
 1993-Apr-19-17:18 chrism
   	remove users_in - now using a request_in
1993-Feb-4-15:35 chrism
	changing to version 2
1992-Dec-18-06:22 chrism = remove lshide.h
1992-Dec-18-05:22 chrism = obscure symbol table
1992-Nov-17-11:18 chrism = move rpc.h into local file for DEC
1992-Nov-3-14:41 davide = fails to compile because of inclusion of time.h
1992-Nov-2-14:54 chrism = added msg and users interface
1992-Oct-20-12:18 chrism = added std types
1992-Oct-7-17:19 chrism = Created

*/
#ifdef CLIPPER
/* On the clipper, <rpc/xdr.h> which is included by <rpc/rpc.h> which
   is included by "rpc.h" uses FILE*. */
#include <stdio.h>
#endif
#include "lshide.h"
#include "rpc.h"
#include "std.h"
#include "lserver.h"

#ifdef CLIPPER
#include <sys/time.h>
#endif

/* Default timeout is changed using clnt_control() */
extern  struct timeval Retry_Timeout;
extern  struct timeval Update_Retry_Timeout;

ls_request_out *
ls_request_1(argp, clnt)
	ls_request_in *argp;
	CLIENT *clnt;
{
	static ls_request_out res;

	bzero((int8 *)&res, sizeof(res));
	if (clnt_call(clnt, ls_request, xdr_ls_request_in, argp, xdr_ls_request_out, &res, Retry_Timeout) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}


ls_update_out *
ls_update_1(argp, clnt)
	ls_update_in *argp;
	CLIENT *clnt;
{
	static ls_update_out res;

	bzero((int8 *)&res, sizeof(res));
	if (clnt_call(clnt, ls_update, xdr_ls_update_in, argp, xdr_ls_update_out, &res,
		      Update_Retry_Timeout) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}


ls_query_out *
ls_query_1(argp, clnt)
	ls_query_in *argp;
	CLIENT *clnt;
{
	static ls_query_out res;

	bzero((int8 *)&res, sizeof(res));
	if (clnt_call(clnt, ls_query, xdr_ls_query_in, argp, xdr_ls_query_out, &res, Retry_Timeout) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}


uint32 *
ls_release_1(argp, clnt)
	ls_release_in *argp;
	CLIENT *clnt;
{
	static uint32 res;

	bzero((int8 *)&res, sizeof(res));
	if (clnt_call(clnt, ls_release, xdr_ls_release_in, argp, xdr_u_int, &res, Retry_Timeout) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&res);
}


ls_msg_out *
ls_message_1(argp, clnt)
        uint32 *argp;
        CLIENT *clnt;
{
        static ls_msg_out res;

        bzero((char *)&res, sizeof(res));
        if (clnt_call(clnt, ls_message, xdr_u_int, argp, xdr_ls_msg_out, &res,Retry_Timeout) != RPC_SUCCESS) {
                return (NULL);
        }
        return (&res);
}

ls_users_out *
ls_users_1(argp, clnt)
    ls_request_in *argp;
    CLIENT *clnt;
{
    static ls_users_out res;

    bzero((char *)&res, sizeof(res));
    if (clnt_call(clnt, ls_users, xdr_ls_request_in, argp, xdr_ls_users_out, &res, Retry_Timeout ) != RPC_SUCCESS) {
	return (NULL);
    }
    return (&res);
}

