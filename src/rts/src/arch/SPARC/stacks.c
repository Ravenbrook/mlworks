/*  === SPARC STACK ROUTINES ===
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
 * All architecture-dependent routines that deal with the stack.
 *
 *  Revision Log
 *  ------------
 *  $Log: stacks.c,v $
 *  Revision 1.20  1998/09/17 15:22:04  jont
 *  [Bug #20124]
 *  Use validate_address in is_ml_heap/is_ml_stack
 *
 * Revision 1.19  1998/04/24  10:32:05  jont
 * [Bug #70034]
 * TYPE_STACK has become TYPE_ML_STACK
 *
 * Revision 1.18  1998/03/18  11:16:50  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.17  1998/03/03  14:22:52  jont
 * [Bug #70018]
 * Allow explorer to search stack for heap values
 *
 * Revision 1.16  1997/06/03  16:27:04  jont
 * [Bug #30076]
 * Modify to make NONGC spills be counted in words
 *
 * Revision 1.15  1997/05/30  10:43:52  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.14  1996/11/15  15:17:42  jont
 * [Bug #1781]
 * Remove the assertion until we know what it should be doing.
 *
 * Revision 1.13  1996/11/07  17:23:35  stephenb
 * [Bug #1461]
 * Must not construct fake frames for non-leaf functions, as
 * they do not contain values which the GC and the debugger expect
 * them to. This can lead to fatal failure of either the GC or
 * the debugger (e.g. indexing down from an fp which does not
 * point to the top of a genuine stack frame).
 *
 * Revision 1.12  1996/11/05  12:25:22  stephenb
 * [Bug #1441]
 * frame_next: change the offset to be a byte rather than word
 * offset since instructions are not word aligned on an I386 and
 * so the debugger has been changed to expect byte offsets.
 *
 * Revision 1.11  1996/02/14  17:28:21  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.10  1996/02/12  15:59:13  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.9  1996/01/11  17:24:46  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.8  1995/11/21  14:44:42  jont
 * Add debugger call to get pointer into frame for accessing reals
 *
 * Revision 1.7  1995/05/30  10:16:57  nickb
 * Add frame_argument function.
 *
 * Revision 1.6  1995/03/29  14:30:28  nickb
 * Threads system.
 *
 * Revision 1.5  1995/03/07  17:28:17  matthew
 * Adding is_top_frame ML function
 *
 * Revision 1.4  1995/03/01  10:37:14  matthew
 * Adding flush_windows to current
 *
 * Revision 1.3  1994/06/21  15:58:40  nickh
 * New ancillary structure.
 *
 * Revision 1.2  1994/06/09  14:30:53  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:55:28  nickh
 * new file
 *
 *
 */

#include <assert.h>		/* assert */
#include "mltypes.h"
#include "diagnostic.h"
#include "values.h"
#include "stacks.h"
#include "arena.h"
#include "mem.h"
#include "fixup.h"
#include "environment.h"
#include "state.h"
#include "interface.h"
#include "utils.h"
#include "allocator.h"
#include "ansi.h"
#include "tags.h"
#include "explore.h"
#include "ml_utilities.h"

/* First the GC stack-crawling code.
 *
 *  NOTE: 1. This code is highly SPARC-specific
 *        2. Register windows need to have been flushed before entry
 *
 *  This function fixes the stack contents between GC_SP and the
 *  first frame pointer since entry to ML.  fix() is called on any
 *  GC values, and link registers (return addresses) are shifted to
 *  correspond with any movement of code.
 *
 *  On entry GC_SP should point the last save area that needs to be fixed.
 *  This area contains the link register which points into the innermost
 *  executing ML function, i.e., the last link that needs fixing.
 *
 *  The obvious one-pass version of this will not work because a
 *  closure may be referred to by more than one frame.  If the closure
 *  is fixed the first time it is seen then information is lost and
 *  later link registers will not be fixed.
 *
 *  The number of non-GC spills in each frame is fetched from the
 *  first word of the code vector.
 */

