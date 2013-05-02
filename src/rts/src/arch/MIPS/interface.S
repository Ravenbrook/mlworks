/*
 * ==== ML TO C INTERFACING CODE ====
 *		MIPS
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
 * This code does the job of managing the calls between ML and C.  The ML
 * and C states are stored in C structures declared in `state.c'.
 *
 * Notes
 * -----
 * Take great care modifying this file. As well as getting the
 * semantics right for MIPS (remember those delay slots!), you have to
 * maintain hidden invariants or you will break the profiler. See the
 * profiler comment in the body of the file.
 *
 * This code uses some predefined macros as parameters.  These are
 * defined (or not) in the Makefile.  They are as follows:
 *
 *   COLLECT_STATS: If defined the routines will update various
 *                  counters defined in callc_codes.c when called.
 *
 * This file must be run through CPP to produce an assembler file. 
 *
 * Revision Log
 * ------------
 * $Log: interface.S,v $
 * Revision 1.35  1996/11/07 17:32:55  stephenb
 * [Bug #1461]
 * Remove fake frame builds from ml_disturbance.
 *
 *Revision 1.34  1996/08/16  13:44:37  io
 *Some URI comments for replacement_code
 *
 *Revision 1.33  1996/08/16  13:37:58  io
 *Some URI comments for replacement_code
 *
 *Revision 1.32  1996/04/25  17:23:14  stephenb
 *Load delay slot hazard not warned by SGI's shit assembler.
 *
 *Revision 1.31  1995/12/12  15:22:02  nickb
 *Fix bug in space profiling; can't use jal as the SGI assembler expands it.
 *
 *Revision 1.30  1995/12/11  15:52:19  nickb
 *Add space profiling.
 *
 *Revision 1.29  1995/11/13  12:34:39  nickb
 *Move CURRENT_THREAD manipulation out of asm into portable C.
 *
 *Revision 1.28  1995/09/06  15:13:30  nickb
 *Change to c_sp protocol.
 *
 *Revision 1.27  1995/07/17  09:45:21  nickb
 *Add dummy sequences for space profiling.
 *
 *Revision 1.26  1995/06/27  14:20:24  jont
 *Fix unbounded stack growth from leaf raise problems
 *
 *Revision 1.25  1995/06/15  14:19:46  jont
 *Modify raise code to remove stack copying down and up in favour of
 *a small extra frame.
 *
 *Revision 1.24  1995/06/01  09:10:02  matthew
 *Save argument on stack in intercept and replace leaf
 *
 *Revision 1.23  1995/05/26  09:20:51  matthew
 *leaf intercept and replace were the wrong way round too
 *
 *Revision 1.22  1995/05/24  13:55:03  nickb
 *Workaround for the Irix 'as' silently removing our instructions.
 *
 *Revision 1.21  1995/05/23  12:26:31  matthew
 *ml_replace and ml_intercept were the wrong way round
 *
 *Revision 1.20  1995/05/09  15:39:19  nickb
 *Fix ml_disturbance; a closure/link address pair are not getting in
 *the same stack frame.
 *
 *Revision 1.19  1995/05/05  15:00:08  nickb
 *Got the operands to jalr backwards in the intercept/replace pieces of code.
 *
 *Revision 1.18  1995/05/05  11:08:29  nickb
 *Oops. Of course I meant clean_caller_saves, not clean_callee_saves.
 *
 *Revision 1.17  1995/05/05  10:54:03  nickb
 *Fix some problems with c_raise.
 *Also add a cautionary comment.
 *
 *Revision 1.16  1995/05/04  10:52:52  nickb
 *Change the manipulation of the in_ML flag so that:
 *(a) in_ML false => thread->ml_state.sp is meaningful
 *(b) in_ML true => sp,fp,closures make some sense for ML.
 *
 *Revision 1.15  1995/03/30  12:20:41  nickb
 *Add threads system.
 *
 *Revision 1.14  1995/01/12  11:21:56  nickb
 *Make ml_raise_leaf do something. Also fix c_raise (it's
 *getting the wrong closure).
 *
 *Revision 1.13  1994/12/13  13:39:40  nickb
 *Rewrote most of this file, including getting the stack extension to work.
 *
 *Revision 1.11  1994/11/08  16:20:36  matthew
 *Save and restore fp registers around gc and C calls
 *
 *Revision 1.10  1994/10/28  12:42:19  jont
 *Untag continuation offsets before use
 *
 *Revision 1.9  1994/10/25  13:07:53  nickb
 *Also fix typo bug in c_raise.
 *
 *Revision 1.8  1994/10/20  11:23:35  nickb
 *Add a name to copy_up and copy_down.
 *
 *Revision 1.7  1994/09/15  17:20:15  jont
 *Reduce handler frame size to four words by leaving out fp
 *
 * Revision 1.6  1994/08/03  13:44:19  jont
 * Add closure to ml_state
 *
 * Revision 1.5  1994/07/27  13:50:32  jont
 * Remove dummy realpath (only there for Ultrix anyway)
 *
 * Revision 1.4  1994/07/22  16:43:28  jont
 * Add c_raise
 *
 * Revision 1.3  1994/07/20  14:24:35  jont
 * Add ml_raise code
 *
 * Revision 1.2  1994/07/15  16:48:59  jont
 * gc entry stuff
 *
 * Revision 1.1  1994/07/12  12:06:12  jont
 * new file
 *
 */

