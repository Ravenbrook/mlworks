/*  ==== PROCESS IOCTL FUNCTIONS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd
 *
 *  Description
 *  -----------

 *  This provides /proc ioctl calls for the current process to the
 *  rest of the Solaris-specific runtime.
 *
 *  $Log: pioc.h,v $
 *  Revision 1.1  1995/02/23 16:04:51  nickb
 *  new unit
 *  Process control file ioctl.
 *
 */

#ifndef pioc_h
#define pioc_h

/* init_pioc opens a file descriptor to the process control file */

extern void pioc_init(void);

/* pioc(n,p) calls ioctl(fd,n,p) with the fd opened by init_pioc() */
/* see man proc(4) for details */

extern int pioc(int code, void *p);

#endif
