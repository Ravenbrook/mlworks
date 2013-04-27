/*
 * ==== ML TO C INTERFACE MACROS ====
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
 * These macros are used by other MIPS assembly language routines in
 * the ML to C interface.  They deal with various conventions between
 * the C runtime system and ML.
 *
 * Notes
 * -----
 *
 * Take great care modifying this file. As well as getting the
 * semantics right for MIPS (remember those delay slots!), you have to
 * maintain hidden invariants or you will break the profiler. See the
 * profiler comment in the body of the file.
 *
 * Revision Log
 * ------------
 * $Log: macros.h,v $
 * Revision 1.23  1997/05/06 10:41:39  stephenb
 * [Bug #30031]
 * {push,pop}_[all]_ML_regs: now save/restore $gp.  See .preserve-gp
 * for more information.
 *
 * Revision 1.22  1996/04/25  17:33:15  jont
 * Remove copy_up and copy_down, no longer required
 *
 * Revision 1.21  1995/09/07  11:40:54  nickb
 * Change to c_sp protocol.
 *
 * Revision 1.20  1995/05/05  10:51:51  nickb
 * Add a cautionary comment.
 *
 * Revision 1.19  1995/05/04  10:49:40  nickb
 * Change the manipulation of the in_ML flag so that:
 * (a) in_ML false => thread->ml_state.sp is meaningful
 * (b) in_ML true => sp,fp,closures make some sense for ML.
 *
 * Revision 1.18  1995/04/06  16:07:23  nickb
 * Non-gcable value getting into $5.
 *
 * Revision 1.17  1995/03/30  11:09:46  nickb
 * Threads system.
 *
 * Revision 1.16  1995/03/20  14:32:19  matthew
 * Fixing syntax error
 *
 * Revision 1.15  1995/03/20  12:57:40  matthew
 * Debugger stuff
 *
 * Revision 1.14  1994/12/19  11:42:33  nickb
 * c_raise getting the wrong closure.
 *
 * Revision 1.13  1994/12/13  10:46:21  nickb
 * Rewrote most of these macros.
 *
 * Revision 1.12  1994/11/08  16:26:03  matthew
 * Added macros to save and restore fp registers
 *
 * Revision 1.11  1994/10/25  13:06:19  nickb
 * Add clean_caller_saves macro.
 *
 * Revision 1.10  1994/10/20  11:28:36  nickb
 * Make 'save_all_ML_regs' stack frame double-word aligned.
 *
 * Revision 1.9  1994/08/03  13:42:02  jont
 * Add closure to ml_state
 *
 * Revision 1.8  1994/08/02  13:58:21  jont
 * Ensure stub_c etc preserve $5
 *
 * Revision 1.7  1994/07/29  14:09:01  jont
 * Fix tagged value test in unwind stack
 *
 * Revision 1.6  1994/07/25  15:38:03  jont
 * Move architecture dependent stuff from values.h into mach_values.h
 *
 * Revision 1.5  1994/07/22  16:38:01  jont
 * Remove handler and implicit from register saved when entering stubs
 *
 * Revision 1.4  1994/07/22  09:00:28  jont
 * Add unwind_stack
 *
 * Revision 1.3  1994/07/18  15:58:17  jont
 * Get clean_current_registers round the right way
 *
 * Revision 1.2  1994/07/14  11:12:13  jont
 * Modifications for store_C_globals etc
 *
 * Revision 1.1  1994/07/12  12:03:25  jont
 * new file
 * */

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

#include "offsets.h"
#include "mach_values.h"
#include "asm_offsets.h"

/* ML boolean values; these must agree with those defined in values.h */

#define TRUE	4
#define FALSE	0

/* Clean the registers */

/* Clean caller-save registers (should be done when moving from C to ML) */
#define clean_caller_saves		\
	move	$16,	$0	;	\
	move	$17,	$0	;	\
	move	$18,	$0	;	\
	move	$19,	$0	;	\
	move	$20,	$0	;	\
	move	$21,	$0	;	\
	move	$22,	$0	;	\
	move	$23,	$0

/* Clean callee-save registers */
#define clean_callee_saves		\
	move	$10,	$0	;	\
	move	$11,	$0	;	\
	move	$12,	$0	;	\
	move	$13,	$0	;	\
	move	$14,	$0	;	\
	move	$15,	$0	;	\
	move	$24,	$0	;	\
	move	$25,	$0

#define clean_current_registers		\
	clean_caller_saves	;	\
	clean_callee_saves