/* The signal-handling interface for the profiler, and for printing
 * backtraces after fatal signals, deduces the current topmost few
 * frames on the logical ML stack from the contents of certain
 * registers and the C variable global_state.in_ML.
 *
 * In order to do this it needs to assume certain invariants. Take
 * great care when modifying this file or you will break these
 * invariants.
 *
 * The signal-handler interface has the following pseudocode:
 * 
 * if global_state.in_ML == 0,
 * 	backtrace = CURRENT_THREAD->ml_state.sp
 * if global_state.in_ML != 0,
 * 	local 
 * 	  val missing_closures = 
 * 		(if $5 <> $6, andalso $5 is a closure,
 * 		    andalso $pc is in that code item,
 * 		then [$5,$6] else [$6])
 * 	  val rest_of_stack =
 * 		(if the instruction under pc is one of a small magic set,
 * 		 (connected with function entry and return)
 * 		then $fp else $sp)
 * 	  val _ = if $sp <> $fp then *($sp) := $fp
 * 	in
 * 	  backtrace = missing_closures @ rest_of_stack
 * 	end
 * 
 * frames upwards from 'backtrace' are then examined by the profiler
 * or the backtrace printer, treating any without ML-tagged closures
 * as C frames.
 *
 * So, for instance, invariants obviously include:
 *
 * - when in_ML == 0, ml_sp must be valid
 * - when in_ML != 0,
 *		- $5 and $6 must not contain non-ML garbage
 *		- $sp and $fp must make _some_ sense together.
 * 		- if $sp doesn't point to a stack frame with 
 *		  a valid closure, one must be at a 'magic' instruction.
 * (see signals.c for a list).  */

#include "tags.h"
#include "offsets.h"
#include "macros.h"


	.set	noat
	.set	noreorder


/* === CALL ML FROM C ===
 *
 * callml is a C-like function which allows C to invoke an ML function in
 * the manner of a coroutine.
 *
 * The C global registers are stored in the structure c_state, and the
 * ML global state is loaded.  A new ML stack frame is allocated below
 * the base pointer of the current ML stack area (pointed to by %g6).
 * The ML function is then called.  On return the stack area base
 * pointer is restored to its calue on entry, the ML state is stored
 * and the C state loaded, then control returns to C.
 *
 *
 * Parameters:
 *   $4		 Argument for the ML function
 *   $5		 Closure of the function to call
 *   $31	 Link register for return to C
 * Returns:
 *   $2		 Result of the ML function
 */

	.globl	callml
callml:
	push_C_regs			/* save C callee saves on C stack */
	clean_callee_saves		/* clean $10-$15, $24-$25 */
	la	$10, global_state	/* global_state (GC-safe) in $10 */
	nop
	lw	$9, GLOBAL_current_thread($10) 		/* current thread */
	nop
	lw	$11, THREAD_c_sp($9)	/* old c_state.sp (GC-safe) in $11 */
	sw	$29, THREAD_c_sp($9)	/* Save new c_state.sp */
	load_ML_state
	lw	$30, THREAD_ml_sp($9)	/* Get ml_state.sp into fp */
	ori	$6, $0, STACK_C_CALL
	addiu	$29, $30, -4*4		/* make frame on the ML stack */
	sw	$11, 12($29)		/* old c_state.sp */
	sw	$31, 8($29)		/* link to caller */
	sw	$6, 4($29)		/* closure slot = STACK_C_CALL */
	sw	$10, GLOBAL_in_ML($10)	/* now in ML */
	clean_caller_saves		/* clean $16-$23 */
	lw	$1, -1($5)		/* Function closure */
	nop
	addu	$1, CODE_OFFSET
	jal	$1			/* Call ML */
	ori	$6, $0, STACK_START	/* with callee-closure = STACK_START*/

/* Enter ML with:

$4	argument
$5	closure
$6	caller's closure = STACK_START
$10	global_state (callee save)
$11	old c_sp (callee save)
$13-$25	all zero

So when we return, $10 and $11 will still have these values....
*/
	lw	$31, 8($29)
	addu	$29, 16			/* Pop ml frame */
	store_ML_state
	sw	$29, THREAD_ml_sp($9)		/* restore ml_state.sp */
	sw	$0, GLOBAL_in_ML($10)	/* no longer in_ML */
	lw	$29, THREAD_c_sp($9)	/* Get old C stack back */
	sw	$11, THREAD_c_sp($9)	/* restore c_sp */
	nop				/* delay slot */
	pop_C_regs			/* reload those C callee saves */
	j	$31			/* Return to C */
	move	$2, $4			/* Get result into C result reg */
/*
 * === STUBS FROM ML ===
 * 
 * These are static ML code vectors which call the routine pointed to
 * by their first closure element.  The C calling stub swaps into the
 * C state before calling the function, whereas the assembler version
 * does not. Since the MIPS assembler cannot build the constants we
 * need, we copy this code into code objects by hand in stubs.c, q.v.
 *
 * Note that the Irix calling convention passes the code address in $25.
 */

	.globl	text_internal_stub_c
	.globl	text_internal_stub_c_end
