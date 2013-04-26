/*
 * interface.h
 * Assembly code interfacing C and ML.
 *
 * $Log: interface.h,v $
 * Revision 1.10  1995/12/11 14:29:13  nickb
 * Add space profiling for MIPS.
 *
 * Revision 1.9  1995/11/13  12:45:33  nickb
 * Change parameters to switch_to_thread().
 *
 * Revision 1.8  1995/08/31  13:00:05  nickb
 * Change INTERCEPT_LENGTH to allow platform-specific values.
 *
 * Revision 1.7  1995/06/19  14:33:56  nickb
 * Add space profiling hooks.
 *
 * Revision 1.6  1995/03/15  15:16:24  nickb
 * Change to thread system.
 *
 * Revision 1.5  1994/11/23  16:47:31  nickb
 * Remove set_stack_underflow, not needed on non-SPARCs.
 *
 * Revision 1.4  1994/10/19  15:27:39  nickb
 * The method of declaring functions to be non-returning has changed.
 *
 * Revision 1.3  1994/07/01  10:38:09  nickh
 * Add debugger trap.
 *
 * Revision 1.2  1994/06/09  14:40:16  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:07:52  nickh
 * new file
 *
 * Revision 1.30  1993/11/05  15:12:26  jont
 * Added check_event entries for leaf and non-leaf.
 *
 * Revision 1.29  1993/04/21  14:16:56  jont
 * Added leaf raise code
 *
 * Revision 1.28  1993/04/14  13:24:02  richard
 * Ripped out old tracing mechanism and installed a new one.
 *
 * Revision 1.27  1992/11/11  16:26:30  clive
 * Access to functions needed for tracing
 *
 * Revision 1.26  1992/10/02  09:23:42  richard
 * Made c_raise nonreturning.
 *
 * Revision 1.25  1992/08/17  10:47:58  richard
 * Added set_stack_underflow().
 *
 * Revision 1.24  1992/08/11  15:27:39  clive
 * Work on tracing
 *
 * Revision 1.23  1992/08/07  13:56:50  clive
 * Changed the functionality of some of the debugger functions - added support
 * for tracing
 *
 * Revision 1.22  1992/07/31  08:14:09  richard
 * The C and assembler calling stubs are now single static code vectors.
 *
 * Revision 1.21  1992/07/27  14:00:28  richard
 * Added poly_equal() and poly_not_equal() so that they can be added to the
 * runtime environment by pervasives.c.
 * Added callasm_code.
 *
 * Revision 1.20  1992/07/22  14:07:17  clive
 * Took out ml_profile
 *
 * Revision 1.19  1992/07/21  15:32:15  richard
 * Changed ml_call_c to callc.
 *
 * Revision 1.18  1992/07/15  12:12:05  richard
 * Added ml_call_c stuff, and ml_boot_environment, although these aren't
 * used at the moment.
 *
 * Revision 1.17  1992/07/03  13:51:09  richard
 * Removed some redundant things and added ml_disturbance.
 *
 * Revision 1.16  1992/06/22  14:08:58  clive
 * A few changes for the new debugger
 *
 * Revision 1.15  1992/06/18  11:47:54  richard
 * Tidied up.
 *
 * Revision 1.14  1992/06/17  13:38:50  richard
 * Added ml_gc_leaf.
 *
 * Revision 1.13  1992/06/01  13:23:47  clive
 * Defined a macro to determine if we are in Raise code
 *
 * Revision 1.12  1992/05/08  13:04:29  clive
 * Added code for memory profiling
 *
 * Revision 1.11  1992/04/13  16:44:46  clive
 * First version of the profiler
 *
 * Revision 1.10  1992/03/25  09:52:41  richard
 * Added ml_poly_equal.
 *
 * Revision 1.9  1992/03/24  15:46:21  richard
 * Removed obsolete `ml_preserve' and updated documentation.
 *
 * Revision 1.8  1992/01/14  10:12:01  richard
 * Added ml_raise and removed ml_toplevel_handler.
 *
 * Revision 1.7  1992/01/08  12:48:14  richard
 * Changed the names of the routines in interface.s.
 *
 * Revision 1.6  1992/01/03  12:49:16  richard
 * Added ml_preserve and documentation.
 *
 * Revision 1.5  1991/10/24  17:16:27  davidt
 * Added header for ml_toplevel_handler.
 *
 * Revision 1.4  91/10/24  16:16:23  davidt
 * Put in headers for ml_callgc and ml_callc.
 * 
 * Revision 1.3  91/10/18  15:59:45  davidt
 * We don't need all those arguments to callml because it really
 * should just access the global variables directly.
 * 
 * Revision 1.2  91/10/16  17:22:22  davidt
 * Changed the type char* to void* and the type tagged_value which
 * is now called mlval.
 * 
 * Revision 1.1  91/10/16  15:24:20  davidt
 * Initial revision
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


#ifndef interface_h
#define interface_h

#include "mltypes.h"
#include "extensions.h"
#include "tags.h"
#include "mach_values.h"


/*  === C INTERFACE TO ML ===
 *
 *  callml() invokes an ML function, applying it to an argument.  The return
 *  value is the result of the function.
 *
 *  c_raise() raises the exception passed as its argument.  It does not
 *  return.
 */

