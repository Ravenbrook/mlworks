/*  ==== UNIX SYSCALL DECLARATIONS HEADER ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
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

#ifndef _STRUCT_TIMESPEC
#define _STRUCT_TIMESPEC
struct timespec {
	long	tv_sec;		/* seconds */
	long	tv_nsec;	/* nanoseconds */
};
#endif /* _STRUCT_TIMESPEC */

/* lstat, messed up in Red Hat 5 */

#define lstat __lstat

/* S_ISLNK and S_ISSOCK, also screwed up in Red Hat 5 */

#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
#endif /* syscall_h */