text_internal_stub_c:
	push_ML_regs			/* save ML callee-saves */
	lw	$16, THREAD_global($9)  /* get global state */
	store_ML_state
	sw	$29, THREAD_ml_sp($9)	/* Save last ML frame for GC */
	lw	$25, 3($5)		/* code address */
	sw	$0, GLOBAL_in_ML($16)	/* No longer in_ML */
	jal	$25			/* Call C function */
	lw	$29, THREAD_c_sp($9)	/* load C sp */

/* Enter C with these values in C callee-save regs (they will be preserved):
	$16	global_state
	$30	ML fp */

	move	$4, $2			/* answer into ML result reg */
	lw	$9, GLOBAL_current_thread($16)
	move    $5, $0			/* clear clos5 so profiling works */
	move    $6, $0			/* clear clos6 so profiling works */
	lw	$29, THREAD_ml_sp($9)	/* restore ML sp */
	sw	$16, GLOBAL_in_ML($16)	/* back in ML */
	load_ML_state
	pop_ML_regs			/* restore callee-saves */
	clean_caller_saves		/* clean caller saves, which could */
					/* contain dead values if C did a GC */
	j	$31			/* return */
	nop
text_internal_stub_c_end:

	.globl	text_internal_stub_asm
	.globl	text_internal_stub_asm_end
text_internal_stub_asm:
	lw	$1, 3($5)		/* Address to call */
	nop
	j	$1			/* Tail to it */
	nop
text_internal_stub_asm_end:

/* === LOOK UP A VALUE IN THE RUNTIME ENVIRONMENT ===
 *
 * Calls directly through to env_lookup() from environment.h.
 */

	.globl ml_lookup_pervasive
ml_lookup_pervasive:
	push_ML_regs
	ML_to_C(perv_lookup)
	nop				/* sp has just been loaded */
	pop_ML_regs
	j	$31			/* As the ml may immediately use it */
	nop

/*
 * === GARBAGE COLLECTOR ENTRY POINTS ===
 *
 * Non-leaf case:
 *  Parameters:
 *    $1  Number of bytes required
 *    $2  Top of live data + $1
 *    $6  Current closure
 *  Returns:
 *    $1  Address of allocated space
 *    $2  New top of live data + $1
 *    $3  New heap limit
 *    Other registers preserved.
 *
 * The address of this code is stored in the implcit vector (see
 * `implicit.h').  It is called when the heap start exceeds the heap
 * limit (i.e. when additional space needs to be found).
*/
	.globl	ml_gc
ml_gc:
	push_all_ML_regs		/* Save all the GCable registers */
	move	$4, $1			/* Size needed in C arg 1 */
	lw	$16, THREAD_global($9)	/* get global state */
	store_ML_state
	sw	$29, THREAD_ml_sp($9)	/* Save last frame for gc */
	sw	$0, GLOBAL_in_ML($16)	/* in_ML := 0 */
	lw	$29, THREAD_c_sp ($9)	/* Onto c stack */
	nop				/* delay slot */
	push_fps			/* save floating-point regs */
	jal	gc			/* Call garbage collector */
	move	$5, $6			/* With caller's closure in arg 2 */
	
/* Enter C with ML fp in $30 and global_state in $16; these are preserved */

	lw	$9, GLOBAL_current_thread($16)
	pop_fps				/* restore floating-point regs */
	lw	$29, THREAD_ml_sp($9)	/* Back onto the ML stack */
	move    $5, $0			/* clear clos5 so profiling works */
	move    $6, $0			/* clear clos6 so profiling works */
	sw	$16, GLOBAL_in_ML($16)	/* back in ML */
	load_ML_state			/* Puts GC return value in $1 */
	pop_all_ML_regs			/* reload all the GCable regs */
	j	$31			/* return */
	nop

/* Leaf case:
 *  Parameters:
 *    $1  Number of bytes required
 *    $2  Top of live data + $1
 *    $3  Link register back to ML code
 *  Returns:
 *    As non-leaf case.
 */
	.globl	ml_gc_leaf
ml_gc_leaf:
	sw	$30, 0($29)		/* Make a frame for the leaf */
	move	$30, $29	
	subu	$29, 16
	sw	$6,  4($29)		/* caller's closure */
	sw	$31, 8($29)		/* link to caller */
	move	$6,  $5			/* leaf's closure in closure reg */
	sw	$4, 12($29)		/* 'argument' slot */
	move	$31, $3			/* link to leaf in link reg */

/* Now proceed as for the non-leaf case : */

	push_all_ML_regs		/* Save all the GCable registers */
	move	$4, $1			/* amount to allocate */
	store_ML_state
	lw	$16, THREAD_global($9)	/* get global_state */
	sw	$29, THREAD_ml_sp($9)	/* Save last frame for gc */
	sw	$0, GLOBAL_in_ML($16)	/* in_ML := 0 */
	lw	$29, THREAD_c_sp($9)	/* Onto c stack */
	nop
	push_fps			/* save floating-point regs */
	jal	gc			/* Call garbage collector */
	move	$5, $6			/* With caller's closure in arg 2 */
	
