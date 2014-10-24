/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * An interface to UNIX.  This is is not a full interface to all the system
 * calls, let alone all the libraries.  It is just an interface to those
 * routines which at some point have been needed on the ML side.
 *
 * This is a synthesis of and replaces OS/{Irix,Linux,Solaris,SunOS}/unix.c
 *
 * Since all the systems don't support the same facilities, this file contains
 * the default implementation for each feature.  If the feature is not
 * supported on all systems, then the default implementation is wrapped in
 *
 *  #ifndef MLW_OVERRIDE_<FEATURE>
 *  ...
 *  #endif
 *
 * so that it can be replaced by a version defined in $OS/unixlocal.c
 * which must exist for each Unix OS supported.
 *
 * For historic reasons most of the functions are prefixed by unix_, but
 * there is a rolling program to change the prefix to mlw_ to avoid any
 * namespace collision problems.  Note that the change isn't strictly
 * necessary for static functions/values but for consistency these should
 * have the mlw_ prefix too.
 *
 * Revision Log
 * ------------
 *
 * $Log: unix.c,v $
 * Revision 1.37  1999/03/22 17:04:12  mitchell
 * [Bug #30286]
 * Support for the Unix structure
 *
 * Revision 1.36  1999/03/20  16:19:16  daveb
 * [Bug #190523]
 * OS.Process.status is now a Word32.word.
 *
 * Revision 1.35  1999/03/17  12:10:48  daveb
 * [Bug #190521]
 * Type of OS.FileSys.readDir has changed.
 *
 * Revision 1.34  1999/01/25  17:58:26  johnh
 * Make changes for the Unix structure.
 *
 * Revision 1.33  1998/09/30  15:06:54  jont
 * [Bug #70108]
 * Ensure syscalls.h included before time.h because of Red Hat 5 stupidities
 *
 * Revision 1.32  1998/09/17  14:30:21  jont
 * [Bug #30108]
 * Move dummy definitions os asm_trampoline from unix.c into os.c
 *
 * Revision 1.31  1998/09/16  15:15:45  jont
 * [Bug #70174]
 * Modify type of parse_command_line to fix compiler warnings
 *
 * Revision 1.30  1998/09/16  11:16:28  jont
 * [Bug #30108]
 * Add parse_command_line
 *
 * Revision 1.29  1998/08/18  11:40:21  jont
 * [Bug #70153]
 * Add prototype for system_validate_ml_address
 *
 * Revision 1.28  1998/08/17  11:07:27  jont
 * [Bug #70153]
 * Add system_validate_ml_address
 *
 * Revision 1.27  1998/07/02  14:55:17  jont
 * [Bug #70132]
 * Add signals_finalise
 *
 * Revision 1.26  1998/02/23  18:48:50  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.25  1997/11/09  17:53:59  jont
 * [Bug #30089]
 * Modify unix_rusage to return ru_utime and ru_stime as basis times
 *
 * Revision 1.24  1997/08/19  15:14:01  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.23  1997/06/27  13:18:45  stephenb
 * [Bug #30029]
 * make mlw_raise_syserr an extern so it can be used elsewhere.
 *
 * Revision 1.22  1997/05/22  08:44:06  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.21  1997/03/21  17:23:20  andreww
 * [Bug #1968]
 * make stdIn, stdOut and stdErr refs.
 *
 * Revision 1.20  1997/03/18  11:00:58  andreww
 * [Bug #1431]
 * Changing call name of POSIX.Error.errorMsg/Name to make it
 * compatible with win32 implementation.
 *
 * Revision 1.19  1996/08/06  13:15:54  stephenb
 * Remove MLW_OVERRIDE_READLINK stuff since it is not needed
 * with gcc-2.7.2.
 *
 * Revision 1.18  1996/08/06  12:42:33  stephenb
 * Correct some of the #include comments.
 *
 * Revision 1.17  1996/07/17  11:48:47  andreww
 * Altering the order of arguments given to the lseek system call.
 *
 * Revision 1.16  1996/07/15  09:12:39  andreww
 * Removing system-specific information from the names of the calls
 * to read, write, seek and close.
 *
 * Revision 1.15  1996/07/10  09:56:02  stephenb
 * remove unnecessary declare/retract roots, particularly
 * those surrounding any use of mlw_option_make_some.
 *
 * Revision 1.14  1996/07/04  09:32:37  stephenb
 * Aargh!  Why o why did I check in the previous version before
 * compiling it first.  I missed out a ")" :-<
 *
 * Revision 1.13  1996/07/04  09:19:55  stephenb
 * Add some missing declare/retract_root calls.
 * Specifically to mlw_posix_file_sys_return_stat.
 *
 * Revision 1.12  1996/06/19  09:45:23  stephenb
 * Ensure that rewinddir raises OS.SysErr when applied to a closed dirstream.
 *
 * Revision 1.11  1996/06/18  15:51:59  stephenb
 * Make stat/lstat raise an exception when given "".
 * Strictly speaking the test is only needed under SunOS, all the other
 * Unix varieties do the test, but for the sake of a test it isn't
 * worth creating a SunOS specific version of these functions.
 *
 * Revision 1.10  1996/06/10  15:35:41  stephenb
 * Fix creat and umask calls so as to remove signed/unsigned warnings.
 *
 * Revision 1.9  1996/06/10  13:03:31  stephenb
 * Implement POSIX.FileSys.{openf,creatf,creat} in order to support
 * basis IO.
 *
 * Revision 1.8  1996/06/10  10:23:11  andreww
 * expose unix IO constants to ML system.
 *
 * Revision 1.7  1996/05/30  08:41:55  stephenb
 * unix_init: add a call to mlw_timer_init.
 *
 * Revision 1.6  1996/05/28  11:53:08  stephenb
 * Add support for OS.errorName and OS.syserror
 *
 * Revision 1.5  1996/05/16  14:37:17  stephenb
 * Add support for OS.errorMsg
 * Also finish of the implementation of OS.FileSys.
 *
 * Revision 1.4  1996/05/07  11:36:37  stephenb
 * Add support for OS.IO
 *
 * Revision 1.3  1996/04/17  10:04:21  stephenb
 * Add various routines to support OS_PROCESS as defined in the latest basis.
 *
 * Revision 1.2  1996/04/01  11:14:19  stephenb
 * Rationalise exception handling so that all routines that raise
 * exceptions raise the same one -- this being one that is compatible
 * with OS.SysErr as defined in the latest basis.
 *
 * Revision 1.1  1996/02/20  10:19:27  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/unix.c
 *
 * Revision 1.4  1996/02/19  15:48:09  nickb
 * unix_environment memoizes the Unix environment. This is not
 * necessary: we can do it in ML if we decide it's a good idea.
 *
 * Revision 1.3  1996/02/16  12:51:13  nickb
 * Change to declare_global().
 *
 * Revision 1.2  1996/01/30  17:27:29  stephenb
 * Add <sys/socket.h>
 *
 * Revision 1.1  1996/01/30  14:51:45  stephenb
 * new unit
 * This is a synthesis of and replaces all the unix.c files for each
 * variety of Unix supported by MLWorks.  It presents an idealised
 * interface to Unix.  It is supported in this by the unixlocal.[ch]
 * files in each Unix dialects directories.
 *
 */

#include "unix.h"
#include "mltypes.h"
#include "values.h"		/* FIELD, MLTAIL, cons ... etc.*/
#include "allocator.h"		/* allocate_record, ml_string */
#include "gc.h"
#include "exceptions.h"		/* exn_raise_syserr */
#include "utils.h"		/* alloc */
#include "environment.h"	/* env_function ... etc. */
#include "global.h"		/* declare_global */
#include "mlw_syserr.h"		/* mlw_raise_syserr */
#include "time_date.h"          /* mlw_time_make */
#include "signals.h"		/* signals_finalise */
#include <assert.h>		/* assert */
#include <errno.h>		/* errno */
#include <string.h>
#include <stdlib.h>
#include <unistd.h>		/* read, write, readlink, ... etc. */
#include <sys/param.h>		/* MAXPATHLEN, realpath */
#include <sys/types.h>		/* mode_t ... */
#include <sys/wait.h>		
#include <sys/stat.h>		/* mkdir, chmod, umask, S_ISDIR, ... */
#include <dirent.h>		/* opendir, ... etc. */
#include <fcntl.h>		/* open, creat, O_RDONLY, ... */
#include <sys/ioctl.h>		/* FIONREAD */
#include <pwd.h>		/* struct passwd */
#include <utime.h>		/* utime, utimbuf */

#include "syscalls.h"
#ifndef MLW_OVERRIDE_RUSAGE
#include "mltime.h"		/* ml_time */
#include <sys/time.h>
#include <sys/resource.h>
#endif

#include <sys/socket.h>
#include <sys/un.h>
#include "unixlocal.h"
#include "time_date.h"		/* mlw_time_make,mlw_time_sec,mlw_time_usec */
#include "time_date_init.h"	/* mlw_time_date_init */
#include "mlw_timer_init.h"	/* mlw_timer_init */
#include "os_io_poll.h"		/* mlw_os_poll_io_init */
#include "os_errors.h"		/* mlw_os_error_name, mlw_os_syserror */
#include "os.h"			/* Prototype for system_validate_ml_address */

extern char **environ;		/* why isn't this in a standard header file? */

static int mlw_path_max;

static mlval unix_exn_ref_would_block;

/*
 * The following are only here until the standard Socket library is defined
 * and then they will be replaced by that.
 */
static mlval unix_af_unix;
static mlval unix_af_inet;
static mlval unix_sock_stream;
static mlval unix_sock_dgram;

/*
 * The following are deprecated.  They are here to support the old style
 * unix_open call which has now been superceded by various POSIX.FileSys
 * routines.
 */

static mlval unix_o_rdonly;
static mlval unix_o_wronly;
static mlval unix_o_creat;
static mlval unix_o_append;
static mlval unix_o_trunc;

/*
 * These are not initialised here so that they will end up in the BSS
 * rather than the data section and so save a small amount of space
 * at the expense of a miniscule amount of initialisation time.
 */
static mlval mlw_posix_file_sys_o_append;
static mlval mlw_posix_file_sys_o_excl;
static mlval mlw_posix_file_sys_o_noctty;
static mlval mlw_posix_file_sys_o_nonblock;
static mlval mlw_posix_file_sys_o_sync;
static mlval mlw_posix_file_sys_o_trunc;

#define SOCKADDR_BUFFER		sizeof(struct sockaddr_un)


/* The box and unbox functions duplicate code in x.c,
 * and probably win32.c and windows.c (although
 * Windows uses a different C compiler.
 */

static inline mlval box(unsigned long int x)
{
  mlval b = allocate_string(sizeof(x));

  memcpy(CSTRING(b), (char *)&x, sizeof(x));

  return(b);
}

static inline unsigned long int unbox(mlval b)
{
  unsigned long int x;

  memcpy((char *)&x, CSTRING(b), sizeof(x));

  return(x);
}

/*
 * OS.errorMsg : syserror -> string
 *
 */
static mlval mlw_os_error_msg(mlval arg)
{
  int error_code= CINT(arg);
  char const * error_message= strerror(error_code);
  return ml_string(error_message);
}

void mlw_raise_syserr(int i)
{
  exn_raise_syserr(ml_string(strerror(i)), i);
}

static mlval unix_environment(mlval unit)
{
  mlval result = MLNIL;
  int i;

  declare_root(&result, 0);

  for(i=0; environ[i] != NULL; ++i) {
    mlval poo = ml_string(environ[i]);
    /* Do not inline this function call */
    /* C is too stupid to realise that it should evaluate parameters */
    /* before building the arguments to a function */
    result = cons(poo, result);
  }
  retract_root(&result);
  return result;
}

#ifndef MLW_OVERRIDE_RUSAGE
static mlval unix_rusage(mlval unit)
{
  struct rusage ru;
  mlval utime, stime, result;

  if(getrusage(RUSAGE_SELF, &ru))
    mlw_raise_syserr(errno);

  utime = mlw_time_make(ru.ru_utime.tv_sec, ru.ru_utime.tv_usec);
  declare_root(&utime, 0);
  stime = mlw_time_make(ru.ru_stime.tv_sec, ru.ru_stime.tv_usec);
  declare_root(&stime, 0);

  result = allocate_record(16);
  retract_root(&utime);
  retract_root(&stime);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * idrss	integral resident set size
   * inblock	block input operations
   * isrss	currently 0
   * ixrss	currently 0
   * majflt	page faults requiring physical I/O
   * maxrss	maximum resident set size
   * minflt	page faults not requiring physical I/O
   * msgrcv	messages received
   * msgsnd	messages sent
   * nivcsw	involuntary context switches
   * nsignals	signals received
   * nswap	swaps voluntary
   * nvcsw	context switches
   * oublock	block output operations
   * stime	system time used
   * utime	user time used
   */

  FIELD(result,  0) = MLINT(ru.ru_idrss);
  FIELD(result,  1) = MLINT(ru.ru_inblock);
  FIELD(result,  2) = MLINT(ru.ru_isrss);
  FIELD(result,  3) = MLINT(ru.ru_ixrss);
  FIELD(result,  4) = MLINT(ru.ru_majflt);
  FIELD(result,  5) = MLINT(ru.ru_maxrss);
  FIELD(result,  6) = MLINT(ru.ru_minflt);
  FIELD(result,  7) = MLINT(ru.ru_msgrcv);
  FIELD(result,  8) = MLINT(ru.ru_msgsnd);
  FIELD(result,  9) = MLINT(ru.ru_nivcsw);
  FIELD(result, 10) = MLINT(ru.ru_nsignals);
  FIELD(result, 11) = MLINT(ru.ru_nswap);
  FIELD(result, 12) = MLINT(ru.ru_nvcsw);
  FIELD(result, 13) = MLINT(ru.ru_oublock);
  FIELD(result, 14) = stime;
  FIELD(result, 15) = utime;

  return(result);
}
#endif

/*
 * Deprecated.  Use on of POSIX.FileSys.{openf,creatf,creat} instead.
 */
static mlval unix_open(mlval arg)
{
  int fd = open(CSTRING(FIELD(arg, 0)),
		CINT(FIELD(arg, 1)),
		CINT(FIELD(arg, 2)));

  if (fd == -1)
    mlw_raise_syserr(errno);

  return MLINT(fd);
}

static mlval unix_socket(mlval arg)
{
  int fd = socket(CINT(FIELD(arg, 0)),
		  CINT(FIELD(arg, 1)),
		  CINT(FIELD(arg, 2)));
  if (fd == -1)
    mlw_raise_syserr(errno);
  return MLINT(fd);
}

static mlval unix_bind(mlval arg)
{
  size_t length;
  struct sockaddr_un un;

  length = strlen(CSTRING(FIELD(arg, 1)));
  if (length > sizeof(un.sun_path))
    mlw_raise_syserr(EINVAL);

  un.sun_family = AF_UNIX;
  memcpy(&un.sun_path, CSTRING(FIELD(arg, 1)), length);

  if (bind(CINT(FIELD(arg, 0)),
	   (struct sockaddr *)&un,
	   (int) (sizeof(un.sun_family)+length)) == -1)
    mlw_raise_syserr(errno);

  return MLUNIT;
}

static mlval unix_connect(mlval arg)
{
  size_t length;
  struct sockaddr_un un;

  length = strlen(CSTRING(FIELD(arg, 1)));
  if (length > sizeof(un.sun_path))
    mlw_raise_syserr(EINVAL);

  un.sun_family = AF_UNIX;
  memcpy(&un.sun_path, CSTRING(FIELD(arg, 1)), length);

  if (connect(CINT(FIELD(arg, 0)),
	      (struct sockaddr *)&un,
	      (int)(sizeof(un.sun_family)+length)) == -1)
    mlw_raise_syserr(errno);

  return MLUNIT;
}

static mlval unix_getsockname(mlval arg)
{
  char buffer[SOCKADDR_BUFFER];
  int namelen = SOCKADDR_BUFFER;
  struct sockaddr *sa = (struct sockaddr *)buffer;
  struct sockaddr_un *un = (struct sockaddr_un *)buffer;
  mlval result;
  size_t length;

  if (getsockname(CINT(arg), sa, &namelen))
    mlw_raise_syserr(errno);

  if (sa->sa_family != AF_UNIX)
    mlw_raise_syserr(EINVAL);

  length = namelen - sizeof(un->sun_family);
  result = allocate_string(length+1);
  memcpy(CSTRING(result), un->sun_path, length);
  CSTRING(result)[length] = '\0';

  return result;
}

static mlval unix_getpeername(mlval arg)
{
  char buffer[SOCKADDR_BUFFER];
  int namelen = SOCKADDR_BUFFER;
  struct sockaddr *sa = (struct sockaddr *)buffer;
  struct sockaddr_un *un = (struct sockaddr_un *)buffer;
  mlval result;
  size_t length;

  if (getpeername(CINT(arg), sa, &namelen))
    mlw_raise_syserr(errno);

  if (sa->sa_family != AF_UNIX)
    mlw_raise_syserr(EINVAL);

  length = namelen - sizeof(un->sun_family);
  result = allocate_string(length+1);
  memcpy(CSTRING(result), un->sun_path, length);
  CSTRING(result)[length] = '\0';

  return result;
}

static mlval unix_accept(mlval arg)
{
  char buffer[SOCKADDR_BUFFER];
  int namelen = SOCKADDR_BUFFER, s;
  struct sockaddr *sa = (struct sockaddr *)buffer;
  struct sockaddr_un *un = (struct sockaddr_un *)buffer;
  mlval ml_sockaddr, result;
  size_t length;

  s= accept(CINT(arg), sa, &namelen);

  if (s == -1)
    mlw_raise_syserr(errno);

  if (sa->sa_family != AF_UNIX)
    mlw_raise_syserr(EINVAL);

  length = namelen - sizeof(un->sun_family);
  ml_sockaddr = allocate_string(length+1);
  memcpy(CSTRING(ml_sockaddr), un->sun_path, length);
  CSTRING(ml_sockaddr)[length] = '\0';
  declare_root(&ml_sockaddr, 0);
  result = allocate_record(2);
  FIELD(result, 0) = MLINT(s);
  FIELD(result, 1) = ml_sockaddr;
  retract_root(&ml_sockaddr);

  return result;
}

static mlval unix_listen(mlval arg)
{
  if (listen(CINT(FIELD(arg, 0)), CINT(FIELD(arg, 1))))
    mlw_raise_syserr(errno);

  return MLUNIT;
}

static mlval unix_write(mlval arg)
{
  int w = write(CINT(FIELD(arg, 0)),
		CSTRING(FIELD(arg, 1)) + (unsigned)CINT(FIELD(arg, 2)),
		(unsigned)CINT(FIELD(arg, 3)));
  if (w == -1)
    mlw_raise_syserr(errno);

  return MLINT(w);
}

static mlval unix_seek(mlval arg)
{
  int fd = CINT(FIELD(arg, 0));
  int offset = CINT(FIELD(arg, 1));
  int meth = CINT(FIELD(arg, 2));

  int moveMethod = (meth==0)? SEEK_SET: ((meth==1)? SEEK_CUR : SEEK_END);
  int result = lseek(fd,offset,moveMethod);

  if (result == -1)  mlw_raise_syserr(errno);

  return MLINT(result);
}

#ifndef MLW_OVERRIDE_BLOCK_MODE

static mlval unix_set_block_mode (mlval arg)
{
  int flags;
  int fd = CINT(FIELD(arg, 0));
  int b = CINT(FIELD(arg, 1));

  flags = fcntl (fd, F_GETFL, 0);

  if (flags == -1)
    mlw_raise_syserr(errno);

  if (b == MLTRUE) {
    if (fcntl (fd, F_SETFL, O_NONBLOCK|flags))
      mlw_raise_syserr(errno);
  }
  else {
    if (fcntl (fd, F_SETFL, (~O_NONBLOCK)&flags))
      mlw_raise_syserr(errno);
  }

  return MLUNIT;
}

static mlval unix_can_input (mlval arg)
{
  int fd = CINT(arg);
  long l;

  if (ioctl(fd, FIONREAD, (caddr_t)&l))
    mlw_raise_syserr(errno);

  return MLINT(l);
}

#endif /* !MLW_OVERRIDE_BLOCK_MODE */

static mlval unix_read(mlval arg)
{
  int length = CINT(FIELD(arg, 1));
  char *buffer = alloc((size_t) length, "unix_read"), *s;
  int r = read(CINT(FIELD(arg, 0)), buffer, (unsigned) length);
  mlval string;

  if (r == -1)
  {
    int e= errno;
    free(buffer);
    mlw_raise_syserr(e);
  }

  string = allocate_string((size_t) (r+1));
  s = CSTRING(string);
  memcpy(s, buffer, (size_t) r);
  free(buffer);
  s[r] = '\0';

  return string;
}

static char **list_to_array(mlval list)
{
  size_t i;
  mlval l;
  char **array;

  i = 0;
  for(l=list; l!=MLNIL; l=MLTAIL(l))
    ++i;

  array = alloc(sizeof(char *)*(i+1), "list_to_array");

  i = 0;
  for(l=list; l!=MLNIL; l=MLTAIL(l))
    array[i++] = CSTRING(MLHEAD(l));
  array[i] = NULL;

  return array;
}

static char **list_to_arg_array(char* fun_location, mlval list)
{
  size_t i;
  mlval l;
  char **array;

  i = 0;
  for(l=list; l!=MLNIL; l=MLTAIL(l))
    ++i;

  array = alloc(sizeof(char *)*(i+2), "list_to_arg_array");

  i = 1;
  for(l=list; l!=MLNIL; l=MLTAIL(l))
    array[i++] = CSTRING(MLHEAD(l));
  array[i] = NULL;

  array[0] = fun_location;

  return array;
}

static mlval unix_execve(mlval arg)
{
  char **argv = list_to_arg_array(CSTRING(FIELD(arg, 0)), FIELD(arg, 1));
  char **envp = list_to_array(FIELD(arg, 2));
  int e;

  execve(CSTRING(FIELD(arg, 0)), argv, envp);

  e= errno;

  free(argv);
  free(envp);

  mlw_raise_syserr(errno);
  return MLUNIT;
}

static mlval unix_execv(mlval arg)
{
  char **argv = list_to_arg_array(CSTRING(FIELD(arg, 0)), FIELD(arg, 1));
  int e;

  execv(CSTRING(FIELD(arg, 0)), argv);

  e= errno;

  free(argv);

  mlw_raise_syserr(errno);
  return MLUNIT;
}

static mlval unix_execvp(mlval arg)
{
  char **argv = list_to_arg_array(CSTRING(FIELD(arg, 0)), FIELD(arg, 1));
  int e;

  execvp(CSTRING(FIELD(arg, 0)), argv);

  e= errno;

  free(argv);

  mlw_raise_syserr(errno);
  return MLUNIT;
}

#ifndef MLW_OVERRIDE_FORK
/*
 * fork_for_exec defines a fork that will always be used in such a way that
 * it is followed by a fork.  On systems without copy-on-write but which
 * do support vfork, it is suggested you override this with vfork in
 * OS/$OS/unixlocal.h
 *
 */
#define fork_for_exec() fork()
#endif

static mlval unix_pipe (mlval arg)
{
  int filedes[2];
  int result;
  mlval ml_result;

  result = pipe(filedes);

  /*   printf("ML pipe called.  Returned values are %d and %d.\n", filedes[0], filedes[1]); */

  ml_result = allocate_record(2);
  FIELD(ml_result, 0) = MLINT(filedes[0]);
  FIELD(ml_result, 1) = MLINT(filedes[1]);

  return ml_result;
}

static mlval unix_fork_execve(mlval arg)
{
  char **argv = list_to_arg_array(CSTRING(FIELD(arg, 0)), FIELD(arg, 1));
  char **envp = list_to_array(FIELD(arg, 2));
  int e, pid;
  volatile int exec_errno = 0;
  int in_fd = CINT(FIELD(arg, 3));
  int out_fd = CINT(FIELD(arg, 4));
  int err_fd = CINT(FIELD(arg, 5));

  pid = fork_for_exec();

  if (pid == 0)
  {
    dup2(in_fd, 0);
    dup2(out_fd, 1);
    dup2(err_fd, 2);
    execve(CSTRING(FIELD(arg, 0)), argv, envp);
    exec_errno = errno;
    _exit(-1);			/* only reached on error */
  }

  e = errno;
  free(argv);
  free(envp);

  if (pid == -1)
    mlw_raise_syserr(e);
  if (exec_errno != 0)
    mlw_raise_syserr(exec_errno);

  return MLINT(pid);
}

static mlval unix_fork_execv(mlval arg)
{
  char **argv = list_to_arg_array(CSTRING(FIELD(arg, 0)), FIELD(arg, 1));
  int e, pid;
  volatile int exec_errno = 0;
  int in_fd = CINT(FIELD(arg, 2));
  int out_fd = CINT(FIELD(arg, 3));
  int err_fd = CINT(FIELD(arg, 4));

  pid = fork_for_exec();

  if (pid == 0)
  {
    dup2(in_fd, 0);
    dup2(out_fd, 1);
    dup2(err_fd, 2);
    execv(CSTRING(FIELD(arg, 0)), argv);
    exec_errno = errno;
    _exit(-1);			/* only reached on error */
  }

  e = errno;
  free(argv);

  if (pid == -1)
    mlw_raise_syserr(e);
  if (exec_errno != 0)
    mlw_raise_syserr(exec_errno);

  return MLINT(pid);
}

static mlval unix_fork_execvp(mlval arg)
{
  char **argv = list_to_arg_array(CSTRING(FIELD(arg, 0)), FIELD(arg, 1));
  int e, pid;
  volatile int exec_errno = 0;

  pid = fork_for_exec();

  if (pid == 0)
  {
    execvp(CSTRING(FIELD(arg, 0)), argv);
    exec_errno = errno;
    _exit(-1);			/* only reached on error */
  }

  e = errno;
  free(argv);

  if (pid == -1)
    mlw_raise_syserr(e);
  if (exec_errno != 0)
    mlw_raise_syserr(exec_errno);

  return MLINT(pid);
}

static mlval unix_wait(mlval arg) {
  pid_t proc = (pid_t)(CINT(arg));
  int stat;

  if (proc == waitpid(proc, &stat, 0)) {
    if (WIFEXITED(stat)) 
      return(box(WEXITSTATUS(stat))); 
    else 
      return(box(-1));
  }
  else {
    mlw_raise_syserr(errno);
    return(box(-1));
  }
}
  

static mlval ml_passwd(struct passwd *pw)
{
  mlval name, passwd, gecos, dir, shell, result;

  /* Lexical ordering of passwd structure fields:
   *
   * dir
   * gecos
   * gid
   * name
   * passwd
   * shell
   * uid
   */

  name = ml_string(pw->pw_name);
  declare_root(&name, 0);
  passwd = ml_string(pw->pw_passwd);
  declare_root(&passwd, 0);
  gecos = ml_string(pw->pw_gecos);
  declare_root(&gecos, 0);
  dir = ml_string(pw->pw_dir);
  declare_root(&dir, 0);
  shell = ml_string(pw->pw_shell);
  declare_root(&shell, 0);
  result = allocate_record(7);
  FIELD(result, 0) = dir;
  FIELD(result, 1) = gecos;
  FIELD(result, 2) = MLINT(pw->pw_gid);
  FIELD(result, 3) = name;
  FIELD(result, 4) = passwd;
  FIELD(result, 5) = shell;
  FIELD(result, 6) = MLINT(pw->pw_uid);
  retract_root(&shell);
  retract_root(&dir);
  retract_root(&gecos);
  retract_root(&passwd);
  retract_root(&name);

  return result;
}

static mlval unix_getpwent(mlval arg)
{
  struct passwd *pw = getpwent();

  if (pw == NULL)
    mlw_raise_syserr(0);

  return ml_passwd(pw);
}

static mlval unix_setpwent(mlval arg)
{
  setpwent();
  return MLUNIT;
}

static mlval unix_endpwent(mlval arg)
{
  endpwent();
  return MLUNIT;
}

static mlval unix_getpwuid(mlval arg)
{
  struct passwd *pw = getpwuid(CINT(arg));

  if (pw == NULL)
    mlw_raise_syserr(0);

  return ml_passwd(pw);
}

static mlval unix_getpwnam(mlval arg)
{
  struct passwd *pw = getpwnam(CSTRING(arg));

  if (pw == NULL)
    mlw_raise_syserr(0);

  return ml_passwd(pw);
}

/*
 * The OS.FileSys.*Dir and POSIX.FileSys.*dir routines require that any
 * attempt to read or rewind a closed stream should raise OS.SysErr.
 * Some systems do the check for readdir(3) but none do it for rewinddir(3).
 * Therefore, the dirstream has to carry some state which indicates whether
 * the stream is open or not.  There are a number of ways of doing this and
 * in the following, making a dirstream a tuple of two values, a dir handle
 * and a boolean indicating open/closed is used.  The state of the dirstream
 * is tested on the C side for no other reason that it only costs one if
 * statement and the alternative of testing it on the ML side doesn't seem
 * to have any particular advantage.
 */
#define mlw_posix_dirstream_make() allocate_record(2)
#define mlw_posix_dirstream_handle(ds) FIELD(ds, 0)
#define mlw_posix_dirstream_state(ds) FIELD(ds, 1)

/*
 * POSIX.FileSys.opendir : string -> dirstream
 */
static mlval mlw_posix_file_sys_opendir(mlval arg)
{
  DIR *dir = opendir(CSTRING(arg));
  mlval dirstream;

  if (dir == NULL)
    mlw_raise_syserr(errno);

  dirstream= mlw_posix_dirstream_make();
  mlw_posix_dirstream_handle(dirstream)= (mlval)dir;
  mlw_posix_dirstream_state(dirstream)= MLTRUE;
  return dirstream;
}

/*
 * POSIX.FileSys.readdir : dirstream -> string option
 */
static mlval mlw_posix_file_sys_readdir(mlval arg)
{
  struct dirent *d;

  if (mlw_posix_dirstream_state(arg) == MLFALSE)
    mlw_raise_syserr(EBADF);

  errno= 0;
  if ((d= readdir((DIR *)mlw_posix_dirstream_handle(arg))) == NULL) {
    if (errno)
      mlw_raise_syserr(errno);
    else
      return mlw_option_make_none();
  }
  return mlw_option_make_some(ml_string(d->d_name));
}

/*
 * POSIX.FileSys.rewinddir : dirstream -> unit
 */
static mlval mlw_posix_file_sys_rewinddir(mlval arg)
{
  if (mlw_posix_dirstream_state(arg) == MLFALSE)
    mlw_raise_syserr(EBADF);
  rewinddir((DIR *)mlw_posix_dirstream_handle(arg));
  return MLUNIT;
}

/*
 * POSIX.FileSys.closedir : dirstream -> unit
 */
static mlval mlw_posix_file_sys_closedir(mlval arg)
{
  if (mlw_posix_dirstream_state(arg) == MLFALSE)
    return MLUNIT;
  if (closedir((DIR *)mlw_posix_dirstream_handle(arg)))
    mlw_raise_syserr(errno);
  mlw_posix_dirstream_state(arg)= MLFALSE;
  return MLUNIT;
}

/*
 * POSIX.FileSys.chdir : string -> unit
 */
static mlval mlw_posix_file_sys_chdir(mlval string)
{
  if (chdir(CSTRING(string)))
    mlw_raise_syserr(errno);

  return MLUNIT;
}

/*
 * POSIX.FileSys.getcwd : unit -> string
 */
static mlval mlw_posix_file_sys_getcwd(mlval unit)
{
  char buffer[MAXPATHLEN];
  char *result = getcwd(buffer, MAXPATHLEN);

  if (result == NULL)
    mlw_raise_syserr(errno);

  return ml_string(buffer);
}

static int
mlw_posix_file_sys_open_modes[]= {O_RDONLY, O_RDWR, O_WRONLY};

/*
 * Instead of implementing openf and creatf as runtime routines, could
 * perhaps just implement one generic routine and do the necessary argument
 * munging on the SML side.  I don't see any clear advantages either way
 * at the moment, so I've arbitrarily implemented both as runtime
 * routines.
 */

/*
 * POSIX.FileSys.openf : string * open_mode * O.flags -> file_desc
 */
static mlval mlw_posix_file_sys_openf(mlval arg)
{
  char const * file_name= CSTRING(FIELD(arg, 0));
  int open_mode= mlw_posix_file_sys_open_modes[CINT(FIELD(arg, 1))];
  int o_flags= CINT(FIELD(arg, 2));
  int fd= open(file_name, open_mode|o_flags);
  if (fd < 0)
    mlw_raise_syserr(errno);
  return MLINT(fd);
}

/*
 * POSIX.FileSys.createf : string * open_mode * O.flags * S.mode -> file_desc
 */
static mlval mlw_posix_file_sys_createf(mlval arg)
{
  char const * file_name= CSTRING(FIELD(arg, 0));
  int open_mode= mlw_posix_file_sys_open_modes[CINT(FIELD(arg, 1))];
  int o_flags= CINT(FIELD(arg, 2));
  int s_mode= CINT(FIELD(arg, 3));
  int fd= open(file_name, open_mode|o_flags|O_CREAT, (mode_t)s_mode);
  if (fd < 0)
    mlw_raise_syserr(errno);
  return MLINT(fd);
}

/*
 * POSIX.FileSys.creat : string * S.mode -> file_desc
 *
 * The docs. describe this as being equivalent to
 *
 *   creatf(s, O_WRONLY, O.trunc, m).
 *
 * But they also state that it should signal an error if the file does
 * not exist!  They can't both be right.  Until such time that a decision
 * is made, creat exists as a separate routine.  If it is equal to the
 * above expression, then it can be removed and done on the SML side.
 */
static mlval mlw_posix_file_sys_creat(mlval arg)
{
  char const * file_name= CSTRING(FIELD(arg, 0));
  int s_mode= CINT(FIELD(arg, 1));
  int fd= creat(file_name, (mode_t)s_mode);
  if (fd < 0)
    mlw_raise_syserr(errno);
  return MLINT(fd);
}

/*
 * POSIX.FileSys.umask : S.mode -> S.mode
 */
static mlval mlw_posix_file_sys_umask(mlval arg)
{
  int omask= CINT(arg);
  mode_t nmask= umask((mode_t)omask);
  return MLINT((int)nmask);
}

/*
 * POSIX.FileSys.link : {old: string, new: string} -> unit
 */
static mlval mlw_posix_file_sys_link(mlval arg)
{
  char const * new= CSTRING(FIELD(arg, 0));
  char const * old= CSTRING(FIELD(arg, 1));
  if (link(old, new) < 0)
    mlw_raise_syserr(errno);
  return MLUNIT;
}

/*
 * POSIX.FileSys.mkdir : string * S.mode -> unit
 */
static mlval mlw_posix_file_sys_mkdir(mlval arg)
{
  if (mkdir(CSTRING(FIELD(arg, 0)), (mode_t) CINT(FIELD(arg, 1))) == -1)
    mlw_raise_syserr(errno);

  return MLUNIT;
}

/*
 * POSIX.FileSys.unlink : string -> unit
 */
static mlval mlw_posix_file_sys_unlink(mlval arg)
{
  if (unlink(CSTRING(arg)))
    mlw_raise_syserr(errno);

  return MLUNIT;
}

/*
 * POSIX.FileSys.rmdir : string -> unit
 */
static mlval mlw_posix_file_sys_rmdir(mlval arg)
{
  if (rmdir(CSTRING(arg)) == -1)
    mlw_raise_syserr(errno);

  return MLUNIT;
}

/*
 * POSIX.FileSys.rename : { new: string, old: string} -> unit
 */
static mlval mlw_posix_file_sys_rename(mlval arg)
{
  if (rename(CSTRING(FIELD(arg, 1)), CSTRING(FIELD(arg, 0))))
    mlw_raise_syserr(errno);

  return MLUNIT;
}

/*
 * POSIX.FileSys.readlink : string -> string
 */
static mlval mlw_posix_file_sys_readlink(mlval arg)
{
  char const * pathname= CSTRING(arg);
  char contents[mlw_path_max];
  int  contents_len;
  mlval tagged_contents;
  if ((contents_len= readlink(pathname, contents, mlw_path_max)) < 0)
    mlw_raise_syserr(errno);
  tagged_contents= allocate_string((size_t)contents_len+1);
  memcpy(CSTRING(tagged_contents), contents, (size_t)contents_len);
  CSTRING(tagged_contents)[contents_len] = '\0';
  return tagged_contents;
}

/*
 * OS.FileSys.fullPath : string -> string
 */
static mlval mlw_os_file_sys_full_path(mlval arg)
{
  char buffer[MAXPATHLEN];
  char *result= realpath(CSTRING(arg), buffer);
  if (result == NULL)
    mlw_raise_syserr(errno);

  return ml_string(buffer);
}

/*
 * OS.FileSys.tmpName : unit -> string
 */
static mlval mlw_os_file_sys_tmp_name(mlval arg)
{
  char * name= tmpnam(NULL);
  if (name == NULL)
    mlw_raise_syserr(errno);

  return ml_string(name);
}

#define stat_offset_atime   0
#define stat_offset_blksize (stat_offset_atime+1)
#define stat_offset_blocks  (stat_offset_blksize+1)
#define stat_offset_ctime   (stat_offset_blocks+1)
#define stat_offset_dev     (stat_offset_ctime+1)
#define stat_offset_gid     (stat_offset_dev+1)
#define stat_offset_ino     (stat_offset_gid+1)
#define stat_offset_mode    (stat_offset_ino+1)
#define stat_offset_mtime   (stat_offset_mode+1)
#define stat_offset_nlink   (stat_offset_mtime+1)
#define stat_offset_rdev    (stat_offset_nlink+1)
#define stat_offset_size    (stat_offset_rdev+1)
#define stat_offset_uid     (stat_offset_size+1)
#define stat_size           (stat_offset_uid+1)

static mlval mlw_posix_file_sys_st_isdir(mlval arg)
{
  return S_ISDIR(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

static mlval mlw_posix_file_sys_st_ischr(mlval arg)
{
  return S_ISCHR(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

static mlval mlw_posix_file_sys_st_isblk(mlval arg)
{
  return S_ISBLK(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

static mlval mlw_posix_file_sys_st_isreg(mlval arg)
{
  return S_ISREG(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

static mlval mlw_posix_file_sys_st_isfifo(mlval arg)
{
  return S_ISFIFO(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

static mlval mlw_posix_file_sys_st_islink(mlval arg)
{
  return S_ISLNK(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

static mlval mlw_posix_file_sys_st_issock(mlval arg)
{
  return S_ISSOCK(CWORD(FIELD(arg, stat_offset_mode))) ? MLTRUE : MLFALSE;
}

/* Converts a C struct stat into an ML POSIX.ST.stat.
 * See src/unix/unixos.sml for the definition of POSIX.ST.stat
 *
 * ALLOCATES.
 */
static mlval mlw_posix_file_sys_return_stat (struct stat * st)
{
  mlval atime, ctime, mtime, result;

  atime= mlw_time_make(st->st_atime, 0);
  declare_root(&atime, 0);

  ctime= mlw_time_make(st->st_ctime, 0);
  declare_root(&ctime, 0);

  mtime= mlw_time_make(st->st_mtime, 0);
  declare_root(&mtime, 0);

  result= allocate_record(stat_size);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * atime      file last access time
   * blksize    preferred blocksize for file system I/O
   * blocks     actual number of blocks allocated
   * ctime      file last status change time
   * dev        device file resides on
   * gid        group ID of owner
   * ino        the file serial number
   * mode       file mode
   * mtime      file last modify time
   * nlink      number of hard links to the file
   * rdev       the device identifier (special files only)
   * size       total size of file, in bytes
   * uid        user ID of owner
   *
   * ino and dev are currently represented as an MLINT.  Since they
   * are generally defined as an (unsigned) long, perhaps these
   * should be represented as a Word32?
   */

  FIELD(result, stat_offset_atime)=   atime;
  FIELD(result, stat_offset_blksize)= MLINT(st->st_blksize);
  FIELD(result, stat_offset_blocks)=  MLINT(st->st_blocks);
  FIELD(result, stat_offset_ctime)=   ctime;
  FIELD(result, stat_offset_dev)=     MLINT(st->st_dev);
  FIELD(result, stat_offset_gid)=     MLINT(st->st_gid);
  FIELD(result, stat_offset_ino)=     MLINT(st->st_ino);
  FIELD(result, stat_offset_mode)=    MLINT(st->st_mode);
  FIELD(result, stat_offset_mtime)=   mtime;
  FIELD(result, stat_offset_nlink)=   MLINT(st->st_nlink);
  FIELD(result, stat_offset_rdev)=    MLINT(st->st_rdev);
  FIELD(result, stat_offset_size)=    MLINT(st->st_size);
  FIELD(result, stat_offset_uid)=     MLINT(st->st_uid);

  retract_root(&mtime);
  retract_root(&ctime);
  retract_root(&atime);

  return result;
}

/*
 * POSIX.FileSys.stat : string -> ST.stat
 *
 * Note POSIX.FileSys.stat is required to raise OS.SysErr if given "".
 * All supported systems except SunOS do this test in stat, but to save
 * having a separate version just for stat, the test is done before
 * calling stat and NOENT is raised explicitly.
 */
static mlval mlw_posix_file_sys_stat (mlval arg)
{
  struct stat st;
  char const * path = CSTRING(arg);

  if (path[0] == '\0')
    mlw_raise_syserr(ENOENT);

  if (stat(path, &st))
    mlw_raise_syserr(errno);

  return mlw_posix_file_sys_return_stat(&st);
}

/*
 * POSIX.FileSys.fstat : file_desc -> ST.stat
 */
static mlval mlw_posix_file_sys_fstat(mlval arg)
{
  struct stat st;
  int fd = CINT (arg);

  if (fstat (fd, &st))
    mlw_raise_syserr(errno);

  return mlw_posix_file_sys_return_stat(&st);
}

/*
 * POSIX.FileSys.lstat : string -> ST.stat
 *
 * Note POSIX.FileSys.lstat is required to raise OS.SysErr if given "".
 * All supported systems except SunOS do this test in lstat, but to save
 * having a separate version just for lstat, the test is done before
 * calling lstat and NOENT is raised explicitly.
 */
static mlval mlw_posix_file_sys_lstat (mlval arg)
{
  struct stat st;
  char const * path = CSTRING(arg);

  if (path[0] == '\0')
    mlw_raise_syserr(ENOENT);

  if (lstat(path, &st))
    mlw_raise_syserr(errno);

  return mlw_posix_file_sys_return_stat(&st);
}

static int
mlw_posix_file_sys_access_mode_ml_to_c[]= {X_OK, R_OK, W_OK};

#define mlw_posix_file_sys_n_access_modes \
  (sizeof(mlw_posix_file_sys_access_mode_ml_to_c)/sizeof(mlw_posix_file_sys_access_mode_ml_to_c[0]))

/*
 * POSIX.FileSys.access : (string * access_mode list) -> bool
 *
 * The description states that :-
 *
 *   ... only raise OS.SysError for errors unrelated to resolving the
 *   pathname and the related permissions, such as being interrupted
 *   by a signal during the the system call.
 *
 * Which seems to leave it to the implementor to decide exactly what
 * are "errors unrelated to resolving the pathname".
 */
static mlval mlw_posix_file_sys_access(mlval arg)
{
  char const * path= CSTRING(FIELD(arg, 0));
  mlval modes= FIELD(arg, 1);
  int access_mode= F_OK;
  int access_status;
  for (; !MLISNIL(modes); modes= MLTAIL(modes)) {
    int ml_mode= CINT(MLHEAD(modes));
    assert(ml_mode >= 0 && ml_mode <= mlw_posix_file_sys_n_access_modes);
    access_mode |= mlw_posix_file_sys_access_mode_ml_to_c[ml_mode];
  }
  if ((access_status= access(path, access_mode)) < 0) {
    switch (errno) {
    case EACCES:
    case ENOENT:
    case ENOTDIR:
    case EROFS:
    case ELOOP:
#ifdef EMULTIHOP
    case EMULTIHOP:
#endif
#ifdef ETIMEDOUT
    case ETIMEDOUT:
#endif
#ifdef ENOLINK
    case ENOLINK:
#endif
      return MLFALSE;
    default:
      mlw_raise_syserr(errno);
    }
  }
  return MLTRUE;
}

/*
 * UnixOS.utime : (string * Time.time * Time.time) -> unit
 *
 * This is used to define POSIX.FileSys.utime.  This is a lower level
 * interface in that you always have to specify the access and modification
 * times.
 */
static mlval mlw_unix_utime(mlval arg)
{
  char const * path= CSTRING(FIELD(arg, 0));
  mlval access_time= FIELD(arg, 1);
  mlval mod_time= FIELD(arg, 2);
  struct utimbuf tb;
  tb.actime= mlw_time_sec(access_time);
  tb.modtime= mlw_time_sec(mod_time);
  if (utime(path, &tb) < 0)
    mlw_raise_syserr(errno);
  return MLUNIT;
}

/*
 * POSIX.IO.close : file_desc -> unit
 */
static mlval mlw_posix_io_close(mlval arg)
{
  if (close(CINT(arg)) == -1)
    mlw_raise_syserr(errno);

  return MLUNIT;
}

static mlval password_file_result = DEAD;

static mlval unix_password_file(mlval arg)
{
  if (password_file_result == DEAD) {
    mlval result = MLNIL,
          str1 = MLNIL,
          str2 = MLNIL,
          pair = MLNIL;
    struct passwd *entry = getpwent();
    password_file_result = MLNIL;
    declare_root(&password_file_result, 0);
    declare_root(&result, 0);
    declare_root(&str1, 0);
    declare_root(&str2, 0);
    declare_root(&pair, 0);
    while (entry != NULL) {
      str1 = ml_string(entry->pw_name);
      str2 = ml_string(entry->pw_dir);
      pair = allocate_record(2);
      FIELD(pair, 0) = str1;
      FIELD(pair, 1) = str2;
      result = cons(pair, result);
      entry = getpwent();
    };
    endpwent();
    retract_root(&result);
    retract_root(&str1);
    retract_root(&str2);
    retract_root(&pair);
    password_file_result = result;
  }
  return password_file_result;
}

static mlval unix_kill(mlval arg)
{ if (kill(CINT(FIELD(arg, 0)), CINT(FIELD(arg, 1)))) {
    mlw_raise_syserr(errno);
  }
  return MLUNIT;
}

static mlval unix_getpid(mlval arg)
{
  pid_t pid = getpid ();
  return MLINT(pid);
}

/*
 * OS.Process.terminate: Word32.word -> 'a
 */
static mlval unix_exit(mlval exit_code)
{
  exit(unbox(exit_code));
  return MLUNIT;		/* keep dumb compilers happy */
}

/*
 * OS.Process.system: string -> Word32.word
 */
static mlval unix_system(mlval arg)
{
  char const * command= CSTRING(arg);
  int status= system(command);
  if (status == -1 || status == 127)
    mlw_raise_syserr(errno);

  return box(status);
}

static mlval unix_getenv(mlval arg)
{
  char const * name= CSTRING(arg);
  char const * value= getenv(name);
  if (value == NULL) {
    return mlw_option_make_none();
  } else {
    return mlw_option_make_some(ml_string(value));
  }
}

/*
 * OS.IO.kind : io_desc -> iodesc_kind
 * Raises: OS.SysErr
 *
 * Note that this is the only OS.IO routine implemented here.
 * All the poll related routines are implemented in os_io_poll.[ch]
 */

static mlval mlw_os_io_kind(mlval arg)
{
  struct stat st;
  int io_desc= CINT(arg);

  if (fstat(io_desc, &st) < 0)
    mlw_raise_syserr(errno);

  if (S_ISREG(st.st_mode)) {
    return isatty(io_desc) ? MLINT(4) : MLINT(1);
  } else if (S_ISDIR(st.st_mode)) {
    return MLINT(2);
  } else if (S_ISLNK(st.st_mode)) {
    return MLINT(3);
  } else if (S_ISFIFO(st.st_mode)) {
    return MLINT(5);
  } else if (S_ISSOCK(st.st_mode)) {
    return MLINT(6);
  } else if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
    return MLINT(7);
  } else {
    exn_raise_syserr(ml_string("OS.IO.kind: unknown io_desc kind"), 0);
  }
}

extern void unix_init(void)
{
  env_value("system io standard in",MLINT(0));
  env_value("system io standard out",MLINT(1));
  env_value("system io standard err",MLINT(2));

  env_function("OS.errorMsg", mlw_os_error_msg);
  env_function("OS.errorName", mlw_os_error_name);
  env_function("OS.syserror", mlw_os_syserror);

  env_function("system os unix environment", unix_environment);
  env_function("system os unix rusage", unix_rusage);
  env_function("system os unix open", unix_open);
  env_function("POSIX.FileSys.opendir", mlw_posix_file_sys_opendir);
  env_function("POSIX.FileSys.readdir", mlw_posix_file_sys_readdir);
  env_function("POSIX.FileSys.rewinddir", mlw_posix_file_sys_rewinddir);
  env_function("POSIX.FileSys.closedir", mlw_posix_file_sys_closedir);
  env_function("POSIX.FileSys.chdir", mlw_posix_file_sys_chdir);
  env_function("POSIX.FileSys.getcwd", mlw_posix_file_sys_getcwd);

  mlw_posix_file_sys_o_append= MLINT(O_APPEND);
  env_value("POSIX.FileSys.O.append", mlw_posix_file_sys_o_append);

  mlw_posix_file_sys_o_excl= MLINT(O_EXCL);
  env_value("POSIX.FileSys.O.excl", mlw_posix_file_sys_o_excl);

  mlw_posix_file_sys_o_noctty= MLINT(O_NOCTTY);
  env_value("POSIX.FileSys.O.noctty", mlw_posix_file_sys_o_noctty);

  mlw_posix_file_sys_o_nonblock= MLINT(O_NONBLOCK);
  env_value("POSIX.FileSys.O.nonblock", mlw_posix_file_sys_o_nonblock);

  mlw_posix_file_sys_o_sync= MLINT(O_SYNC);
  env_value("POSIX.FileSys.O.sync", mlw_posix_file_sys_o_sync);

  mlw_posix_file_sys_o_trunc= MLINT(O_TRUNC);
  env_value("POSIX.FileSys.O.trunc", mlw_posix_file_sys_o_trunc);

  env_function("POSIX.FileSys.openf", mlw_posix_file_sys_openf);
  env_function("POSIX.FileSys.createf", mlw_posix_file_sys_createf);
  env_function("POSIX.FileSys.creat", mlw_posix_file_sys_creat);
  env_function("POSIX.FileSys.umask", mlw_posix_file_sys_umask);
  env_function("POSIX.FileSys.link", mlw_posix_file_sys_link);
  env_function("POSIX.FileSys.mkdir", mlw_posix_file_sys_mkdir);
  env_function("POSIX.FileSys.rmdir", mlw_posix_file_sys_rmdir);
  env_function("POSIX.FileSys.unlink", mlw_posix_file_sys_unlink);
  env_function("POSIX.FileSys.rename", mlw_posix_file_sys_rename);
  env_function("POSIX.FileSys.readlink", mlw_posix_file_sys_readlink);
  env_function("OS.FileSys.tmpName", mlw_os_file_sys_tmp_name);
  env_function("OS.FileSys.fullPath", mlw_os_file_sys_full_path);

  env_function("POSIX.FileSys.ST.isdir", mlw_posix_file_sys_st_isdir);
  env_function("POSIX.FileSys.ST.ischr", mlw_posix_file_sys_st_ischr);
  env_function("POSIX.FileSys.ST.isblk", mlw_posix_file_sys_st_isblk);
  env_function("POSIX.FileSys.ST.ischr", mlw_posix_file_sys_st_ischr);
  env_function("POSIX.FileSys.ST.isreg", mlw_posix_file_sys_st_isreg);
  env_function("POSIX.FileSys.ST.isfifo", mlw_posix_file_sys_st_isfifo);
  env_function("POSIX.FileSys.ST.islink", mlw_posix_file_sys_st_islink);
  env_function("POSIX.FileSys.ST.issock", mlw_posix_file_sys_st_issock);

  env_function("POSIX.FileSys.stat", mlw_posix_file_sys_stat);
  env_function("POSIX.FileSys.fstat", mlw_posix_file_sys_fstat);
  env_function("POSIX.FileSys.lstat", mlw_posix_file_sys_lstat);

  env_function("POSIX.FileSys.access", mlw_posix_file_sys_access);

  env_function("system os unix utime", mlw_unix_utime);

  env_function("system io read", unix_read);
  env_function("system io seek", unix_seek);
  env_function("system io write", unix_write);
  env_function("system io close", mlw_posix_io_close);
  env_function("system io can input", unix_can_input);
  env_value ("system io standard input", mlw_ref_make(MLINT(0)));
  env_value ("system io standard output", mlw_ref_make(MLINT(1)));
  env_value ("system io standard error", mlw_ref_make(MLINT(2)));

  env_function("system os unix socket", unix_socket);
  env_function("system os unix bind", unix_bind);
  env_function("system os unix connect", unix_connect);
  env_function("system os unix set block mode", unix_set_block_mode);
  env_function("system os unix accept", unix_accept);
  env_function("system os unix listen", unix_listen);
  env_function("system os unix getsockname", unix_getsockname);
  env_function("system os unix getpeername", unix_getpeername);
  env_function("system os unix execve", unix_execve);
  env_function("system os unix execv", unix_execv);
  env_function("system os unix execvp", unix_execvp);
  env_function("system os unix fork_execve", unix_fork_execve);
  env_function("system os unix fork_execv", unix_fork_execv);
  env_function("system os unix fork_execvp", unix_fork_execvp);
  env_function("system os unix wait", unix_wait);
  env_function("system os unix getpwent", unix_getpwent);
  env_function("system os unix setpwent", unix_setpwent);
  env_function("system os unix endpwent", unix_endpwent);
  env_function("system os unix getpwuid", unix_getpwuid);
  env_function("system os unix getpwnam", unix_getpwnam);
  env_function("system os unix password_file", unix_password_file);
  env_function("system os unix kill", unix_kill);
  env_function("system os unix getpid", unix_getpid);

  env_function("system os unix pipe", unix_pipe);

  env_function("system os exit", unix_exit);
  env_function("system os system", unix_system);
  env_function("system os getenv", unix_getenv);

  env_function("OS.IO.kind", mlw_os_io_kind);

  unix_af_unix= MLINT(AF_UNIX);
  env_value("system os unix af_unix", unix_af_unix);

  unix_af_inet= MLINT(AF_INET);
  env_value("system os unix af_inet", unix_af_inet);

  unix_sock_stream= MLINT(SOCK_STREAM);
  env_value("system os unix sock_stream", unix_sock_stream);

  unix_sock_dgram= MLINT(SOCK_DGRAM);
  env_value("system os unix sock_dgram", unix_sock_dgram);

  unix_exn_ref_would_block = ref(exn_default);
  env_value("system os unix exception Would Block", unix_exn_ref_would_block);
  declare_global
    ("system os unix exception Would Block", &unix_exn_ref_would_block,
     GLOBAL_DEFAULT, NULL, NULL, NULL);

  unix_o_rdonly = MLINT(O_RDONLY);
  env_value("system os unix o_rdonly", unix_o_rdonly);

  unix_o_wronly = MLINT(O_WRONLY);
  env_value("system os unix o_wronly", unix_o_wronly);

  unix_o_append = MLINT(O_APPEND);
  env_value("system os unix o_append", unix_o_append);

  unix_o_creat = MLINT(O_CREAT);
  env_value("system os unix o_creat", unix_o_creat);

  unix_o_trunc = MLINT(O_TRUNC);
  env_value("system os unix o_trunc", unix_o_trunc);

  /* PATH_MAX can be set at compile time or runtime or neither!  See
   * section 2.5.7, page 41 of Advanced Programming in the UNIX Environment
   * W. Richard Stevens for more info.
   */
#ifdef PATH_MAX
  mlw_path_max= PATH_MAX;
#else
  if ((mlw_path_max= pathconf("/", _PC_PATH_MAX)) < 0) {
    /* Should only do the following if errno == 0, but since
     * we don't want to signal an error from the initialisation code
     * it is done whether there is an error or not.
     */
    mlw_path_max= MAXPATHLEN;
  }
#endif

  /* Arguably the following should not be here but in os_init.
   * However, since they are the same for all Unix systems there
   * doesn't seem much point in repeating them in each Unix
   * variant's os_init.
   */
  mlw_time_date_init();
  mlw_timer_init();
  mlw_os_io_poll_init();
}

extern void signals_finalise (void)
{
  /* No action required on unix */
}

extern int system_validate_ml_address(void *addr)
{
  return 0;
  /* Temporary implementation until shared objects done */
}

extern const char *const *parse_command_line(int *argc)
{
  error("Unix version of parse_command_line not yet implemented and shouldn't be called");
}

extern void register_time_stamp(unsigned long *addr);

extern void register_time_stamp(unsigned long *addr)
{
  error("Unix version of register_time_stamp not yet implemented and shouldn't be called");
}
