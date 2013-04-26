/*
 * ==== ML TO C INTERFACING CODE ====
 *		I386
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
 * This code does the job of managing the interface between ML and C -
 * calls, exception raising, interception, garbage collection entry,
 * &c.
 *
 * Notes
 * -----
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
 * Revision 1.41  1998/10/30 17:08:27  jont
 * [Bug #70226]
 * Fix alignment of raise_count and stack_extensions
 *
 * Revision 1.40  1998/10/20  10:37:15  jont
 * [Bug #70201]
 * Add interface to retract_root
 *
 * Revision 1.39  1998/09/15  10:25:22  jont
 * [Bug #20133]
 * Add an extra gc_limit slot so we can modify the other one when space profiling
 *
 * Revision 1.38  1998/07/31  11:05:23  jont
 * [Bug #70146]
 * Make sure that ml_profile_alloc is all excuted not in ML
 * This requires making a macro of the guts of ml_gc, and
 * placing that in both ml_gc and ml_profile_alloc
 *
 * Revision 1.37  1998/06/09  09:36:28  jont
 * [Bug #70129]
 * Make sure code is not in data section
 *
 * Revision 1.36  1998/04/22  10:47:18  jont
 * [Bug #30395]
 * Pop fp stack after testing for negative zeroes
 *
 * Revision 1.35  1998/02/05  13:11:47  jont
 * [Bug #70039]
 * Add code to check for negative real zero, to patch up broken
 * Win32 sprintf
 *
 * Revision 1.34  1998/01/26  10:38:29  jont
 * [Bug #70025]
 * Fix critical in_ML regions which were breaking profiler
 *
 * Revision 1.33  1997/06/04  10:39:32  jont
 * [Bug #30076]
 * Modifications to disturbance code to allow stack passing of procedure arguments
 *
 * Revision 1.32  1997/04/11  12:56:28  jont
 * [Bug #1412]
 * [Bug #1412]
 * Add piece of assembler to read fpu control word
 * for benefit of setting/getting rounding mode
 *
 * Revision 1.31  1996/11/15  13:05:42  nickb
 * Fix ml_disturbance "fake stack frame" behaviour.
 *
 * Revision 1.30  1995/12/13  11:27:30  nickb
 * OK, now let's make space profiling work.
 *
 * Revision 1.29  1995/12/12  17:45:14  nickb
 * Whoops; error in space profiling.
 *
 * Revision 1.28  1995/12/12  17:23:16  nickb
 * Add space profiling hooks.
 *
 * Revision 1.27  1995/11/23  15:36:58  nickb
 * Additional in_ML hacking.
 *
 * Revision 1.26  1995/11/16  13:34:27  nickb
 * Fix in_ML setting and unsetting to allow profiling.
 *
 * Revision 1.25  1995/11/15  15:03:02  nickb
 * Clear interrupt flags when entering ev_poll.
 *
 * Revision 1.24  1995/11/13  15:34:13  nickb
 * Move CURRENT_THREAD manipulation out of asm into portable C.
 * Also add native threads support for Win95.
 *
 * Revision 1.23  1995/10/17  14:56:51  jont
 * Temporarily remove stack switching to aid development on Win95
 *
 * Revision 1.22  1995/09/07  11:54:25  nickb
 * Restore callee-saves when unwinding past c_sp.
 *
 * Revision 1.21  1995/09/06  14:25:07  nickb
 * Change to c_sp protocol.
 *
 * Revision 1.20  1995/09/04  16:22:12  nickb
 * Interception/replacement.
 *
 * Revision 1.19  1995/09/01  10:37:52  nickb
 * Fix stack extension and various other things.
 *
 * Revision 1.18  1995/07/17  12:32:56  nickb
 * Add dummy sequences for space profiling.
 *
 * Revision 1.17  1995/06/13  16:15:36  jont
 * Event polling code
 * Also modify raise code to remove stack copying down and up in favour of
 * a small extra frame.
 *
 * Revision 1.16  1995/06/08  11:00:07  jont
 * Improvements to stack overflow and event handling
 * Also fixed some bugs in handling exceptions raised in C
 *
 * Revision 1.15  1995/06/06  10:17:54  jont
 * Add stack extension code
 *
 * Revision 1.14  1995/05/30  12:54:41  jont
 * Fix c_raise to work with thread system
 *
 * Revision 1.13  1995/05/18  15:47:00  jont
 * Modify comments on c_raise
 *
 * Revision 1.12  1995/03/15  17:35:13  nickb
 * Add threads system.
 *
 * Revision 1.11  1995/01/30  16:21:24  jont
 * Add stuff to make it work with gcc
 *
 * Revision 1.10  1995/01/23  12:32:11  jont
 * Modification of stub values for windows NT
 *
 * Revision 1.9  1994/11/23  17:02:16  nickb
 * Remove set_stack_underflow.
 *
 * Revision 1.8  1994/11/18  15:30:27  jont
 * Modify to new register assignment
 *
 * Revision 1.7  1994/11/03  14:46:48  jont
 * Fix problem with old c_state.sp being corrupted during callml
 *
 * Revision 1.6  1994/11/02  15:40:23  jont
 * Add ml_raise_leaf
 * Intended to add ml_gc_leaf, but this may not be necessary
 *
 * Revision 1.5  1994/10/27  22:40:33  jont
 * Add code for C_raise
 *
 * Revision 1.4  1994/10/20  16:11:09  jont
 * Add code for non-leaf raise
 *
 * Revision 1.3  1994/10/18  11:24:49  jont
 * Add gc entry code
 *
 * Revision 1.2  1994/10/06  17:30:14  jont
 * Also stub_c and stub_asm
 *
 * Revision 1.1  1994/10/04  16:49:58  jont
 * new file
 *
 *
*/