/* Enter C with ML fp in $30 and global_state in $16; these are preserved */

	lw	$9, GLOBAL_current_thread($16)
	pop_fps				/* restore floating-point regs */
	lw	$29, THREAD_ml_sp($9)	/* Back onto the ML stack */
	move	$5, $0			/* clear clos5 so profiling works */
	move	$6, $0			/* clear clos6 so profiling works */
	sw	$16, GLOBAL_in_ML($16)	/* in_ML != 0 */
	load_ML_state			/* Puts GC return value in $1 */
	pop_all_ML_regs			/* reload all the GCable regs */

/* Now we need to pop the special frame made for the leaf
 * function. All our registers except $6, $31, sp and fp are as they
 * need to be at re-entry. $31 currently has the address to which we
 * need to re-enter; we have to hold that in fp temporarily. */

	move	$30, $31		/* keep return address in fp */
	lw	$6,  4($29)		/* reload caller's closure */
	lw	$31, 8($29)		/* reload caller's return address */
	addu	$29, 16			/* pop the leaf's frame */
	j	$30			/* return */
	lw	$30, 0($29)		/* restore the fp */
	
/* === FLUSH REGISTER WINDOWS ===
 *
 * This routine would invoke the window flushing trap on SPARC.  We
 * have it for portability of interface.h.
 */

	.globl	flush_windows

flush_windows:
	j	$31			/* Do nothing */
	nop

/*
 * === STACK OVERFLOW / ASYNCHRONOUS EVENT ===
 *
 * This code is called by ML when sp-STACK_BUFFER < slimit (unsigned).
 * This condition is checked by ML on function entry to ensure that
 * there is enough room for a frame, and is used by the asynchronous
 * event handler to trip up ML at a `safe' moment.
 * 
 * The comments here use function names as if e called f called g,
 * and g is the disturbed function.
 *
 * g jumps here with the following values in registers
 *
 *  $1	frame size required 
 *       (not including usual safety zone)
 *  $3  link to continue g
 *  $4, $17-$23: arguments of g
 *  $5  closure of g
 *  $6	closure of f
 *  $7	stack limit (or -1 if there's been an asynchronous event)
 *  $16 caller-save, so we can use it
 *  $29 the unchanged sp
 *  $30 fp = sp (the old fp has already been saved)
 *  $31 link to f
 */

	.globl	ml_disturbance

ml_disturbance:

/* make new stack frame */

	addiu	$sp, $sp, -16			/* make new stack frame: */
	sw	$1, 12($sp)			/* +12:	requirement	*/
	sw	$31, 8($sp)			/* +8:	link to f	*/
	sw	$6, 4($sp)			/* +4:  closure of f	*/
	lw	$16, -PAIRPTR($5)		/* code ptr of g */
	move	$31, $0
	addiu	$16, $16, CODE_OFFSET		/* code base of g */
	subu	$16, $3, $16			/* continuation offset for g */

/* Now we check whether a stack extension is required */
	lw	$3, IMPLICIT_stack_limit($9)	/* get true stack limit */
	subu	$6, $sp, $1			/* calculate new sp */
	slt	$6, $6, $3			/* do we require extension? */
	beq	$6, $0, check_for_events	/* if not, skip it */
	li	$6, STACK_DISTURB_EVENT		/* with $6 = DISTURB */

/* We  do require a stack extension, so we call make_stack */
	push_all_ML_regs
#ifdef COLLECT_STATS				
	la	$4, stack_extension_count	/* inc stack_extension_count */
	nop
	lw	$5, 0($4)
	nop
	addiu	$5, $5, 1
	sw	$5, 0($4)
#endif
/* we have requirement in $1, true stack limit in $3 */
	addiu	$4, $3, -(STACK_BUFFER+DEFAULT_STACK_SIZE)
						/* arg 0 = current stack */
	addiu	$5, $1, STACK_BUFFER+DEFAULT_STACK_SIZE
						/* arg 1 = requirement */
	ML_to_C(make_ml_stack)			/* exits with $9 = thread */
	addiu	$16, $4, STACK_BUFFER+DEFAULT_STACK_SIZE
						/* calculate new stack limit */
	sw	$16, IMPLICIT_stack_limit($9)	/* save it away */
	move	$7, $16				/* update the limit reg */
	lw	$1, 4($4)			/* new sp in global */

/* move onto new stack */
	pop_all_ML_regs
	move	$3, $sp				/* remember old sp in temp */
	lw	$6, 4($3)			/* get f closure */
	addiu	$sp, $1, -16			/* make frame on new block: */
	sw	$6, 4($sp)			/* +4: f closure */
	lw	$1, 12($3)			/* get required frame size */
	lw	$3, 8($3)			/* get link to f */
	sw	$1, 12($sp)			/* +12: required frame size */
	sw	$3, 8($sp)			/* +8: link to f */
	li	$6, STACK_EXTENSION

/* Now we test for events. We get here by one of two routes (depending
 * on whether we have extended the stack or not). Either way, $1
 * (required frame size), $4 $10-$15, $17-$25 have not changed, $7 is
 * the stack limit, $5 is g's closure, $6 is either STACK_EXTENSION or
 * STACK_DISTURB_EVENT, depending on whether we've done a stack
 * extension */

