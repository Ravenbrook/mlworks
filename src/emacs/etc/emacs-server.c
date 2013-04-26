/**************************************************************************
***
***  emacs-server.c  - forked by emacs, listen for find-file's 
***  ---------------------------------------------------------
***
***  SCCS ID: 92/04/07 11:51:36 2.2 emacs-server.c
***
***  Copyright (C) 1991 Claus Bo Nielsen
**************************************************************************/

#ifndef lint
static char      *_Version = "@(#)92/04/07 11:51:36, 2.2 emacs-server.c";
#endif

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
#include <sys/time.h>
#include <netdb.h>
#include <stdio.h>
#include <malloc.h>
#include <signal.h>

#include "se.h"				  /* here we defind mutual things  */


static int     debug = DEBUG;		  /* are we debugging?             */
static int     file_socket = FALSE;	  /* use unix file socket          */
static int     acceptsock;		  /* The connected socket port     */
static FILE   *confp;			  /* the console file pointer      */
static char   *port_path = NULL;

static int     SigInt();		  /* signal handler                */


/***************************************************************************/
int   main(argc, argv)
int   argc;
char *argv[];
/***************************************************************************/
{
   int                ch;
   int                sock;
   int                length;
   struct hostent    *hp, *gethostbyname();
   extern char       *optarg;
   extern int         optind;
   struct sockaddr_in server;
   struct sockaddr_un server_un;
   
   signal(SIGINT, SigInt);

   while ((ch = getopt(argc, argv, "dfp:u")) != -1)
      switch(ch)
      {
      case 'd':
	 debug = TRUE;
	 break;
      case 'p':
	 port_path = optarg;
	 break;
      case 'f':
	 file_socket = TRUE;
	 break;
      case 'u':
      case '?':
	 PrintUsage();
	 exit(0);
	 break;
      }

   /* We open the console for error messages */
   if ((confp = fopen("/dev/console", "a")) == NULL)
   {
      fprintf(stderr,"Can't_fopen_console");
      exit(0);
   }

   if (file_socket)			  /* use UNIX socket */
   {
      sock = socket(AF_UNIX, SOCK_STREAM, 0);
      
      server_un.sun_family = AF_UNIX;
      if (port_path == NULL)
	  strcpy(server_un.sun_path, SOCKET_PATH);
      else
      {
	 if (debug)
	    fprintf(confp, "Using file %s for unix socket\n", port_path);
	 
	 strcpy(server_un.sun_path, port_path);
      }
      
      if (bind(sock, (struct sockaddr *)&server_un, sizeof(server_un)) == -1)
	 err("115 Can't get socket path (remove file %s??)",
	     (port_path == NULL ? SOCKET_PATH : port_path));
      
      listen(sock, 5);
   }
   else					  /* use inet socket */
   {
      sock = socket(AF_INET, SOCK_STREAM, 0);
      
      server.sin_family = AF_INET;
      server.sin_addr.s_addr = INADDR_ANY;
      if (port_path == NULL)
	 server.sin_port = SOCKET_PORT;
      else
	 server.sin_port = atoi(port_path);
      
      if (bind(sock, (struct sockaddr *)&server, sizeof(server)) == -1)
	{
	  close(sock);
	  err("132 Can't bind socket");
	}
      
      listen(sock, 5);
   }
   
   while(1)				  /* just do this forever */
   {
      if (debug)
	 fprintf(confp,"Waiting for some one to call ... ");
      
      if ((acceptsock = accept(sock, (struct sockaddr *)0, (int *)0)) < 0)
	 err("143 Accept failed");
      
      if (debug)
	 fprintf(confp,"Yep! - got it\n");
      
      GetMessageAndSendEmacs();		  /* OK - get file path(s) and send */
      
      close(acceptsock);		  /* we're all done! */
   }
}


/*****************************************************************************/
int GetMessageAndSendEmacs()		  /* get file path(s) and send emacs */
/*****************************************************************************/
{
   char               filepath[PATH_LENGTH];
   char              *elisp;
   int                length;
   
   while(1)				  /* for all files to come */
   {
      memset(filepath, '\0', PATH_LENGTH); /* clear the old one */
      
      if (read(acceptsock, &length, 4) != 4)
	 err("168 Transmission error");

   	 
      if (length == ELISP_EXP)
      {
	 if (read(acceptsock, &length, 4) != 4)
	    err("174 Transmission error");
	 
	 elisp = (char *)calloc(length+1, 1);
	 
	 if (debug)
	    fprintf(confp,"Got a elisp expression of length %d\n", length);
	 
	 if (read(acceptsock, elisp, length) != length)
	    err("182 Transmission error");

	 fprintf(stderr,"%s", elisp);	  /* print it out */
	 free(elisp);
	 usleep(WAIT_TIME);		  /* wait for emacs (1/2 sec.) */
	 continue;
      }
      
      if (length == -1)
	 break;

      if (length >= PATH_LENGTH)	  /* we don't have room for it */
	 err("194 File path too long");

      if (read(acceptsock, filepath, length) != length)
	 err("197 Transmission error");

      if (debug)
	 fprintf(confp,"File path: %s\n", filepath);

      fprintf(stderr,"%s", filepath);	  /* send file path to emacs */
      usleep(WAIT_TIME);		  /* wait for emacs (1/2 sec.) */
   }
   return(0);
}


/***************************************************************************/
static int SigInt()
/***************************************************************************/
{
   unlink(SOCKET_PATH);			  /* remove the socket file   */
   unlink(port_path);
   
   exit(0);
}


/***************************************************************************/
int err(s, arg1, arg2)			  /* send error message to console */
char *s;
int arg1;
int arg2;
/***************************************************************************/
{
   char   str[120];

   strcpy(str, "Error - emacs-server.c:");
   strcat(str, s);
   
   fprintf(confp, str, arg1, arg2);
   exit(1);
}


/***************************************************************************/
int PrintUsage()			  /* print usage on stdout         */
/***************************************************************************/
{
   fprintf(stderr,"emacs-server version: 2.2 (92/04/07 11:51:36)\n");
   fprintf(stderr,"Usage: emacs-server [-d][-f][-p<port/path>]\n");
   fprintf(stderr," -d             : debug information\n");
   fprintf(stderr," -f             : use UNIX socket (other path in -p)\n");
   fprintf(stderr," -p <port/path> : port no or file path to use, default %d or %s\n", SOCKET_PORT, SOCKET_PATH);
}