#include "tags.h"
#include "offsets.h"
#include "mach_values.h"
#include "macros.h"

/* === CALL ML FROM C ===
 *
 * callml is a C-like function which allows C to invoke an ML function in
 * the manner of a coroutine.
 *
 * Parameters:
 *   8(ESP)	Closure of the function to call
 *   4(ESP)	Argument for the ML function -- no multiple arg calls here.
 *   0(ESP)	Link register for return to C
 *   ESP	Current stack pointer
 *   EBP	Current (C) frame pointer (callee save)
 *   EBX	Callee save
 *   ESI	Callee save
 *   EDI	Callee save
 * Returns:
 *   EAX	Result of the ML function
 */

/* enter with in_ML = 0 */

	.global C_NAME(callml)
C_NAME(callml):
	mov	%esp, %eax		/* save esp so we can refer to args */
	save_C_regs
	mov	4(%eax), fnarg		/* argument */
	mov	8(%eax), %ebp		/* closure */
	lea	(C_NAME(global_state)), %eax
	mov	GLOBAL_current_thread(%eax), %esi
	mov	THREAD_c_sp(%esi), %edi  /* Old c_state.sp */
	mov	%esp, THREAD_c_sp(%esi)  /* Remember C sp for calls to C */
	load_ML_state(%ecx)
	mov	THREAD_ml_sp(%esi), %esp	/* saved ml_state.sp */
/* Now create a small frame at the top of the ml stack */
	mov	%esp, %edx		/* Remember current esp */
	pushl	$0			/* Dummy link here */
	push	%edi			/* Save old c_state.sp */
	pushl	$STACK_C_CALL		/* Dummy closure value */
	push	%edx			/* Link fp */
	movl	$1, GLOBAL_in_ML(%eax)	/* now in ML */
	mov	$STACK_START, %edi	/* Set up old closure value */
	mov	-1(%ebp), %ecx		/* Get code pointer */
	add	$CODE_OFFSET, %ecx
	call	%ecx

/* we enter ML with eax = global_state, edx = old ml_sp, esi = thread */
/* all these values are preserved in ML */
	movl	$2, GLOBAL_in_ML(%eax)		/* no longer in ML */
	mov	8(%esp), %ecx
	add	$16, %esp			/* Pop ML frame */
	mov	%esp, THREAD_ml_sp(thread)
	movl	$0, GLOBAL_in_ML(%eax)		/* ml_sp is valid */
	mov	THREAD_c_sp(thread), %esp	/* Reset to C stack */
	mov	%ecx, THREAD_c_sp(thread)	/* restore c_sp */
	mov	fnarg, %eax			/* Get result */
	load_C_regs
	ret

/*
 * === STUBS FROM ML ===
 *
 * These are static ML code vectors which call the routine pointed to
 * by their first closure element.  The C calling stub swaps into the C
 * state before calling the function, whereas the assembler version
 * does not. */

	.text
	.globl	C_NAME(text_internal_stub_c)
	.globl	C_NAME(text_internal_stub_c_end)
C_NAME(text_internal_stub_c):
	save_ML_regs
	mov	%esp, THREAD_ml_sp(thread) /* ml_sp = %sp */
	movl	$0, C_NAME(global_state)+GLOBAL_in_ML	/* ml_sp is valid */
	mov	THREAD_c_sp(thread), %esp  /* %sp = c_sp */
	push	fnarg			/* Stack argument */

#if __WINNT__
	mov	3(%ebp), %ecx
	shr	$2, %ecx
	call	%ecx
#else
	call	3(%ebp)			/* Call C function */
#endif

	mov	%eax, fnarg		/* Get the answer */
	load_ML_state(%ecx)
	pop	%ecx			/* pop argument */
	mov	THREAD_ml_sp(thread), %esp /* %sp = ml_sp */
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML /* ml_sp becomes invalid here */
	load_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML /* Now back to ML */
	ret
C_NAME(text_internal_stub_c_end):

	.text
	.globl	C_NAME(text_internal_stub_asm)
	.globl	C_NAME(text_internal_stub_asm_end)
C_NAME(text_internal_stub_asm):
#if __WINNT__
	mov	3(%ebp), %ecx
	shr	$2, %ecx
	jmp	%ecx
#else
	jmp	3(%ebp)			/* Tail to it */
#endif

C_NAME(text_internal_stub_asm_end):
	.text

stub_code_end:
	.align 4

/* === LOOK UP A VALUE IN THE RUNTIME ENVIRONMENT ===
 *
 * Calls directly through to perv_lookup() from environment.h.
 */

	.global C_NAME(ml_lookup_pervasive)

C_NAME(ml_lookup_pervasive):
	save_ML_regs
	ML_to_C(perv_lookup)
	load_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret
#define ml_gc_internals								  \
	save_all_ML_regs		/* Save all the standard registers */	; \
	mov	%esp, THREAD_ml_sp(thread) /* Save last frame for gc */		; \
	movl	$0, C_NAME(global_state)+GLOBAL_in_ML	/* Not in ML */		; \
	mov	THREAD_c_sp(thread), %esp  /* Onto c stack */			; \
	push	%edi								; \
	push	%ecx								; \
	call	C_NAME(gc)		/* Call garbage collector */		; \
	load_ML_state(%ecx)							; \
	mov	THREAD_ml_sp(thread), %esp /* Point back to ml frame */		; \
	mov	THREAD_ml_global(thread), %ecx /* Answer in correct place */	; \
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not in ML, ml_sp invalid*/; \
	load_all_ML_regs		/* restore ml's registers */