extern void stack_crawl_phase_one(void)
{
  struct thread_state *thread;
  struct stack_frame *sp;

  flush_windows();
  DIAGNOSTIC(4, "stack_crawl first pass", 0, 0);

  for (thread= TOP_THREAD.next; thread != &TOP_THREAD; thread = thread->next) {
    DIAGNOSTIC(4,"  thread %d",thread->number, 0);
    /* turn each ML link slot into an offset from the closure code address */
    for(sp = GC_SP(thread); sp != NULL; sp = sp->fp) {
      if(TYPE(sp->fp) == TYPE_ML_STACK) { /* it's a GCable frame */
	if (SPACE_TYPE(sp->lr) == TYPE_FROM) { /* make the link relative */
	  struct stack_frame *fp = sp->fp;
	  mlval codeptr = FIELD(fp->closure, 0);
	  DIAGNOSTIC(5, "  frame 0x%X  next 0x%X", sp, fp);
	  DIAGNOSTIC(5, "    lr 0x%X from `%s'", sp->lr,
		     CSTRING(CCODENAME(codeptr)));
	  if (sp->lr && pc_in_closure(sp->lr, fp->closure)) {
	    sp->lr -= codeptr;			 /* NB: no longer aligned */
	  }
	  DIAGNOSTIC(5, "    lr is 0x%X+0x%X", codeptr, sp->lr);
	} 
      }
    }
  }
}

extern mlval *stack_crawl_phase_two(mlval *to)
{
  struct thread_state *thread;
  struct stack_frame *sp;
    
  DIAGNOSTIC(4, "stack_crawl(to = 0x%X):", to, 0);
  DIAGNOSTIC(4, " second pass", 0, 0);

  /* Now fix everything on the stacks, restoring the link slots as we go */

  for (thread= TOP_THREAD.next; thread != &TOP_THREAD; thread = thread->next) {
    DIAGNOSTIC(4,"  thread %d",thread->number, 0);
    for(sp = GC_SP(thread); sp != NULL; sp = sp->fp) {
      struct stack_frame *fp = sp->fp;
      if (TYPE(sp->fp) == TYPE_ML_STACK) {
	DIAGNOSTIC(5, "  frame 0x%X (to = 0x%X)", sp, to);
	
	if(MLVALISPTR(fp->closure)) {
	  mlval *top, closure, code;
	  fix(to, &fp->closure);		/* fix the caller's closure */
	  closure = fp->closure;
	  fix(to, &FIELD(closure, 0));	/* fix the caller's code vector */
	  code = FIELD(closure, 0);
	  
	  /* if the link address is unaligned, it must be restored: */
	  if(word_align(sp->lr) != sp->lr) {
	    DIAGNOSTIC(5, "    lr is 0x%X+0x%X", code, sp->lr);
	    sp->lr += code;    
	    DIAGNOSTIC(5, "    fixed to 0x%X", sp->lr, 0);
	  }
	  
	  top = (mlval *)fp->fp - CCODENONGC(code);
	  scan((mlval *)(sp->fp+1), top, to); /* fix stack allocated area */
		  /* (sp->fp+1 is the top of the struct stack_frame) */
	}
	/* Now fix the register slots */
	fix_reg(to, &sp->l0); fix_reg(to, &sp->l1); fix_reg(to, &sp->l2);
	fix_reg(to, &sp->l3); fix_reg(to, &sp->l4); fix_reg(to, &sp->l5);
	fix_reg(to, &sp->l6); fix_reg(to, &sp->l7);
	
	fix_reg(to, &sp->i0); fix_reg(to, &sp->closure); fix_reg(to, &sp->i2);
	fix_reg(to, &sp->i3); fix_reg(to, &sp->i4); fix_reg(to, &sp->i5);
      }
    }
  }
  return(to);
}

#ifdef EXPLORER

/* The explorer needs to find any potential roots on the stacks. */

extern void explore_stacks(void)
{
  struct thread_state *thread;
  struct stack_frame *sp;

  flush_windows();
  for (thread= TOP_THREAD.next; thread != &TOP_THREAD; thread = thread->next) {
    for(sp = GC_SP(thread); sp != NULL; sp = sp->fp) {
      struct stack_frame *fp = sp->fp;
      if (TYPE(sp->fp) == TYPE_ML_STACK) {
	if(MLVALISPTR(fp->closure)) {	/* there may be stack allocation */
	  mlval *top, code;
	  code = FIELD(fp->closure, 0);
	  top = (mlval *)fp->fp - CCODENONGC(code);
	  explore_stack_allocated(thread, fp, (mlval *)(fp+1), top); 
		  /* fp+1 is the top of the struct stack_frame */
	}
	explore_stack_registers(thread, sp, &sp->l0, &sp->i5);
      }
    }
  }
}