/*
 *.preserve-gp: It is possible that a called C function alters the value
 * of $gp.  This can play havoc with the few implicit uses of $gp in MLWorks
 * code -- for example, see uses of la in 
 * <URI:hope://MLWsrc/rts/src/arch/MIPS/Irix/poly_equal.S#ml_eq_not_eq
 * <URI:hope://MLWsrc/rts/src/arch/MIPS/Irix/poly_equal.S#ml_eq_pointer).
 * This change of $gp has only been observed in dynamically loaded C code, 
 * and so a special case could be made for just saving $gp then.  However,
 * given that there are so many registers being saved already when calling
 * C, one more won't make much of a difference.
 */



/* push_ML_regs and pop_ML_regs:
 *
 * push_ML_regs creates a new ML stack frame to save all the ML callee
 * save registers prior to calling C.
 *
 * pop_ML_regs pops the stack frame and restores all the registers. It
 * also clears $5, as that can contain a bad value at this point.
 */

#define	push_ML_regs			;			\
	sw	$30, 0($29)		;/* Save current fp */	\
	move	$30, $29		;/* New fp */		\
	subu	$29, 48			;/* Create frame */	\
	sw	$6, 4($29)		;/* save caller's closure */\
	sw	$31, 8($29)		;/* save link reg */	\
	move	$6, $5			;/* As per normal function entry */ \
	sw	$30, 0($29)		;/* Fill fp slot */	\
	sw	$10, 12($29)		;/* save ML callee-saves */\
	sw	$11, 16($29)		;			\
	sw	$12, 20($29)		;			\
	sw	$13, 24($29)		;			\
	sw	$14, 28($29)		;			\
	sw	$15, 32($29)		;			\
	sw	$24, 36($29)		;			\
	sw	$25, 40($29)		;			\
	sw	$28, 44($29)		; /* .preserve-gp */


#define	pop_ML_regs						\
	move	$5, $0			; /* clear $5 */	\
	lw	$31, 8($29)		; /* restore link reg */\
	lw	$10, 12($29)		; /* restore callee-saves */\
	lw	$11, 16($29)		;			\
	lw	$12, 20($29)		;			\
	lw	$13, 24($29)		;			\
	lw	$14, 28($29)		;			\
	lw	$15, 32($29)		;			\
	lw	$24, 36($29)		;			\
	lw	$25, 40($29)		;			\
	lw	$28, 44($29)		; /* .preserve-gp */	\
	lw	$6, 4($29)		; /* restore closure */	\
	move	$29,$30			;/* pop frame */	\
	lw	$30, 0($29)		;/* restore fp */

/*
 * push_all_ML_regs and pop_all_ML_regs
 *
 * push_all_ML_regs is used when entering C when ML has not had
 * opportunity to save any values (e.g. at GC entry), so all the
 * general-purpose registers, including the caller-saves, must be
 * saved on the ML stack so the GC can fix them up.
 *
 * pop_all_ML_regs restores all the registers from that stack frame
 *
 */

#define	push_all_ML_regs			;		\
	sw	$30, 0($29)		;/* Save current fp */	\
	move	$30, $29		;/* New fp */		\
	subu	$29, 88			;/* Create aligned frame */\
	sw	$6,   4($29)		;/* save caller's closure */\
	sw	$31,  8($29)		;/* save link register */\
	sw	$30,  0($29)		;/* Save new fp */	\
	sw	$10, 12($29)		;/* save callee-saves */\
	sw	$11, 16($29)		;			\
	sw	$12, 20($29)		;			\
	sw	$13, 24($29)		;			\
	sw	$14, 28($29)		;			\
	sw	$15, 32($29)		;			\
	sw	$24, 36($29)		;			\
	sw	$25, 40($29)		;			\
	sw	$16, 44($29)		;/* save caller-saves */\
	sw	$17, 48($29)		;			\
	sw	$18, 52($29)		;			\
	sw	$19, 56($29)		;			\
	sw	$20, 60($29)		;			\
	sw	$21, 64($29)		;			\
	sw	$22, 68($29)		;			\
	sw	$23, 72($29)		;			\
	sw	$4,  76($29)		;/* save arg */		\
	sw	$5,  80($29)		;/* save callee's closure */\
	sw	$28, 84($29)		;/* .preserve-gp */

