/*  ==== DYNAMIC DATA EXCHANGE for Win32 ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This provides some low-level support for DDE in MLworks.  This is
 *  likely to be replaced by a FI implementation.
 *
 *  Revision Log
 *  ------------
 *  $Log: dde_lib.c,v $
 *  Revision 1.6  1998/03/30 15:13:55  jont
 *  [Bug #70086]
 *  Add a request function for use by the Windows structure
 *
 * Revision 1.5  1998/03/27  18:57:24  jont
 * [Bug #30090]
 * Fix further problem with perv_exn_ref_io (oops)
 *
 * Revision 1.4  1998/03/23  16:06:36  jont
 * [Bug #30090]
 * Replace use of MLWorks.IO.Io with syserr
 *
 * Revision 1.3  1997/07/15  15:50:15  johnh
 * [Bug #30124]
 * Add web location function for use by help menu.
 *
 * Revision 1.2  1996/07/05  10:33:47  stephenb
 * pack_dde_info: remove bogus declare_root
 *
 * Revision 1.1  1996/04/16  16:44:38  brianm
 * new unit
 * New file.
 *
 * */

#include <windows.h>
#include <ddeml.h>
#include <time.h>
#include <math.h>
#include <shellapi.h>

#include "mltypes.h"
#include "allocator.h"
#include "environment.h"
#include "exceptions.h"
#include "values.h"
#include "tags.h"
#include "utils.h"
#include "words.h"
#include "gc.h"
#include "dde_lib.h"


/*   ==== DDE Interface ====

We provide some basic C-level operators 

     - start a DDE dialog
     - send a DDE execute string
     - stop a DDE dialog

This basic repertoire is the minimal required to set up an interface
to simple server applications accepting particular execute strings.

*/

#define TICKS_PER_MSEC    (CLOCKS_PER_SEC / 1000)  /* ticks per millisecond */

#define TIMEOUT_SYNC     500

#define POSNUM(x)  ((x > 0) ? x : 0)

/* ==== DDE info data type ==== */

typedef struct _dde_info {
   /* DDE Initialize parameters */
   DWORD         idInst;    
   PFNCALLBACK   callbackFn;
   DWORD         afCmd;

   /* DDE Connect conversation parameters */
   HSZ           hszService;
   HSZ           hszTopic;
   HCONV         hConv;
} dde_info;


/* ==== Utilities ==== */

static HSZ dde_string (DWORD, char *);
static void dde_error (DWORD, char *, char *);
static void dde_error_action (DWORD, char *, char *);
static mlval pack_dde_info (dde_info *);
static dde_info *unpack_dde_info (mlval);
static void pause (long int);
static void print_dde_info (dde_info *);

/* ==== `The' callback function ====
  
The DDE service supported here is restricted to:

  - standard (i.e non-monitoring)
  - client only
  - ignoring all notifications

Callbacks are used almost exclusively by DDE servers - there are only
a few occasions when a client needs to handle events via the callback
function.  Hence, we only need to deal with the following transaction
types:

  XTYP_ERROR
  - something went wrong ....

  XTYP_ADVDATA
  - data has been received from a server as part of
  a client request advise loop.  Such events result from
  data in the server having changed.

  Since we restrict clients not to enter advise loops, this cannot
  arise in any of our conversations - in any event, we return
  DDE_FNOTPROCESSED to reject the transaction.

  XTYPE_XACT_COMPLETE
  - asynchronous transaction has been completed.  But our clients cannot
  initiate asynchronous transactions - so we return 0.
*/

static HDDEDATA
       std_dde_callback_fn
          ( UINT     wType,
            UINT     wFmt,
            HCONV    hConv,
            HSZ      hsz1,
            HSZ      hsz2,
            HDDEDATA hData,
            DWORD    dwData1,
            DWORD    dwData2
          )
{
   switch (wType & XTYP_MASK) {
   case XTYP_ADVDATA       :
        return ( DDE_FNOTPROCESSED );

   case XTYP_XACT_COMPLETE : return (0);
        
   case XTYP_ERROR         :
        switch (dwData1 & 0xffff) {
        case DMLERR_LOW_MEMORY :
             exn_raise_syserr(ml_string("DML error - DDE running out of memory"), 0);
	default :
             exn_raise_syserr(ml_string("General DML error"), 0);
        };

   default : return(0);
   };
}


