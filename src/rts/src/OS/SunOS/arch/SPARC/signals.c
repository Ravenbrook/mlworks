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
 * 
 * Revision Log
 * ------------
 * $Log: signals.c,v $
 * Revision 1.50  1997/01/07 10:47:59  matthew
 * Changing diagnostic level for EMT message
 *
 * Revision 1.49  1996/11/08  11:03:48  matthew
 * [Bug #1710]
 * Adding dummy matherr functions
 *
 * Revision 1.48  1996/10/17  14:52:07  jont
 * Merge in license stuff
 *
 * Revision 1.47.2.2  1996/10/09  11:58:43  nickb
 * Move to Harlequin license server.
 *
 * Revision 1.47.2.1  1996/10/07  16:12:32  hope
 * branched from 1.47
 *
 * Revision 1.47  1996/06/07  09:31:23  jont
 * Update best before to 01/01/97
 *
 * Revision 1.46  1996/05/23  13:46:24  matthew
 * Fixing bungle with comment brackets
 *
 * Revision 1.45  1996/05/23  11:05:48  matthew
 * Fixing matherr again
 *
 * Revision 1.44  1996/05/23  10:54:07  matthew
 * Commenting out matherr
 *
 * Revision 1.43  1996/04/22  09:16:54  matthew
 * removing unused real signal handler
 *
 * Revision 1.42  1996/04/19  14:22:13  matthew
 * Changes to Exception raising
 *
 * Revision 1.41  1996/02/08  15:49:46  jont
 * Removing do_exportFn, as this is no longer architecture dependent
 *
 * Revision 1.40  1996/02/08  13:08:32  jont
 * Modify exportFn mechanism not to use signals at all
 * Use busy waiting in parent instead, thus avoiding
 * potential race contions
 *
 * Revision 1.39  1996/02/07  16:56:12  jont
 * Ensure signal_child_handler only deals with signals from known children
 *
 * Revision 1.38  1996/02/07  11:45:50  nickb
 * Make interval window updates happen even if we stay in ML.
 *
 * Revision 1.37  1996/01/29  15:09:04  stephenb
 * Add <unistd.h>
 *
 * Revision 1.36  1996/01/17  17:35:47  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.35  1996/01/16  14:01:11  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.34  1996/01/16  12:22:15  stephenb
 * Add a patch to die_on_signal that I should have added in my previous bug fix.
 *
 * Revision 1.33  1996/01/16  10:52:58  stephenb
 * Fix bug #995 - death of last thread due to a fatal signal should
 * result in a non-zero termination code.
 *
 * Revision 1.32  1996/01/12  12:45:58  stephenb
 * Fix fatal signal handler so that it does not loop if a
 * fatal signal is received whilst the handler is active.
 *
 * Revision 1.31  1996/01/11  13:21:49  nickb
 * Add timer-triggered window updates.
 *
 * Revision 1.29  1996/01/02  12:19:20  nickb
 * Update best-before date to 1996-07-01.
 *
 * Revision 1.28  1995/09/19  15:19:33  nickb
 * Improve the full GC we do during function export.
 *
 * Revision 1.27  1995/09/15  16:27:55  jont
 * Add do_exportFn to do the system specific part of exportFn
 *
 * Revision 1.26  1995/09/12  15:04:00  nickb
 * Unusual SIGINT bug.
 *
 * Revision 1.25  1995/07/04  13:02:06  nickb
 * Change to profiler interface.
 *
 * Revision 1.24  1995/07/03  10:17:09  nickb
 * Update best-before date.
 *
 * Revision 1.23  1995/06/12  15:22:47  nickb
 * Fix minor thinko in fatal_signal.
 *
 * Revision 1.22  1995/06/06  12:27:30  nickb
 * Tidy up fatal signal handling some more.
 *
 * Revision 1.21  1995/06/06  11:22:07  nickb
 * Tidy up fatal signal handling.
 *
 * Revision 1.20  1995/06/02  15:52:02  nickb
 * Better fatal signal handling.
 *
 * Revision 1.19  1995/04/27  11:57:33  daveb
 * If signal_ml_handler is called while we are waiting for an X event,
 * the runtime just prints a message.  This avoids problems with pointer
 * grabs in X callbacks.
 *
 * Revision 1.18  1995/04/24  12:47:45  nickb
 * Add thread_preemption_pending.
 *
 * Revision 1.17  1995/04/12  12:25:13  nickb
 * Make fatal signal messages come out on stderr.
 *
 * Revision 1.16  1995/04/12  09:39:58  matthew
 * Changing underflow behaviour in matherr
 *
 * Revision 1.15  1995/04/10  14:30:53  nickb
 * Fix profiler entry.
 *
 * Revision 1.14  1995/03/15  16:20:23  nickb
 * Introduce the threads system.
 *
 * Revision 1.13  1995/01/05  11:10:23  nickb
 * Adjust best-before date to 1995-07-01 00:00
 * Also make child sig handler run on current stack (otherwise the
 * first occurence causes a bus error).
 * Also correct the Harlequin telephone number.
 *
 * Revision 1.12  1994/12/14  14:54:42  matthew
 * Changed error output to be written to stderr
 *
 * Revision 1.11  1994/11/23  16:52:00  nickb
 * Put in declaration for set_stack_underflow().
 *
 * Revision 1.10  1994/11/15  15:37:37  nickb
 * Add cache flushing.
 *
 * Revision 1.9  1994/10/19  14:32:42  nickb
 * Better type checking in Gcc 2.5.8 points out a missing cast.
 *
 * Revision 1.8  1994/09/07  10:05:04  jont
 * Update license expiry date
 *
 * Revision 1.7  1994/07/25  13:16:54  nickh
 * Make sure all handlers execute on signal stack.
 *
 * Revision 1.6  1994/07/22  14:33:33  nickh
 * Add GC trap handling.
 *
 * Revision 1.5  1994/07/08  10:03:57  nickh
 * Add interrupt signal number and reserve two more signals.
 *
 * Revision 1.4  1994/06/14  14:51:09  jont
 * Add critical region support for FP signals
 *
 * Revision 1.3  1994/06/13  12:02:58  nickh
 * Update best-before date.
 *
 * Revision 1.2  1994/06/09  14:24:13  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:49:10  nickh
 * new file
 *
 */

#include "signals.h"
#include "utils.h"
#include "diagnostic.h"
#include "interface.h"
#include "implicit.h"
#include "values.h"
#include "gc.h"
#include "stacks.h"
#include "syscalls.h"
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

#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <memory.h>
#include <sys/wait.h>
#include <signal.h>
#include <sys/signal.h>
#include <errno.h>
#include <sys/errno.h>
#include <math.h>

/*  
 * Under SunOS, the signal context does not contain the whole
 * processor state. Some of the state is saved and restored by
 * _sigtramp, the OS library function which is the direct caller of
 * the signal handler. _sigtramp saves this information in its stack
 * frame.
 *
 * We need to modify some of this information. Notably g6, which is
 * the stack limit register, needs to be modified in order to trigger
 * a stack overflow check (which causes ML signal handlers to be run).
 *
 * When dealing with a fatal signal we also want to see register o1,
 * which is in this frame.  */

/* This is very OS-specific */

struct sigtramp_frame {
  struct stack_frame	frame;
  word			pad1;
  int			sig;
  int			code;
  struct sigcontext *	scp;
  char *		addr;
  word			pad2[3];
  double		floats[16];	/* only saved if FP enabled */
  word			fsr;		/* only saved if FP enabled */
  word			y;
  word			g2;
  word			g3;
  word			g4;
  word			g5;
  word			g6;
  word			g7;
};

extern struct sigtramp_frame *get_callers_frame(void);

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
#define SIGNAL_STACK_SIZE 	8192

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
 {SIGURG,	"SIGURG"},
 {SIGSTOP,	"SIGSTOP"},
 {SIGTSTP,	"SIGTSTP"},
 {SIGCONT,	"SIGCONT"},
 {SIGCHLD,	"SIGCHLD"},
 {SIGTTIN,	"SIGTTIN"},
 {SIGTTOU,	"SIGTTOU"},
 {SIGIO,	"SIGIO"},
 {SIGXCPU,	"SIGXCPU"},
 {SIGXFSZ,	"SIGXFSZ"},
 {SIGVTALRM,	"SIGVTALRM"},
 {SIGPROF,	"SIGPROF"},
 {SIGWINCH,	"SIGWINCH"},
 {SIGLOST,	"SIGLOST"},
 {SIGUSR1,	"SIGUSR1"},
 {SIGUSR2,	"SIGUSR2"},
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

/* SunOS-specific stuff for setting and clearing a signal handler */

typedef void (*signal_handler)(int sig, int, struct sigcontext *, char *);

static int check_sigvec (int sig, struct sigvec *vec)
{
  int result = sigvec (sig,vec,NULL);

  if (result)
    switch(errno) {
    case EINVAL:
      errno = ESIGNALNO;
      break;
    default:
      error("sigvec returned an unexpected error code %d", errno);
    }
  return result;
}

static int set_signal_handler(int sig, signal_handler handler)
{
  struct sigvec sv;
  sv.sv_handler = handler;

  /* due to an OS bug in SunOS 4.1.3, we have to mask our
   * control-flow-changing signals here, because otherwise their
   * handlers can over-ride these ones, with the result that the
   * process signal mask doesn't get reset correctly. See MLWorks
   * change report 1225. */
  sv.sv_mask = sigmask(SIGEMT);	/* mustn't take a GC trap */
  sv.sv_flags = SV_ONSTACK;
      
  return (check_sigvec (sig,&sv));
}

static int restore_default_signal_handler(int sig)
{
  struct sigvec sv;
  sv.sv_handler = SIG_DFL;
  sv.sv_mask = 0;
  sv.sv_flags = 0;
  return check_sigvec(sig, &sv);
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

static void signal_ml_event (struct sigtramp_frame *sf)
{
  if (global_state.in_ML)
    sf->g6 = (word)-1;
}

/* This function converts a C signal into an ML signal event. */

static void ml_signal_handler (int sig, struct sigtramp_frame *sf)
{
  if (awaiting_x_event) {
    message ("Signal %s at top level", name_that_signal (sig));
  } else {
    record_event(EV_SIGNAL, (word) sig);
    signal_ml_event(sf);
  }
}

static void signal_ml_handler
  (int sig, int code, struct sigcontext *scp, char *addr)
{
  ml_signal_handler(sig, get_callers_frame());
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

/* Define a matherr that does nothing */
extern int matherr(struct exception *e)
{
  return(1);
}

static void handle_fatal_signal(int sig, int code,
				  struct sigcontext *scp, char *addr)
{
  if (CURRENT_THREAD == 0) {
    die_in_fatal_signal_handler("Corrupt threads system");

  } else if (CURRENT_THREAD->in_fatal_signal_handler) {
    die_in_fatal_signal_handler("Fatal signal raised by handler");

  } else if (in_GC) {
    die_in_fatal_signal_handler("fatal signal raised during GC.");

  } else {
    const char *signal_name;
    mlval handler;
    struct sigtramp_frame *st_frame;
  
    CURRENT_THREAD->in_fatal_signal_handler= 1;
    signal_name= name_that_signal (sig);
    handler= THREAD_ERROR_HANDLER(CURRENT_THREAD);
    st_frame= get_callers_frame();
    flush_windows();

    DIAGNOSTIC(2, "signal_handler(sig = %d)", sig, 0);

    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      ml_signal_handler(sig, st_frame);
  
    if (handler == MLUNIT) {
      /* there is no handler; print a message and kill this thread. */
      if (runnable_threads == 2) {
	die_in_fatal_signal_handler("Last thread dying.");
      } else {
	message ("Thread #%d received an intolerable signal %s (%d : %d) %sin ML and died.",
		 CURRENT_THREAD->number, signal_name, sig, code,
		 global_state.in_ML? "" : "not ");
	backtrace ((struct stack_frame *)scp->sc_sp, CURRENT_THREAD,
		   max_backtrace_depth);
	SET_RESULT(ML_THREAD(CURRENT_THREAD), THREAD_DIED);
	if (global_state.in_ML) { 
	  scp->sc_pc = (int)stub_c+CODE_OFFSET;
	  scp->sc_npc = (int)stub_c+CODE_OFFSET+4;
	  scp->sc_o0 = MLUNIT;
	  st_frame->frame.closure = (int)signal_thread_suicide_stub+POINTER;
	} else {
	  scp->sc_pc = (int) thread_suicide;
	  scp->sc_npc = (int)thread_suicide+4;
	}
	/* to reduce the race window the following should be near the
	 * end of thread_suicide.  However, that entails putting it in
	 * the end of the asm routine change_thread, so for simplicity it
	 * is left here. */
	CURRENT_THREAD->in_fatal_signal_handler= 0;
      }
    } else {
      /* there is a handler; skip to it */
      scp->sc_o0 = MLINT(sig);
      st_frame->frame.closure = handler;
      if (global_state.in_ML) {
	scp->sc_pc = FIELD(handler,0)+CODE_OFFSET;
	scp->sc_npc = FIELD(handler,0)+CODE_OFFSET+4;
      } else {
	scp->sc_pc = (int)callml;
	scp->sc_npc = (int)callml+4;
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
  (int sig, int code, struct sigcontext *scp, char *addr)
{
  word instruction = *(word*)addr;

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    ml_signal_handler(sig, get_callers_frame());
  
  if(!global_state.in_ML) {
    message_stderr("Warning: signal %d outside ML", sig);
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
    word overwrite_instr; /* the instruction to put in the overwrite slot */
    word *overwrite;	/* the address of the overwrite slot */

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

    gc_trap_return_address = ((word)addr)+4;

    /* construct tagging instruction, which tags the value in the
       return register and puts it in whatever register the allocation
       routine was going to put it. We do this by getting the tagging
       instruction out of the allocation routine and changing the
       register number */

    instr2 = ((word*)addr)[1];

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
      scp->sc_pc = (int)gc_trap_entry_leaf;
      scp->sc_npc = ((int)gc_trap_entry_leaf)+4;
      overwrite = gc_trap_ret_leaf_overwrite;
    } else {
      scp->sc_pc = (int)gc_trap_entry;
      scp->sc_npc = ((int)gc_trap_entry)+4;
      overwrite = gc_trap_ret_overwrite;
    }
    *overwrite = overwrite_instr;
    cache_flush((void *)overwrite,sizeof(word));
    return;
  }

  /* Not a GC trap, so what was it? */

  DIAGNOSTIC(3, "signal %d: EMT exception code 0x%X", sig, code);
  DIAGNOSTIC(3, "  addr 0x%X: %08X", addr, *(word*)addr);

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
    message_stderr("Warning: signal %d on non-trap instruction %08X -- ignoring", sig, instruction);
    return;
  }
  scp->sc_o0 = DEREF(perv_exn_ref_overflow);
  scp->sc_pc = (int)ml_raise;
  scp->sc_npc = (int)ml_raise+4;
}

/* == Licensing support == 
 * 
 * SIGALRM is handled by refreshing the license. */

static void signal_timer_handler
    (int sig, int code, struct sigcontext *scp, char *addr)
{
  refresh_license();

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    ml_signal_handler(sig, get_callers_frame());
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

static void signal_interrupt_handler (int sig, int sig_code,
				      struct sigcontext *scp,
				      char *addr)
{
  if (awaiting_x_event) {
    message ("Signal %s at top level", name_that_signal (sig));
  } else {
    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      ml_signal_handler(sig, get_callers_frame());
    else 
      signal_ml_event(get_callers_frame());
  
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
 * We need a virtual-time alarm for several purposes: stack-based
 * profiling, thread pre-emption, and window updates.
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
  (void)signal_update_windows(residue);
}

/* The signal handler function. If we're profiling we run the
 * profiler. If we're pre-empting we record the event. */

static void signal_interval_alarm (int sig, int sig_code,
				   struct sigcontext *scp,
				   char *addr)
{
  struct sigtramp_frame *sf = get_callers_frame();

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    ml_signal_handler(sig, sf);
  
  if (profile_on)
    time_profile_scan((struct stack_frame *) scp->sc_sp);
  
  if (thread_preemption_on) {
    thread_preemption_pending = 1;
    record_event(EV_SWITCH, (word) 0);
    if ((signal_handled[sig] & SIGNAL_HANDLED_IN_ML) == 0)
      signal_ml_event(sf);
  }

  if (signal_update_windows (current_interval))
    signal_ml_event(sf);
  
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
  struct sigstack ss;
  char *signal_stack;

  /* Initialise the signal stack */
  signal_stack =
    (char *)alloc(SIGNAL_STACK_SIZE, "Unable to allocate signal stack.");

  ss.ss_sp = signal_stack + SIGNAL_STACK_SIZE;
  ss.ss_onstack = 0;

  if(sigstack(&ss, NULL) == -1)
    error("Unable to set up signal stack (sigstack set errno to %d).", errno);

  /* set up 'where is signal handled' table */
  establish_signal_table();

  /* establish integer arithmetic exception catcher */
  if(set_signal_handler(SIGEMT, signal_integer_exception_handler))
    error("Unable to set integer exception handler.");

  /* establish virtual interval timer signal handler */
  if(set_signal_handler(SIGVTALRM,signal_interval_alarm))
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
