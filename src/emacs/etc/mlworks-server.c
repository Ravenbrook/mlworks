/*	==== MLWORKS EMACS SERVER ====
 *
 *  Copyright (C) 1993 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This program is started as a subprocess under Emacs.  It creates a
 *  UNIX socket (see init_socket_path for info on the name) and then
 *  copies anything coming in on the socket to its standard output.
 *  Emacs evaluates it.  Errors are reported by sending error reporting code
 *  to Emacs.
 *
 *  The socket binding has its permissions set to SOCKET_MODE.  This can be
 *  used to prevents other users sending spurious commands to your Emacs.
 *
 *  Revision Log
 *  ------------
 *  $Log: mlworks-server.c,v $
 *  Revision 1.7  1999/03/20 16:28:55  mitchell
 *  Fix to work with RedHat 5.2
 *
 *  Revision 1.6  1996/11/06  12:44:24  stephenb
 *  [Bug #1719]
 *  change the location of the socket from $HOME/.mlworks-server
 *  to read MLWORKS_SERVER_FILE which defaults to /tmp/.$USER-mlworks-server
 *  to avoid problems with creating sockets on an Andrew file system.
 *
 *  Revision 1.5  1996/01/31  11:42:07  stephenb
 *  Make it work under Irix.  The main change being not to chmod
 *  the socket since for some reason this means that MLWorks cannot
 *  connect to the socket.  Also took the opportunity to clean up
 *  the signal handler code so that the body of the code only uses
 *  sigaction.
 *
 *  Revision 1.4  1996/01/26  09:20:59  stephenb
 *  Fix so that the read call taks account of the fact that it is
 *  reading from a socket.
 *
 *  Revision 1.3  1995/05/03  13:25:50  jont
 *  Conditionalise on OS type
 *  Now works hopefully of all unix platforms. Tested on Solaris and SunOS
 *
 *  Revision 1.2  1993/06/22  13:15:48  richard
 *  The socket name in the user's home directory is now removed when the
 *  server is killed, but only if it's the actual socket created by this
 *  server.
 *
 *  Revision 1.1  1993/03/15  14:23:27  richard
 *  Initial revision
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>		/* strcpy, strcat */
#include <errno.h>
#include <stdarg.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/un.h>
#include "syscalls.h"
#include <unistd.h>
extern char *sys_errlist[];

#define SOCKET_PREFIX "/tmp/."
#define SOCKET_SUFFIX "-mlworks-server"
#define SOCKET_MODE	(S_IFSOCK|S_IRUSR|S_IWUSR)
#define BUFFER_SIZE	4096

/* This next bit needs to be tidied up/removed */
#ifdef MLW_DEFINE_SIGACTION
#define S_IFSOCK        __S_IFSOCK
#define S_IFMT          __S_IFMT
#include <sigaction.h>
#endif

#ifdef MLW_USE_SIGVEC
/*
 * Some pre-POSIX systems don't support sigaction (or do so via optional
 * compatability libraries) but do support sigvec.  For our purposes
 * it is possible to pretend that sigvec is sigaction.
 */
#define sigaction sigvec
#define sa_handler sv_handler
#define sa_mask sv_mask
#define sa_flags sv_flags
#define sigemptyset(m) *(m)= 0 
#endif


/*  == Send error code to Emacs ==
 *
 *  This function packages up an error message in the form of printf() as an
 *  Emacs LISP expression to report the error.  If the code is non-zero the
 *  program is terminated with that code.
 */

static void error(int code, const char *format, ...)
{
  va_list arg;

  va_start(arg, format);
  fputs("(progn (message \"MLWorks server: ", stdout);
  vfprintf(stdout, format, arg);
  fputs("\") (ding))\n", stdout);
  va_end(arg);

  if(code)
    exit(code);
}


/*  == Socket information ==
 *
 *  The device and inode number are those of the created socket.  They are
 *  used in sigterm(), along with the name from the socket address.
 */

static dev_t device;
static ino_t inode;
static struct sockaddr_un sun;	/* socket address structure */


/*  == Termination signal handler ==
 *
 *  If the server is killed then it unlinks the socket it created in the
 *  user's home directory provided it is the same one it created, i.e., has
 *  the same device and inode number.
 */

static void sigterm()
{
  struct stat st;

  if(stat(sun.sun_path, &st))
  {
    if(errno != ENOENT)
      error(0, "Couldn't stat %s: %s", sun.sun_path, sys_errlist[errno]);
    exit(0);
  }

  if(st.st_dev == device && st.st_ino == inode)
    if(unlink(sun.sun_path))
      error(11, "Couldn't remove socket %s: %s",
	    sun.sun_path, sys_errlist[errno]);

  exit(0);
}



ssize_t readn(int fd, void *buff, size_t nbytes)
{
  size_t nleft, nread;

  nleft= nbytes;
  while (nleft > 0)
  {
    nread= read(fd, buff, nleft);
    if (nread < 0)
    {
      return nread;
    }
    else if (nread == 0)
    {
      break;
    }
    else
    {
      nleft -= nread;
      buff += nread;
    }
  }
  return nbytes-nleft;
}



/*
 * init_socket_path tries to fill in sun.sun_path with the
 * pathname of the socket.  It first tries MLWORKS_SERVER_FILE
 * and if this is not defined, it tries to construct a default
 * path of the form "/tmp/.$USER-mlworks-server".  If neither variable
 * is defined, it terminates the program with an error message since
 * it isn't clear whether it is worth defining yet another default to
 * cover this case.
 * 
 * Note that the method of determining the socket name must be kept
 * consistent with that used in the editor interface, see
 * <URI:hope://MLWsrc/unix/_editor.sml#getSocketName>
 */