/* ==== Main definitions ==== */


static mlval start_dde_dialog (mlval arg)
{
   DWORD        idInst;
   HCONV        hConv;
   dde_info     *info;
   HSZ          serviceName, topicName;

   /* Allocate the DDE info */
   info = malloc(sizeof(dde_info));

   if (NULL == info)
     exn_raise_syserr(ml_string("start_dde_dialog : Couldn't allocate DDE info. object"), 0);

   info -> callbackFn = (PFNCALLBACK)std_dde_callback_fn;
   info -> afCmd =
        APPCLASS_STANDARD         |
        CBF_SKIP_ALLNOTIFICATIONS | 
        APPCMD_CLIENTONLY;

   idInst = 0;

   switch (DdeInitialize(&idInst,info -> callbackFn,info -> afCmd,0L)) {
   case DMLERR_NO_ERROR : break;

   case DMLERR_INVALIDPARAMETER :
        exn_raise_syserr (ml_string("start_dde_dialog : DdeInitialize - bad parameter"), DMLERR_INVALIDPARAMETER);

   case DMLERR_DLL_USAGE :
        exn_raise_syserr (ml_string("start_dde_dialog : DdeInitialize - DLL failed"), DMLERR_DLL_USAGE);

   case DMLERR_SYS_ERROR :
        exn_raise_syserr (ml_string("start_dde_dialog : DdeInitialize - system error"), DMLERR_SYS_ERROR);
   };

   info -> idInst = idInst;

   serviceName = dde_string( idInst,  CSTRING( FIELD(arg,0) ) );
   topicName   = dde_string( idInst,  CSTRING( FIELD(arg,1) ) );

   info -> hszService = serviceName;
   info -> hszTopic   = topicName;


   hConv = DdeConnect(idInst,serviceName,topicName,NULL);

   if ((HCONV)NULL == hConv)
     { dde_error (idInst, "start_dde_dialog", "DdeConnect"); };

   info -> hConv = hConv;

   return (pack_dde_info(info));
}


static mlval send_dde_command (mlval arg, DWORD type)
{
   dde_info *info;
   char *cmd;
   long int busy_retry_delay, retry, busy_retry;

   HDDEDATA   result;
   HCONV      hConv;
   DWORD      idInst;
   DWORD      error;

   info             = unpack_dde_info(  FIELD(arg,0) );

   cmd              = CSTRING(          FIELD(arg,1) );
   retry            = CINT(             FIELD(arg,2) );
   busy_retry_delay = CINT(             FIELD(arg,3) );

   retry = POSNUM( retry );
   busy_retry_delay = POSNUM( busy_retry_delay );

   busy_retry = ((busy_retry_delay > 0) && (retry > 0)) ? 1 : 0;

   hConv = info -> hConv;
   idInst = info -> idInst;

   while (retry >= 0) {
      retry--;

      result = DdeClientTransaction (
		   (LPBYTE)cmd,  /* The command to be sent ...          */
		   strlen(cmd),  /* Size of the command                 */
		   hConv,        /* Conversation being used             */
		   0L,           /* handle to item name - not needed    */
		   0,            /* clipboard data format - not needed  */
		   type,         /* Type of transaction */
		   TIMEOUT_SYNC, /* timeout                             */
		   NULL);        /* transaction result pointer - unused */

      if ((HDDEDATA)NULL != result) { retry = -1; }
      else
         { error = DdeGetLastError (idInst); 
	   switch ( error ) {
	   case DMLERR_BUSY :
	       if (1 == busy_retry && retry >= 0)
		  { pause(busy_retry_delay);
		    break;
		  };
	   default :
	       dde_error_action(error,"send_dde_execute_string","DdeClientTransaction");
	   };
         };
   };

   return MLUNIT;
}

static mlval send_dde_execute_string (mlval arg)
{
  return send_dde_command(arg, XTYP_EXECUTE);
}

static mlval send_dde_request_string (mlval arg)
{
  return send_dde_command(arg, XTYP_REQUEST);
}

