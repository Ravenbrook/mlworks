/* ==== SIGNAL HANDLING ====
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
 *
 * Description
 * -----------
 * This module abstracts the OS-specific signal handling code from
 * the various parts of the runtime system.
 *
 * Note:
 * According to the sigaction manual page, sa_sigaction rather than
 * sa_handler should be set if SA_SIGINFO is set in sa_flags.  This
 * is not done in the following (i.e. sa_sigaction is never set, sa_handler
 * always is) because of header file problems which mean that the
 * sa_sigaction field is not visible.  The code works because in the
 * current version of Solaris, sa_handler and sa_sigaction are a union.
 *
 * Revision Log
 * ------------
 * $Log: signals.c,v $
 * Revision 1.41  1997/01/07 10:48:33  matthew
 * Changing diagnostic level for EMT message
 *
 * Revision 1.40  1996/10/23  17:45:11  jont
 * Use SA_RESTART to avoid interrupted system calls
 *
 * Revision 1.39  1996/10/17  14:35:16  jont
 * Merge in license stuff
 *
 * Revision 1.38.2.2  1996/10/09  11:56:57  nickb
 * Move to Harlequin license server.
 *
 * Revision 1.38.2.1  1996/10/07  16:15:05  hope
 * branched from 1.38
 *
 * Revision 1.38  1996/06/07  09:31:05  jont
 * Update best before to 01/01/97
 *
 * Revision 1.37  1996/05/23  11:12:48  matthew
 * Belatedly fixing for new basis
 *
 * Revision 1.36  1996/04/19  14:50:11  matthew
 * Changes to Exception raising
 *
 * Revision 1.35  1996/02/08  15:34:31  jont
 * Moving do_exportFn to a common place independent of architecture
 *
 * Revision 1.34  1996/02/08  13:03:43  jont
 * Modify exportFn mechanism not to use signals at all
 * Use busy waiting in parent instead, thus avoiding
 * potential race contions
 *
 * Revision 1.33  1996/02/07  12:12:25  nickb
 * Make interval window updates happen even if we stay in ML.
 *
 * Revision 1.32  1996/01/17  16:47:51  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.31  1996/01/16  13:45:57  nickb
 * Getting rid of sm_interface().
 *
 * Revision 1.30  1996/01/16  10:28:44  stephenb
 * fix so that the termination of the final thread due to a fatal
 * signal returns a non-zero exit status.  Also that a fatal signal
 * caught in a fatal signal handler kills the thread rather than
 * the whole of MLWorks (unless it is the last thread of course).
 *
 * Revision 1.29  1996/01/12  16:41:43  stephenb
 * handle_fatal_signal: ensure that it does not get caught in a loop
 * if a fatal signal occurs while handling a fatal signal.
 *
 * Revision 1.28  1996/01/11  15:34:22  nickb
 * Add timer-triggered window updates.
 *
 * Revision 1.27  1996/01/11  11:58:59  stephenb
 * Added a comment noting that the sa_handler rather than sa_sigaction
 * field is being set and the reasons why this is.
 *
 * Revision 1.26  1996/01/11  11:15:18  nickb
 * SIGCHLD handler problems under /bin/sh again
 *
 * Revision 1.25  1996/01/10  16:01:02  stephenb
 * handle_fatal_signal: fix so that NPC is set as well as PC.
 *
 * Revision 1.24  1996/01/09  11:52:02  nickb
 * Extensions to event handling for non-signal events.
 *
 * Revision 1.23  1996/01/02  12:20:50  nickb
 * Update best-before date to 1996-07-01.
 *
 * Revision 1.22  1995/09/19  15:20:21  nickb
 * Improve the full GC we do during function export.
 *
 * Revision 1.21  1995/09/15  15:01:48  jont
 * Add stuff to handle the temporary child process created for exportFn
 *
 * Revision 1.20  1995/07/17  10:10:50  nickb
 * Change to profiler interface.
 *
 * Revision 1.19  1995/07/03  10:17:34  nickb
 * Update best-before date.
 *
 * Revision 1.18  1995/06/12  15:28:00  nickb
 * Fix minor thinko in fatal_signal.
 *
 * Revision 1.17  1995/06/06  11:49:33  nickb
 * Improve fatal signal support.
 *
 * Revision 1.16  1995/04/27  12:54:03  daveb
 * If signal_ml_handler is called while we are waiting for an X event,
 * the runtime just prints a message.  This avoids problems with pointer
 * grabs in X callbacks.
 *
 * Revision 1.15  1995/04/24  15:16:54  nickb
 * Add thread_preemption_pending.
 *
 * Revision 1.14  1995/04/13  15:46:42  matthew
 * Changing underflow behaviour in matherr
 *
 * Revision 1.13  1995/04/12  12:27:32  nickb
 * Make fatal signal messages come out on stderr.
 *
 * Revision 1.12  1995/03/28  13:28:26  nickb
 * Introduce the threads system.
 *
 * Revision 1.11  1995/02/28  14:09:32  jont
 * Fix interrupted system call problems during child liveness check through pipe
 *
 * Revision 1.10  1995/02/24  09:41:18  nickb
 * Fix diagnostic message.
 *
 * Revision 1.9  1995/02/23  16:21:57  nickb
 * Fix licensing signal handling.
 *
 * Revision 1.8  1995/01/05  12:55:06  nickb
 * Amend best-before date to 1st July.
 * Also fix Harlequin's telephone number.
 * Also make license signal handler run on the current stack.
 *
 * Revision 1.7  1994/11/23  16:51:32  nickb
 * Put in declaration for set_stack_underflow().
 *
 * Revision 1.6  1994/11/15  15:37:26  nickb
 * Add cache flushing.
 *
 * Revision 1.5  1994/10/20  10:44:21  nickb
 * Add cast to avoid type warning.
 *
 * Revision 1.4  1994/09/07  10:38:10  nickb
 * Update best-before to 1995-Jan-01.
 *
 * Revision 1.3  1994/08/11  14:30:03  nickh
 * Make sure signal handlers get executed on the signal stack.
 *
 * Revision 1.2  1994/07/22  14:33:48  nickh
 * Add GC trap handling.
 *
 * Revision 1.1  1994/07/08  10:30:41  nickh
 * new file
 *
 *
 */

