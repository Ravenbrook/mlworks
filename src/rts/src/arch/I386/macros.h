/*
 * ==== ML TO C INTERFACE MACROS ====
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
 * These macros are used by other I386 assembly language routines in
 * the ML to C interface.  They deal with various conventions between
 * the C runtime system and ML.
 *
 * Notes
 * -----
 *
 * Revision Log
 * ------------
 * $Log: macros.h,v $
 * Revision 1.17  1995/11/24 11:33:43  nickb
 * Add in_ML hacking.
 *
 * Revision 1.16  1995/11/16  13:36:38  nickb
 * Fix in_ML setting and unsetting to allow profiling.
 *
 * Revision 1.15  1995/09/07  11:56:23  nickb
 * Restore callee-saves when unwinding past c_sp.
 *
 * Revision 1.14  1995/09/06  14:48:11  nickb
 * Change to c_sp protocol.
 *
 * Revision 1.13  1995/08/29  13:55:44  nickb
 * Fix stack extension and various other things.
 *
 * Revision 1.12  1995/06/02  15:54:46  jont
 * Add stack extension code
 *
 * Revision 1.11  1995/06/01  16:33:02  jont
 * Remove call to unwind_stack at present
 *
 * Revision 1.10  1995/04/25  12:27:03  nickb
 * A space after a backslash causing code to be dropped.
 *
 * Revision 1.9  1995/03/15  17:28:10  nickb
 * Add threads system.
 *
 * Revision 1.8  1994/12/09  14:53:23  jont
 * Fix incorrect register usage in ML_to_C
 *
 * Revision 1.7  1994/11/18  15:32:34  jont
 * Modify to new register assignment
 *
 * Revision 1.6  1994/10/28  00:38:19  jont
 * Improvements to state saving and loading macros
 *
 * Revision 1.5  1994/10/20  12:33:52  jont
 * Add macros for raise handling
 *
 * Revision 1.4  1994/10/14  15:37:40  jont
 * Add save_all_regs and load_all_regs macros
 *
 * Revision 1.3  1994/10/05  16:35:26  jont
 * Also save_regs and load_regs
 *
 * Revision 1.2  1994/10/05  13:30:14  jont
 * Get copying to/from implicit vector corrected
 *
 * Revision 1.1  1994/10/04  16:53:30  jont
 * new file
 *
 */

#include "offsets.h"
#include "asm_offsets.h"
#include "naming.h"

/* ML boolean values; these must agree with those defined in values.h */

#define TRUE	4
#define FALSE	0

/* Clean caller-save registers (should be done when moving from C to ML) */
#define clean_caller_saves		\
	xor	%ebp, %ebp	;	\
	xor	%ecx, %ecx

/* Register definitions */

#define	thread		%esi
#define	fnarg		%ebx

/*
 * save_all_ML_regs
 * create a new ml stack frame to save all the ml gc (including caller saves)
 * registers prior to calling C.
 * Preserve ecx, this contains the gc size argument
 */

#define	save_all_ML_regs					\
	push	fnarg			;			\
	push	%ebp			; /* Caller saves */	\
	push	%edx			;			\
	push	%eax			; /* Callee saves */	\
	push	%edi			; /* Closure */		\
	lea	24(%esp), %ebp		;			\
	push	%ebp			; /* fp */

/*
 * save_ML_regs
 * create a new ml stack frame to save all the ml callee save
 * registers prior to calling C
 */

#define	save_ML_regs						\
	push	%ebp			;/* gc register */	\
	push	%edx			;/* Save callee saves */\
	push	%eax			;			\
	push	%edi			;/* Save callee_clos */	\
	lea	20(%esp), %ecx		;/* Calculate fp */	\
	push	%ecx			;/* And push it */	\
	mov	%ebp, %edi		;/* Copy in closure */

/*
 * load_all_ML_regs
 * discard ml stack frame created for gc entry
 * prior to calling C
 * Preserve ecx, this contains the gc result
 */

#define	load_all_ML_regs					\
	add	$4, %esp		;			\
	pop	%edi			; /* Closure */		\
	pop	%eax			; /* Callee saves */	\
	pop	%edx			;			\
	pop	%ebp			; /* Caller saves */	\
	pop	fnarg			;

/*
 * load_ML_regs
 * restore all the ml callee save
 * registers after calling C
 */

#define	load_ML_regs						\
	add	$4, %esp		;/* Throw away fp */	\
	pop	%edi			;			\
	pop	%eax			;			\
	pop	%edx			;			\
	pop	%ebp			;

/*
 * save_C_regs
 * save the C callee saves
 * ie %esi, %edi, %ebx, %ebp
 */
#define	save_C_regs						\
	push	%ebx			;			\
	push	%ebp			;			\
	push	%esi			;			\
	push	%edi

/*
 * load_C_regs
 * restore the C callee saves
 * ie %esi, %edi, %ebx, %ebp
 */
