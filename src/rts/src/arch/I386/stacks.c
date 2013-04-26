/*  === INTEL x86 STACK ROUTINES ===
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
 *  Revision 1.33  1998/09/17 15:22:35  jont
 *  [Bug #20124]
 *  Remove compiler warning and improve backtrace and is_ml_frame
 *
 * Revision 1.32  1998/07/15  15:20:26  jont
 * [Bug #20124]
 * Stop assuming all code and closures must be on ml heap
 *
 * Revision 1.31  1998/03/19  11:54:25  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.30  1998/03/03  17:17:33  jont
 * [Bug #70018]
 * Split stack_crawl into two phases
 *
 * Revision 1.29  1998/02/13  15:07:16  jont
 * [Bug #30242]
 * Use ml_utilities for function pc_in_clousre when finxing return addresses
 *
 * Revision 1.28  1997/06/05  12:45:56  jont
 * [Bug #30076]
 * More work for stack parameter passing, getting the gc scan right.
 *
 * Revision 1.27  1997/06/03  16:28:48  jont
 * [Bug #30076]
 * Modify to make NONGC spills be counted in words
 *
 * Revision 1.26  1997/06/02  17:02:22  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.25  1996/11/18  15:05:31  nickb
 * Fix stack_crawl to fit new stack invariants.
 *
 * Revision 1.24  1996/11/14  15:19:05  stephenb
 * [Bug #1760]
 * frame_next: Change the offset from 0 to 1 since 0 is used to
 * indicate that the frame is a C frame.
 *
 * Revision 1.23  1996/11/14  09:54:29  stephenb
 * [Bug #1760]
 * See .fake_frame in the comment associated with frame_next.
 *
 * Revision 1.22  1996/11/07  17:41:33  stephenb
 * [Bug #1461]
 * Fix stack closure tags.
 *
 * Revision 1.21  1996/11/04  14:12:53  stephenb
 * [Bug #1441]
 * frame_next: change the offset to be a byte rather than word
 * offset since instructions are not word aligned on an I386.
 *
 * Revision 1.20  1996/10/04  13:05:47  stephenb
 * [Bug #1445]
 * frame_next: adjust the offset calculated for an ML frame so that
 * it produces values that correctly index into the debugger annotation
 * tables.
 *
 * Revision 1.19  1996/02/14  17:35:14  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.18  1996/02/14  13:11:36  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.17  1996/02/14  11:06:02  jont
 * Fixing some compiler warnings under VC++
 *
 * Revision 1.16  1996/01/11  17:23:58  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.15  1995/12/18  15:58:52  matthew
 * Fixing bungle with last change
 *
 * Revision 1.14  1995/12/18  13:53:27  matthew
 * Adding set_frame_return_value
 *
 * Revision 1.13  1995/11/21  14:32:04  jont
 * Add debugger_double for getting floats straight from spills
 *
 * Revision 1.12  1995/05/30  10:18:09  nickb
 * Add frame_argument function.
 *
 * Revision 1.11  1995/05/24  10:43:27  nickb
 * Fix all the register save frames, not just one.
 *
 * Revision 1.10  1995/05/05  12:04:03  nickb
 * Remove some SPARCisms.
 *
 * Revision 1.9  1995/04/25  13:21:30  nickb
 * Bug in stack_crawl fixing up return addresses.
 *
 * Revision 1.8  1995/03/29  14:13:38  nickb
 * Threads system.
 *
 * Revision 1.7  1995/03/20  13:58:50  matthew
 * Adding is_top_frame function
 *
 * Revision 1.6  1995/03/02  13:52:29  matthew
 * Adding is_ml_frame
 *
 * Revision 1.5  1995/02/27  16:16:14  nickb
 * TYPE_LARGE becomes TYPE_STATIC
 *
 * Revision 1.4  1994/12/02  16:04:03  jont
 * Avoid running off stack tops
 *
 * Revision 1.3  1994/10/12  11:41:31  jont
 * Modify link address fixing to be done for all ml link addresses
 *
 * Revision 1.2  1994/10/07  11:08:06  jont
 * Make it Intel architecture specific
 *
 * Revision 1.1  1994/10/04  16:55:28  jont
 * new file
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

#include <string.h>

/* First the GC stack-crawling code.
 *
 *  NOTE: This code is highly Intel-specific
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

#define prev_slot(sp) ((mlval *)((unsigned int)(sp)-4))

#define return_slot(frame,args)      (((mlval*)(frame)->fp)-args-1)
#define return_address(frame,code)   return_slot(frame,CCODEARGS(code))

#define final_frame(sp,thread) ((word)((sp)->fp)==(thread)->ml_state.stack_top)

/* fix a 'non-ML frame', i.e. a frame created in the ML/C interface,
 * consisting solely of GCable values */

