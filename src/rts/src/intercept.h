/*  ==== CODE VECTOR INTERCEPTION ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
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