static mlval stop_dde_dialog (mlval arg)
{
   dde_info   *info;
   HCONV      hConv;
   DWORD      idInst;

   info = unpack_dde_info( arg );

   hConv = info -> hConv;
   idInst = info -> idInst;


   if (FALSE == DdeDisconnect( hConv ))
       { dde_error( idInst,"stop_dde_dialog","DdeDisconnect"); };

   if (FALSE == DdeFreeStringHandle( idInst, info -> hszService ))
       { dde_error( idInst,"stop_dde_dialog","DdeFreeStringHandle"); };

   if (FALSE == DdeFreeStringHandle( idInst, info -> hszTopic ))
       { dde_error( idInst,"stop_dde_dialog","DdeFreeStringHandle"); };

   free( info );

   return ((mlval)MLUNIT );
}



/* 
 * netscape_dde_link:  Netscape is already running so use it to 
 *   show the specified web location.
 *
 *  Ddeinitialize;
 *  openURL = DdeConnect("netscape", "WWW_openURL");
 *  DdeClientTransaction(openURL, request, <http file to open>);
 *  activate = DdeConnect("netscape", "WWW_Activate");
 *  DdeClientTransaction(activate, request, "");
 *  return; 
 */

void netscape_dde_link(HCONV openConv, 
		       DWORD idInst, 
		       HSZ serviceName, 
		       const char filename[])
{
  HDDEDATA result;
  HSZ itemstr, topicName;
  HCONV actConv;
  char const activate_args[] = "0xFFFFFFFF,0x0";
  char open_url_args[MAX_PATH + 20];
    
  /* open_url_args stores the arguments that are passed to the DDE topic
   * WWW_OpenURL.  See netscape DDE documentation for more details.
   * The 0xFFFFFFFF value instructs Netscape to use the last active
   * window, and if there is no last active window, Netscape attempts
   * to create a new window.
   */
    
  sprintf(open_url_args, "%s,,0xFFFFFFFF,0x0,,,", filename); 
  itemstr = DdeCreateStringHandle(idInst, open_url_args, CP_WINANSI);
  if (itemstr == 0L) 
    dde_error(idInst, "open_web_location", "DdeCreateStringHandle");
  
  result = DdeClientTransaction((LPBYTE)NULL, 
				0, 
				openConv,       
				itemstr,     
				CF_TEXT,           
				XTYP_REQUEST,
				TIMEOUT_SYNC,
				NULL);       
  if ((HDDEDATA)NULL == result)
    dde_error(idInst, "open_web_location", "DdeClientTransaction");
  
  if (DdeFreeStringHandle(idInst, itemstr) == 0)
    dde_error(idInst, "open_web_location", "DdeFreeStringHandle");
  if (DdeDisconnect(openConv) == 0) 
    dde_error(idInst, "open_web_location", "DdeDisconnect");
  
  topicName = dde_string(idInst,"WWW_Activate");
  
  actConv = DdeConnect(idInst, serviceName, topicName, NULL);
  if (actConv == 0L)
    dde_error(idInst, "open_web_location", "DdeConnect");
  if (DdeFreeStringHandle(idInst, serviceName) == 0)
    dde_error(idInst, "open_web_location", "DdeFreeStringHandle");
  if (DdeFreeStringHandle(idInst, topicName) == 0)
    dde_error(idInst, "open_web_location", "DdeFreeStringHandle");
  
  itemstr = DdeCreateStringHandle(idInst, activate_args, CP_WINANSI);
  if (itemstr == 0L) 
    dde_error(idInst, "open_web_location", "DdeCreateStringHandle");
  
  result = DdeClientTransaction((LPBYTE)NULL,
				0, 
				actConv,       
				itemstr,
				CF_TEXT,
				XTYP_REQUEST,
				TIMEOUT_SYNC,
				NULL);       
  if ((HDDEDATA)NULL == result)
    dde_error(idInst, "open_web_location", "DdeClientTransaction");
  
  if (DdeFreeStringHandle(idInst, itemstr) == 0)
    dde_error(idInst, "open_web_location", "DdeFreeStringHandle");
  if (DdeDisconnect(actConv) == 0) 
    dde_error(idInst, "open_web_location", "DdeDisconnect");      
  
  if (DdeUninitialize(idInst) == 0)
    exn_raise_syserr(ml_string("open_web_location: DdeUninitialize failed"), 0);
}



/* 
 * netscape_location:  tries to connect to a Netscape window which 
 *   is already running using dde commands, and if it fails it calls
 *   ShellExecute which either starts Netscape and displays the 
 *   specified web location or starts another web browser.
 */