#endif

/* Stack backtrace */

static const char *code_vector_name(word closure)
{
  if (validate_ml_address(&(FIELD(closure, 0)))) {
    word code = FIELD(closure, 0);
    if (validate_ml_address((void *)code) && validate_ml_address((void *)(OBJECT(code)))) {
      if (validate_ml_address(&(CCODEANCILLARY(code))) &&
	  validate_ml_address(&(CCODEANCRECORD(code, NAMES))) &&
	  validate_ml_address(&(CCODEANCVALUE(code, NAMES))) &&
	  validate_ml_address(CSTRING(CCODENAME(code)))) {
	return CSTRING(CCODENAME(code));
      } else {	
	return "invalid code ancillary";
      }
    } else {
      return "invalid code pointer";
    }
  } else {
    return "invalid closure";
  }
}

int max_backtrace_depth = 50;

void backtrace(struct stack_frame *sp, struct thread_state *thread,
	       int depth_max)
{
  message_content("Stack backtrace\n");
  if (sp == NULL)
    message_content("  No stack!\n");
  else if ((word)sp == thread->ml_state.stack_top)
    message_content("  %p empty stack.\n",sp);
  if (validate_address(&sp->closure)) {
    if (!is_ml_stack(sp)) {
      message_content("  %p closure 0x%08X\n", sp, sp->closure);
      if (validate_address(&sp->fp)) sp = sp->fp;
    }
  } else {
    message_content("  %p cannot read closure address %p\n", sp, &sp->closure);
    if (validate_address(&sp->fp)) sp = sp->fp;
  }
  while(depth_max-- && sp) {
    if(is_ml_stack(sp)) {
      if (validate_address(&sp->closure)) {
	const char *name =
	  MLVALISPTR(sp->closure) ? code_vector_name(sp->closure) :
	  sp->closure == STACK_START ? "stack start" :
	  sp->closure == STACK_DISTURB_EVENT ? "disturb event" :
	  sp->closure == STACK_EXTENSION ? "stack extension" :
	  sp->closure == STACK_RAISE ? "raise" :
	  sp->closure == STACK_EVENT ? "asynchronous event handler" :
	  sp->closure == STACK_C_RAISE ? "raise from C" :
	  sp->closure == STACK_C_CALL ? "call to C" :
	  sp->closure == STACK_INTERCEPT ? "intercept" :
	  sp->closure == STACK_SPACE_PROFILE ? "space profile" : "special";
	message_content("  %p closure 0x%08X: ", sp, sp->closure);
	message_string(name);
	message_string("\n");
      } else {
	message_content("  %p cannot read closure address %p\n",
			sp, &sp->closure);
	break;
      }
    }
    if (validate_address(&sp->fp)) {
      sp = sp->fp;
    } else {
      break;
    }
  }
  if (sp == NULL || (word)sp == thread->ml_state.stack_top)
    message_content("--- base of stack --- \n");
  else if (depth_max > 0 && !validate_address(&sp->fp)) {
    /* Not at top of stack, but address invalid */
    message_content("  %p cannot read frame address %p\n", sp, &sp->fp);
  }
}

/* A SPARC stack frame contains ML values iff its frame pointer points
 * into an ML stack area. */

mlval is_ml_frame(struct stack_frame *sp)
{
  mlval closure = sp->closure;

  if(ISORDPTR(closure) && validate_ml_address((void *)closure)) {
    mlval secondary = SECONDARY(GETHEADER(closure));
    if(secondary == RECORD || secondary == 0) {
      mlval code = FIELD(closure, 0);
      if(validate_ml_address((void *)code) && PRIMARY(code) == POINTER &&
	 SECONDARY(GETHEADER(code)) == BACKPTR)
	return(code);
    }
  }
  return(MLUNIT);
}

/* Pervasive stack functions */

/* These first few are not SPARC-specific, assuming we have an fp, the
 * stack is full descending, &c */

static mlval ml_is_ml_frame (mlval frame)
{
  if (is_ml_frame ((struct stack_frame *)frame) == MLUNIT)
    return MLFALSE;
  else
    return MLTRUE;
}

