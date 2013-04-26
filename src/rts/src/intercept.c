/*  ==== CODE VECTOR INTERCEPTION ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *  This is rather SPARC specific and will need to be moved later.
 *
 *  Revision Log
 *  ------------
 *  $Log: intercept.c,v $
 *  Revision 1.9  1996/01/08 15:56:35  stephenb
 *  Remove reference to %i0, fixing bug 744.
 *
 * Revision 1.8  1995/09/01  14:33:04  nickb
 * Add CCODE_UNIT_SIZE
 *
 * Revision 1.7  1995/08/31  13:06:43  nickb
 * Change INTERCEPT_LENGTH to allow platform-specific values.
 *
 * Revision 1.6  1994/11/15  15:38:27  nickb
 * Add cache flushing.
 *
 * Revision 1.5  1994/10/19  14:29:43  nickb
 * Use the invalid value from the code_status enum.
 *
 * Revision 1.4  1994/07/13  16:34:26  jont
 * Remove references to i0 for the moment
 *
 * Revision 1.3  1994/06/21  15:59:15  nickh
 * New ancillary structure.
 *
 * Revision 1.2  1994/06/09  14:39:33  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:06:59  nickh
 * new file
 *
 *  Revision 1.4  1993/06/02  13:04:42  richard
 *  Added missing parameters to memcmp() calls.
 *
 *  Revision 1.3  1993/05/18  14:11:32  richard
 *  Added call counting for the profiler.
 *
 *  Revision 1.2  1993/04/26  14:51:09  richard
 *  Increased diagnostic levels.
 *
 *  Revision 1.1  1993/04/15  14:22:46  richard
 *  Initial revision
 *
 */

#include "values.h"
#include "intercept.h"
#include "interface.h"
#include "tags.h"
#include "diagnostic.h"
#include "extensions.h"
#include "profiler.h"
#include "utils.h"
#include "cache.h"

#include <errno.h>
#include <memory.h>

static int blat(mlval code, byte *new)
{
  byte *start;
  int offset;

  DIAGNOSTIC(4, "blat(code = 0x%X, new = 0x%X)", code, new);

  /* Check that the parameter is actually a code object */

  if(PRIMARY(code) != POINTER || SECONDARY(GETHEADER(code)) != BACKPTR)
  {
    DIAGNOSTIC(4, "  not code!", 0, 0);
    errno = EINTERCEPTCODE;
    return(-1);
  }

  /* Check that it can be intercepted */

  offset = CCODEINTERCEPT(code);
  DIAGNOSTIC(4, "  offset = %d", offset, 0);

  if(offset == CCODE_NO_INTERCEPT)
  {
    errno = EINTERCEPTFORM;
    return(-1);
  }

  /* Copy the intercepting instructions into the slot */

  start = (byte*)CCODESTART(code) + offset * CCODE_UNIT_SIZE;
  memcpy(start, new, INTERCEPT_LENGTH);
  cache_flush((void*)start,INTERCEPT_LENGTH);

  return(0);
}

int code_intercept(mlval code)
{
  DIAGNOSTIC(4, "code_intercept(0x%X)  name `%s'", code, CSTRING(CCODENAME(code)));

  return(blat(code,
	      CCODELEAF(code) ? ml_intercept_on_leaf : ml_intercept_on));
}

int code_replace(mlval code)
{
  DIAGNOSTIC(4, "code_replace(0x%X)  name `%s'", code, CSTRING(CCODENAME(code)));

  return(blat(code,
	      CCODELEAF(code) ? ml_replace_on_leaf : ml_replace_on));
}

int code_nop(mlval code)
{
  DIAGNOSTIC(4, "code_nop(0x%X)  name `%s'", code, CSTRING(CCODENAME(code)));

  /* If call-count profiling is operating on this code then change to */
  /* interception rather than nothing. */

  if((unsigned int *)CCODEPROFILE(code) != NULL)
    return(blat(code,
		CCODELEAF(code) ? ml_intercept_on_leaf : ml_intercept_on));
  else
    return(blat(code, ml_nop));
}

enum code_status code_status(mlval code)
{
  byte *start;
  int offset;

  if(PRIMARY(code) != POINTER || SECONDARY(GETHEADER(code)) != BACKPTR)
  {
    errno = EINTERCEPTCODE;
    return CS_INVALID;
  }

  offset = CCODEINTERCEPT(code);

  if(offset == CCODE_NO_INTERCEPT)
  {
    errno = EINTERCEPTFORM;
    return CS_INVALID;
  }

  start = (byte *)CCODESTART(code) + offset * CCODE_UNIT_SIZE;

  if(!memcmp(start, ml_nop, INTERCEPT_LENGTH))
    return(CS_NOP);
  else if(!memcmp(start, ml_intercept_on, INTERCEPT_LENGTH) ||
	  !memcmp(start, ml_intercept_on_leaf, INTERCEPT_LENGTH))
    return(CS_INTERCEPT);
  else if(!memcmp(start, ml_replace_on, INTERCEPT_LENGTH) ||
	  !memcmp(start, ml_replace_on_leaf, INTERCEPT_LENGTH))
    return(CS_REPLACE);

  error("code_status: code 0x%X has unrecognisable instructions in its intercept slot");
}

static inline void count_call(mlval code)
{
  unsigned int *count = (unsigned int *)CCODEPROFILE(code);
  if(count != NULL && !profile_suspended)
    ++*count;
}

void intercept(struct stack_frame *frame)
{
  mlval code, f;

  flush_windows();
  code = FIELD(frame->closure, 0);
  f = CCODEINTERFN(code);

  DIAGNOSTIC(2, "intercept(frame = 0x%X)", frame, 0);
  DIAGNOSTIC(2, "  function `%s'  intercept function `%s'",
	        CSTRING(CCODENAME(code)), CSTRING(CCODENAME(FIELD(f, 0))));
  DIAGNOSTIC(2, "  closure = 0x%X", frame->closure, 0);

  count_call(code);

  if(f != MLUNIT)
    callml((mlval)frame, f);
}

void replace(struct stack_frame *frame)
{
  mlval code, f;

  flush_windows();
  code = FIELD(frame->closure, 0);
  f = CCODEINTERFN(code);

  DIAGNOSTIC(2, "replace(frame = 0x%X)", frame, 0);
  DIAGNOSTIC(2, "  function `%s'  replace function `%s'",
	        CSTRING(CCODENAME(code)), CSTRING(CCODENAME(FIELD(f, 0))));
  DIAGNOSTIC(2, "  closure = 0x%X", frame->closure, 0);

  count_call(code);

  if(f != MLUNIT)
    callml((mlval)frame, f);
}

