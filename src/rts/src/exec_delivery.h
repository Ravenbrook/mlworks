/*  ==== EXECUTABLE FILE DELIVERY AND EXECUTION ====
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
 *  This code deals with delivery executables rather than heap images.
 *  There are two halves to this. Firstly, writing such an object,
 *  and secondly, rerunning it
 *
 *  $Log: exec_delivery.h,v $
 *  Revision 1.5  1998/04/14 12:42:06  mitchell
 *  [Bug #50061]
 *  Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.4  1997/11/26  10:09:56  johnh
 * [Bug #30134]
 * save_exceutable takes extra arg to save exe as console or windows app.
 *
 * Revision 1.3  1996/08/27  16:29:01  nickb
 * Change return values for load_.
 *
 * Revision 1.2  1996/05/01  08:53:16  nickb
 * Change to save_executable.
 *
 * Revision 1.1  1995/09/26  15:15:26  jont
 * new unit
 *
 */

#ifndef exec_delivery_h
#define exec_delivery_h

#include "mltypes.h"

#define APP_CONSOLE 0
#define APP_WINDOWS 1
#define APP_CURRENT 2

extern mlval save_executable(char *to, mlval heap, int console_app);
/* Save a re-executable version of the current system */
/* We need to know where the current runtime is */ 
/* in order to acquire its other sections */
/* returns 0 if ok, 1 on error of some sort (with errno set) */

extern int load_heap_from_executable
  (mlval *heap, const char *runtime, int just_check);
/* Reload the heap from within the executable, or just check if there is
   such an executable */

/* Returns: */
/* 0 if done */
/* 1 if no image section or exec images not supported (in which case
   we continue as before) */
/* 2 if an error has occurred and errno is set */

#endif