#define	load_C_regs						\
	pop	%edi			;			\
	pop	%esi			;			\
	pop	%ebp			;			\
	pop	%ebx

#define load_thread_registers(use)				\
	mov	THREAD_c_ebp(use), %ebp	;			\
	mov	THREAD_c_esi(use), %esi ;			\
	mov	THREAD_c_edi(use), %edi ;			\
	mov	THREAD_c_ebx(use), %ebx

#define save_thread_registers(use)				\
	mov	%ebp, THREAD_c_ebp(use) ;			\
	mov	%esi, THREAD_c_esi(use) ;			\
	mov	%edi, THREAD_c_edi(use) ;			\
	mov	%ebx, THREAD_c_ebx(use)

/* Combines the implicit stack_limit slot with the implicit interrupt
 * slot, so that while in ML the stack limit slot reflects any
 * interrupts done while last in C. Careful to avoid a race
 * condition. Uses the only argument as a scratch. */

#define load_ML_state(use)					\
	mov	IMPLICIT_stack_limit(thread), use	; 	\
	mov	use, IMPLICIT_register_stack_limit(thread) ;	\
	mov	IMPLICIT_interrupt(thread), use		;	\
        or      use, IMPLICIT_register_stack_limit(thread)

/* Call C from ML : 
 * Calls the given function on the args in fnarg, %eax, %edx as
 * arguments for C.
 * The C return value is returned in fnarg. */

#define ML_to_C(what)							\
	mov	%esp, THREAD_ml_sp(thread) ; /* Save ML sp     */	\
	movl	$0, C_NAME(global_state)+GLOBAL_in_ML ;	/* ml_sp now valid */ \
	mov	THREAD_c_sp(thread), %esp ; /* Fetch the previous C sp */ \
	push	thread			; /* Save thread so we can use it */ \
	mov	THREAD_global(thread), thread ; /* global state in thread */ \
	push	%edx			; /* Push args */		\
	push	%eax			; /* Push args */		\
	push	fnarg			; /* Push args */		\
	call	C_NAME(what)		; /* Call function	     */	\
	add	$12, %esp		; /* Pop arguments off stack */	\
	pop	thread			; /* Restore thread register */ \
	mov	%eax, fnarg		; /* Get returned value */	\
	load_ML_state(%ecx) ;						\
	mov	THREAD_ml_sp(thread), %esp ; /* Back on ml stack */	\
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* ml_sp invalid */

/* finds the number of saves for the frame pushed by a given closure;
 * the flags are set accordingly. */

#define number_of_saves(closure,use)					\
	mov	-1(closure),use		;	/* get code vector */	\
	mov	-1(use), use		;	/* get ancillary word */\
	shr	$CCODE_SAVES_SHIFT, use;				\
	and	$CCODE_MAX_SAVES, use

/* Unwind stack to a particular point
 * 
 * The ML stack is unwound by repeatedly popping until the sp equals
 * ecx.  The arg is a label prefix.*/

#define unwind_stack(label)					\
label ## _unwind:							\
	cmp	0(%esp), %ecx	; /*in the right frame already?*/ 	\
	jmp	label ## _start	;					\
label ## _c:								\
	test	$3, %edi	; /* Is the closure tagged */		\
	je	label ## _done	; /* Branch if not */			\
	number_of_saves(%edi, %ebp) ;					\
	je	label ## _done	;					\
	mov	8(%esp), %eax	;					\
	sub	$1, %ebp	;					\
	je	label ## _done	;					\
	mov	12(%esp), %edx	;					\
label ## _done:								\
	mov	4(%esp), %edi	; /* Get caller's closure back */	\
	cmp	$STACK_C_CALL, %edi ;					\
	jne	label ## _over	;					\
	mov	8(%esp), %ebp	; /* restore c_sp */			\
	mov	%ebp, THREAD_c_sp(thread) ;				\
	mov	0(%esp), %eax	; /* restore callee-saves */		\
	mov	12(%eax), %edx	;					\
	mov	8(%eax), %eax	;					\
label ## _over:								\
	mov	0(%esp), %esp	; /* And pop off stack */ 		\
	cmp	0(%esp), %ecx	; /* In the right frame yet? */		\
label ## _start:							\
	jne	label ## _c	;					\
									\
/* Now we have finished unwinding the stack and have the right callee	\
 * saves, and esp and edi are both correct. We have to call the C	\
 * function unwind_stack() and then return to ML. */			\
									\
label ## _callC:       							\
	push	fnarg		; /* preserve handler result */		\
	mov	%esp, fnarg	; /* argument is the SP */		\
	save_ML_regs		; /* Preserve ML callee saves */	\
	ML_to_C(unwind_stack)	; /* unwind */				\
	load_ML_regs		; /* Restore ML callee saves */		\
	clean_caller_saves	; /* Get rid of any crap C values */	\
	pop	fnarg		; /* restore handler result */		\
label ## exit:

