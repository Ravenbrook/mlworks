/* ==== SIGNAL HANDLING ====
 * 
 * Copyright (C) 1994 Harlequin Ltd.
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
 * Revision 1.37  1996/10/25 12:49:08  stephenb
 * [Bug #1700]
 * Convert from sigvec -> sigaction so that it is possible to
 * add a SA_RESTART to the flags in set_signal_handler and therefore
 * avoid interrupted system calls.
 *
 * Revision 1.36  1996/10/17  14:55:11  jont
 * Merge in license stuff
 *
 * Revision 1.35.2.2  1996/10/09  11:57:33  nickb
 * Move to Harlequin license server.
 *
 * Revision 1.35.2.1  1996/10/07  16:11:47  hope
 * branched from 1.35
 *
 * Revision 1.35  1996/06/07  09:31:44  jont
 * Update best before to 01/01/97
 *
 * Revision 1.34  1996/05/14  12:11:48  stephenb
 * Remove the #define LANGUAGE_C as this is now defined for all files
 *
 * Revision 1.33  1996/04/30  12:00:58  matthew
 * Reinstating signal handler for integer
 *
 * Revision 1.32  1996/04/19  11:01:58  matthew
 * Different exceptions for integer operations
 * No trapping for real operations
 *
 * Revision 1.31  1996/02/08  15:59:21  jont
 * Removing do_exportFn, as this is no longer architecture dependent
 *
 * Revision 1.30  1996/02/08  13:21:13  jont
 * Modify exportFn mechanism not to use signals at all
 * Use busy waiting in parent instead, thus avoiding
 * potential race contions
 *
 * Revision 1.29  1996/02/07  12:14:38  nickb
 * Make interval window updates happen even if we stay in ML.
 *
 * Revision 1.28  1996/01/17  16:30:23  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.27  1996/01/16  13:46:13  nickb
 * Getting rid of sm_interface().
 *
 * Revision 1.26  1996/01/16  12:06:31  stephenb
 * Fix bug #995 - death of last thread due to a fatal signal should
 * result in a non-zero termination code.
 *
 * Revision 1.25  1996/01/12  16:25:22  stephenb
 * Fix handle_fatal_signal so that it deals with a fatal signal
 * being raised whilst handling a fatal signal.
 *
 * Revision 1.24  1996/01/11  14:47:48  nickb
 * Add timer-triggered window updates.
 *
 * Revision 1.23  1996/01/09  12:34:10  nickb
 * Extensions to event handling for non-signal events.
 *
 * Revision 1.22  1996/01/02  12:23:04  nickb
 * Update best-before date to 1996-07-01.
 *
 * Revision 1.21  1995/12/12  16:17:27  nickb
 * Extend closure check in the profiling code.
 *
 * Revision 1.20  1995/09/19  15:18:55  nickb
 * Improve the full GC we do during function export.
 *
 * Revision 1.19  1995/09/15  16:28:30  jont
 * Add do_exportFn to do the system specific part of exportFn
 *
 * Revision 1.18  1995/07/17  10:01:00  nickb
 * Change profiler interface.
 *
 * Revision 1.17  1995/07/03  10:18:13  nickb
 * Update best-before date.
 *
 * Revision 1.16  1995/06/12  15:28:23  nickb
 * Fix minor thinko in fatal_signal.
 *
 * Revision 1.15  1995/06/06  12:22:52  nickb
 * Improve fatal signal support.
 *
 * Revision 1.14  1995/05/23  09:29:10  nickb
 * Fatal signal code not fixing up the stack correctly.
 *
 * Revision 1.13  1995/05/04  10:45:52  nickb
 * Remove diagnostic printing.
 *
 * Revision 1.12  1995/05/02  12:33:50  nickb
 * Get signal handling &c to work.
 *
 * Revision 1.11  1995/04/27  13:03:59  daveb
 * If signal_ml_handler is called while we are waiting for an X event,
 * the runtime just prints a message.  This avoids problems with pointer
 * grabs in X callbacks.
 *
 * Revision 1.10  1995/04/24  15:17:19  nickb
 * Add thread_preemption_pending.
 *
 * Revision 1.9  1995/04/12  12:09:30  nickb
 * Make fatal signal messages come out on stderr.
 *
 * Revision 1.8  1995/03/15  16:43:58  nickb
 * Introduce the threads system.
 *
 * Revision 1.7  1995/01/05  11:33:44  nickb
 * Amend best-before date to 1st July 1995.
 * Also fix Harlequin's telephone number.
 * Also make license signal handler run on the current stack.
 *
 * Revision 1.6  1994/11/23  16:50:02  nickb
 * Remove set_stack_underflow() call.
 *
 * Revision 1.5  1994/10/19  16:52:53  nickb
 * Add includes.
 *
 * Revision 1.4  1994/09/07  10:06:43  jont
 * Update license expiry date
 *
 * Revision 1.3  1994/07/25  14:01:54  nickh
 * Make sure signal handlers get executed on the signal stack.
 *
 * Revision 1.2  1994/07/13  16:20:23  jont
 * Add signal_interrupt
 *
 * Revision 1.1  1994/07/12  12:47:45  jont
 * new file
 *
 */

#include <math.h>
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
#include "state.h"
#include "threads.h"
#include "x.h"
#include "main.h"
#include "pervasives.h"
#include "global.h"
#include "allocator.h"
#include "image.h"

#include <time.h>
#include <sys/types.h>
#include <sys/time.h>
#include <signal.h>		/* sigaction */
#include <string.h>
#include <memory.h>
#include <errno.h>		/* errno */
#include <sym.h>
#include <exception.h>
#include <unistd.h>
#include <sys/fpu.h>

#define SC_REG(scp,reg)	((scp)->sc_regs[reg].lo32)

#define SC_ARG(scp)	SC_REG(scp,4)
#define SC_SLIMIT(scp)	SC_REG(scp,7)
#define SC_SP(scp)	SC_REG(scp,29)
#define SC_FP(scp)	SC_REG(scp,30)
#define SC_CLOSURE(scp)	SC_REG(scp,6)
#define SC_BASE(scp)	SC_REG(scp,25)
#define SC_PC(scp)	((scp)->sc_pc.lo32)
#define SC_BRANCH_DELAY(scp)	(((long)(scp)->sc_cause.lo32)<0)

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
 {SIGUSR1,	"SIGUSR1"},
 {SIGUSR2,	"SIGUSR2"},
 {SIGCHLD,	"SIGCHLD"},
 {SIGPWR,	"SIGPWR"},
 {SIGWINCH,	"SIGWINCH"},
 {SIGURG,	"SIGURG"},
 {SIGIO,	"SIGIO"},
 {SIGSTOP,	"SIGSTOP"},
 {SIGTSTP,	"SIGTSTP"},
 {SIGCONT,	"SIGCONT"},
 {SIGTTIN,	"SIGTTIN"},
 {SIGTTOU,	"SIGTTOU"},
 {SIGVTALRM,	"SIGVTALRM"},
 {SIGPROF,	"SIGPROF"},
 {SIGXCPU,	"SIGXCPU"},
 {SIGXFSZ,	"SIGXFSZ"},
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

/* Irix-specific stuff for setting and clearing a signal handler */

static int check_sigaction(int sig, struct sigaction * act)
{
  int result= sigaction(sig, act, NULL);
  if (result) {
    switch(errno) {
    case EINVAL:
      errno = ESIGNALNO;
      break;
    default:
      error("sigaction returned an unexpected error code %d", errno);
    }
  }
  return result;
}