/*
 * Call declare_root
 * ebx is root address
 *
 */
	.globl	ml_declare_root
ml_declare_root:
	save_ML_regs
	mov	$0, %eax	/* This is not a root as far as image saving is concerened */
	ML_to_C(declare_root)
	load_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret
/*
 * Call retract_root
 * eax is root address
 *
 */
	.globl	ml_retract_root
ml_retract_root:
	save_ML_regs
	ML_to_C(retract_root)
	load_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret
/*
 * Add a setup function result to the module table
 * %ebx is value to be added
 * %eax is module name
 * %edx is timestamp
 */
	.globl	ml_mt_update
ml_mt_update:
	save_ML_regs
	ML_to_C(mt_update)
	load_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret

/*
 * Add a code item to the weak table of code items
 * %ebx is value to be added
 */
	.globl	ml_loader_code_add
ml_loader_code_add:
	save_ML_regs
	ML_to_C(loader_code_add)
	load_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret

/*
 * Add a global to be reinstated on image reload
 * %ebx is value to be added
 * %eax is module name
 */
	.globl	ml_declare_global
ml_declare_global:
	push	%eax
	push	%ebx
	call	C_NAME(declare_global_result)
	add	$8, %esp
	ret
	
/*
 * Record the time stamp of a dll
 * %eax is start address
 */
	.globl	ml_register_time_stamp
ml_register_time_stamp:
	push	%eax
	call	C_NAME(register_time_stamp)
	add	$4,%esp
	ret

/*
 * ml_internal_gc
 *
 * ecx = requested size
 * return address on stack
 * edi = current closure
 */
	.global C_NAME(ml_internal_gc)
C_NAME(ml_internal_gc):
	mov	IMPLICIT_profile_alloc_2(thread), %ecx	/* alloc amount back */
	save_all_ML_regs				/* Save all the standard registers */
	mov	%esp, THREAD_ml_sp(thread)		/* Save last frame for gc */
	movl	$0, C_NAME(global_state)+GLOBAL_in_ML	/* Not in ML */
	mov	THREAD_c_sp(thread), %esp		/* Onto c stack */
	push	%edi
	push	%ecx
	call	C_NAME(gc)				/* Call garbage collector */
	load_ML_state(%ecx)
	mov	THREAD_ml_sp(thread), %esp		/* Point back to ml frame */
	mov	THREAD_ml_global(thread), %ecx		/* Answer in correct place */
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not in ML, ml_sp invalid*/
	load_all_ML_regs				/* restore ml's registers */
	ret

/* On the Intel x86 we do not allow allocation in leaf functions */

	.global C_NAME(ml_gc_leaf)
C_NAME(ml_gc_leaf):
	call	C_NAME(ml_gc_leaf_die)

/* === FLUSH REGISTER WINDOWS ===
 *
 * This routine would invoke the window flushing trap on SPARC.  We
 * have it for portability of interface.h.
 */
	.global C_NAME(flush_windows)

C_NAME(flush_windows):
	ret

/*
 * === STACK OVERFLOW / ASYNCHRONOUS EVENT ===
 *
 * This code is called by ML when %esp < stack_limit.
 * This condition is checked by ML on function entry to ensure that
 * there is enough room for a frame, and is used by the asynchronous
 * event handler to trip up ML at a `safe' moment.  The function
 * jumps here with the following parameters:
 *
 * (in all these comments, we assume that f called g which was disturbed)
 *
 *  ebx  g argument
 *  ebp  g
 *  edi  f
 *  ecx  minimum stack requirement of g
 *       (not including safety zone of 2kb or the normal register save area)
 *  esp[0]  link to continue g
 *  esp[1]  link to f
 *  esp+8   g's arguments (caller push, callee pop)
 *  esp+12  more g's arguments (Nb, there may be no arguments)
 *  esp+...
 *  esp+8+(#args*4)   f's frame
 */
	.global C_NAME(ml_disturbance)

C_NAME(ml_disturbance):

/* first we create a dummy stack frame for the disturbed function. This 
 * leaves us with a consistent stack */
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */

	push	%edi			/* Save f's closure */
	mov	-1(%ebp), %edi		/* g's code item */
	mov	-1(%edi), %edi		/* g's ancillary field */
	shr	$CCODE_ARGS_SHIFT, %edi
	and	$CCODE_MAX_ARGS, %edi	/* # args */
	lea	12(%esp, %edi, 4), %edi	/* calc frame pointer */
	push 	%edi			/* Save frame pointer */
	xchg	%ecx, 8(%esp)		/* swap frame size with continuation */
	mov	-1(%ebp), %edi		/* g's code item */
	sub	%edi, %ecx		/* g's code offset */
	shl	$2, %ecx		/* as an ML value */

/* build a new frame */

	pushl	$0			/* link slot */
	push	%ecx			/* ML(g offset) */
	push	%ebx			/* g arg */
	push	%ebp			/* g; stack_crawl depends heavily on
	                                 * the placement of this value */
	push	%edx			/* callee saves */
	push	%eax
	push	$STACK_DISTURB_EVENT
	lea	28(%esp), %ebp
	push	%ebp			/* frame pointer */
/* now we've saved the registers, we dink with the arguments to g
 * that were passed on the stack.
 * The first argument and f's link (return address in f) are swapped.
 * This puts the return address in the "correct place" for stack_crawl
 * to find.
 * Note that this is done (and does "the right thing") even when
 * there are no argumens.
 */
