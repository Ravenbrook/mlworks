/*  === MIPS STACK ROUTINES ===
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 * All architecture-dependent routines that deal with the stack.
 *
 *  Revision Log
 *  ------------
 *  $Log: stacks.c,v $
 *  Revision 1.25  1998/09/18 11:09:23  jont
 *  [Bug #20124]
 *  Fix is_ml_frame to use validate_ml_address,
 *  and make backtrace more robust against bad addresses
 *
 * Revision 1.24  1998/03/19  11:53:59  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.23  1998/03/03  17:15:46  jont
 * [Bug #70018]
 * Split stack_crawl into two phases
 *
 * Revision 1.22  1998/02/18  17:43:58  jont
 * [Bug #30242]
 * Ensure we don't fix pseudo return addresses in raise frames
 * Also check return address we fix are within code
 *
 * Revision 1.21  1997/06/03  16:27:27  jont
 * [Bug #30076]
 * Modify to make NONGC spills be counted in words
 *
 * Revision 1.20  1997/05/30  10:44:20  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.19  1996/11/07  17:35:52  stephenb
 * [Bug #1461]
 * Fix stack closure tags.
 *
 * Revision 1.18  1996/11/04  16:10:44  stephenb
 * [Bug #1441]
 * frame_next: change the offset to be a byte rather than word
 * offset since instructions are not word aligned on an I386 and
 * so the debugger has been changed to expect byte offsets.
 *
 * Revision 1.17  1996/10/03  13:31:10  stephenb
 * [Bug #1446]
 * frame_next: adjust the offset by -2 in the case of an ML frame.
 *
 * Revision 1.16  1996/09/06  13:16:34  stephenb
 * [Bug #1595]
 *   Changed the offset calculatation in frame_next to use the return
 *   address of in the frame pointed to by the frame pointer instead of
 *   the stack pointer.  That is, the line :-
 *
 *     FIELD(result, 2) = MLINT((word *)sp->lr - CCODESTART(code));
 *
 *   becomes
 *
 *     FIELD(result, 2) = MLINT((word *)sp->fp->lr - CCODESTART(code));
 *
 *   Also removed flush and ml_is_top_frame since they are never used.
 *
 * Revision 1.15  1996/02/14  17:34:59  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.14  1996/02/14  12:25:46  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.13  1996/01/11  17:24:15  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.12  1995/12/18  13:55:39  matthew
 * Adding set_frame_return_value
 *
 * Revision 1.11  1995/11/21  14:32:03  jont
 * Add debugger_double for getting floats straight from spills
 *
 * Revision 1.10  1995/05/30  10:16:00  nickb
 * Add frame_argument function.
 *
 * Revision 1.9  1995/05/24  10:38:15  nickb
 * Fix all the register save frames, not just one.
 *
 * Revision 1.8  1995/05/04  10:49:21  nickb
 * Clear up SPARCisms in is_ml_frame &c.
 *
 * Revision 1.7  1995/03/29  14:59:15  nickb
 * Threads system.
 *
 * Revision 1.6  1995/03/20  12:43:23  matthew
 * Adding is_top_frame ml functions
 *
 * Revision 1.5  1995/03/16  14:24:13  matthew
 * Adding check on stack_top
 *
 * Revision 1.4  1995/03/01  17:29:07  matthew
 * Adding is_ml_frame
 *
 * Revision 1.3  1994/07/18  16:42:12  jont
 * Fix use of fix_reg to avoid ++ in macro call
 * Sort out stack_crawl to spot cases where there is no ml stack (eg image saving)
 *
 * Revision 1.2  1994/07/18  14:16:00  jont
 * Modify for MIPS version
 *
 * Revision 1.1  1994/07/12  12:04:00  jont
 * new file
 *
 */

#include <assert.h>

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
 *  NOTE: 1. This code is highly MIPS-specific
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

#define final_frame(sp,thread) ((word)((sp)->fp)==(thread)->ml_state.stack_top)