void netscape_location(const char* filename)
{
  PFNCALLBACK callbackFn;
  DWORD       afCmd, idInst;
  HSZ         serviceName, topicName;
  HCONV       openConv;
  int         result;

  callbackFn = (PFNCALLBACK)std_dde_callback_fn;
  afCmd =
    APPCLASS_STANDARD         |
    CBF_SKIP_ALLNOTIFICATIONS | 
    APPCMD_CLIENTONLY;
  idInst = 0;
  
  result = DdeInitialize(&idInst, callbackFn, afCmd, 0L);  
  if (result != DMLERR_NO_ERROR)
    exn_raise_syserr(ml_string("open_web_location: DdeInitialize failed"), 0);
  
  serviceName = dde_string(idInst, "NETSCAPE");
  topicName   = dde_string(idInst, "WWW_OpenURL");
  
  openConv = DdeConnect(idInst, serviceName, topicName, NULL);

  if (DdeFreeStringHandle(idInst, topicName) == 0)
    dde_error(idInst, "open_web_location", "DdeFreeStringHandle");

  if ((HCONV)NULL == openConv) {
    /* Either Netscape doesn't exist or is not running, so can just use 
     * ShellExecute, which will either start Netscape manually or start 
     * another web browser, eg. MS Internet Explorer.
     */
    if (DdeUninitialize(idInst) == 0)
      exn_raise_syserr(ml_string("open_web_location: DdeUninitialize failed"), 0);
    if (((int)ShellExecute(0, "open", filename, 0, 0, SW_NORMAL)) <= 32) 
      dde_error(idInst, "open_web_location", "ShellExecute");
  } else {
    netscape_dde_link(openConv, idInst, serviceName, filename);
  }

}



/* 
 * open_web_location:  attempts to open a web browser at the specified location.
 * 
 * if Web Browser exists (FindExcecutable) then 
 *   call netscape_location(<name of html file to open>)
 * else  
 *   raise system error - browser could not be opened - why?
 *
 * return;
 */

static mlval open_web_location(mlval arg)
{
  char        ignored_exestr[MAX_PATH], *filename;
  int         result;

  filename = CSTRING(arg);

  /* if FindExecutable succeeds the return value is greater than 32,
   * otherwise it returns a value indicating the type of error it failed by.
   */
  if ((result = (int)FindExecutable(filename, "", ignored_exestr)) > 32)
    netscape_location(filename);
  else
    switch (result) {
    case 0:
      exn_raise_syserr(ml_string("The system is out of memory or resources"), 0);
      break;
    case 31:
      exn_raise_syserr(ml_string("There is no association for the specified file type"), 0);
      break;
    case ERROR_FILE_NOT_FOUND:
      exn_raise_syserr(ml_string("HTML file not found"), 0);
      break;
    case ERROR_PATH_NOT_FOUND:
      exn_raise_syserr(ml_string("HTML path not found"), 0);
      break;
    case ERROR_BAD_FORMAT:
      exn_raise_syserr(ml_string("HTML: bad exe format"), 0);
      break;
    default:
      exn_raise_syserr(ml_string("Loading html page: unknown error"), 0);      
    }
    
  return MLUNIT;
}

static HSZ dde_string (DWORD idInst, char *str)
{

   if (strlen(str) <= 0)
     { return((HSZ)0L); }
   else 
     return( DdeCreateStringHandle(idInst,str,CP_WINANSI) );
}

static void raise_dde_error (char *fn_name, char *lib_fn_name, char *msg)
{
  mlval error_string = format_to_ml_string("%s : %s - %s", fn_name, lib_fn_name, msg);
  exn_raise_syserr(error_string, 0);
}