/* %edi - g's code item */
	mov	-1(%edi), %edi		/* g's ancillary field */
	shr	$CCODE_ARGS_SHIFT, %edi
	and	$CCODE_MAX_ARGS, %edi	/* # args */
	mov	44(%esp), %ecx		/* load link f */
	xchg	%ecx, 44(%esp, %edi, 4) /* swap with g's 1st arg */
	mov	%ecx, 44(%esp)		/* store g's 1st arg */
	mov	$STACK_DISTURB_EVENT, %edi /* frame closure tag */

/* Now we check that a stack extension is required (could be we've
 * just had an event) */

extend_stack:
	mov	%esp, %ebp
	mov	40(%esp), %ecx		/* recover frame size from stack */
	sub	%ecx, %ebp		/* Calculate required new sp */
	cmp	IMPLICIT_stack_limit(thread), %ebp /* compare with slimit */
	jae	check_for_events	/* Branch if not */

/* We need a stack extension */

#ifdef COLLECT_STATS				
	incl	C_NAME(stack_extension_count)	/* Inc stack extension count */
#endif
	mov	IMPLICIT_stack_limit(thread), %eax
	lea	-(STACK_BUFFER+DEFAULT_STACK_SIZE)(%eax), %ebx
					/* arg 0 = current stack */
	lea	(STACK_BUFFER+DEFAULT_STACK_SIZE)(%ecx), %eax
					/* arg 1 = requested amount */
	ML_to_C(make_ml_stack)
	lea	(STACK_BUFFER+DEFAULT_STACK_SIZE)(%ebx), %ecx /* new slimit */
	mov	%ecx, IMPLICIT_stack_limit(thread)	/* save it */
	mov	%ecx, IMPLICIT_register_stack_limit(thread)
	mov	4(%ebx), %ecx		/* The new sp */

/* Having made a new stack block, we move our final frame onto it */

	load_all_ML_regs		/* All ML registers as before call */
	pop	%edi			/* ML(g offset) */
	mov	%edi, -4(%ecx)		/* ML(g offset) */
	mov	%ebx, -8(%ecx)		/* g argument */
	mov	%ebp, -12(%ecx)		/* g */
	mov	%edx, -16(%ecx)		/* saved edx */
	mov	%eax, -20(%ecx)		/* saved eax */
	movl	$STACK_EXTENSION, %edi	/* closure */
	movl	%edi, -24(%ecx)		/* in closure slot */
	lea	4(%esp), %ebx		/* frame pointer */
	mov	%ebx, -28(%ecx)		/* fp slot */
	lea	-28(%ecx), %esp		/* onto new stack */
	
/* Now we test for events. We get here by one of two routes (depending
 * on whether we have extended the stack or not).
 * eax Callee save (already saved)
 * ebx -
 * ecx -
 * edx Callee save (already saved)
 * esi thread
 * edi STACK_DISTURB_EVENT or STACK_EXTENSION
 * ebp -
 */

check_for_events:
	mov	IMPLICIT_interrupt(thread), %ecx
	or	IMPLICIT_register_stack_limit(thread), %ecx
	jg	call_disturbed_fn	/* Branch if no interrupts pending */
	movl	$0, IMPLICIT_interrupt(thread)
	mov	IMPLICIT_stack_limit(thread), %ecx
	mov	%ecx, IMPLICIT_register_stack_limit(thread)
	ML_to_C(ev_poll)

/* We need to call the disturbed function with caller's closure set to
 * STACK_EXTENSION or STACK_EVENT as appropriate, and the stack size in ecx.
*/

call_disturbed_fn:
	mov	4(%esp), %edi		/* restore STACK_* */
	mov	16(%esp),%ebp		/* restore g */
	mov	-1(%ebp),%ecx		/* code item */
	mov	-1(%ecx),%ecx		/* ancillary word */
	shr	$CCODE_ARGS_SHIFT,%ecx
	and	$CCODE_MAX_ARGS,%ecx	/* # args */
	mov	%ecx,%eax		/* save #args */
	jecxz	copy_no_more_args	/* break early for no stack args */
	mov	0(%esp),%edx		/* locate g's arguments... */
	push	12(%edx)		/* 1st arg has been dinked */
	dec	%ecx
	jecxz	copy_no_more_args	/* only 1 arg */
	mov	0(%edx),%edx		/* 2 frames back ... */
	/* the following loop could probably be improved */
	lea	-8(%edx),%edx		/* points to 2nd pushed arg */
copy_args:
	push	(%edx)			/* copy an argument down */
	lea	-4(%edx),%edx
	dec	%ecx
	jnz	copy_args
copy_no_more_args:
	/* eax contains number of args */
	mov	12(%esp,%eax,4),%edx	/* restore saved edx */
	mov	20(%esp,%eax,4),%ebx	/* restore g's argument */
	mov	24(%esp,%eax,4),%ecx	/* ML (g offset) */
	shr	$2, %ecx		/* g offset */
	add	-PAIRPTR(%ebp), %ecx	/* g continuation */
	push	%ecx			/* push anything */
	push	%ecx			/* push continuation address */
	lea	return_from_disturbed_fn, %ecx	/* Our return address */
	mov	%ecx, 4(%esp)		/* Put it on the stack */
	mov	8(%esp,%eax,4), %ecx	/* frame pointer */
	mov	8(%ecx), %ecx		/* size requested */
	mov	16(%esp,%eax,4),%eax	/* restore saved eax */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret				/* Call the rest of the disturbed fn */

return_from_disturbed_fn:
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not in ML */
	cmp	$STACK_EXTENSION, %edi	/* Did we extend the stack */
	jne	return_to_caller	/* Branch if not */