#define	pop_all_ML_regs			;			\
	lw	$6,   4($29)		;/* load caller's closure */\
	lw	$31,  8($29)		;/* load link register */\
	lw	$10, 12($29)		;/* load callee-saves */\
	lw	$11, 16($29)		;			\
	lw	$12, 20($29)		;			\
	lw	$13, 24($29)		;			\
	lw	$14, 28($29)		;			\
	lw	$15, 32($29)		;			\
	lw	$24, 36($29)		;			\
	lw	$25, 40($29)		;			\
	lw	$16, 44($29)		;/* load caller-saves */\
	lw	$17, 48($29)		;			\
	lw	$18, 52($29)		;			\
	lw	$19, 56($29)		;			\
	lw	$20, 60($29)		;			\
	lw	$21, 64($29)		;			\
	lw	$22, 68($29)		;			\
	lw	$23, 72($29)		;			\
	lw	$28, 84($29)		;/* .preserve-gp */	\
	lw	$4,  76($29)		;/* load arg */		\
	lw	$5,  80($29)		;/* load callee's closure */\
	move	$29, $30		; /* pop frame */	\
	lw	$30, 0($29)		;/* Can't delay this */ \
	nop

/* save C callee-saves; push a stack frame and save $16-$23, $30 in
   it. Note that we leave 4 slots so when ML calls back into C the arg
   slots are pre-allocated. */

#define push_C_regs						\
	addu	$29, -14*4	;				\
	sw	$16, 16($29)	;	/* gp callee saves */	\
	sw	$17, 20($29)	;				\
	sw	$18, 24($29)	;				\
	sw	$19, 28($29)	;				\
	sw	$20, 32($29)	;				\
	sw	$21, 36($29)	;				\
	sw	$22, 40($29)	;				\
	sw	$23, 44($29)	;				\
	sw	$30, 48($29)

/* load C callee-saves; this reloads the registers saved by
   push_C_regs above and pops that stack frame. */

#define pop_C_regs						\
	lw	$16, 16($29)	;       /* gp callee saves */	\
	lw	$17, 20($29)	;       			\
	lw	$18, 24($29)	;       			\
	lw	$19, 28($29)	;       			\
	lw	$20, 32($29)	;       			\
	lw	$21, 36($29)	;       			\
	lw	$22, 40($29)	;       			\
	lw	$23, 44($29)	;       			\
	lw	$30, 48($29)	;       			\
	addu	$29, 14*4

/* save caller-save floating point registers */

#define push_fps						\
        addu 	$29,-80		        ;/* Make some room */   \
        swc1	$f0, 0($29)		;			\
        swc1	$f1, 4($29)		;			\
        swc1	$f2, 8($29)		;			\
        swc1	$f3, 12($29)		;			\
        swc1	$f4, 16($29)		;			\
        swc1	$f5, 20($29)		;			\
        swc1	$f6, 24($29)		;			\
        swc1	$f7, 28($29)		;			\
        swc1	$f8, 32($29)		;			\
        swc1	$f9, 36($29)		;			\
        swc1	$f10, 40($29)		;			\
        swc1	$f11, 44($29)		;			\
        swc1	$f12, 48($29)		;			\
        swc1	$f13, 52($29)		;			\
        swc1	$f14, 56($29)		;			\
        swc1	$f15, 60($29)		;			\
        swc1	$f16, 64($29)		;			\
        swc1	$f17, 68($29)		;			\
        swc1	$f18, 72($29)		;			\
        swc1	$f19, 76($29)		;			\

/* reload them */

#define pop_fps				       			\
        lwc1	$f0, 0($29)		;			\
        lwc1	$f1, 4($29)		;			\
        lwc1	$f2, 8($29)		;			\
        lwc1	$f3, 12($29)		;			\
        lwc1	$f4, 16($29)		;			\
        lwc1	$f5, 20($29)		;			\
        lwc1	$f6, 24($29)		;			\
        lwc1	$f7, 28($29)		;			\
        lwc1	$f8, 32($29)		;			\
        lwc1	$f9, 36($29)		;			\
        lwc1	$f10, 40($29)		;			\
        lwc1	$f11, 44($29)		;			\
        lwc1	$f12, 48($29)		;			\
        lwc1	$f13, 52($29)		;			\
        lwc1	$f14, 56($29)		;			\
        lwc1	$f15, 60($29)		;			\
        lwc1	$f16, 64($29)		;			\
        lwc1	$f17, 68($29)		;			\
        lwc1	$f18, 72($29)		;			\
        lwc1	$f19, 76($29)		;			\
	addu	$29,80

/* Thread state loading and saving code */

#define load_thread_floats(use)					\
	lwc1	$f20, THREAD_c_float_saves(use);		\
	lwc1	$f21, THREAD_c_float_saves+4(use);		\
	lwc1	$f22, THREAD_c_float_saves+8(use);		\
	lwc1	$f23, THREAD_c_float_saves+12(use);		\
	lwc1	$f24, THREAD_c_float_saves+16(use);		\
	lwc1	$f25, THREAD_c_float_saves+20(use);		\
	lwc1	$f26, THREAD_c_float_saves+24(use);		\
	lwc1	$f27, THREAD_c_float_saves+28(use);		\
	lwc1	$f28, THREAD_c_float_saves+32(use);		\
	lwc1	$f29, THREAD_c_float_saves+36(use);		\
	lwc1	$f30, THREAD_c_float_saves+40(use);		\
	lwc1	$f31, THREAD_c_float_saves+44(use)