static mlval ml_is_top_frame (mlval frame)
{
  struct stack_frame *sp = (struct stack_frame *)frame;
  if (sp->fp == NULL)
    return MLTRUE;
  else
    return MLFALSE;
}

static mlval flush(mlval arg)
{
  flush_windows();		/* I assume this is a nop on non-SPARCs */
  return(MLUNIT);
}

/* This returns the frame of the ML function calling it */

static mlval current(mlval arg)
{
  flush_windows();
  return((mlval)(GC_SP(CURRENT_THREAD)->fp));
}

static mlval sub(mlval arg)
{
  struct stack_frame *sp = (struct stack_frame *)FIELD(arg, 0);
  int index = CINT(FIELD(arg, 1));

  flush_windows();
  return(((mlval *)sp)[index]);
}

static mlval update(mlval arg)
{
  ((mlval *)FIELD(arg, 0))[CINT(FIELD(arg, 1))] = FIELD(arg, 2);
  return(MLUNIT);
}

static mlval frame_call(mlval argument)
{
  flush_windows();

  return(callml((mlval)GC_SP(CURRENT_THREAD), argument));
}

static mlval frame_offset(mlval argument)
{
  struct stack_frame *sp = (struct stack_frame *)FIELD(argument, 0);
  int index = CINT(FIELD(argument, 1));
  return(*((mlval *)(((int)(sp->fp))+index)));
}

static mlval frame_double(mlval argument)
{
  struct stack_frame *sp = (struct stack_frame *)FIELD(argument, 0);
  int index = CINT(FIELD(argument, 1)); /* This is a pointer to an unboxed double */
  mlval real = allocate_real();
  char *ptr = (char *)(((int)(sp->fp))+index);
  memcpy (((char *)real)+(8-POINTER), ptr, 8); /* Copy into double from stack */
  return (real);
}

/* Now these are SPARC-specific */

static mlval frame_next(mlval arg)
{
  mlval result;
  struct stack_frame *sp = (struct stack_frame *)arg;

  flush_windows();

  result = allocate_record(3);

  while(sp->fp != NULL)
  {
    mlval code= is_ml_frame(sp->fp);
    if(code != MLUNIT) {
      word code_start_addr= (word)CCODESTART(code);
      word call_addr= sp->lr;
      word call_offset= call_addr - code_start_addr;
/* Temporarily removed until we know what it should do with STACK_RAISE frames
      assert(code_start_addr < call_addr);
*/
      FIELD(result, 0) = MLTRUE;
      FIELD(result, 1) = (mlval)sp->fp;
      FIELD(result, 2) = MLINT(call_offset);
      return(result);
    } else {
      FIELD(result,0) = MLTRUE;
      FIELD(result, 1) = (mlval)sp->fp;
      FIELD(result,2) = MLINT(0);
      return(result);
    }

    sp = sp->fp;
  }

  /* No frames on the stack! */

  FIELD(result, 0) = MLFALSE;
  FIELD(result, 1) = MLUNIT;
  FIELD(result, 2) = MLINT(0);

  return(result);
}

static mlval frame_argument(mlval frame)
{
  struct stack_frame *sp = (struct stack_frame *) frame;
  return (sp->i0);
}

static mlval frame_allocations(mlval frame)
{
  struct stack_frame *sp = (struct stack_frame *)frame;

  if (((int)sp) < 0)
    return(MLFALSE);
    
  switch(((int)(sp->fp))-((int)(sp))-64)
    {
      case 0 : 
	{
	  return(MLFALSE);
	}
      default :
	{
	  return(MLTRUE);
	}
    }
}

void stacks_init()
{
  env_function("stack flush", flush);
  env_function("stack frame sub", sub);
  env_function("stack frame update", update);
  env_function("stack frame current", current);
  env_function("stack is ml frame", ml_is_ml_frame);
  env_function("stack is top frame", ml_is_top_frame);
  env_function("debugger frame call", frame_call);
  env_function("debugger frame next", frame_next);
  env_function("debugger frame sub", sub);
  env_function("debugger frame offset", frame_offset);
  env_function("debugger frame double", frame_double);
  env_function("debugger frame argument", frame_argument);
  env_function("debugger frame allocations", frame_allocations);
}
