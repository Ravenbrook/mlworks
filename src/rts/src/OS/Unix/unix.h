/* Copyright (C) 1996 Harlequin Ltd
 *
 * This is a synthesis of and replaces OS/{Irix,Linux,Solaris,SunOS}/unix.h
 *
 * $Log: unix.h,v $
 * Revision 1.1  1996/02/12 11:58:36  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/unix.h
 *
 * Revision 1.1  1996/01/30  14:53:16  stephenb
 * new unit
 * A replacement for the unix.h in each of the Unix dialect directories.
 *
 *
 */

#ifndef unix_h
#define unix_h


/*
 *  Intialises the module and adds the unix values to the runtime
 *  environment.
 */

extern void unix_init(void);

#endif
