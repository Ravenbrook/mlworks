/*  ==== CODE VECTOR INTERCEPTION ====
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
 *  Code vectors are intercepted by altering them to call a special routine.
 *  The functions below take care of this alteration and with dispatching
 *  the intercepted flow of control.
 *
 *  Revision Log 
 *  ------------
 *  $Log: intercept.h,v $
 *  Revision 1.3  1994/10/19 14:29:03  nickb
 *  Need an invalid value in code_status enum.
 *
 * Revision 1.2  1994/06/09  14:39:54  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:07:26  nickh
 * new file
 *
 *  Revision 1.1  1993/04/15  12:57:33  richard
 *  Initial revision
 *
 */

#ifndef intercept_h
#define intercept_h

#include "mltypes.h"
#include "stacks.h"

/*  === INTERCEPT/REPLACE CODE VECTOR ===
 *
 *  code_intercept() alters a code vector so that it calls intercept()
 *  instead of executing.  code_replace() alters it so that it calls
 *  replace().  code_nop() restores its original behaviour.  They return zero
 *  on success and set errno otherwise.
 */

enum /* errno */
{
  EINTERCEPTCODE = 1,	/* Object is not a code vector */
  EINTERCEPTFORM	/* Code vector not compiled with interception slot */
};

extern int code_intercept(mlval code);
extern int code_replace(mlval code);
extern int code_nop(mlval code);


/*  === TEST STATUS OF A CODE VECTOR ===
 *
 *  May return -1 and set errno.
 */

enum code_status
{
  CS_INTERCEPT, CS_REPLACE, CS_NOP, CS_INVALID
} code_status(mlval code);


/*  === INTERCEPTION/REPLACEMENT HANDLERS ===
 *
 *  These are called by the code in the ML to C interface and should not be
 *  called directly.  They apply the function pointed to by the ancillary
 *  slot INTERFNS to the stack frame.  The result of this function is
 *  discarded.
 */

extern void intercept(struct stack_frame *frame);
extern void replace(struct stack_frame *frame);



#endif
