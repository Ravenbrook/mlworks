/*  ==== UNIX SYSCALL DECLARATIONS HEADER ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This header declares Unix system calls which are not declared in
 *  system header files. 
 *
 *  $Log: syscalls.h,v $
 *  Revision 1.5  1996/10/17 13:57:51  jont
 *  Merge in license stuff
 *
 */

#ifndef syscall_h
#define syscall_h

#include <stdio.h>
#include <sys/types.h>
#include <signal.h>


/* memory */

extern int plock (int op);
extern void bcopy (char *b1, char *b2, int length);


/* signals */

extern int sigblock (int mask);
extern int sigvec (int sig, struct sigvec *vec, struct sigvec *ovec);
extern int sigstack (struct sigstack *ss, struct sigstack *oss);

/* processes */

extern char **environ;
extern unsigned int sleep(unsigned int);

/* uids */

extern int seteuid(int euid);

/* Maths */

extern int isnan(double);

#endif /* syscall_h */
