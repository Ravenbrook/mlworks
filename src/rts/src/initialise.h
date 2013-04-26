/*
 * initialise.h
 * Initialise the run-time system.
 * $Log: initialise.h,v $
 * Revision 1.3  1996/08/27 14:23:18  nickb
 * storeman arguments no longer passed to initializer.
 *
 * Revision 1.2  1994/06/09  14:39:10  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:06:27  nickh
 * new file
 *
 * Revision 1.4  1993/06/02  13:04:06  richard
 * Improved the use of const in the argv argument type.
 *
 * Revision 1.3  1993/04/30  12:36:44  richard
 * Multiple arguments can now be passed to the storage manager in a general
 * way.
 *
 * Revision 1.2  1992/03/12  12:28:07  richard
 * Added top_generation parameter.
 *
 * Revision 1.1  1991/10/23  15:26:52  davidt
 * Initial revision
 *
 * 
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 */


#ifndef initialise_h
#define initialise_h

#include <stddef.h>

void initialise(void);

#endif
