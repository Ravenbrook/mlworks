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
 *  $Id: syscalls.h,v 1.6 1998/09/30 15:53:49 jont Exp $
 */

#ifndef syscall_h
#define syscall_h

/* Most things get defined OK in Linux header files */

#include <sys/types.h>
#include <sys/socket.h>

/* files */

extern int open (const char *path, int flags, ...);
extern int close (int fd);
extern char *getwd (char *pathname);
extern int pipe (int fd[2]);
extern off_t lseek(int fd, off_t offset, int whence);
extern char *realpath(__const char *__path,
		      char __resolved_path []);

/* time */

extern int getpagesize (void);

/* signals */

/* struct sigcontext from /usr/include/asm/signal.h, #ifdeffed __KERNEL__ */

struct sigcontext {
	unsigned short gs, __gsh;
	unsigned short fs, __fsh;
	unsigned short es, __esh;
	unsigned short ds, __dsh;
	unsigned long edi;
	unsigned long esi;
	unsigned long ebp;
	unsigned long esp;
	unsigned long ebx;
	unsigned long edx;
	unsigned long ecx;
	unsigned long eax;
	unsigned long trapno;
	unsigned long err;
	unsigned long eip;
	unsigned short cs, __csh;
	unsigned long eflags;
	unsigned long esp_at_signal;
	unsigned short ss, __ssh;
	unsigned long i387;
	unsigned long oldmask;
	unsigned long cr2;
};

/* processes */

extern int getpid(void);
extern int fork (void);
extern char **environ;
extern int vfork (void);
extern int kill (pid_t pid, int signal);

/* uids */

/* sockets */

/* passwords */

struct passwd *getpwent(void);
extern void setpwent(void);
extern void endpwent(void);

/* option parsing */

/* math */

extern int isnan(double);

/* misc */

extern char *sys_errlist [];

/* Return the current machine's Internet number.  */
extern long int gethostid __P ((void));

/* struct timespec, messed up in Red Hat 5 */

#if 0 /* RB 2013-05-18 */
#ifndef _STRUCT_TIMESPEC
#define _STRUCT_TIMESPEC
struct timespec {
	long	tv_sec;		/* seconds */
	long	tv_nsec;	/* nanoseconds */
};
#endif /* _STRUCT_TIMESPEC */
#endif

/* lstat, messed up in Red Hat 5 */

#define lstat __lstat

/* S_ISLNK and S_ISSOCK, also screwed up in Red Hat 5 */

#if 0 /* RB 2013-05-18 */
#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
#endif
#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)

#endif /* syscall_h */