extern mlval callml(mlval argument, mlval closure);
nonreturning (extern void, c_raise,(mlval exception));

/*  === ML INTERFACE TO C ===
 *
 *  These routines are included here because they must be entered in the
 *  `implicit vector' (see implicit.h).
 *
 *  Note: The address of ml_extend is also used to mark stack extension
 *  frames.  See interface code and garbage collector.
 */

extern void ml_gc(void);		/* GC entry point from ML */
extern void ml_gc_leaf(void);		/* ditto for leaf procedures */
extern void ml_lookup_pervasive(void);	/* ML interface to lookup_pervasive */
extern void ml_disturbance(void);	/* Disturbed function entry */
extern void ml_raise(void);		/* Raise an exception */
extern void ml_raise_leaf(void);	/* Raise an exception */
extern void ml_trap(void);		/* Debugging trap */
extern void ml_replace(void);		/* Code vector replacement entry point */
extern void ml_replace_leaf(void);
extern void ml_intercept(void);		/* Code vector interception entry point */
extern void ml_intercept_leaf(void);
extern byte ml_replace_on[INTERCEPT_LENGTH];	/* Replacing code fragment */
extern byte ml_replace_on_leaf[INTERCEPT_LENGTH];
extern byte ml_intercept_on[INTERCEPT_LENGTH];	/* Intercepting code fragment */
extern byte ml_intercept_on_leaf[INTERCEPT_LENGTH];
extern byte ml_nop[INTERCEPT_LENGTH];		/* No operation code fragment */
extern void ml_event_check(void);       /* Check for events */
extern void ml_event_check_leaf(void);  /* Check for events */

#ifdef IMPLICIT_PROFILE_CODE

/* Code is copied from these locations onto the implicit vector */

extern word implicit_profile_alloc_code;/* allocate when space profiling */
extern word implicit_profile_alloc_code_end;

#else

extern void ml_profile_alloc(void);	 /* space profile entry point */
extern void ml_profile_alloc_leaf(void); /* space profile entry point */

#endif

/* On the SPARC the register windows need to be flushed to memory
 *  before the garbage collector or other runtime code can examine the
 *  stack.  On other processors other actions may be necessary. The
 *  function flush_windows() performs these actions. */

extern void flush_windows(void);

/*  == C and assembler calling ML code ==
 *
 *  These values are ML values which refer to static ML code vectors.  When
 *  called the code vectors call the C or assembler routine pointed to by
 *  their first closure element, after any housekeeping.  The assembler stub
 *  calls assembler routines in the ML state.
 */

extern mlval stub_c, stub_asm;

/*  == Cause a debugger trap ==
 * 
 * This is called from the runtime when something fatal has gone wrong
 * and we'd like to enter the debugger. Its use is unusual.
 *
 */

nonreturning(extern void, generate_debugger_trap,(void));


/* switch_to_thread() is an asm function which saves the current state
   in the current C state, switches to the C stack of the argument
   thread state, reinstalls the C state of that thread and jumps to
   the C pc. When it returns (when some other thread switches back to
   this one), it returns the thread state of the previous thread */

struct thread_state *switch_to_thread(struct thread_state *old_thread,
				      struct thread_state *new_thread);

#ifdef COLLECT_STATS

extern unsigned int stack_extension_count;
extern unsigned int raise_count;

#endif

#endif