/* We did a stack extension; we need to move back to the previous
 * stack and call unmake_stack.
 * eax Callee save
 * ebx Result
 * ecx -
 * edx Callee save
 * esi thread
 * edi STACK_EXTENSION
 * ebp -

 * We have to push a frame on the old stack containing the
 * callee-saves, then call unmake_stack. We have to be careful to pass
 * the returned value back to the caller. */

	mov	0(%esp), %esp		/* back to old stack */
	pushl	$0			/* link slot */
	save_all_ML_regs
	mov	IMPLICIT_stack_limit(thread), fnarg
					/* Stack limit of stack to discard */
	sub	$(STACK_BUFFER+DEFAULT_STACK_SIZE), fnarg
					/* Get proper pointer to it */
	ML_to_C(unmake_ml_stack)	/* Throw away the stack */
	add	$(STACK_BUFFER+DEFAULT_STACK_SIZE), fnarg
					/* Calculate new slimit */
	mov	fnarg, IMPLICIT_stack_limit(thread) /* Save it */
	mov	fnarg, IMPLICIT_register_stack_limit(thread)
	mov	IMPLICIT_interrupt(thread),fnarg	/* interrupt status */
	or	fnarg,IMPLICIT_register_stack_limit(thread)
	load_all_ML_regs
	pop	%ecx			/* discard */
	pop	%ecx			/* fp */
	pop	%edi			/* f's closure */
	lea	-4(%ecx),%esp		/* junk frame except for link f */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret				/* return to caller */

return_to_caller:
	mov	0(%esp),%esp		/* discard frame */
	pop	%ecx			/* fp */
	pop	%edi			/* f's closure */
	lea	-4(%ecx),%esp		/* junk frame except for link f */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret

/*
 * === CHECK FOR AN ML EVENT ===
 *
 * We arrive here when register_stack_limit(thread) has been detected to be -1
 * in a non-leaf function.
 *
 * All registers potentially significant
 * 4(esp) frame pointer
 * 0(esp) return address
 * edi function closure
 */
	.global	C_NAME(ml_event_check)
C_NAME(ml_event_check):
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
	movl	$0, IMPLICIT_interrupt(thread)
	mov	IMPLICIT_stack_limit(thread), %ecx
	mov	%ecx, IMPLICIT_register_stack_limit(thread)
	save_all_ML_regs
	ML_to_C(ev_poll)
	load_all_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* Now in ML */
	ret

/*
 * We arrive here when register_stack_limit(thread) has been detected to be -1
 * in a leaf function
 *
 * All registers potentially significant
 * 8(esp) frame pointer for caller of leaf function
 * 4(esp) return address from leaf function
 * 0(esp) return address to polling (leaf) function
 * ebp function closure
 */

	.globl	C_NAME(ml_event_check_leaf)
C_NAME(ml_event_check_leaf):
/*
 * Need to create a dummy frame for the leaf function
 */
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
	lea	8(%esp), %ecx	/* New fp */
	push	%ecx		/* Save on stack */
	push	4(%esp)		/* Move the return address down */
	mov	%edi, 8(%esp)	/* Save caller's caller's closure */
	mov	%ebp, %edi	/* Set up closure as if from non-leaf */
/* Now in common with ml_event_check */
	movl	$0, IMPLICIT_interrupt(thread)
	mov	IMPLICIT_stack_limit(thread), %ecx
	mov	%ecx, IMPLICIT_register_stack_limit(thread)
	save_all_ML_regs
	ML_to_C(ev_poll)
	load_all_ML_regs
/* Now undo dummy frame */
	mov	8(%esp), %edi	/* Restore caller's caller's closure */
	pop	%ecx		/* get return address */
	mov	%ecx, 4(%esp)	/* to where we want it */
	add	$4, %esp
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret			/* return */

/* === RAISE AN EXCEPTION FROM C === */
/* This is an entry point to ml_raise which may be called from C. */

	.global C_NAME(c_raise)

C_NAME(c_raise):

/*
 * Cut back to last ml frame, as saved in stub_c
 * Raise argument is at 4(ESP)
 * Rewind to previous ml_state.sp
 */
	mov	C_NAME(global_state)+GLOBAL_current_thread, thread
					/* get current thread pointer */
	load_ML_state(%ecx)
	mov	4(%esp), fnarg		/* Place exception argument in fnarg */
	mov	THREAD_ml_sp(thread), %esp	/* Restore ml_state.sp */
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */

	xor	%ebp, %ebp				/* clean caller clos */
	load_ML_regs
	/* \/\/ fall through \/\/ */
/* At this point, the return address to whatever called C is at
 * 0(esp)
 */

/* 
 * === RAISE AN EXCEPTION ===
 *
 * When an exception is raised the first exception handler function on
 * the handler chain is called to deal with it.	If the handler
 * function returns then the exception was handled.  In the context of
 * the function in which the handler was created (the `creator') must
 * be restored and that function continued.  Restore instructions are
 * executed repeatedly until the current stack pointer matches the
 * pointer that was stored in the handler record.
 *
 * There are some subtleties.  The stack may be disjoint, so, after
 * crawling our way back up it the C function unwind_stack is called
 * to deallocate an extensions that are no longer required.
 *
 * If the handler record is zero then the next handler is the top-level
 * handler, and the C function handle() is called.  This returns iff a
 * debugger is installed, and passes some information about where to
 * find it.  In this case, the debugger is called, and that in turn
 * returns instructions for what to do next.
 *
 * Handler record format:
 *   -1	Previous handler
 *    3	Stack pointer of creator
 *    7	Handler function closure
 *   11	Offset within creator of continuation code
 *
 * Parameters:
 *   fnarg		The exception packet to raise
 *   EDI		Current function's closure
 *   thread		Thread state
 *   0(ESP)		Return address for resumption
			 (not used at present, and not true for leaf)
 *   64(thread)	Exception handler record
 *
 *
 * Warning. This code assumes that all procedures containing handler
 * continuations are non-leaf. This is currently true because handlers
 * are stack allocated.
 *
 */
	.global C_NAME(ml_raise)
	.global C_NAME(ml_raise_leaf)