check_for_events:
	lw	$3, IMPLICIT_interrupt($9)	/* if either interrupt slot */
	nop					/* (delay slot) */
	or	$3, $3, $7			/* or stack limit register */
	bgtz	$3, call_disturbed_fn		/* is set, we have an event */
	nop					/* ... */

/* We have an event; call ev_poll */
	sw	$0, IMPLICIT_interrupt($9)	/* clear the interrupt slot */
	lw	$7, IMPLICIT_stack_limit($9)	/* restore the stack limit */
	push_all_ML_regs
	ML_to_C(ev_poll)
	pop_all_ML_regs

/* Now continue and call the disturbed function. Note that $6 is now
 * either STACK_EXTENSION or STACK_EVENT, according to whether we've
 * done a stack extension or not. */

/* Note that we must continue with fp = sp, *sp = old fp, and $1 unchanged */

call_disturbed_fn:
	lw	$1, -PAIRPTR($5)		/* code ptr of g */
	lw	$3, IMPLICIT_gc_limit($9)	/* restore GC limit */
	addiu	$1, $1, CODE_OFFSET		/* code base of g */
	addu	$16, $1, $16			/* continuation for g */
	sw	$fp, 0($sp)			/* save fp */
	lw	$1, 12($sp)			/* get global from frame */
	jalr	$31, $16			/* continue */
	move	$fp, $sp			/* fp = sp */

/* When we return, sp points to a frame size 12, either on the old or
 * new stack, which contains the caller's closure and return address. We
 * must determine whether we extended the stack, and un-extend it if
 * so. */

return_from_disturbed_fn:
	li	$1, STACK_EXTENSION		/* did we extend the stack? */
	lw	$31, 8($sp)			/* get link to caller */
	bne	$6, $1, return_to_caller	/* if not, return now */
	lw	$6, 4($sp)			/* get caller's closure */

/* We did a stack extension; we need to move back to the previous
 * stack and call unmake_stack. We have loads of registers free at
 * this point (result is in $4, but $1, $5, $16-$23 are all free). We
 * have to push a frame on the old stack containing all the
 * callee-saves, then call unmake_stack. We have to be careful to pass
 * the returned value back to the caller */
	
	addiu	$sp, $fp, -48			/* push frame on old stack */
	sw	$6, 4($sp)			/* save caller's closure */
	sw	$31, 8($sp)			/* save link to caller */
	sw	$30, 0($sp)			/* Fill Fp Slot */
	sw	$10, 12($sp)			/* Save ML Callee-Saves */
	sw	$11, 16($sp)
	sw	$12, 20($sp)
	sw	$13, 24($sp)
	sw	$14, 28($sp)
	sw	$15, 32($sp)
	sw	$24, 36($sp)
	sw	$25, 40($sp)
	sw	 $4, 44($sp)			/* save result */

	lw	$4, IMPLICIT_stack_limit($9)	/* get stack limit in $4 */
	nop
	addiu	$4, $4, -(STACK_BUFFER+DEFAULT_STACK_SIZE)
						/* arg 0 = new stack base */
	ML_to_C(unmake_ml_stack)
	addiu	$4, $4, (STACK_BUFFER+DEFAULT_STACK_SIZE) /* old stack limit */
	sw	$4, IMPLICIT_stack_limit($9)	/* save it in ml_state */
	move	$7, $4				/* and in the slimit reg */
	lw	$16, IMPLICIT_interrupt($9)	/* or slimit with interrupt */
	lw	$6, 4($sp)			/* restore clos in delay slot*/
	or	$7, $7, $16
	lw	$31, 8($sp)			/* restore link to caller */
	lw	$10, 12($sp)			/* Restore ML Callee-Saves */
	lw	$11, 16($sp)
	lw	$12, 20($sp)
	lw	$13, 24($sp)
	lw	$14, 28($sp)
	lw	$15, 32($sp)
	lw	$24, 36($sp)
	lw	$25, 40($sp)
	lw	 $4, 44($sp)			/* result of disturbed fn */

return_to_caller:
	move	$sp,$fp				/* pop the stack */
	lw	$fp, 0($sp)			/* restore fp */
		
	jr	$31				/* return to caller */
	nop		

/* event_check is entered when an explicit check is made on the stack
 * limit: has it been set to -1? If so, we come here with all
 * registers live. For ml_event_check the continuation address is in
 * $31. For ml_event_check_leaf the continuation is in $3. */

	.globl	ml_event_check
ml_event_check:
	push_all_ML_regs
	sw	$0, IMPLICIT_interrupt($9)
	ML_to_C(ev_poll)
	nop
	pop_all_ML_regs
	jr	$31
	nop

	.globl	ml_event_check_leaf
ml_event_check_leaf:
	sw	$30, 0($29)		/* create dummy frame for leaf fn */
	move	$30, $29
	subu	$29, 16
	sw	$0, 12($29)
	sw	$31, 8($29)
	sw	$6, 4($29)
	move	$31, $3			/* set up lr as if called */
	move	$6, $5			/* likewise closure */
	push_all_ML_regs		/* create new frame for all registers*/
	lw	$3, IMPLICIT_gc_limit($9)
	sw	$0, IMPLICIT_interrupt($9)
	ML_to_C(ev_poll)
	nop
	pop_all_ML_regs
	move	$5, $6
	move	$1, $31			/* return address in global */
	lw	$31, 8($29)		/* pop dummy frame */
	lw	$6, 4($29)
	move	$29, $30
	lw	$30, 0($29)
	jr	$1
	nop
	
