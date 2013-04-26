/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any Solaris specific declarations which are needed to override the
 * default code in ../OS/common/unix.c should go here.
 *
 * $Log: unixlocal.h,v $
 * Revision 1.1  1996/01/30 14:36:02  stephenb
 * new unit
 * There is only one unix.c file now.  This file encapsulates the
 * differences between Solaris and the version of Unix supported in unix.c
 *
 */


#include "mltypes.h"
#include "values.h"
#include <sys/filio.h>		/* for FIONREAD */

extern mlval unix_exn_ref_unix;


#define MLW_OVERRIDE_RUSAGE 1
extern mlval unix_rusage(mlval);
