/*  ==== UNIX SYSCALL DECLARATIONS HEADER ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This header declares Unix system calls which are not declared in
 *  system header files. 
 *
 * $Log: syscalls.h,v $
 * Revision 1.9  1997/11/06 11:03:32  johnh
 * [Bug #30125]
 * Correct the declaration of kill.
 *
 * Revision 1.8  1996/12/18  13:51:56  stephenb
 * [Bug #1758]
 * Add a prototype for gethostid since it is missing from unistd.h and
 * needed by rts/src/OS/Unix/license.c
 *
 * Revision 1.7  1996/10/17  14:01:09  jont
 * Merge in license stuff
 *
 */

#ifndef syscall_h
#define syscall_h

/* Hardly anything gets defined properly in SunOS header files */

#include <stdio.h>
#include <sys/types.h>
#include <sys/time.h>
#include <signal.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <math.h>
#include <fcntl.h>

#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0

typedef signed int ssize_t;


/* files */

extern int ioctl (int fd, int request, caddr_t arg);
extern char *getwd (char *pathname);
extern char *realpath(char *path,char resolved_path[]);
extern int fsync (int fd);


/* time */

extern int gettimeofday(struct timeval *tp, struct timezone *tzp);
extern int setitimer (int which, struct itimerval *value, struct itimerval *ovalue);

/* memory */

extern int brk (caddr_t addr);
extern caddr_t sbrk (int incr);
extern int plock (int op);
extern void bcopy (char *b1, char *b2, int length);
extern int munmap (caddr_t addr, size_t len); /* mmap is in <sys/mman.h> */
extern int getpagesize (void);

/* signals */

extern int sigblock (int mask);
extern int sigvec (int sig, struct sigvec *vec, struct sigvec *ovec);
extern int sigstack (struct sigstack *ss, struct sigstack *oss);

/* processes */

extern int getpid(void);
extern int kill (pid_t pid, int signal);
extern int on_exit (void (*fun)(int status, caddr_t arg), caddr_t arg);
extern int getrusage (int who, struct rusage *rusage);
extern int fork (void);
extern int vfork (void);
extern char **environ;
extern unsigned int sleep(unsigned int);

/* uids */

extern int seteuid(int euid);


/* sockets */

extern int socket (int domain, int type, int protocol);
extern int connect (int s, struct sockaddr *name, int namelen);
extern int bind (int s, struct sockaddr *name, int namelen);
extern int getsockname (int s, struct sockaddr *name, unsigned int *namelen);
extern int getpeername (int s, struct sockaddr *name, unsigned int *namelen);
extern int listen (int s, int backlog);
extern int accept (int s, struct sockaddr *name, unsigned int *namelen);

/* passwords */

extern void setpwent(void);
extern void endpwent(void);

/* math */

/* have to give a full prototype of matherr to avoid a warning */

extern int matherr(struct exception *exn);

/* misc */

extern int gethostname (char *name, int namelen);


/* Missing from <unistd.h> */

/*
 * If the SunOS <unistd.h> had a prototype for this it would define
 * it as returning an int.  However, since it doesn't and the code
 * that uses it expects it to return a long (a la POSIX prototype)
 * we lie here and give the POSIX prototype sure in the knowledge
 * that sizeof(int) == sizeof(long) under SunOS 4.1.X.
 */
extern long gethostid(void);


#endif /* syscall_h */