typedef void (*signal_handler)(int, int, struct sigcontext *);
/*
 * Note that unlike the Solaris case, SA_SIGINFO is not used in
 * the following and so a signal handler has the above prototype.
 * This has been done to try an limit the amount of code that has
 * to change in the sigvec->sigaction conversion that is necessary
 * to allow the SA_RESTART handler to be used.
 * 
 * Using SA_SIGINFO requires the ucontext_t structure to be used,
 * and as usual this is not clearly documented, especially the part
 * about setting PC -- ucontext_t only appears to have an EPC, not a PC,
 * and according to Kane&Heinrich page 6-21, EPC register is read only
 * on all but R4000.  Perhaps when you fill in the EPC field it
 * really fills in the PC.  This is something to test if/when
 * the upgrade to SA_SIGINFO is done - stephenb.
 */
static int set_signal_handler(int sig, signal_handler handler)
{
  struct sigaction sa;
  sa.sa_handler= handler;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags= SA_ONSTACK | SA_RESTART;
  return check_sigaction(sig, &sa);
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

static void signal_ml_event (struct sigcontext *scp)
{
  if (global_state.in_ML) {
    /* set the stack limit register to -1 */
    SC_SLIMIT(scp) = (word)-1;
  }
}

/*  == The C signal handler ==
 *
 *  This function converts a C signal into an ML signal event.
 */

static void signal_ml_handler
  (int sig, int code, struct sigcontext *scp)
{
  if (awaiting_x_event) {
    message ("Signal %s at top level", name_that_signal (sig));
  } else {
    record_event(EV_SIGNAL, (word) sig);
    signal_ml_event(scp);
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

/* Up to two 'stack frames' of interest to the profiler or to a fatal
   signal backtrace may be kept in registers. We diagnose the current
   state from the registers and build fake frames if necessary: */

static struct stack_frame signal_fake_frames[2];

/* This tells us whether a given ML value is a valid closure */

static int is_closure(mlval clos)
{
  /* first check that it is an ML pointer into a heap area */
  if (ISORDPTR(clos)) {
    int type = SPACE_TYPE(clos);
    if (type != TYPE_RESERVED
	&& type != TYPE_FREE) {
      /* next check that it indicates a record, or a shared closure */
      mlval header = GETHEADER(clos);
      if (header == 0 || SECONDARY(header) == RECORD) {
	/* then check that the first field is a pointer */
	mlval code = FIELD(clos,0);
	if (PRIMARY(code) == POINTER) {
	  if (code == stub_c || code == stub_asm ||
	      SECONDARY(GETHEADER(code)) == BACKPTR)
	    return 1;
	}
      }
    }
  }
  return 0;
}

/* This checks whether the given PC indicates code within the code
 * item associated with the given closure */

static int pc_in_closure(word pc, mlval clos)
{
  mlval code = FIELD(clos,0);
  word code_start = (word)CCODESTART(code);
  /* is it after the start of this function ? */
  if (pc >= code_start) {
    mlval codeobj = FOLLOWBACK(code);
    word code_end = ((word)OBJECT(codeobj)) + (LENGTH(OBJECT(codeobj)[0]) << 2);
    /* is it before the end of this code object ? */
    if (pc < code_end) { 
      int codenum = CCODENUMBER(code);
      int codes = NFIELDS(FIELD(CCVANCILLARY(codeobj), ANC_NAMES));
      if (codes != codenum+1) {
	if (FIELD(clos,1) == 0) {
	  /* so we are in a shared closure; not the case for stub_c */
	  mlval nextcode = FIELD(clos,2);
	  if (nextcode > code) {
	    code_end = (word)CCODESTART(nextcode);
	    /* is it after the end of this code item ? */
	    if (pc >= code_end)
	      return 0;
	  } else {
	    error("signal handler found code vectors in wrong order\n");
	  }
	}
      }
      return 1;
    }
  }
  return 0;
}

/* this function examines the registers and the instructions around
 * the PC to establish the contents of the fake stack frames. It
 * returns an sp which can be passed to the profiler or a backtrace */

static struct sigcontext *debug_scp = NULL;

static struct stack_frame * signal_fixup_ML_state(struct sigcontext *scp)
{
  struct stack_frame *profile_top = NULL;
  word pc = SC_PC(scp);
  debug_scp = scp;
  if ((global_state.in_ML) /* &&
       (   TYPE(pc) == TYPE_GEN
	|| TYPE(pc) == TYPE_STATIC)) */) {
    mlval clos6 = SC_CLOSURE(scp);
    mlval clos5 = SC_REG(scp,5);
    word instr = *(word *)pc;
    
    signal_fake_frames->fp = signal_fake_frames+1;
    signal_fake_frames[1].closure = clos6;
    signal_fake_frames[0].closure = clos5;
    
    /* if clos5 == clos6 or the pc is not in clos5, we take the pc to be in
       clos6 */
    
    if (clos5 != clos6 && is_closure(clos5) && pc_in_closure(pc,clos5))
      profile_top = signal_fake_frames;
    else
      profile_top = signal_fake_frames+1;
    
    /* these are the only three instructions between sp being changed and
     * the closure list $6::stack($sp) being valid. These instructions
     * only occur there.  While there, the closure list $5::$6::stack($fp)
     * should be used instead. */
    
#define SW_CLOS_SP_4		0xafa60004
#define SW_LINK_SP_8		0xafbf0008
#define MV_CLOS_CCLOS		0x00a03025
    
    /* this is the only instruction between the closure being changed and
     * the $sp being right for that closure when leaving or tailing from a
     * function. While at this instruction, $6::stack($fp) should be
     * used. */
    
#define MV_SP_FP		0x03c0e825
    
    if (   (instr == SW_CLOS_SP_4)
	|| (instr == SW_LINK_SP_8)
	|| (instr == MV_CLOS_CCLOS)
	|| (instr == MV_SP_FP))
      signal_fake_frames[1].fp = (struct stack_frame *)SC_FP(scp);
    else
      signal_fake_frames[1].fp = (struct stack_frame *)SC_SP(scp);
    
    if (SC_SP(scp) != SC_FP(scp))
      ((struct stack_frame *)SC_SP(scp))->fp =
	(struct stack_frame *)SC_FP(scp);
  } else {
    profile_top = (struct stack_frame *)CURRENT_THREAD->ml_state.sp;
  }
  return profile_top;
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

static void handle_fatal_signal(int sig, int code, struct sigcontext *scp)
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
    CURRENT_THREAD->in_fatal_signal_handler= 1;

    signal_name= name_that_signal (sig);
    handler= THREAD_ERROR_HANDLER(CURRENT_THREAD);

    DIAGNOSTIC(2, "signal_handler(sig = %d)", sig, 0);

    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      signal_ml_handler(sig,code,scp);
  
    if (handler == MLUNIT) {
      /* there is no handler; print a message and kill this thread. */
      if (runnable_threads == 2) {
	die_in_fatal_signal_handler("Last thread dying.");
      } else {
	struct stack_frame *sp = signal_fixup_ML_state(scp);
	message ("Thread #%d received an intolerable signal %s (%d : %d) %sin ML and died.",
		 CURRENT_THREAD->number, signal_name, sig, code,
		 global_state.in_ML? "" : "not ");
	backtrace (sp, CURRENT_THREAD, max_backtrace_depth);
	SET_RESULT(ML_THREAD(CURRENT_THREAD),THREAD_DIED);

	if (global_state.in_ML) {
	  SC_PC(scp) = (word)stub_c+CODE_OFFSET;
	  SC_ARG(scp) = MLUNIT;
	  SC_REG(scp,5) = (word)signal_thread_suicide_stub+POINTER;
	} else {
	  SC_PC(scp) = (word)thread_suicide;
	  SC_BASE(scp) = (word)thread_suicide;
	}
	/* to reduce the race window the following should be near the
	 * end of thread_suicide.  However, that entails putting it in
	 * the end of the asm routine change_thread, so for simplicity it
	 * is left here. */
	CURRENT_THREAD->in_fatal_signal_handler= 0;
      }
    } else {
      /* there is a handler; skip to it */
      SC_ARG(scp) = MLINT(sig);
      SC_REG(scp,5) = handler;
      if (global_state.in_ML) {
	SC_PC(scp) = FIELD(handler,0)+CODE_OFFSET;
      } else {
	SC_PC(scp) = (word)callml;
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


/* == Arithmetic exception support == 
 *
 *  This function is the handler for the floating point signals.  If
 *  called while in ML it examines the instruction which caused the
 *  exception in order to determine which ML exception to raise.  The
 *  signal context is updated in order to raise the exception when the
 *  handler returns.  */

static void signal_arithmetic_exception_handler
  (int sig, int code, struct sigcontext *scp)
{
  word *pc = (word*)SC_PC(scp);
  word instruction;

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    signal_ml_handler(sig,code,scp);
  
  if (SC_BRANCH_DELAY(scp)) /* we're in a delay slot; pc is the branch */
    pc++;

  instruction = *pc;

  /* Switch on the instruction code: MIPS specific */
  switch(instruction & 0xfc000000) {	/* opcode field: top 6 bits */
  case 0x00000000:	/* SPECIAL */
    switch (instruction & 0x000007ff) {	/* shamt,funct fields: bottom 11 bits*/
    case 0x00000020:	/* ADD */
      break;
    case 0x00000022:	/* SUB */
      break;
    default:
      message("Arithmetic signal on non-trapping instruction 0x%08x",
	      instruction);
    }
    break;
  case 0x20000000:	/* ADDI */
    break;
  default:
    message("Arithmetic signal on non-trapping instruction 0x%08x",
	    instruction);
  }

  if (global_state.in_ML) {
    SC_PC(scp) = (word) ml_raise;
    SC_ARG(scp) = DEREF(perv_exn_ref_overflow);
  } else {
    message("Warning: FPE signal outside ML");
    SC_BASE(scp) = (word) exn_raise;
    SC_PC(scp) = (word) exn_raise;
    SC_ARG(scp) = perv_exn_ref_overflow;
  }
}

/* == Licensing support == 
 * 
 * SIGALRM is handled by refreshing the license. */

static void signal_timer_handler
  (int sig, int code, struct sigcontext *scp)
{
  refresh_license();

  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    signal_ml_handler(sig,code,scp);
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
				      struct sigcontext *scp)
{
  if (awaiting_x_event) {
    message ("Signal %s at top level", name_that_signal (sig));
  } else {
    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      signal_ml_handler(sig,sig_code,scp);
    else 
      signal_ml_event(scp);
  
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
  (void) signal_update_windows(residue);
}

/* The signal handler function. If we're profiling we run the
 * profiler. If we're pre-empting we record the event. */

static void signal_interval_alarm (int sig, int sig_code,
				  struct sigcontext *scp)
{
  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    signal_ml_handler(sig,sig_code,scp);
  
  if (profile_on)
    time_profile_scan(signal_fixup_ML_state(scp));
  
  if (thread_preemption_on) {
    thread_preemption_pending = 1;
    record_event(EV_SWITCH, (word) 0);
    if ((signal_handled[sig] & SIGNAL_HANDLED_IN_ML) == 0)
      signal_ml_event(scp);
  }

  if (signal_update_windows (current_interval))
    signal_ml_event(scp);
    
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

static void establish_signal_table(void)
{
  int i;
  signal_handled = (word*) alloc(NR_SIGNALS * sizeof(word),
				 "Unable to allocate signal table");
  for (i=0; i < NR_SIGNALS; i++)
    signal_handled[i] = SIGNAL_NOT_HANDLED;
  signal_handled[SIGFPE]    = SIGNAL_HANDLED_IN_C;	/* float exns */
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

  /* establish arithmetic exception catcher */
  /* No longer required */
  if (set_signal_handler(SIGFPE,signal_arithmetic_exception_handler))
    error("Unable to set arithmetic exception handler.");

  /* establish virtual interval timer signal handler */
  if (set_signal_handler(SIGVTALRM, signal_interval_alarm))
    error("Unable to set up interval timer signal handler.");

  /* these signals are fatal */
  die_on_signal (SIGILL);
  die_on_signal (SIGBUS);
  die_on_signal (SIGSEGV);
}
