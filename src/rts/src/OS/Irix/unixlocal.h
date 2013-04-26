/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any Irix specific declarations which need to override the default
 * in ../OS/common/unix.c should go here.
 *
 * $Log: unixlocal.h,v $
 * Revision 1.3  1996/08/06 14:46:23  stephenb
 * Update to gcc-2.7.2: MLW_OVERRIDE_READLINK as it is no longer necessary.
 *
 * Revision 1.2  1996/05/28  11:49:42  stephenb
 * Introduce mlw_unix_readlink to abstract over differences in readlink
 * prototypes.
 *
 * Revision 1.1  1996/01/30  14:43:25  stephenb
 * new unit
 * There is now only one unix.c and this supports and idealised Unix.
 * This file contains any support functions needed under Irix to
 * support this idealised version.
 *
 */