static inline mlval *fix_non_ML_frame(struct stack_frame *sp, mlval *to)
{
  mlval *base = prev_slot(sp+1);
  mlval *top = prev_slot(sp->fp);
  if (sp->closure == STACK_EXTENSION) {
    /* then this should be a stack extension frame, and the fp should 
     * lie on a different arena block. Note that "fp is in different arena
     * block" is not a sufficient test for stack extensions, as stack sections
     * can cover more than one arena block, in the case where an ML function
     * has in the past requested a huge stack frame. */
    DIAGNOSTIC(5,"    stack extension frame 0x%08x, fp 0x%08x",sp,sp->fp);
    if (SPACE(top) == SPACE(base) && BLOCK_NR(top) == BLOCK_NR(base)) {
      DIAGNOSTIC(1, "EXTENSION frame [0x%08x,0x%08x] not on block boundary",
		 sp, sp->fp);
    } else {
      top = (mlval*)(BLOCK_BASE(SPACE(base),BLOCK_NR(base)+1));
    }
  }
  while (base < top) {
    fix_reg(to, base);
    base++;
  }
  return to;
}

extern void stack_crawl_phase_one(void)
{
  struct thread_state *thread;
  struct stack_frame *sp;
  DIAGNOSTIC(4, "stack_crawl first pass", 0, 0);

  for (thread = TOP_THREAD.next; thread != &TOP_THREAD; thread =thread->next) {
    mlval *ret_addr;
    DIAGNOSTIC (4, "  thread %d", thread->number,0);
    sp = GC_SP(thread);
    if (!is_stack_top(sp,thread)) {
      /* turn each ML link slot into an offset from the closure code address */
      ret_addr = return_slot(sp,0);
      for(; !final_frame(sp,thread); sp = sp->fp) {
	struct stack_frame *fp = sp->fp;
	if(MLVALISPTR(sp->closure)) {
	  mlval codeptr = FIELD(sp->closure, 0);
	  DIAGNOSTIC(5, "   frame 0x%X  next 0x%X", sp, fp);
	  DIAGNOSTIC(5, "     lr 0x%X from `%s'", *ret_addr,
		     CSTRING(CCODENAME(codeptr)));
	  if (*ret_addr) {
	    assert(pc_in_closure(*ret_addr, sp->closure));
	    *ret_addr -= codeptr;
	  }
	  DIAGNOSTIC(5, "     lr is 0x%X+0x%X", codeptr,
		     ret_addr);
	  ret_addr = return_address(fp, codeptr);
	} else {
	  ret_addr = return_slot(fp,0);
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
  /* Now fix everything on the stacks,  restoring link slots as we go */

  for (thread = TOP_THREAD.next; thread != &TOP_THREAD; thread =thread->next) {
    DIAGNOSTIC (4, "  thread %d", thread->number,0);
    sp = GC_SP(thread);
    if (!is_stack_top(sp,thread)) {
      mlval *ret_addr = return_slot(sp,0);
      to = fix_non_ML_frame(sp,to);	/* first frame is never an ML frame */
      for(; !final_frame(sp,thread); sp = sp->fp) {
	struct stack_frame *fp = sp->fp;
	DIAGNOSTIC(5, "  frame 0x%X (to = 0x%X)", sp, to);
	
	if(MLVALISPTR(sp->closure)) { /* then fp is an ML frame */
	  mlval *top, *base, closure, code;
	  fix(to, &sp->closure);		/* fix the caller's closure */
	  closure = sp->closure;
	  fix(to, &FIELD(closure, 0));	/* fix the caller's code vector */
	  code = FIELD(closure, 0);

	  /* restore the link address */
	  DIAGNOSTIC(5, "    lr is 0x%X+0x%X", code, *ret_addr);
	  if (*ret_addr) {
	    *ret_addr += code;
	  }
	  DIAGNOSTIC(5, "    fixed to 0x%X", *ret_addr, 0);
	  /* scan the arguments */
	  top = (mlval*)(fp->fp);
	  base = top-CCODEARGS(code);
	  scan(base, top, to);

	  /* scan the gc spills and saves */
	  top = (mlval*)(fp->fp) - CCODEARGS(code) - 1
	                         - (CCODENONGC(code));
	  base = prev_slot(fp+1);	 	  /* top of the stack_frame */
	  scan(base, top, to);
	  ret_addr = return_address(fp, code);
	} else {
	  to = fix_non_ML_frame(fp,to);
	  ret_addr = return_slot(fp,0);
	}
      }
    }
  }
  return(to);
}

#ifdef EXPLORER

/* The explorer needs to find any potential roots on the stacks. */

static void explore_non_ML_frame(struct thread_state *thread,
				 struct stack_frame *sp)
{
  mlval *base = prev_slot(sp+1);
  mlval *top = prev_slot(sp->fp);
  if (sp->closure == STACK_EXTENSION) {
    /* then this should be a stack extension frame, and the fp should 
     * lie on a different arena block. Note that "fp is in different arena
     * block" is not a sufficient test for stack extensions, as stack sections
     * can cover more than one arena block, in the case where an ML function
     * has in the past requested a huge stack frame. */
    if (SPACE(top) == SPACE(base) && BLOCK_NR(top) == BLOCK_NR(base)) {
      /* do nothing */
    } else {
      top = (mlval*)(BLOCK_BASE(SPACE(base),BLOCK_NR(base)+1));
    }
  }
  explore_stack_registers(thread,sp,base,top);
}

extern void explore_stacks(void)
{
  struct thread_state *thread;
  struct stack_frame *sp;

  for (thread = TOP_THREAD.next; thread != &TOP_THREAD; thread =thread->next) {
    sp = GC_SP(thread);
    if (!is_stack_top(sp,thread)) {
      explore_non_ML_frame(thread,sp);
      for(; !final_frame(sp,thread); sp = sp->fp) {
	struct stack_frame *fp = sp->fp;
	
	if(MLVALISPTR(sp->closure)) {
	  mlval *top, *base, code;
	  explore_stack_registers(thread,sp,&sp->closure, (&sp->closure)+1);
	  code = FIELD(sp->closure, 0);

	  /* arguments */
	  top = (mlval*)(fp->fp);
	  base = top-CCODEARGS(code);
	  explore_stack_allocated(thread, fp, base, top);

	  /* gc spills and saves */
	  top = (mlval*)(fp->fp) - CCODEARGS(code) - 1
	                         - (CCODENONGC(code));
	  base = prev_slot(fp+1); 		  /* top of the stack_frame */
	  explore_stack_allocated(thread,fp, base, top);
	} else {
	  explore_non_ML_frame(thread, fp);
	}
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

int max_backtrace_depth = 25;

void backtrace(struct stack_frame *sp, struct thread_state *thread,
	       int depth_max)
{
  message_content("Stack backtrace\n");
  if (!sp)
    message_content("  No stack!\n");
  else if ((word)sp == thread->ml_state.stack_top)
    message_content("  %p empty stack.\n",sp);
  else {
    while(depth_max-- && sp &&
	  (word)sp != thread->ml_state.stack_top) {
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
}

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

/* These first few are not I386-specific, assuming we have an fp, the
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
  
  if (is_stack_top(sp->fp,CURRENT_THREAD))
    return (MLTRUE);
  else
    return (MLFALSE);
}

static mlval flush(mlval arg)
{
  return(MLUNIT);
}

static mlval current(mlval arg)
{
  return((mlval)GC_SP(CURRENT_THREAD)->fp);
}

static mlval sub(mlval arg)
{
  struct stack_frame *sp = (struct stack_frame *)FIELD(arg, 0);
  int index = CINT(FIELD(arg, 1));

  return(((mlval *)sp)[index]);
}

static mlval update(mlval arg)
{
  ((mlval *)FIELD(arg, 0))[CINT(FIELD(arg, 1))] = FIELD(arg, 2);
  return(MLUNIT);
}

static mlval frame_call(mlval argument)
{
  flush_windows(); /* a nop on non-SPARCs */

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

/* Now these are I386-specific */


/*
 * All the following sizes are in bytes.
 */
#define mlw_i386_call_instr_size 1
#define mlw_i386_call_addr_size 4
#define mlw_i386_call_size (mlw_i386_call_instr_size+mlw_i386_call_addr_size)


/*
 * Returns a triple: (isMLFrame:bool, framePointer:mlval, instrByteOffset:int)
 *
 * The instrByteOffset is only meaningful if the frame is an ML frame
 * and not a fake frame (see .fake-frame below).
 * 
 * If the frame is a C frame then instrByteOffset is 0.
 *
 * It is possible that there are no frames and in that case
 * isMLFrame = false and framePointer = MLUNIT.
 *
 * .fake-frame: In certain cicumstances a fake frame is pushed on the stack 
 * (see <URI:hope//MLWsrc/rts/arch/I386/interface.S#ml_raise>).  Such a frame
 *  can be distinguished from normal frames in two ways :-
 * 
 *   1. The return address in the stack frame is set to zero.
 *   2. The frame above it on the stack will have STACK_RAISE in the closure
 *      field.
 * 
 * The debugger (currently) doesn't have any special knowledge of thse fake 
 * frames and so treats them like any other ML frame.  Consequently the 0 
 * return address has to be dealt with here to avoid the calculation of 
 * instrByteOffset generating a large negative number.
 */

/*
 * This is the offset that is returned in a fake frame.
 * It cannot be 0 because a 0 offset is interpreted as meaning
 * that the frame is a C frame 
 * <URI:hope://MLWsrc/debugger/_newtrace.sml#gather_recipes>
 * It should not match a real offset to avoid the debugger
 * incorrectly deriving a type for the associated function.
 * It probably shouldn't be a negative value so the following
 * is a compromise.
 */
#define mlw_fake_frame_offset 1


static mlval frame_next(mlval arg)
{
  mlval result;
  struct stack_frame *sp = (struct stack_frame *)arg;

  result= allocate_record(3);
  if (!is_stack_top(sp->fp,CURRENT_THREAD)) {
    mlval code= is_ml_frame(sp->fp);
    if(code != MLUNIT) { /* it's an ML frame */
      word code_start_addr= (word)CCODESTART(code);
      mlval sp_code = is_ml_frame(sp);
      word arguments = (sp_code == MLUNIT) ? 0 : CCODEARGS(sp_code);
      word return_addr = *return_slot(sp->fp, arguments);
      word call_offset= return_addr - code_start_addr - mlw_i386_call_size;
      if (return_addr == 0)	/* see .fake_frame */
	call_offset= mlw_fake_frame_offset;
      else
	assert(code_start_addr < return_addr);
      FIELD(result, 0) = MLTRUE;
      FIELD(result, 1) = (mlval)sp->fp;
      FIELD(result, 2) = MLINT(call_offset);
    } else { /* not an ML frame */
      FIELD(result,0) = MLTRUE;
      FIELD(result, 1) = (mlval)sp->fp;
      FIELD(result,2) = MLINT(0);
    }
  } else { /* No frames on the stack! */
    FIELD(result, 0) = MLFALSE;
    FIELD(result, 1) = MLUNIT;
    FIELD(result, 2) = MLINT(0);
  }
  return(result);
}



static mlval frame_argument(mlval frame)
{
  struct stack_frame *sp = (struct stack_frame *)frame;
  mlval code = FIELD(sp->closure,0);
  int saves = CCODESAVES(code);
  struct stack_frame *fp = sp->fp;
  mlval *save_area = (mlval*)(fp+1)-1;
  return (save_area[saves]);
}

static mlval set_frame_return_value(mlval arg)
{
  mlval frame = FIELD (arg,0);
  mlval value = FIELD (arg,1);
  struct stack_frame *sp = (struct stack_frame *)frame;
  mlval code = FIELD(sp->closure,0);
  mlval *mlsp = (mlval *) (frame + (CCODELEAF (code) ? 16 : 20));
  *mlsp = value;
  return (MLUNIT);
}

static mlval frame_allocations(mlval frame)
{
  /* not clear what to do here for Intel; we don't have enough information */
  return MLTRUE;
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
  env_function("debugger set frame return value", set_frame_return_value);
  env_function("debugger frame allocations", frame_allocations);
}
