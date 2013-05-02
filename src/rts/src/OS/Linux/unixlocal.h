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
