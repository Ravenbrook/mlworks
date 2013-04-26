/*  ==== PERVASIVE NT FUNCTIONS ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This part of the runtime environment contains all the Windows NT specific
 *  stuff.
 *
 *  Revision Log
 *  ------------
 *  $Log: win32.h,v $
 *  Revision 1.1  1996/02/12 11:58:38  stephenb
 *  new unit
 *  This used to be src/rts/src/OS/common/win32.h
 *
 * Revision 1.3  1996/01/22  15:45:30  stephenb
 * change nt_init to win32_init.
 *
 * Revision 1.2  1996/01/18  15:49:05  stephenb
 * Now that the name of the file has changed (nt.h -> win32.h), the
 * ifndef name must change accordingly.
 *
 * Revision 1.1  1994/12/12  14:30:08  jont
 * new file
 *
 *
 */

#ifndef win32_h
#define win32_h


/*  === INTIALISE ===
 *
 *  Intialises the module and adds the nt values to the runtime
 *  environment.
 */

extern void win32_init(void);

#endif