static void init_socket_path(void)
{
  char const * s= getenv("MLWORKS_SERVER_FILE");
  if (s != NULL) {
    if (strlen(s) > sizeof(sun.sun_path)) {
      error(EXIT_FAILURE, "The socket file name defined by MLWORKS_SERVER_FILE is too long.");
    } else {
      (void)strcpy(sun.sun_path, s);
    }
  } else if ((s= getenv("USER")) != NULL) {
    size_t ul= strlen(s);
    size_t pl= sizeof(SOCKET_PREFIX)-1 + ul + sizeof(SOCKET_SUFFIX)-1;
    if (pl > sizeof(sun.sun_path)) {
      error(EXIT_FAILURE, "The socket file name defined by USER is too long.");
    } else {
      /* Not time critical, so strcat has lower maintenance overhead ... */
      strcpy(sun.sun_path, SOCKET_PREFIX);
      strcat(sun.sun_path, s);
      strcat(sun.sun_path, SOCKET_SUFFIX);
    }
  } else {
    error(EXIT_FAILURE, "Neither MLWORKS_SERVER_FILE nor USER are defined.");
  }
}




int main(void)
{
  int s;
  size_t sun_size;
  struct sigaction signal_handler;

  struct stat st;

  /* Read the HOME environment variable and check that it, plus the socket */
  /* base name, will fit into the socket naming structure. */

  memset(&sun, 0, sizeof(sun));
  init_socket_path();
  sun.sun_family = AF_UNIX;
  sun_size = sizeof(sun.sun_family) + strlen(sun.sun_path);

  s = socket(AF_UNIX, SOCK_STREAM, 0);
  if(s < 0)
    error(3, "Couldn't create socket: %s", sys_errlist[errno]);

  /* Before creating the socket name, set up termination signal handler to */
  /* remove it later. */
  signal_handler.sa_handler = sigterm;
  signal_handler.sa_flags= 0;
  sigemptyset(&signal_handler.sa_mask);
  if(sigaction(SIGTERM, &signal_handler, NULL) ||
     sigaction(SIGHUP, &signal_handler, NULL) ||
     sigaction(SIGINT, &signal_handler, NULL))
    error(0, "Couldn't set up signal handler: %s\n"
	     "Socket %s won't be removed.",
	  sys_errlist[errno], sun.sun_path); 

  if (bind(s, (struct sockaddr *)&sun, sun_size))
    switch (errno)
    {
      /* If the path is already in use try to find out what's occupying it. */
      /* If it's a socket, remove it and try again. */
      case EADDRINUSE:
      {
	struct stat st;
	if(stat(sun.sun_path, &st))
	  error(5, "Couldn't stat %s: %s", sun.sun_path, sys_errlist[errno]);
	if(!S_ISSOCK(st.st_mode))
	  error(6, "%s is in use and isn't a socket", sun.sun_path);
	if(unlink(sun.sun_path))
	  error(7, "Couldn't remove old socket %s: %s",
		sun.sun_path, sys_errlist[errno]);
	if(!bind(s, (struct sockaddr *)&sun, sun_size))
	  break;
      }

      default:
      error(4, "Couldn't bind socket to %s: %s",
		  sun.sun_path, sys_errlist[errno]);
    }

  /* Record the device and inode number for later reference. */

  if(stat(sun.sun_path, &st))
    error(13, "Couldn't stat %s: %s", sun.sun_path, sys_errlist[errno]);
  device = st.st_dev;
  inode = st.st_ino;

  if (listen(s, 5) != 0)
    error(EXIT_FAILURE, "Cannot listen ...");


#ifndef MLW_NO_SOCKET_PROTECTION
  /* Protect the socket. */
  if(chmod(sun.sun_path, SOCKET_MODE) != 0)
    error(0, "Unable to protect %s: %s", sun.sun_path, sys_errlist[errno]);
#endif

  for(;;)
  {
    struct {
      struct sockaddr_un addr;
      int                addr_len;
      int                fd;
    } mlworks;

    mlworks.addr_len= sizeof(mlworks.addr);
    mlworks.fd= accept(s, (struct sockaddr *)&mlworks.addr, &mlworks.addr_len);
    if(mlworks.fd < 0)
      error(9, "Couldn't accept from socket: %s", sys_errlist[errno]);

    for (;;)
    {
      ssize_t nread;
      char    msg_buf[BUFFER_SIZE];
      size_t  msg_len;

      if ((nread= readn(mlworks.fd, msg_buf, 2)) == 0)
	break;
      if (nread != 2) 
	error(EXIT_FAILURE, "Couldn't read message length: %s", sys_errlist[errno]);
      msg_len= ((unsigned char)msg_buf[0])*256 + (unsigned char)msg_buf[1];
      if (msg_len > BUFFER_SIZE)
	error(EXIT_FAILURE, "Message is too long");

      nread= readn(mlworks.fd, msg_buf, msg_len);
      if (nread != msg_len)
	error(EXIT_FAILURE, "Could not read message: %s", sys_errlist[errno]);

      if (write(STDOUT_FILENO, msg_buf, msg_len) != msg_len)
	error(EXIT_FAILURE, "Could not write message: %s", sys_errlist[errno]);
    }

    close(mlworks.fd);
  }

  return EXIT_SUCCESS;
}
