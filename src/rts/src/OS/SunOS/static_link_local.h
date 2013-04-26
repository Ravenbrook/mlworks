/* rts/src/OS/Unix/static_link_local.h
 *
 * Header file for static_link.c.  The generic version just includes <dlfcn.h>,
 * but for SunOS we have to define them explicitly.
 *
 * Copyright (c) 1996 Harlequin Ltd.
 *
 * $Log: static_link_local.h,v $
 * Revision 1.1  1996/10/09 14:26:07  daveb
 * new unit
 * Declares the functions defined in static_link.c; we override the ones
 * provided by SunOS.
 *
 */

#ifndef _static_link_local_h
#define _static_link_local_h

extern void *dlopen(const char*, int);
extern void *dlsym(void*, const char*);
extern int dlclose(void*);
extern char *dlerror(void);

#endif