/* === RAISE AN EXCEPTION FROM C === */
/* This is an entry point to _ml_raise which may be called from C. */

	.globl	c_raise
c_raise:

/* We unwind the stack to the most recent ML frame and raise the
 * exception from there. */

	la	$10, global_state	/* global_state (GC-safe) in $10 */
	move	$6, $0			/* clear clos6 so profiling works */
	lw	$9, GLOBAL_current_thread($10) 		/* current thread */
	move	$5, $0			/* clear clos5 so profiling works */
	load_ML_state
	lw	$29, THREAD_ml_sp($9)	/* back onto the ML stack */
	clean_caller_saves
	lw	$30, 0($29)		/* restore the fp */
	sw	$10, GLOBAL_in_ML($10)	/* now in ML */
	pop_ML_regs			/* restore ML callee-saves */

/* Now it looks as if we are raising the exception from the ML
 * function which made the call into C */

	/* \/\/ fall through \/\/ */

/* 
 * === RAISE AN EXCEPTION ===
 *
 * When an exception is raised the first exception handler function on
 * the handler chain is called to deal with it.	If the handler
 * function returns then the exception was handled.  The context of
 * the function in which the handler was created (the `creator') must
 * be restored and that function continued.  The stack frame is
 * restored repeatedly until we reach the one recorded in the handler
 * record (this is done by the unwind_stack macro).
 *
 * Handler record format:
 *   -1	Previous handler
 *    3	Frame pointer of creator
 *    7	Stack pointer of creator
 *   11	Handler function closure
 *   15	Offset within creator of continuation code
 *
 * Parameters:
 *   $4		The exception packet to raise
 *   $6		The current function's closure
 *   $31	Return address for resumption (not used at present, and not true for leaf)
 *   $8		Exception handler record
 *
 *
 * Warning. This code assumes that all procedures containing handler
 * continuations are non-leaf. This is currently true because setting
 * up a handler calls adr, which forces non-leaf because it corrupts $31.
 * However, should we produce a leaf adr by preserving $31 in $1, then
 * all hell will break loose.
 *
 */
	.globl	ml_raise
	.globl	ml_raise_leaf

/* Note: in a leaf function on MIPS the leaf's closure is not
 * available since it may have been overwritten. So we raise as if
 * from the calling function. */

ml_raise_leaf:
ml_raise:
#ifdef COLLECT_STATS
	la	$16, raise_count
	nop
	lw	$17, 0($16)
	nop
	addiu	$17, $17, 1
	sw	$17, 0($16)
#endif
	li	$1, STACK_RAISE		/* do not exchange with next instr */
	sw	$30, 0($29)		/* Save current frame pointer if not already done */
	beq	$6, $1, ml_raise10	/* Branch if already got a spare frame */
	lw	$5, 7($8)		/* Get handler closure */
	move	$30, $29		/* New fp */
	subu	$29, 16			/* New sp */
	sw	$30, 0($29)		/* Save fp just in case */
	sw	$6, 4($29)		/* Save caller's closure */
	sw	$0, 8($29)		/* Zero return address to avoid gc fiddling */
ml_raise10:
	sw	$8, 12($29)		/* Save current handler pointer */
	lw	$1, -1($5)		/* Get handler address */
	li	$6, STACK_RAISE		/* Our closure mark */
	addiu	$1, CODE_OFFSET
	jalr	$1			/* Call the handler */
	lw	$8, -1($8)		/* With previous handler pointer */
/*
 * Remove dummy frame from stack
 */
	lw	$6, 4($29)		/* Restore caller's closure */
	lw	$8, 12($29)		/* Restore handler pointer */
	move	$29, $30		/* Pop frame */
	lw	$30, 0($29)		/* And fp */
	lw	$1, 3($8)		/* Get sp of handler creator */
	nop
	lw	$18, 0($1)		/* And get fp from that */

	unwind_stack(raise)		/* Unwind to that fp, propagating result */
	lw	$1, 11($8)		/* Offset of continuation */
	lw	$5, -1($6)		/* Start of creator function */
	srl	$1, $1, 2		/* Untag it */
	addu	$1, CODE_OFFSET
	addu	$1, $5
	j	$1
	nop

/*
 * === CODE VECTOR REPLACEMENT AND INTERCEPTION ===
 *
 *
 * When compiled for debugging, code vectors contain a sequence of
 * three nop operations which can be replaced with code to intercept or
 * replace the flow of control.  This is used to implement tracing,
 * profiling, etc.
 *
 *  _ml_intercept (_ml_intercept_leaf) is jumped to by the instructions
 * inserted into a code vector when it is to be intercepted (see
 * `intercept_on' below).  It calls the C function `intercept', passing
 * its parameter and closure (see intercept.c).  When `intercept'
 * returns, the intercepted function is continued.
 * 
 * The above comments hold (mutatis mutandis) for 'replace'; in that
 * case the intercepted function is abandoned.
 *
 * These four routines all live on the implicit vector.
 *
 *  Parameters:
 *    $4, 17-23	parameters } of intercepted function
 *    $5/$6	closure    }
 *
 * Return address is in $31, or $3 for leaf versions.
 *
 */
	.globl	ml_replace
	.globl	ml_replace_leaf
	.globl	ml_intercept
	.globl	ml_intercept_leaf

