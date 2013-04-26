/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any Linux specific declarations which need to override the default code
 * in  ../OS/common/unix.c should go here.
 *
 * $Log: unixlocal.h,v $
 * Revision 1.2  1996/05/24 11:24:46  stephenb
 * Add a prototype for readlink since it is protected by a #ifdef __USE_BSD
 * in <unistd.h> and #defining that might have undesirable consequences.
 *
 * Revision 1.1  1996/01/30  14:40:20  stephenb
 * new unit
 * There is now only one unix.c and this supports an idealised Unix.
 * This file contains any supporting declarations needed under Linux
 * to support this idealised version.
 *
 */

#include "mltypes.h"
#include "values.h"

extern mlval unix_exn_ref_unix;

#define MLW_OVERRIDE_BLOCK_MODE 1

extern mlval unix_set_block_mode(mlval);
extern mlval unix_can_input(mlval);

/* This is declared in <unistd.h> but is surrounded by #ifdef __USE_BSD.
 * Since defining that has wider effects that just including readlink
 * it seems safest just to add a prototype here.
 */
extern int readlink(const char *, char *, int);