#define save_thread_floats(use)					\
	swc1	$f20, THREAD_c_float_saves(use);		\
	swc1	$f21, THREAD_c_float_saves+4(use);		\
	swc1	$f22, THREAD_c_float_saves+8(use);		\
	swc1	$f23, THREAD_c_float_saves+12(use);		\
	swc1	$f24, THREAD_c_float_saves+16(use);		\
	swc1	$f25, THREAD_c_float_saves+20(use);		\
	swc1	$f26, THREAD_c_float_saves+24(use);		\
	swc1	$f27, THREAD_c_float_saves+28(use);		\
	swc1	$f28, THREAD_c_float_saves+32(use);		\
	swc1	$f29, THREAD_c_float_saves+36(use);		\
	swc1	$f30, THREAD_c_float_saves+40(use);		\
	swc1	$f31, THREAD_c_float_saves+44(use)

#define load_thread_saves(use)					\
		lw	$16, THREAD_c_callee_saves(use);	\
		lw	$17, THREAD_c_callee_saves+4(use);	\
		lw	$18, THREAD_c_callee_saves+8(use);	\
		lw	$19, THREAD_c_callee_saves+12(use);	\
		lw	$20, THREAD_c_callee_saves+16(use);	\
		lw	$21, THREAD_c_callee_saves+20(use);	\
		lw	$22, THREAD_c_callee_saves+24(use);	\
		lw	$23, THREAD_c_callee_saves+28(use);	\
		lw	$30, THREAD_c_callee_saves+32(use)

#define save_thread_saves(use)					\
		sw	$16, THREAD_c_callee_saves(use);	\
		sw	$17, THREAD_c_callee_saves+4(use);	\
		sw	$18, THREAD_c_callee_saves+8(use);	\
		sw	$19, THREAD_c_callee_saves+12(use);	\
		sw	$20, THREAD_c_callee_saves+16(use);	\
		sw	$21, THREAD_c_callee_saves+20(use);	\
		sw	$22, THREAD_c_callee_saves+24(use);	\
		sw	$23, THREAD_c_callee_saves+28(use);	\
		sw	$30, THREAD_c_callee_saves+32(use)

/* These next macros load and store the ML state. */

/* Saves 'global', 'gc1', and 'handler' in a thread state given by $9
 * Does _not_ save gc2 (which is just a copy of the value in the
 * thread state) or the stack limit. */

#define store_ML_state						\
	sw	$1, THREAD_ml_global($9);			\
	sw	$2, IMPLICIT_gc_base($9);			\
	sw	$8, IMPLICIT_handler($9);			

/* Loads the global registers from a thread state given by $9. The
   stack register is loaded and then ORed with the interrupt stack
   slot, which is left in $16. This is so when we return to ML the
   stack register is -1 if there has been an asynchronous event */

#define load_ML_state						\
	lw	$1, THREAD_ml_global($9);			\
	lw	$2, IMPLICIT_gc_base($9);			\
	lw	$7, IMPLICIT_stack_limit($9);			\
	lw	$8, IMPLICIT_handler($9);			\
	lw	$16, IMPLICIT_interrupt($9);			\
	lw	$3, IMPLICIT_gc_limit($9);			\
	or	$7, $7, $16

/* Call C from ML : Saves the ML state and restore the C state, then
 * calls the function, passing registers $4 to $6 as arguments for C.
 * The C return value is returned in $4. */

#define ML_to_C(what)							\
	store_ML_state		 	;			 	\
	sw	$29, THREAD_ml_sp($9)	;/* Save ML sp   	     */	\
	sw	$30, 0($29)		;/* Save fp in this frame */    \
	lw	$16, THREAD_global($9)	;/* get the global state */	\
	lw	$29, THREAD_c_sp($9)	; /* Fetch the previous C sp */	\
	jal	what			; /* Call function	     */	\
	sw	$0, GLOBAL_in_ML($16)	; /* Not in ML */		\
									\
	lw	$9, GLOBAL_current_thread($16); /* current thread */	\
	move	$4, $2			; /* Get returned value */	\
	lw	$29, THREAD_ml_sp($9)  ; /* re-load the ML sp */	\
	move	$5, $0			; /* clear clos5 for profiling */\
	move	$6, $0			; /* clear clos6 for profiling */\
	sw	$16, GLOBAL_in_ML($16)	; /* back in ML; $16 != 0 */	\
	load_ML_state			;