ml_replace:
	push_all_ML_regs	/* this creates the frame passed to the intercept function */
	move	$4, $29		/* Pass frame to replace() */
	ML_to_C(replace)
	nop
	pop_all_ML_regs

/* Now we need to pop the function's own frame and return to the caller */

	lw 	$31, 8($29)
	lw	$6,  4($29)
	move	$29, $30
	lw	$30, 0($29)
	jr	$31
	nop

ml_intercept:
	push_all_ML_regs	/* this creates the frame passed to the intercept function */
	move	$4, $29		/* Pass frame to intercept() */
	ML_to_C(intercept)
	nop
	pop_all_ML_regs
	jr 	$31
	nop

ml_replace_leaf:
	sw	$30, 0($29)
	move	$30, $29
	subu	$29, 16
	sw	$4, 12($29)	/* The debugger expects the function arg here */
	sw	$31, 8($29)
	sw	$6, 4($29)
	move	$31, $3
	move	$6, $5
	push_all_ML_regs	/* this creates the frame passed to the intercept function */
	lw	$3, IMPLICIT_gc_limit($9)
	move	$4, $29
	ML_to_C(replace)
	nop
	pop_all_ML_regs
	move	$5, $6
	lw	$31, 8($29)
	lw	$6, 4($29)
	move	$29, $30
	lw	$30, 0($29)
	jr	$31
	nop

ml_intercept_leaf:
	sw	$30, 0($29)
	move	$30, $29
	subu	$29, 16
	sw	$4, 12($29)	/* The debugger expects the function arg here */
	sw	$31, 8($29)
	sw	$6, 4($29)
	move	$31, $3
	move	$6, $5
	push_all_ML_regs	/* this creates the frame passed to the intercept function */
	lw	$3, IMPLICIT_gc_limit($9)
	move	$4, $29
	ML_to_C(intercept)
	nop
	pop_all_ML_regs
	move	$5, $6
	move	$1, $31
	lw	$31, 8($29)
	lw	$6, 4($29)
	move	$29, $30
	lw	$30, 0($29)
	jr	$1
	nop

/* == Replacement code ==
 *
 * These are sections of code which are inserted at the start of a code
 * vector and altered to implement interception.  They are
 * INTERCEPT_LENGTH words long; four in the MIPS case.
 * 
 * There are four interception code segments; for intercepting and
 * replacing, for leaf and non-leaf functions. They call the relevant
 * bit of code above (_ml_intercept_on calls _ml_intercept, for
 * instance). _ml_nop is the sequence of three special nops which are
 * replaced by the intercepts; they are here so we can undo
 * interception.
 */
	.globl	ml_replace_on
	.globl	ml_replace_on_leaf
	.globl	ml_intercept_on
	.globl	ml_intercept_on_leaf
	.globl	ml_nop

ml_replace_on:
	lw	$1, IMPLICIT_replace($9)
	nop	
	jalr	$31, $1
	nop
ml_replace_on_leaf:
	lw	$1, IMPLICIT_replace_leaf($9)
	nop	
	jalr	$3, $1
	nop
ml_intercept_on:
	lw	$1, IMPLICIT_intercept($9)
	nop	
	jalr	$31, $1
	nop
ml_intercept_on_leaf:
	lw	$1, IMPLICIT_intercept_leaf($9)
	nop	
	jalr	$3, $1
	nop

/* <URI:mips/_mach_cg.sml#trace_dummy_instructions>
 * <URI:rts/gen/__tags.sml#MIPS_INTERCEPT_LENGTH>
 *
 * ml_nop should be the special no-op instruction "srl $0,$0,0",
 * repeated 4 times. However, there is no way of forcing the Irix 'as'
 * to assemble this instruction. So we hand-assemble it (it is
 * 0x00000002). There is also no way of forcing the Irix 'as' to
 * put constant words in the text segment. What a piece of shit. So we
 * put it in the data segment. */

	.data
ml_nop:
	.word	2
	.word	2
	.word	2
	.word	2
	.text

	.globl	generate_debugger_trap

generate_debugger_trap:
	break	0
	nop


	.globl switch_to_thread

switch_to_thread:
		save_thread_floats($4)
		save_thread_saves($4)
		sw	$31, THREAD_c_pc($4)	/* save pc */
		sw	$29, THREAD_c_tsp($4)	/* save fp */
		load_thread_floats($5)
		load_thread_saves($5)
		lw	$25, THREAD_c_pc($5)
		lw	$29, THREAD_c_tsp($5)
		jr	$25
		move	$2, $4			/* returns old thread to new */

/* Space profiling. ml_profile_alloc and ml_profile_alloc_leaf are
 * entered as if they were ml_gc and ml_gc_leaf respectively,
 * on every allocation in a profiled function, without a proper test
 * having been made for allocation overflow. We have a couple of slots
 * on the implicit vector for temporaries, if we need them. */