#include "syscalls.h"

#include <signal.h>
#include <sys/signal.h>
#include <sys/ucontext.h>
#include <ucontext.h>
#include <siginfo.h>
#include <errno.h>
#include <sys/errno.h>
#include <math.h>
#include <time.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <memory.h>
#include <sys/wait.h>
#include <floatingpoint.h>

#include "signals.h"
#include "utils.h"
#include "diagnostic.h"
#include "interface.h"
#include "implicit.h"
#include "values.h"
#include "gc.h"
#include "stacks.h"
#include "exceptions.h"
#include "event.h"
#include "license.h"
#include "profiler.h"
#include "ansi.h"
#include "reals.h"
#include "alloc.h"
#include "cache.h"
#include "threads.h"
#include "state.h"
#include "x.h"
#include "main.h"
#include "pervasives.h"
#include "global.h"
#include "allocator.h"
#include "image.h"

/* To enter garbage collection we cause a trap. The trap handler, in
   this file, sets up some variables and then calls one of these two
   asm functions: */

extern void gc_trap_entry(void);
extern void gc_trap_entry_leaf(void);

/* The first two things the trap handler sets up are these variables:

   gc_trap_bytes is the number of bytes requested by the GC entry code?
   (if this equals -1, the number of bytes is in register %g4.

   gc_trap_return_address is the value which should be in the register
   used as a link gc register when the GC code performs a jmpl to
   return to ML (i.e. it is the return address -8). */ 

word gc_trap_bytes;
word gc_trap_return_address;

/* The other thing set up by the trap handler is a routine through
   which the GC asm code should return to ML (one instruction in the
   appropriate routine has to be modified to tag the allocation result
   correctly). These two routines (leaf and non-leaf) are written in
   asm and copied into the data segment when we set up the signal
   handler.

   gc_trap_ret_template is the address of the asm
   routine. gc_trap_ret_template_end is where it
   ends. gc_trap_ret_template_overwrite is the address of the
   instruction the copy of which we want to modify.

   gc_trap_ret_code is the address of the data-segment copy of the
   code. gc_trap_ret_overwrite is the address of the instruction to
   modify. */

