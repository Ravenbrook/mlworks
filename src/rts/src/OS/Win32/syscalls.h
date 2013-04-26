/*  Copyright (C) 1994 Harlequin Ltd
 *
 * Description
 * -----------
 * In theory this header declares system calls which are not declared in
 * system header files.  In practice all it now contains a couple of misc.
 * prototypes which would perhaps be better placed elsewhere.
 *
 * Revision Log
 * ------------
 * 
 *  $Log: syscalls.h,v $
 *  Revision 1.4  1996/07/31 12:39:59  stephenb
 *  Remove most of the declarations since they can be found in
 *  <windows.h> and it is safe to #include <windows.h> since we
 *  are using VC++ to compile and not gcc (which chokes on <windows.h>)
 *
 * Revision 1.3  1996/07/25  10:08:46  jont
 * Add include of float.h to get prototype for _isnan
 *
 * Revision 1.2  1996/07/24  16:46:09  jont
 * Add prototype for _isnan and definition of isnan(p) as _isnan(p)
 *
 * Revision 1.1  1996/03/04  12:07:05  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/win32_syscalls.h
 *
 * Revision 1.1  1996/02/14  12:07:01  jont
 * new unit
 *
 * Revision 1.3  1996/01/15  16:13:25  matthew
 * Adding some more stuff
 *
 *
 */

#ifndef syscalls_h
#define syscalls_h

#include <float.h>

extern void winmain_init(void);

#define isnan(p) _isnan(p)

#endif /* syscalls_h */