C_NAME(ml_raise):
#ifdef COLLECT_STATS
	incl	C_NAME(raise_count)
#endif
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */

	add	$4, %esp		/* Throw away return address */
	mov	IMPLICIT_handler(thread), %ecx
	pushl	$0			/* Dummy return address */
	push	%ecx			/* Save current handler */
	lea	8(%esp), %ebp		/* Calculate fp for this frame */
	push	%edi			/* Save caller's closure */
	push	%ebp			/* Save fp */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* Now in ML */
	mov	7(%ecx), %ebp		/* Handler closure */
	movl	$STACK_RAISE, %edi	/* This frame's closure */
	mov	-1(%ecx), %ecx		/* Previous handler frame */
	mov	%ecx, IMPLICIT_handler(thread)	/* Set new handler */
	mov	-1(%ebp), %ecx		/* Code pointer of handling function */
	add	$CODE_OFFSET, %ecx	/* Plus offset */
	call	%ecx			/* Call the handler function */
/*
 * Remove dummy frame from stack
 */
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
	add	$4, %esp		/* Throw away fp */
	pop	%edi			/* Caller's closure back */
	pop	%ecx			/* Current handler frame for unwind */
	add	$4, %esp		/* Throw away return address */
	xor	%ebp, %ebp		/* Clean out potential non-GC value */
	mov	%ecx, IMPLICIT_handler(thread) 	/* Restore original handler */
	mov	3(%ecx), %ecx		/* Get sp value from handler frame */
	mov	0(%ecx), %ecx		/* And get its fp */
	unwind_stack(raise)		/* Unwind to that frame */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* Now in ML */
	mov	IMPLICIT_handler(thread), %ebp
	mov	11(%ebp), %ecx		/* Fetch offset of the continuation */
	shr	$2, %ecx		/* Untag it */
	add	-1(%edi), %ecx		/* Add in start of creator function */
	add	$CODE_OFFSET, %ecx	/* Plus tag */
	jmp	%ecx			/* Back we go */

C_NAME(ml_raise_leaf):
#ifdef COLLECT_STATS
	incl	C_NAME(raise_count)
#endif

	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
/*
 * Here we may have some arguments on the stack to throw away
 */
	mov	-1(%ebp), %ecx		/* Get code vector */
	mov	-1(%ecx), %ecx		/* Get ancillary word */
	shr	$CCODE_ARGS_SHIFT, %ecx	/* Move args part into ls bits */
	and	$CCODE_MAX_ARGS, %ecx	/* Get rid of other bits */
	lea	4(%esp, %ecx, 4), %esp	/* Throw away one return address and args */
	jmp	C_NAME(ml_raise)

/*
 * === CODE VECTOR REPLACEMENT AND INTERCEPTION ===
 *
 *
 * When compiled for debugging, code vectors contain a sequence of
 * nop operations which can be replaced with code to intercept or
 * replace the flow of control.  This is used to implement tracing,
 * profiling, etc.
 * 
 * ml_intercept (ml_intercept_leaf) is jumped to by the instructions
 * inserted into a code vector when it is to be intercepted (see
 * `intercept_on' below).  It calls the C function `intercept',
 * passing its frame.  When `intercept' returns, the intercepted
 * function is continued.
 * 
 * The above comments hold (mutatis mutandis) for 'replace'; in that
 * case the intercepted function is abandoned.
 *
 * These four routines are all pointed to from the implicit vector.
 *
 */
	.global	C_NAME(ml_replace)
	.global	C_NAME(ml_replace_leaf)
	.global C_NAME(ml_intercept)
	.global C_NAME(ml_intercept_leaf)

C_NAME(ml_replace):
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML
	save_all_ML_regs		/* dummy frame */
	mov	%esp, fnarg
	ML_to_C(replace)
	load_all_ML_regs
	mov	8(%esp), %edi		/* restore caller's closure */
	mov	4(%esp), %ecx		/* fp of parent frame */
	lea	-4(%ecx), %esp		/* sp = fp-4, below return address */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret

C_NAME(ml_intercept):
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
	save_all_ML_regs
	mov	%esp, fnarg
	ML_to_C(intercept)
	load_all_ML_regs
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* Now in ML */
	ret

C_NAME(ml_replace_leaf):
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
	pop	%ecx			/* pop continuation address */
	push	fnarg			/* dummy frame 1 : argument */
	push	%edi			/*                 caller's closure */
	lea	12(%esp), %edi		/*		   fp */
	push	%edi
	push	%ecx			/* dummy frame 2: continuation address */
	push	fnarg			/*		  argument */
	push	%edx			/*		  callee-save */
	push	%eax			/*		  callee-save */
	push	%ebp			/*		  closure */
	lea	20(%esp),%ecx		/*		  fp */
	push	%ecx
	mov	%esp, fnarg		/* frame as argument */
	ML_to_C(replace)
	add	$8, %esp
	pop	%eax			/* restore callee-saves */
	pop	%edx
	pop	fnarg			/* restore result */
	mov	8(%esp), %edi		/* restore caller's closure */
	add	$16, %esp		/* pop dummy frame 1 */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret

/* interception is the same except for the very last part. */

C_NAME(ml_intercept_leaf):
	movl	$2, C_NAME(global_state)+GLOBAL_in_ML
	pop	%ecx			/* pop continuation address */
	push	fnarg			/* dummy frame 1 : argument */
	push	%edi			/*                 caller's closure */
	lea	12(%esp), %edi		/*		   fp */
	push	%edi
	push	%ecx			/* dummy frame 2: continuation address */
	push	fnarg			/*		  argument */
	push	%edx			/*		  callee-save */
	push	%eax			/*		  callee-save */
	push	%ebp			/*		  closure */
	lea	20( %esp),%ecx		/*		  fp */
	push	%ecx
	mov	%esp, fnarg		/* frame as argument */
	ML_to_C(replace)
	add	$4, %esp
	pop	%ebp
	pop	%eax			/* restore callee-saves */
	pop	%edx
	pop	fnarg			/* restore result */
	pop	%ecx			/* continuation address */
	add	$4, %esp		/* skip frame ptr */
	pop	%edi			/* restore caller's closure */
	add	$4, %esp		/* skip arg slot */
	push	%ecx			/* push continuation address */
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* We are now in ML */
	ret

/* == Replacement code ==
 *
 * These are sections of code which are inserted at the start of a code
 * vector and altered to implement interception.  They are
 * *_INTERCEPT_LENGTH bytes long (from tags.h); three in the intel case.
 * 
 * There are four interception code segments; for intercepting and
 * replacing, for leaf and non-leaf functions. They call the relevant
 * bit of code above (ml_intercept_on calls ml_intercept, for
 * instance). ml_nop is the sequence of three special nops which are
 * replaced by the intercepts; they are here so we can undo
 * interception.
 */

	.global C_NAME(ml_replace_on)
	.global	C_NAME(ml_replace_on_leaf)
	.global C_NAME(ml_intercept_on)
	.global C_NAME(ml_intercept_on_leaf)
	.global C_NAME(ml_nop)

C_NAME(ml_replace_on):
	call	IMPLICIT_replace(thread)

C_NAME(ml_replace_on_leaf):
	call	IMPLICIT_replace_leaf(thread)

C_NAME(ml_intercept_on):
	call	IMPLICIT_intercept(thread)

C_NAME(ml_intercept_on_leaf):
	call	IMPLICIT_intercept_leaf(thread)

C_NAME(ml_nop):
	cmc
	cmc	
	cmc

/* This generates a debugger trap. */

	.global C_NAME(generate_debugger_trap)

C_NAME(generate_debugger_trap):
	int 	$3

	.global C_NAME(switch_to_thread)
#ifdef NATIVE_THREADS
C_NAME(switch_to_thread):
	mov	4(%esp),%eax			  /* eax = old thread */
	mov	8(%esp),%edx			  /* edx = new thread */
	pop	%ecx				  /* save old eip */
	mov	%ecx, THREAD_c_eip(%eax)
	push	%edx				  /* new thread */
	push	%eax				  /* old thread */
	call	C_NAME(native_thread_yield)	  /* returns previous thread */
	pop	%edx				  /* this thread */
	add	$4, %esp			  /* discard */
	mov	THREAD_c_eip(%edx), %ecx
	push	%ecx				  /* install continuation */
	ret					  /* return previous thread */
#else
C_NAME(switch_to_thread):
	mov	4(%esp),%eax			 /* the old thread */
	mov	8(%esp),%edx			 /* the new thread */
	save_thread_registers(%eax)		  /* swap saved registers */
	load_thread_registers(%edx)		  /* (ebp, esi, edi, ebx) */
	pop	%ecx				  /* save and set esp, eip */
	mov	%ecx, THREAD_c_eip(%eax)
	mov	THREAD_c_eip(%edx), %ecx
	mov	%esp, THREAD_c_esp(%eax)
	mov	THREAD_c_esp(%edx), %esp
	push	%ecx				/* the address to return to */
	ret					/* return the old thread */
#endif

/* Space profiling. We come here as if we were going to ml_gc. */
	.global	C_NAME(ml_gc)
/*
 * ml_gc
 *
 * ecx = requested size
 * return address on stack
 * edi = current closure
 */

C_NAME(ml_gc):
	mov	%ecx, IMPLICIT_profile_alloc_2(thread)	/* save alloc amount */
	mov	IMPLICIT_gc_base(thread), %ecx		/* test for GC */
	cmp	IMPLICIT_real_gc_limit(thread), %ecx
	jbe	ml_gc_noGC				/* no GC */

/* a GC is required */	

	movl	$2, C_NAME(global_state)+GLOBAL_in_ML	/* Not really in ML */
	push	%edi					/* create fake frame */
	lea	8(%esp), %ecx
	push	%ecx
	mov	IMPLICIT_profile_alloc_2(thread), %ecx	/* restore alloc amt */
	movl	$STACK_SPACE_PROFILE, %edi		/* fake frame closure */
	call	C_NAME(ml_internal_gc)
	add	$4, %esp				/* pop fp */
	pop	%edi
	movl	$1, C_NAME(global_state)+GLOBAL_in_ML	/* back in ML */
	jmp	ml_gc_record
ml_gc_noGC:	
	mov	IMPLICIT_gc_base(thread), %ecx		/* advanced alloc point */
	sub	IMPLICIT_profile_alloc_2(thread), %ecx	/* alloc point */