extern word gc_trap_ret_template, gc_trap_ret_template_end;
extern word gc_trap_ret_template_overwrite;

word *gc_trap_ret_code;
word *gc_trap_ret_overwrite;

/* the same, for the leaf case : */

extern word gc_trap_ret_leaf_template, gc_trap_ret_leaf_template_end;
extern word gc_trap_ret_leaf_template_overwrite;

word *gc_trap_ret_leaf_code;
word *gc_trap_ret_leaf_overwrite;

/* An earlier version of MLWorks generated code for each allocation
   which explicitly tested for heap overflow and called either ml_gc()
   or ml_gc_leaf() accordingly (these two functions are on the
   implicit vector). These functions have been changed to call
   ml_gc_die() and ml_gc_leaf_die() respectively (so the user may get
   a message when attempting to execute out-of-date .mo files */

extern void ml_gc_die(mlval closure);
extern void ml_gc_leaf_die(mlval closure);

/* ML signal handler support */

#define NR_SIGNALS	32
#define SIGNAL_STACK_SIZE 	SIGSTKSZ

unsigned int signal_nr_signals = NR_SIGNALS;

/* an array of flags showing how signals are handled */

#define SIGNAL_NOT_HANDLED 	((word)0)
#define SIGNAL_HANDLED_IN_ML	((word)1)
#define SIGNAL_HANDLED_IN_C	((word)2)
#define SIGNAL_HANDLED_FATALLY	((word)4)


static word *signal_handled = NULL;

static struct signal_name {int number;
			   const char *name;
			 } signal_names [] =
{{SIGHUP,	"SIGHUP"},
 {SIGINT,	"SIGINT"},
 {SIGQUIT,	"SIGQUIT"},
 {SIGILL,	"SIGILL"},
 {SIGTRAP,	"SIGTRAP"},
 {SIGIOT,	"SIGIOT"},
 {SIGABRT,	"SIGABRT"},
 {SIGEMT,	"SIGEMT"},
 {SIGFPE,	"SIGFPE"},
 {SIGKILL,	"SIGKILL"},
 {SIGBUS,	"SIGBUS"},
 {SIGSEGV,	"SIGSEGV"},
 {SIGSYS,	"SIGSYS"},
 {SIGPIPE,	"SIGPIPE"},
 {SIGALRM,	"SIGALRM"},
 {SIGTERM,	"SIGTERM"},
 {SIGUSR1,	"SIGUSR1"},
 {SIGUSR2,	"SIGUSR2"},
 {SIGCHLD,	"SIGCHLD"},
 {SIGPWR,	"SIGPWR"},
 {SIGWINCH,	"SIGWINCH"},
 {SIGURG,	"SIGURG"},
 {SIGPOLL,	"SIGPOLL"},
 {SIGSTOP,	"SIGSTOP"},
 {SIGTSTP,	"SIGTSTP"},
 {SIGCONT,	"SIGCONT"},
 {SIGTTIN,	"SIGTTIN"},
 {SIGTTOU,	"SIGTTOU"},
 {SIGVTALRM,	"SIGVTALRM"},
 {SIGPROF,	"SIGPROF"},
 {SIGXCPU,	"SIGXCPU"},
 {SIGXFSZ,	"SIGXFSZ"},
 {SIGWAITING,	"SIGWAITING"},
 {SIGLWP,	"SIGLWP"},
 {0,		NULL}};

static const char *name_that_signal (int sig)
{
  static const char *no_such_signal = "Unknown";
  struct signal_name *this = signal_names;

  while (this->number != sig &&
	 this->name != NULL)
    this++;

  if (this->name == NULL)
    return no_such_signal;
  else
    return this->name;
}

