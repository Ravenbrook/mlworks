/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any SunOS specific code which need to override the default code
 * in  ../OS/Unix/unix.c should go here.
 *
 * $Log: unixlocal.c,v $
 * Revision 1.2  1996/05/07 15:25:18  stephenb
 * Removed any reference to OS/common and replaced it with OS/Unix
 *
 * Revision 1.1  1996/01/30  14:33:51  stephenb
 * new unit
 * There is only one unix.c file now.  This file encapsulates the differences
 * between SunOS and the the standard Unix implementation.
 *
 */

#include "unixlocal.h"

extern char const *sys_errlist[];

extern char const *strerror(int n)
{
  return sys_errlist[n];
}