ml_gc_record:
/*
 * Now determine if we are space profiling
 */
	.globl	C_NAME(space_profile_active)
	mov	%eax, IMPLICIT_profile_alloc_2(thread)	/* save eax */
	mov	C_NAME(space_profile_active), %eax	/* get flag */
	cmp	$0, %eax
	je	ml_gc_exit				/* branch if not space profiling */
	mov	THREAD_ml_profile(thread), %eax
	mov	%edi, 0(%eax)
	mov	%ecx, 4(%eax)
	add	$8, %eax
	mov	%eax, THREAD_ml_profile(thread)
#ifdef	SPACE_PROFILE_OVERFLOW
/*
 * Now ensure that the limit is set to the base so we reenter at next allocation
 */
	mov	IMPLICIT_gc_base(thread), %eax
	mov	%eax, IMPLICIT_gc_limit(thread)
#endif
ml_gc_exit:
	mov	IMPLICIT_profile_alloc_2(thread), %eax	/* restore eax */
	ret

	.global	C_NAME(ml_profile_alloc)
C_NAME(ml_profile_alloc):
#ifdef	SPACE_PROFILE_OVERFLOW
	jmp	C_NAME(ml_gc)
#else
/* Deprecated interface */
	call	C_NAME(ml_profile_alloc_die)
#endif

/* leaf allocation is not allowed on the x86 */

	.global	C_NAME(ml_profile_alloc_leaf)
C_NAME(ml_profile_alloc_leaf):
	call	C_NAME(ml_gc_leaf_die)

/* fpu control word reading for linux */
	
	.global	C_NAME(get_fpu_control_word)
C_NAME(get_fpu_control_word):
	sub	$4, %esp	/* Make some space on stack */
	fnstcw	2(%esp)		/* Store the control word there */
	movw	2(%esp), %ax	/* Load it into %ax */
	and	$0xf3f, %eax	/* Clean out rubbish */
	add	$4, %esp	/* Don't need the space any more */
	ret			/* Return, answer in eax */

	.global	C_NAME(asm_check_neg_zero)
C_NAME(asm_check_neg_zero):
	mov	4(%esp), %eax
	fldl	0(%eax)		/* Get the real to be tested */
	fxam			/* Check status */
	fstsw	%ax		/* Get float status into ax */
	fstp	%ST(0)		/* Pop fp stack again */
	andw	$0x4300, %ax	/* Mask out crap */
	cmpw	$0x4000, %ax	/* Check for +0 */
	jz	l0
	cmpw	$0x4200, %ax	/* Check for -0 */
	jz	l1
	movl	$0, %eax	/* Return 0 */
	ret
l0:	movl	$1, %eax	/* Return 1 */
	ret
l1:	movl	$2, %eax	/* Return 2 */
	ret

/* Trampoline call ML from C
 *
 * trampoline is a C-like function which allows C to invoke an ML function in
 * the manner of a coroutine.
 *
 * Parameters:
 *   4(ESP)     Function to be called
 *   0(ESP)	Link register for return to C
 *   ESP	Current stack pointer
 *   EBP	Current (C) frame pointer (callee save)
 *   EBX	Callee save
 *   ESI	Callee save
 *   EDI	Callee save
 *   EAX	Function to be called
 * Returns:
 *   EAX	Result of the ML function
 */

/* enter with in_ML = 0 */

	.global C_NAME(asm_trampoline)
C_NAME(asm_trampoline):
	mov	%esp, %eax		/* save esp so we can refer to args */
	save_C_regs
	mov	4(%eax), %ebp		/* The function closure */
	lea	(C_NAME(global_state)), %eax
	mov	GLOBAL_current_thread(%eax), %esi
	mov	THREAD_c_sp(%esi), %edi  /* Old c_state.sp */
	mov	%esp, THREAD_c_sp(%esi)  /* Remember C sp for calls to C */
	load_ML_state(%ecx)
	mov	THREAD_ml_sp(%esi), %esp	/* saved ml_state.sp */
/* Now create a small frame at the top of the ml stack */
	mov	%esp, %edx		/* Remember current esp */
	pushl	$0			/* Dummy link here */
	push	%edi			/* Save old c_state.sp */
	pushl	$STACK_C_CALL		/* Dummy closure value */
	push	%edx			/* Link fp */
	movl	$1, GLOBAL_in_ML(%eax)	/* now in ML */
	mov	$STACK_START, %edi	/* Set up old closure value */
	mov	-1(%ebp), %ecx		/* Get code pointer */
	add	$CODE_OFFSET, %ecx
	call	%ecx
/* we enter ML with edx = old ml_sp, esi = thread */
/* all these values are preserved in ML */
	lea	(C_NAME(global_state)), %eax
	movl	$2, GLOBAL_in_ML(%eax)		/* no longer in ML */
	mov	8(%esp), %ecx
	add	$16, %esp			/* Pop ML frame */
	mov	%esp, THREAD_ml_sp(thread)
	movl	$0, GLOBAL_in_ML(%eax)		/* ml_sp is valid */
	mov	THREAD_c_sp(thread), %esp	/* Reset to C stack */
	mov	%ecx, THREAD_c_sp(thread)	/* restore c_sp */
	mov	fnarg, %eax			/* Get result */
	load_C_regs
	ret


	.section	.drectve
	.asciz	"-export:ml_declare_root"
	.asciz	"-export:ml_retract_root"
	.asciz	"-export:ml_mt_update"
	.asciz	"-export:ml_declare_global"
	.asciz	"-export:ml_register_time_stamp"
	.asciz	"-export:ml_loader_code_add"

#ifdef COLLECT_STATS
	.global C_NAME(raise_count)
	.global C_NAME(stack_extension_count)
#endif
