/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any Linux specific code which needs to override the default code
 * in  ../OS/common/unix.c should go here.
 *
 * $Log: unixlocal.c,v $
 * Revision 1.3  1997/05/22 08:46:18  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.2  1996/04/02  12:31:18  stephenb
 * Replace the unix exception by Os.SysErr.
 *
 * Revision 1.1  1996/01/30  14:39:34  stephenb
 * new unit
 * There is now only one unix.c and this supports an idealised Unix.
 * This file contains any support functions needed under Linux
 * to support this idealised version.
 *
 */

#include "exceptions.h"		/* exn_raise_syserr */
#include "values.h"		/* MLINT */
#include "allocator.h"          /* ml_string */
#include "unixlocal.h"


extern mlval unix_set_block_mode(mlval arg)
{
  exn_raise_syserr(ml_string("Linux does not support set_block_mode"), MLINT(0));
}


extern mlval unix_can_input(mlval arg)
{
  exn_raise_syserr(ml_string("Linux does not support set_block_mode"), MLINT(0));
}