/* finds the number of saves for the frame pushed by a given closure */

#define number_of_saves(closure,use)					\
	lw	use, -1(closure)	; /* Get code vector */		\
	nop				;				\
	lw	use, -1(use)		; /* Get ancillary */		\
	nop				;				\
	srl	use, use, CCODE_SAVES_SHIFT;				\
	andi	use, use, CCODE_MAX_SAVES	; /* Number of callee saves */

/* computes the number of words for saves+linkage of a frame produced
 * by a given closure */

#define compute_frame_size(closure,answer)				\
	number_of_saves(closure,answer)	;				\
	addiu	answer, answer, 3	; /* Plus three for the linkage */

/* Unwind stack to a particular point
 *
 * The ML stack is unwound by repeatedly popping until the fp equals $18.
 * On entry, $6 is the closure for the current frame
 * The argument is a label prefix.
 */

#define unwind_stack(label)						\
label ## _unwind:			;				\
	beqz	$0, label ## _unw_while	;				\
	ori	$17, $0, STACK_C_CALL	;				\
label ## _unw_loop:			;				\
      	andi	$5, $6, 3		;/* is the closure tagged? */	\
	subu	$5, 1			;				\
	bnez	$5, label ## _unw_loaded;/*if so, restore callee-saves */\
	nop				;				\
	number_of_saves($6,$5)		;/* how many are there? */	\
	addiu	$1, $5, -9		;/* maximum for this code */	\
	bgez	$1, label ## _unw_error	;/* are there too many? */	\
	nop				;				\
	.set at				;     /* just for this instr: */\
	la	$16, label ## _unw_loaded ;/* base for computed goto */	\
	.set noat			;     				\
	sll	$5, $5, 2		;/* this block of register */	\
	sub	$16, $16, $5		;/* restores according to */	\
	jr	$16			;/* the number of callee-saves*/\
	nop				;				\
	lw	$25, 40($29)		;/* restore 8th callee-save */  \
	lw	$24, 36($29)		;/* restore 7th callee-save */  \
	lw	$15, 32($29)		;/* restore 6th callee-save */  \
	lw	$14, 28($29)		;/* restore 5th callee-save */  \
	lw	$13, 24($29)		;/* restore 4th callee-save */  \
	lw	$12, 20($29)		;/* restore 3th callee-save */  \
	lw	$11, 16($29)		;/* restore 2nd callee-save */  \
	lw	$10, 12($29)		;/* restore 1st callee-save */  \
label ## _unw_loaded:			;				\
	lw	$6, 4($29)		;/* Get caller's closure back */\
	nop				;/* delay slot */		\
	bne	$17, $6, label ## _unw_skip ;	/* if a c_sp frame */	\
        nop				;				\
	lw	$5, 12($29)		; /* then restore c_sp from it*/\
	lw	$10, 12($30)		; /* and restore callee-saves */\
	lw	$11, 16($30)		; /* from previous frame */     \
	lw	$12, 20($30)		;				\
	lw	$13, 24($30)		;				\
	lw	$14, 28($30)		;				\
	lw	$15, 32($30)		;				\
	lw	$24, 36($30)		;				\
	lw	$25, 40($30)		;				\
	sw	$5, THREAD_c_sp($9)	;				\
label ## _unw_skip:			;				\
	move	$29, $30		;/* Point to previous frame */	\
        lw	$30,0($29)		;/* Restore fp as well */	\
	nop				;				\
label ## _unw_while:			;/* while $18 != $fp */		\
	bne	$30, $18, label ## _unw_loop ;				\
	nop				;				\
label ## _unw_callC:			;				\
									\
/* We now have the correct callee-saves to return to ML. Also the	\
 * closure register, our sp and fp are all correct. We have just to	\
call unwind_stack and return to ML. Of course, in order to call		\
unwind_stack we have to save the ML callee-saves.... */			\
									\
	move	$17, $4			;/* preserve handler result */	\
	move	$4, $29			;/* move sp into argument */	\
	push_ML_regs			;				\
	ML_to_C(unwind_stack)		;				\
	move	$4, $17			;/* restore handler result */	\
	pop_ML_regs			;/* restore callee-saves */	\
	clean_caller_saves		;				\
	b	label ## _unw_done	;/* Finished! */		\
	nop				;				\
label ## _unw_error:			;				\
	break 0				;/* cause breakpoint trap */	\
	nop				;				\
label ## _unw_done:

