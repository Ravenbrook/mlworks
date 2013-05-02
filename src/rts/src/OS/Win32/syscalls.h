/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
