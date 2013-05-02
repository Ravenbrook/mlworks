/*  ==== UNIX SYSCALL DECLARATIONS HEADER ====
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
 *  This header declares Unix system calls which are not declared in
 *  system header files. 
 *
 * Loosely based on SunOS version.
 *
 *  $Log: syscalls.h,v $
 *  Revision 1.8  1997/11/06 10:53:44  johnh
 *  [Bug #30125]
 *  Correct the definition of kill.
 *
 * Revision 1.7  1996/10/24  13:17:29  jont
 * Add definition for SA_RESTART
 *
 */

#ifndef syscall_h
#define syscall_h

/* Hardly anything gets defined properly in Solaris header files */

#include <stdio.h>
#include <sys/types.h>
#include <sys/time.h>
#include <signal.h>
#include <sys/resource.h>

#include <sys/socket.h>
#include <sys/stat.h>
#include <math.h>
#include <floatingpoint.h>
#include <fcntl.h>
#include <unistd.h>

/* files */

extern int close (int fd);
extern char *getwd (char *pathname);
extern char* realpath(char *path,char resolved_path[]);
extern int fsync (int fd);
extern int pipe (int fd[2]);

/* GNU has its own header files, which do not use ANSI-style function
prototypes for certain functions. For mkdir this is a problem since
mode_t is a type with implicit promotion. */

#ifdef __GNUC__
extern int mkdir ();
#else
extern int mkdir (char *path, mode_t mode);
#endif

/* time */

extern int gettimeofday(struct timeval *tp, void *);
/* 
 * For Solaris 2.3 on dedekind this takes one argument.
 * This prototype is needed for dedekind.
 *
 * For Solaris 2.5 on binatone and abel, this takes two arguments
 * and the second argument must be set to NULL and ignored.
 * This prototype is not needed for binatone and abel.
 *
 * I'll leave Stephen to decide whats best.
 */

/* memory */

extern int plock (int op);
extern int munmap (caddr_t addr, size_t len); /* mmap is in <sys/mman.h> */
extern int getpagesize (void);

/* processes */

extern int kill (pid_t pid, int signal);
extern char **environ;

/* signals */

/* this is all in the system include files, but #ifdeffed out when
 * __STDC__ is set */

#ifdef __STDC__

typedef struct {		/* signal set type */
	unsigned long	__sigbits[4];
} sigset_t;

struct sigaction {
	int sa_flags;
	void (*sa_handler)();
	sigset_t sa_mask;
	int sa_resv[2];
};

#define SA_ONSTACK 0x00000001
#define SA_RESTART 0x00000004
#define SA_SIGINFO 0x00000008

struct sigaltstack {
	char	*ss_sp;
	int	ss_size;
	int	ss_flags;
};

#define SIGSTKSZ 8096

typedef struct sigaltstack stack_t;

extern int sigaltstack (const stack_t *new, stack_t *old);

extern int sigaction
  (int sig, const struct sigaction *new, struct sigaction *old);
extern int sigaddset(sigset_t *s, int sig);
extern int sigdelset(sigset_t *s, int sig);
extern int sigfillset(sigset_t *s);
extern int sigemptyset(sigset_t *s);
extern int sigprocmask(int sig, const sigset_t *new, sigset_t *old);

#endif

/* passwords */

extern void setpwent(void);
extern void endpwent(void);

/* option parsing */

extern char *optarg;
extern int optind;

/* maths */

/* Again, this is all in math.h but ifdeffed out when __STDC__ is defined. */

#ifdef __STDC__

struct exception {
	int type;
	char *name;
	double arg1;
	double arg2;
	double retval;
};

/* these values are seen in the 'type' field of a struct exception */

#define	DOMAIN		1
#define	SING		2
#define	OVERFLOW	3
#define	UNDERFLOW	4
#define	TLOSS		5
#define	PLOSS		6

extern int matherr (struct exception *exc);

extern int ieee_handler
  (const char *action, const char *exception, sigfpe_handler_type hdl);

extern int isnan(double);

#endif

/* misc */

extern int gethostname (char *name, int namelen);
extern char *sys_errlist [];
extern long sysconf(int);

#endif /* syscall_h */