#define CONTEXT_REG(thecontext,name)				\
	       ((thecontext)->uc_mcontext.gregs[REG_ ## name])
#define CONTEXT_SP(c)	(CONTEXT_REG(c,O6))
#define CONTEXT_PC(c)	(CONTEXT_REG(c,PC))
#define CONTEXT_NPC(c)	(CONTEXT_REG(c,nPC))
#define CONTEXT_G6(c)	(CONTEXT_REG(c,G6))
#define CONTEXT_ARG(c)	(CONTEXT_REG(c,O0))

/* Solaris-specific stuff for setting and clearing a signal handler */

typedef void (*signal_handler)(int sig, siginfo_t *info, ucontext_t *context);

static int check_sigaction (int sig, struct sigaction *act)
{
  int result = sigaction (sig,act,NULL);

  if (result)
    switch(errno) {
    case EINVAL:
      errno = ESIGNALNO;
      break;
    default:
      error("sigaction returned an unexpected error code %d", errno);
    }
  return result;
}

static int set_signal_handler(int sig, signal_handler handler)
{
  struct sigaction sa;
  sa.sa_handler = handler;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = SA_ONSTACK | SA_SIGINFO | SA_RESTART;
      
  return (check_sigaction (sig,&sa));
}

static int restore_default_signal_handler(int sig)
{
  struct sigaction sa;
  sa.sa_handler= SIG_DFL;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags= 0;
  return check_sigaction(sig, &sa);
}

/* signal_event() is called from record_event (in the events
   module). It can be called either synchronously in C or
   asynchronously in C or ML. It should set the 'interrupted' flag
   such that the event is taken synchronously by ML when we return to
   ML. */

extern void signal_event(void)
{
  /* set the thread state interrupt slot to -1 */
  CURRENT_THREAD->implicit.interrupt = (unsigned)-1;
}

static void signal_ml_event (ucontext_t *context)
{
  if (global_state.in_ML) {
    CONTEXT_G6(context) = -1;		/* set g6 register to -1 */
  }
}

/*  == The C signal handler ==
 *
 *  This function converts a C signal into an ML signal event.
 */

static void signal_ml_handler
  (int sig, siginfo_t *info, ucontext_t *context)
{
  if (awaiting_x_event) {
    message ("Signal %s at top level", name_that_signal (sig));
  } else {
    record_event(EV_SIGNAL, (word) sig);
    signal_ml_event(context);
  }
}

/* Install or remove the signal handler for a given signal */

extern int signal_set_ml_handler(int sig)
{
  word handled = signal_handled[sig];
  if ((handled & SIGNAL_HANDLED_IN_ML) == 0) {
    signal_handled[sig] = handled + SIGNAL_HANDLED_IN_ML;
    if ((handled & SIGNAL_HANDLED_IN_C) == 0) {
      return set_signal_handler(sig,signal_ml_handler);
    }
  }
  return 0;
}

extern int signal_clear_ml_handler(int sig)
{
  word handled = signal_handled[sig];
  if (handled & SIGNAL_HANDLED_IN_ML) {
    signal_handled[sig] = handled = handled - SIGNAL_HANDLED_IN_ML;
    if (handled == 0) {
      return restore_default_signal_handler(sig);
    }
  }
  return 0;
}

/* Do something tolerable in the face of a fatal signal */

static mlval signal_thread_suicide_stub[] = {0, 0, (mlval)thread_suicide};

static void restore_default_fatal_signal_handlers(void)
{
  int i;
  for (i=0; i < NR_SIGNALS; i++) {
    if (signal_handled[i] & SIGNAL_HANDLED_FATALLY) {
      signal_handled[i] -= (SIGNAL_HANDLED_FATALLY + SIGNAL_HANDLED_IN_C);
      if (restore_default_signal_handler(i) != 0)
	error_without_alloc("Could not restore default fatal signal handlers");
    }
  }
}

static void die_in_fatal_signal_handler(char const *message)
{
  /* race condition here if the following call fails with a fatal signal */
  restore_default_fatal_signal_handlers();
  message_stderr("Fatal signal handler dying: %s", message);
}

static void handle_fatal_signal
  (int sig, siginfo_t *info, ucontext_t *context)
{
  if (CURRENT_THREAD == 0) {
    die_in_fatal_signal_handler("corrupt threads system");

  } else if (CURRENT_THREAD->in_fatal_signal_handler) {
    die_in_fatal_signal_handler("fatal signal raised by handler");

  } else if (in_GC) {
    die_in_fatal_signal_handler("fatal signal raised during GC.");

  } else {
    const char *signal_name;
    mlval handler;

    CURRENT_THREAD->in_fatal_signal_handler= 1;
    signal_name= name_that_signal (sig);
    handler= THREAD_ERROR_HANDLER(CURRENT_THREAD);
    flush_windows();

    DIAGNOSTIC(2, "signal_handler(sig = %d)", sig, 0);

    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      signal_ml_handler(sig,info,context);
  
    if (handler == MLUNIT) {
      /* there is no handler; print a message and kill this thread */
      if (runnable_threads == 2) {
	die_in_fatal_signal_handler("Last thread dying.");
      } else {
	message ("Thread #%d received an intolerable signal %s (%d : %d) %sin ML and died.",
		 CURRENT_THREAD->number, signal_name, sig, info->si_code,
		 global_state.in_ML? "" : "not ");
	backtrace ((struct stack_frame *)CONTEXT_SP(context),
		   CURRENT_THREAD, max_backtrace_depth);

	SET_RESULT(ML_THREAD(CURRENT_THREAD), THREAD_DIED);
	if (global_state.in_ML) {
	  CONTEXT_PC(context) = (int) stub_c+CODE_OFFSET;
	  CONTEXT_NPC(context) = (int) stub_c+CODE_OFFSET+4;
	  CONTEXT_ARG(context) = MLUNIT;
	  CONTEXT_REG(context, O1) = (int)signal_thread_suicide_stub+POINTER;
	} else {
	  CONTEXT_PC(context) = (int)thread_suicide;
	  CONTEXT_NPC(context) = (int)thread_suicide+4;
	}
	/* to reduce the race window the following should be near the
	 * end of thread_suicide.  However, that entails putting it in
	 * the end of the asm routine change_thread, so for simplicity it
	 * is left here. */
	CURRENT_THREAD->in_fatal_signal_handler= 0;
      }
    } else {
      CONTEXT_ARG(context) = MLINT(sig);
      CONTEXT_REG(context,O1) = handler;
      /* if there is a handler, skip to it: */
      if (global_state.in_ML) {
	CONTEXT_PC(context) = FIELD(handler,0)+CODE_OFFSET;
	CONTEXT_NPC(context) = FIELD(handler,0)+CODE_OFFSET+4;
      } else {
	CONTEXT_PC(context) = (int)callml;
	CONTEXT_NPC(context) = (int)callml+4;
      }
      /* Note that CURRENT_THREAD->in_fatal_signal_handler is not reset here.
       * The onus is on the SML fatal signal handler to call the SML
       * version of thread_reset_fatal_status before returning. */
    }
  }
}

/* Install the above function for a given signal */

static int die_on_signal(int sig)
{
  signal_handled[sig] |= SIGNAL_HANDLED_IN_C | SIGNAL_HANDLED_FATALLY;
  return set_signal_handler(sig,handle_fatal_signal);
}


/* == Integer exception support == 
 *
 * This function is the handler for the emulation trap signals. These
 * are caused by ML arithmetic instructions which overflow (and which
 * should therefore raise an exception) and by allocation sequences
 * which run out of heap (and which should therefore cause a GC).

 * If called while in ML it examines the instruction which caused the
 * exception in order to determine which ML exception to raise, or to
 * do a GC.  The signal context is updated in order to raise the
 * exception (or enter the GC code) when the handler returns.  */

static void signal_integer_exception_handler
  (int sig, siginfo_t *info, ucontext_t *context)
{
  word instruction = *(word*)CONTEXT_PC(context);

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    signal_ml_handler(sig,info,context);
  
  if (!global_state.in_ML) {
    message_stderr("Warning: signal %d outside ML -- ignoring", sig);
    return;
  }

/* Check for allocation traps so we can start a GC.

   Allocation sequences always look like one of the following:

 * 1. Allocating a known amount < 4k:

	taddcctv %g1, #bytes, %g1
	add	rn, %g2, #tag
	add	%g2, %g2, #bytes

 * 2. Allocating an unknown amount, or a known amount > 4k:

 	<get the number of bytes into the 'global' register %g4>
 	taddcctv %g1, %g4, %g1
 	add	rn, %g2, #tag
 	add	%g2, %g2, %g4

 * In a leaf procedure, the 'add rn' instruction (the one after the
 * taddcctv) should be replaced with an 'or rn' instruction. This
 * enables us to distinguish the leaf case.

 * The taddcctv instruction fails if there is insufficient space for
 * the alloc */

#define TADDCCTV_MASK 0xffffc000
#define TADDCCTV_BITS 0x83104000

  if ((instruction & TADDCCTV_MASK) == TADDCCTV_BITS) {
    /* then it's a GC entry point */

    int leaf;
    word instr2;
    word overwrite_instr;	/* the instr to go in the overwrite slot */
    word *overwrite;		/* the address of the overwrite slot */


    /* get the number of bytes */

#define TADDCCTV_IMMEDIATE_FLAG_MASK 0x2000
#define TADDCCTV_IMMEDIATE_MASK 0x1fff

    if (instruction & TADDCCTV_IMMEDIATE_FLAG_MASK) {
      gc_trap_bytes = ((instruction & TADDCCTV_IMMEDIATE_MASK));
    } else {
      /* -1 means "the number is in the 'global' register" */
      gc_trap_bytes = 0xffffffff;
    }

    /* We want to return to address+12, so set the fake link register
       to addr+4 */

    gc_trap_return_address = ((word)CONTEXT_PC(context))+4;

    /* construct tagging instruction, which tags the value in the
       return register and puts it in whatever register the allocation
       routine was going to put it. We do this by getting the tagging
       instruction out of the allocation routine and changing the
       register number */

    instr2 = ((word*)CONTEXT_PC(context))[1];

#define GC_RETURN_REGISTER 0x1u
#define GC_TAGGING_SHIFT 14u
#define GC_TAGGING_MASK 0x1fu

    overwrite_instr =
      ((instr2 & (~(GC_TAGGING_MASK << GC_TAGGING_SHIFT)))
       | (GC_RETURN_REGISTER << GC_TAGGING_SHIFT));

    /* was the allocation routine in a leaf procedure? */

#define GC_ENTRY_LEAF_MASK 0x3f
#define GC_ENTRY_LEAF_SHIFT 19
#define GC_ENTRY_LEAF_VALUE 2

    leaf = (((instr2 & (GC_ENTRY_LEAF_MASK << GC_ENTRY_LEAF_SHIFT))
		 >> GC_ENTRY_LEAF_SHIFT) == GC_ENTRY_LEAF_VALUE);

    if (leaf) {
      CONTEXT_PC(context) = (int)gc_trap_entry_leaf;
      CONTEXT_NPC(context) = ((int)gc_trap_entry_leaf)+4;
      overwrite = gc_trap_ret_leaf_overwrite;
    } else {
      CONTEXT_PC(context) = (int)gc_trap_entry;
      CONTEXT_NPC(context) = ((int)gc_trap_entry)+4;
      overwrite = gc_trap_ret_overwrite;
    }
    *overwrite = overwrite_instr;
    cache_flush((void*)overwrite, sizeof(word));
    return;
  }

  DIAGNOSTIC(3, "signal %d: EMT exception code 0x%X", sig, info->si_code);
  DIAGNOSTIC(3, "  addr 0x%X: %08X", CONTEXT_PC(context), instruction);

  /* Switch on the instruction code: SPARC specific */

  switch(instruction & 0xC1F80000) {
    case 0x81180000:
    DIAGNOSTIC(4, "  tsubcctv", 0, 0);
    break;

    case 0x81100000:
    DIAGNOSTIC(4, "  taddcctv", 0, 0);
    break;

    default:
    DIAGNOSTIC(4, "  not a tagged trap int instruction", 0, 0);
    message("Warning: signal %d on non-trap instruction %08X -- ignoring", sig, instruction);
    return;
  }
  CONTEXT_ARG(context) = DEREF(perv_exn_ref_overflow);
  CONTEXT_PC(context) = (int)ml_raise;
  CONTEXT_NPC(context) = (int)ml_raise+4;
}


/* == Licensing support == 
 * 
 * SIGALRM is handled by refreshing the license. */

static void signal_timer_handler
  (int sig, siginfo_t *info, ucontext_t *context)
{
  refresh_license();

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      signal_ml_handler(sig,info,context);
}

extern void signal_license_timer (int interval) 
{
  struct itimerval period;

  /* establish real interval timer signal handler */
  if(set_signal_handler(SIGALRM, signal_timer_handler))
    error("Unable to set up real interval timer signal handler.");

  signal_handled[SIGALRM]   |= SIGNAL_HANDLED_IN_C;	/* licensing */

  /* Establish timer for refreshing the license */
  period.it_value.tv_sec = interval;
  period.it_value.tv_usec = 0;
  period.it_interval.tv_sec = interval;
  period.it_interval.tv_usec = 0;
  
  if(setitimer(ITIMER_REAL, &period, NULL) == -1)
    error("Unable to set up licensing timer.  "
	  "setitimer set errno to %d.", errno);
}

/* == Interrupt Support ==
 * 
 * SIGINT is handled and interpreted as an interrupt. */

static void signal_interrupt_handler
  (int sig, siginfo_t *info, ucontext_t *context)
{
  if (awaiting_x_event) {
    message ("Signal %s at top level", name_that_signal (sig));
  } else {
    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      signal_ml_handler(sig,info,context);
    else 
      signal_ml_event(context);
  
    record_event(EV_INTERRUPT, (word) 0);
  }
}

extern int signal_set_interrupt_handler(void)
{
  signal_handled[SIGINT] |= SIGNAL_HANDLED_IN_C;	/* interrupt */
  return set_signal_handler(SIGINT,signal_interrupt_handler);
}

extern int signal_clear_interrupt_handler(void)
{
  signal_handled[SIGINT] &= !SIGNAL_HANDLED_IN_C;

  if (signal_handled[SIGINT] & SIGNAL_HANDLED_IN_ML)
    return signal_set_ml_handler(SIGINT);
  else
    return restore_default_signal_handler(SIGINT);
}

/* == Timer support ==
 *
 * We need a virtual-time alarm for two purposes: for stack-based profiling
 * and for thread pre-emption.
 */

static struct itimerval interval_timer, residual_timer;
unsigned int current_interval = 0;

/* the number of milliseconds for the profiling and pre-emption intervals. */

unsigned int profiling_interval = 0;
unsigned int thread_preemption_interval = 0;
unsigned int window_update_interval = 0;
static unsigned int window_update_remaining = 0;
static unsigned int window_updates_on = 0;

static void signal_start_timer(void)
{
  if(setitimer(ITIMER_VIRTUAL, &interval_timer, &residual_timer) == -1)
    message("Warning: Unable to set interval timer. \n"
	    " Profiling, preemption, and window updates may not occur");
}

static unsigned int signal_set_timer(unsigned int interval)
{
  unsigned int last_interval = current_interval;
  current_interval = interval;
  interval_timer.it_value.tv_sec = interval/1000;
  interval_timer.it_value.tv_usec = (interval%1000)*1000;
  interval_timer.it_interval.tv_sec = 0;
  interval_timer.it_interval.tv_usec = 0; /* one shot timer */

  signal_start_timer();
  interval = ((residual_timer.it_value.tv_sec * 1000) +
	      (residual_timer.it_value.tv_usec / 1000));
  interval = last_interval - interval;
  return interval;
}

static int signal_update_windows(unsigned int interval)
{
  if (window_update_remaining < interval) {
    window_update_remaining = window_update_interval;
    if (window_updates_on) {
      record_event(EV_WINDOWS, (word) 0);
      return 1;
    }
  } else
    window_update_remaining -= interval;
  return 0;
}
  
static void signal_do_timer(unsigned int interval)
{
  unsigned int residue = signal_set_timer(interval);
  (void) signal_update_windows(residue);
}

/* The signal handler function. If we're profiling we run the
 * profiler. If we're pre-empting we record the event. */

static void signal_interval_alarm
  (int sig, siginfo_t *info, ucontext_t *context)
{
  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    signal_ml_handler(sig,info,context);
  
  if (profile_on)
    time_profile_scan((struct stack_frame *) CONTEXT_SP(context));
  
  if (thread_preemption_on) {
    thread_preemption_pending = 1;
    record_event(EV_SWITCH, (word) 0);
    if ((signal_handled[sig] & SIGNAL_HANDLED_IN_ML) == 0)
      signal_ml_event(context);
  }

  if (signal_update_windows (current_interval))
      signal_ml_event(context);
  signal_start_timer();
}

/* == Profiling support == */

extern void signal_profiling_start(void)
{
  signal_do_timer(profiling_interval);
}

extern void signal_profiling_stop(void)
{
  unsigned int interval;
  if (thread_preemption_on)
    interval = thread_preemption_interval;
  else if (window_updates_on)
    interval = window_update_interval;
  else
    interval = 0;
  signal_do_timer(interval);
}

/* == Preemption support == */

extern void signal_preemption_start(void)
{
  if (!profile_on)
    signal_do_timer(thread_preemption_interval);
}

extern void signal_preemption_stop(void)
{
  if (!profile_on) {
    unsigned int interval;
    if (window_updates_on)
      interval = window_update_interval;
    else
      interval = 0;
    signal_do_timer(interval);
  }
}

extern void signal_preemption_change(void)
{
  signal_preemption_start();
}

/* Window update support */

extern void signal_window_updates_start(void)
{
  window_updates_on = 1;
  if (current_interval == 0)
    signal_do_timer(window_update_interval);
}

extern void signal_window_updates_stop(void)
{
  window_updates_on = 0;
}

/* a generic routine to make a new copy of some code */

static word* copy_code(char* start, char* finish)
{
  unsigned int bytes = finish-start;
  word *result = (word*)malloc(bytes);
  memcpy(result,start,bytes);
  return result;
}

/* copy the two GC return codes into the data segment */

static void copy_codes(void)
{
  gc_trap_ret_code = copy_code((char*) &gc_trap_ret_template,
			       (char*) &gc_trap_ret_template_end);
  gc_trap_ret_leaf_code = copy_code((char*) &gc_trap_ret_leaf_template,
				    (char*) &gc_trap_ret_leaf_template_end);

  gc_trap_ret_overwrite = (word*) (((int)gc_trap_ret_code) +
				   ((int)&gc_trap_ret_template_overwrite) -
				   ((int)&gc_trap_ret_template));
  gc_trap_ret_leaf_overwrite =
    (word*) (((int)gc_trap_ret_leaf_code) +
	     ((int)&gc_trap_ret_leaf_template_overwrite)-
	     ((int)&gc_trap_ret_leaf_template));
}

static void establish_signal_table(void)
{
  int i;
  signal_handled = (word*) alloc(NR_SIGNALS * sizeof(word),
				 "Unable to allocate signal table");
  for (i=0; i < NR_SIGNALS; i++)
    signal_handled[i] = SIGNAL_NOT_HANDLED;
  signal_handled[SIGEMT]    = SIGNAL_HANDLED_IN_C;	/* integer exns */
  signal_handled[SIGVTALRM] = SIGNAL_HANDLED_IN_C;	/* intervals */
}

extern void signals_init (void)
{
  stack_t ss;
  char *signal_stack;

  /* Initialise the signal stack */
  signal_stack =
    (char *)alloc(SIGNAL_STACK_SIZE, "Unable to allocate signal stack.");

  ss.ss_sp = signal_stack;
  ss.ss_size = SIGNAL_STACK_SIZE;
  ss.ss_flags = 0;

  if(sigaltstack(&ss, NULL) == -1)
    error("Unable to set up signal stack (sigaltstack set errno to %d).",
	  errno);

  /* set up 'where is signal handled' table */
  establish_signal_table();

  /* establish integer arithmetic exception catcher */
  if (set_signal_handler(SIGEMT, signal_integer_exception_handler))
    error("Unable to set integer exception handler.");

  /* establish virtual interval timer signal handler */
  if (set_signal_handler(SIGVTALRM, signal_interval_alarm))
    error("Unable to set up virtual interval timer signal handler.");

  /* make copies of GC return codes */
  copy_codes();

  /* these signals are fatal */
  die_on_signal (SIGILL);
  die_on_signal (SIGBUS);
  die_on_signal (SIGSEGV);
}


extern void ml_gc_die(mlval closure)
{
  error("ml_gc() called by %s.\n\tYou are probably running out-of-date .mo files\n",
	CSTRING(CCODENAME(FIELD(closure,0))));
}

extern void ml_gc_leaf_die(mlval closure)
{
  error("ml_gc_leaf() called by %s.\n\tYou are probably running out-of-date .mo files\n",
	CSTRING(CCODENAME(FIELD(closure,0))));
}