/*
 * Non-leaf case:
 *  Parameters:
 *    $1  Number of bytes required
 *    $2  Top of live data + $1
 *    $6  Current closure
 *  Returns:
 *    $1  Address of allocated space
 *    $2  New top of live data + $1
 *    $3  New heap limit
 *    Other registers preserved. */
	.globl	ml_profile_alloc
ml_profile_alloc:
	sw	$1, IMPLICIT_profile_alloc_2($9) /* save alloc amount */
	sub	$1, $2, $3			/* test for GC */
	bltz	$1, ml_profile_alloc_noGC	/* no GC */
	lw	$1, IMPLICIT_profile_alloc_2($9) /* restore alloc amount */
	sw	$30, 0($29)			/* save fp */
	move	$30, $29			/* new fp */
	subu	$29, 16 			/* create fake frame */
	sw	$6, 4($29)			/* allocator's closure */
	sw	$31, 8($29)			/* link to allocator */
	sw	$0, 12($29)			/* frame padding */
	la	$6, ml_gc			/* can't use a JAL here */
	nop
	jalr	$6				/* do the GC */
	ori	$6, $0, STACK_SPACE_PROFILE	/* fake frame closure */
	lw	$31, 8($29)			/* pop fake frame */
	lw	$6, 4($29)
	move	$29, $30
	lw	$30, 0($29)
	beq	$0, $0, ml_profile_alloc_record
	nop
ml_profile_alloc_noGC:	
	nop
	sub	$1, $2, $1			/* allocated point */
ml_profile_alloc_record:
	sw	$2, IMPLICIT_profile_alloc_2($9)	/* save alloc point */
	lw	$2, THREAD_ml_profile($9)	/* profile point */
	nop
	sw	$6, 0($2)		/* first word is the closure */
	sw	$1, 4($2)		/* second word is the alloc point */
	add	$2, 8			/* advance the profile point */
	sw	$2, THREAD_ml_profile($9) /* and save it */
	j	$31			/* return to caller */
	lw	$2, IMPLICIT_profile_alloc_2($9)	/* restore alloc pt */

/* Leaf case:
 *  Parameters:
 *    $1  Number of bytes required
 *    $2  Top of live data + $1
 *    $3  Link register back to ML code
 *  Returns:
 *    As non-leaf case.
 */
	.globl	ml_profile_alloc_leaf
ml_profile_alloc_leaf:
	sw	$3, IMPLICIT_profile_alloc_3($9) /* save link to allocator */
	lw	$3, IMPLICIT_gc_limit($9)	/* restore alloc limit */
	sw	$1, IMPLICIT_profile_alloc_2($9) /* save alloc amount */
	sub	$1, $2, $3			/* test for GC */
	bltz	$1, ml_profile_alloc_leaf_noGC	/* no GC */
	lw	$1, IMPLICIT_profile_alloc_2($9) /* restore alloc amount */

	sw	$30, 0($29)			/* save fp */
	move	$30, $29			/* new fp */
	subu	$29, 16 			/* create fake frame 1 */
	sw	$6, 4($29)			/* alloc's caller's closure */
	sw	$31, 8($29)			/* link to alloc's caller */
	sw	$0, 12($29)			/* frame padding */
	move	$6, $5
	lw	$31, IMPLICIT_profile_alloc_3($9) /* link to allocator */
	sw	$30, 0($29)			/* save fp */
	move	$30, $29			/* new fp */
	subu	$29, 16				/* create fake frame 2 */
	sw	$6, 4($29)			/* allocator's closure */
	sw	$31, 8($29)			/* link to allocator */
	sw	$0, 12($29)			/* frame padding */
	la	$6, ml_gc			/* can't use a JAL here */
	nop
	jalr	$6				/* do the GC */
	ori	$6, $0, STACK_SPACE_PROFILE	/* fake frame closure */
	lw	$31, 8($29)			/* pop fake frame 2 */
	lw	$6, 4($29)
	move	$29, $30			
	lw	$30, 0($29)			
	sw	$31, IMPLICIT_profile_alloc_3($9)	/* link to alloc */
	move	$5, $6				/* restore allocator */
	lw	$31, 8($29)			/* pop fake frame 1 */
	lw	$6, 4($29)
	move	$29, $30
	lw	$30, 0($29)
	beq	$0, $0, ml_profile_alloc_leaf_record
	nop
ml_profile_alloc_leaf_noGC:	
	nop
	sub	$1, $2, $1			/* allocated point */
ml_profile_alloc_leaf_record:
	sw	$2, IMPLICIT_profile_alloc_2($9)	/* save alloc point */
	lw	$2, THREAD_ml_profile($9)	/* profile point */
	nop
	sw	$5, 0($2)		/* first word is the closure */
	sw	$1, 4($2)		/* second word is the alloc point */
	add	$2, 8			/* advance the profile point */
	sw	$2, THREAD_ml_profile($9) /* and save it */
	lw	$2, IMPLICIT_profile_alloc_3($9)	/* link to allocator */
	nop	
	j	$2			/* return to caller */
	lw	$2, IMPLICIT_profile_alloc_2($9)	/* restore alloc pt */
	
#ifdef COLLECT_STATS
	.globl raise_count
	.globl stack_extension_count
	.sdata
	.align 2
raise_count:
	.word 0
stack_extension_count:
	.word 0
#endif
