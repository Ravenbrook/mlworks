/*  ==== C HEAP MANAGER ====
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
 * Description
 * -----------
 *
 * MLWorks provides replacements for the system versions of 
 * calloc(), malloc(), realloc(), and free().  This is currently necessary
 * to avoid the system versions being used and potentially fouling up the
 * MLWorks memory manager.
 *
 * Some OSes don't have ANSI compatible header files and so don't declare
 * the necessary prototypes in <stdlib.h>, or if they do they don't match
 * the ANSI spec.  For such OSes create rts/src/OS/$(OS)/alloc.h and put
 * the correct prototypes in it.  See rts/src/OS/SunOS/alloc.h for an
 * example.
 * 
 * Revision Log
 * ------------
 *  $Log: alloc.h,v $
 *  Revision 1.3  1996/07/31 12:14:03  stephenb
 *  Replace the explicit malloc/calloc/realloc/free definitions with
 *  #include <stdlib.h> so that the (hopefully) standard platform
 *  declarations are used instead.
 *
 * Revision 1.2  1994/06/09  14:31:53  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:56:44  nickh
 * new file
 *
 *  Revision 1.6  1993/06/02  13:01:33  richard
 *  Commented out the prototypes of malloc, free, etc.  These shouldn't
 *  really be duplicated here.
 *
 *  Revision 1.5  1993/01/22  16:46:41  richard
 *  Corrected header comment.
 *
 *  Revision 1.4  1992/10/02  08:33:59  richard
 *  Changed types to become non-standard but compatable with GCC across
 *  platforms.
 *
 *  Revision 1.3  1992/07/17  14:15:17  richard
 *  Removed init_alloc(), and caused allocation to automatically request
 *  an initial area when first called.  This simplifies the interface to
 *  the memory manager.
 *
 *  Revision 1.2  1992/06/30  08:22:04  richard
 *  Moved ALLOC_INITIAL_MINIMUM to storeman.h and changed to to C_HEAP_MINIMUM.
 *
 *  Revision 1.1  1992/01/17  11:46:11  richard
 *  Initial revision
 */


#ifndef alloc_h
#define alloc_h

#include <stdlib.h>		/* malloc, free, realloc, calloc */

#endif