/* fix a 'register save frame', i.e. a frame saved when entering C
 * from ML, consisting solely of ML register saves (with no
 * stack-allocated objects or non-gcable values) */

static inline mlval *fix_reg_save_frame(struct stack_frame *sp, mlval *to)
{
  mlval *base = (mlval *)(sp+1);
  mlval *top = (mlval *)(sp->fp);
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

  DIAGNOSTIC(4, "stack_crawl first pass:", 0, 0);

  for (thread= TOP_THREAD.next; thread != &TOP_THREAD; thread = thread->next) {
    DIAGNOSTIC (4,"  thread %d",thread->number,0);
    sp = GC_SP(thread);
    if (!is_stack_top(sp,thread)) {
      /* turn each ML link slot into an offset from the closure code address */
      for(; !(final_frame(sp,thread)); sp = sp->fp)
	if(SPACE_TYPE(sp->lr) == TYPE_FROM) {
	  mlval codeptr = FIELD(sp->closure,0);
	  DIAGNOSTIC(5, "   frame 0x%X  next 0x%X", sp, sp->fp);
	  DIAGNOSTIC(5, "     lr 0x%X from `%s'", sp->lr,
		     CSTRING(CCODENAME(codeptr)));
	  if (sp->lr) {
	    assert(pc_in_closure(sp->lr, sp->closure));
	    sp->lr -= codeptr;			/* NB: no longer aligned */
	  }
	  DIAGNOSTIC(5, "     lr is 0x%X+0x%X", codeptr, sp->lr);
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
  /* Now fix everything on the stacks, restoring link slots as we go */
  
  for (thread= TOP_THREAD.next; thread != &TOP_THREAD; thread = thread->next) {
    DIAGNOSTIC (4,"  thread %d",thread->number,0);
    sp = GC_SP(thread);
    if (!is_stack_top(sp,thread)) {
      int register_save_frame = 1;
      for(; !(final_frame(sp,thread)); sp = sp->fp) {
	struct stack_frame *fp = sp->fp;
	DIAGNOSTIC(5, "   frame 0x%X (to = 0x%X)", sp, to);
	
	if (register_save_frame) {
	  to = fix_reg_save_frame(sp,to);
	  register_save_frame = 0;
	}

	if(MLVALISPTR(sp->closure)) {
	  mlval *top, closure, code;
	  fix(to, &sp->closure);		/* fix the caller's closure */
	  closure = sp->closure;
	  fix(to, &FIELD(closure, 0));	/* fix the caller's code vector */
	  code = FIELD(closure, 0);
	  
	  /* if the link address is unaligned, it must be restored: */
	  if(word_align(sp->lr) != sp->lr) {
	    DIAGNOSTIC(5, "     lr is 0x%X+0x%X", code, sp->lr);
	    sp->lr += code;
	    DIAGNOSTIC(5, "     fixed to 0x%X", sp->lr, 0);
	  }
	  
	  top = (mlval *)fp->fp - CCODENONGC(code);
	  scan((mlval *)(fp+1), top, to); /* fix stack allocated area */
	  /* fp+1 is the top of the struct stack_frame */

	} else if (sp->closure == STACK_C_CALL)
	  /* the next frame we come to is a register save frame */
	  register_save_frame = 1;
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

  for (thread= TOP_THREAD.next; thread != &TOP_THREAD; thread = thread->next) {
    sp = GC_SP(thread);
    if (!is_stack_top(sp,thread)) {
      int register_save_frame = 1;
      for(; !(final_frame(sp,thread)); sp = sp->fp) {
	struct stack_frame *fp = sp->fp;
	
	if (register_save_frame) {
	  explore_stack_registers(thread, sp, (mlval*)sp+1, (mlval*)fp);
	  register_save_frame = 0;
	}

	if(MLVALISPTR(sp->closure)) {
	  mlval *top, code;
	  explore_stack_registers(thread, sp, &sp->closure, (&sp->closure)+1);
	  code = FIELD(sp->closure, 0);
	  
	  top = (mlval *)fp->fp - CCODENONGC(code);
	  explore_stack_allocated(thread, fp, (mlval *)(fp+1), top);
	  /* fp+1 is the top of the struct stack_frame */
	} else if (sp->closure == STACK_C_CALL)
	  /* the next frame we come to is a register save frame */
	  register_save_frame = 1;
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
	  MLVALISPTR(sp->closure) ? CSTRING(CCODENAME(FIELD(sp->closure, 0))) :
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

/* These first few are not MIPS-specific, assuming we have an fp, the
 * stack is full descending, &c */

static mlval ml_is_ml_frame (mlval frame)
{
  if (is_ml_frame ((struct stack_frame *)frame) == MLUNIT)
    return MLFALSE;
  else
    return MLTRUE;
}



static mlval current(mlval arg)
{
  return((mlval)(GC_SP(CURRENT_THREAD)->fp));
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

/* Now these are MIPS-specific */


/*
 * All the following sizes are in bytes.
 */
#define mlw_mips_call_instr_size 4
#define mlw_mips_delay_slot_size 4
#define mlw_mips_call_size (mlw_mips_call_instr_size+mlw_mips_delay_slot_size)


/*
 * Returns a triple: (isMLFrame:bool, framePointer:mlval, instrByteOffset:int)
 *
 * The instrByteOffset is only meaningful if the frame is an ML frame,
 * if the frame is a C frame then instrByteOffset is 0.
 *
 * It is possible that there are no frames and in that case
 * isMLFrame = false and framePointer = MLUNIT.
 */

static mlval frame_next(mlval arg)
{
  struct stack_frame *sp = (struct stack_frame *)arg;
  mlval result= allocate_record(3);

  if (!is_stack_top(sp->fp,CURRENT_THREAD)) {
    mlval code= is_ml_frame(sp->fp);
    if(code != MLUNIT) {
      word code_start_addr= (word)CCODESTART(code);
      word next_instr_addr= sp->fp->lr;
      word call_offset= next_instr_addr - code_start_addr - mlw_mips_call_size;
      FIELD(result, 0)= MLTRUE;
      FIELD(result, 1)= (mlval)sp->fp;
      FIELD(result, 2)= MLINT(call_offset);
      return result;
    } else {
      FIELD(result,0)= MLTRUE;
      FIELD(result, 1)= (mlval)sp->fp;
      FIELD(result,2)= MLINT(0);
      return result;
    }
  } else { /* No frames on the stack! */
    FIELD(result, 0)= MLFALSE;
    FIELD(result, 1)= MLUNIT;
    FIELD(result, 2)= MLINT(0);
    return result;
  }
}



static mlval frame_argument(mlval frame)
{
  struct stack_frame *sp = (struct stack_frame *)frame;
  mlval code = FIELD(sp->closure,0);
  int saves = CCODESAVES(code);
  struct stack_frame *fp = sp->fp;
  mlval *save_area = (mlval*)(fp+1);
  return (save_area[saves]);
}

/* 76 is kind of magic */
static mlval set_frame_return_value(mlval arg)
{
  mlval frame = FIELD (arg,0);
  mlval value = FIELD (arg,1);
  mlval *mlsp = (mlval *)(frame+76);
  *mlsp = value;
  return (MLUNIT);
}

static mlval frame_allocations(mlval frame)
{
  /* not clear what to do here for MIPS; we don't have enough information */
  return MLTRUE;
}

void stacks_init()
{
  env_function("stack frame sub", sub);
  env_function("stack frame update", update);
  env_function("stack frame current", current);
  env_function("stack is ml frame", ml_is_ml_frame);
  env_function("debugger frame call", frame_call);
  env_function("debugger frame next", frame_next);
  env_function("debugger frame sub", sub);
  env_function("debugger frame offset", frame_offset);
  env_function("debugger frame double", frame_double);
  env_function("debugger frame argument", frame_argument);
  env_function("debugger set frame return value", set_frame_return_value);
  env_function("debugger frame allocations", frame_allocations);
}
