/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any SunOS specific declarations which override the default code
 * in  ../OS/Unix/unix.c should go here.
 *
 * $Log: unixlocal.h,v $
 * Revision 1.6  1996/05/15 14:49:31  stephenb
 * Add yet more declarations for functions missing from SunOS header files.
 *
 * Revision 1.5  1996/05/07  09:30:42  stephenb
 * Removed any reference to OS/common and replaced it with OS/Unix
 *
 * Revision 1.4  1996/04/11  12:36:22  stephenb
 * Add prototype for system now that it is used in unix.c
 *
 * Revision 1.3  1996/03/29  15:13:34  stephenb
 * Add some prototypes missing from the SunOS headers but which are needed
 * by the unix.c file.
 *
 * Revision 1.2  1996/03/07  11:50:19  stephenb
 * #define getcwd getwd so that the default getcwd which opens a pipe to pwd
 * is not used.  This will hopefully eliminate any signal handling problems
 * that are due to SIGCHLD (due to the pwd dying) being sent at innapropriate
 * times.
 *
 * Revision 1.1  1996/01/30  14:35:20  stephenb
 * new unit
 * There is only one unix.c file now.  This file encapsulates the
 * differences between SunOS and the version of Unix supported in unix.c
 *
 */

#ifndef unixlocal_h
#define unixlocal_h


#define MLW_OVERRIDE_FORK
#include <vfork.h>
#define fork_for_exec() vfork()


/* 
 * Prototypes for various functions missing from the SunOS headers
 */
extern char const *strerror(int);
extern int rename(char const *, char const *);
extern int system(char const *);
extern int readlink(char const *, char *, int);

#include <sys/types.h>
#include <sys/stat.h>
extern int lstat (char const *, struct stat *);


/* getcwd under SunOS opens a pipe to pwd!  The resulting SIGCHLD
 * can cause havoc if it arrives at a sensitive moment in the rts.
 * To avoid the problem, getcwd is replaced by getwd which is a 
 * syscall under SunOS.  Note that the len argument is ignored,
 * it is up to you to ensure that the size of the buffer is at
 * least MAXPATHLEN.
 */
#define getcwd(buffer, ignored_len) getwd(buffer)

#endif /* !unixlocal_h */