static void dde_error_action ( DWORD error, char *fn_name, char *lib_fn )
{
    switch ( error ) {
    case DMLERR_ADVACKTIMEOUT :
      raise_dde_error(fn_name,lib_fn,"synch. advise transaction timed out");
      break;

    case DMLERR_BUSY :
      raise_dde_error(fn_name,lib_fn,"busy transaction flag set");
      break;

    case DMLERR_DATAACKTIMEOUT :
      raise_dde_error(fn_name,lib_fn,"synch. request transaction timed out");
      break;

    case DMLERR_DLL_NOT_INITIALIZED :
      raise_dde_error(fn_name,lib_fn,"DDEML not initialised");
      break;

    case DMLERR_EXECACKTIMEOUT :
      raise_dde_error(fn_name,lib_fn,"synch. execute transaction timed out");
      break;

    case DMLERR_INVALIDPARAMETER :
      raise_dde_error(fn_name,lib_fn,"bad parameter to library function (various causes)");
      break;

    case DMLERR_LOW_MEMORY :
      raise_dde_error(fn_name,lib_fn,"low memory (caused by server outrunning client)");
      break;

    case DMLERR_MEMORY_ERROR :
      raise_dde_error(fn_name,lib_fn,"memory allocation failed");
      break;

    case DMLERR_NO_CONV_ESTABLISHED :
      raise_dde_error(fn_name,lib_fn,"no conversation established");
      break;

    case DMLERR_NOTPROCESSED :
      raise_dde_error(fn_name,lib_fn,"transaction failed");
      break;

    case DMLERR_POKEACKTIMEOUT :
      raise_dde_error(fn_name,lib_fn,"synch. poke transaction timed out");
      break;

    case DMLERR_POSTMSG_FAILED :
      raise_dde_error(fn_name,lib_fn,"an internal call to PostMessage failed");
      break;

    case DMLERR_REENTRANCY :
      raise_dde_error(fn_name,lib_fn,"reentrant synch. transaction attempted");
      break;

    case DMLERR_SERVER_DIED :
      raise_dde_error(fn_name,lib_fn,"partner has died");
      break;

    case DMLERR_SYS_ERROR :
      raise_dde_error(fn_name,lib_fn,"internal DDEML system error");
      break;

    case DMLERR_UNADVACKTIMEOUT :
      raise_dde_error(fn_name,lib_fn,"request to terminate advise transaction timed out");
      break;

    case DMLERR_UNFOUND_QUEUE_ID :
      raise_dde_error(fn_name,lib_fn,"invalid transaction identifier passed to DDEML");
      break;
    };
}

static void dde_error (DWORD idInst, char *fn_name, char *lib_fn )
{
   dde_error_action (DdeGetLastError (idInst), fn_name, lib_fn);
}


static mlval pack_dde_info (dde_info *pinfo)
{
   mlval object;

   object = allocate_word32();
   num_to_word32((unsigned long)pinfo, object);

   return(object);
}

static dde_info *unpack_dde_info(mlval arg)
{
   dde_info *pinfo;

   pinfo = (dde_info *)word32_to_num(arg);
   return(pinfo);
}  


static void pause (long int time)
{
   clock_t stop;
   unsigned x = 0;

   if (0 == time) return;

   stop = clock() + (clock_t)ceil(time / TICKS_PER_MSEC);

   while (clock() < stop) { x = x++; };

}

static void print_dde_info(dde_info *info)
{
   DWORD idInst ;
   PFNCALLBACK callbackFn ;
   DWORD  afCmd ;

   HSZ     hszService ;
   HSZ     hszTopic ;
   HCONV   hConv ;

   idInst     = info -> idInst;
   callbackFn = info -> callbackFn;
   afCmd      = info -> afCmd;

   hszService = info -> hszService;
   hszTopic   = info -> hszTopic;
   hConv      = info -> hConv;

   printf("\nDDE Info object (0x%x)\n", (unsigned long)info);
   printf("  info -> idInst     = %i (0x%x)\n", (long)idInst, (unsigned long)idInst);
   printf("  info -> callbackFn = %i (0x%x)\n", (long)callbackFn, (unsigned long)callbackFn);
   printf("  info -> hszService = %i (0x%x)\n", (long)hszService, (unsigned long)hszService);
   printf("  info -> hszTopic   = %i (0x%x)\n", (long)hszTopic, (unsigned long)hszTopic);
   printf("  info -> hConv      = %i (0x%x)\n\n", (long)hConv, (unsigned long)hConv);

}

extern void dde_init(void)
{
  env_function("dde start dialog",         start_dde_dialog);
  env_function("dde send execute string",  send_dde_execute_string);
  env_function("dde send request string",  send_dde_request_string);
  env_function("dde stop dialog",          stop_dde_dialog);
  env_function("win32 open web location",  open_web_location);
}
