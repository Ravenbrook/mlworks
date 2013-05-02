/*
 * ==== ML TO C INTERFACING CODE ====
 *		SPARC
 *
 * Copyright (C) 1991 Harlequin Ltd
 *
 * Description
 * -----------
 * This code does the job of managing the calls between ML and C.  The ML
 * and C states are stored in C structures declared in `state.c'.
 *
 * Notes
 * -----
 * This code uses some predefined macros as parameters.  These are
 * defined (or not) in the Makefile.  They are as follows:
 *
 *   COLLECT_STATS: If defined the routines will update various
 *                  counters defined in callc_codes.c when called.
 *
 * This file must be run through both CPP and the m4 macro processor to
 * produce an assembler file. 
 *
 * Revision Log
 * ------------
 * $Log: interface.S,v $
 * Revision 1.27  1998/05/20 14:01:25  jont
 * [Bug #70035]
 * Add stub_code_start and stub_code_end variables
 * for use in address validation
 *
 * Revision 1.26  1997/07/15  15:36:52  daveb
 * [Bug #30200]
 * Set in_ML in c_raise.
 *
 * Revision 1.25  1997/02/06  11:41:51  nickb
 * The ST_CLEAN_WINDOWS trap semantics are subtly different on UltraSPARCs. The
 * effect is that the registers which are current at the time of the trap may
 * reappear in a later register window. So whenever we invoke it, we have to
 * ensure that the current registers (ins, locals, and outs) are GC-safe.
 *
 * Revision 1.24  1996/11/07  17:51:52  stephenb
 * [Bug #1461]
 * Must not construct fake frames for non-leaf functions, as
 * they do not contain values which the GC and the debugger expect
 * them to. This can lead to fatal failure of either the GC or
 * the debugger (e.g. indexing down from an fp which does not
 * point to the top of a genuine stack frame).
 *
 * Revision 1.23  1996/11/01  12:04:12  nickb
 * When restoring the stack limit after return from a stack
 * extension, we should OR in the interrupt slot. By mistake,
 * we are ORing in the stack limit slot, which will have no
 * effect. This relatively harmless bug discovered when looking
 * for a much more serious one.
 *
 * Revision 1.21  1995/11/13  12:31:59  nickb
 * Move CURRENT_THREAD manipulation out of asm into portable C.
 *
 * Revision 1.20  1995/09/06  15:34:22  nickb
 * Change to c_sp protocol.
 *
 * Revision 1.19  1995/07/26  08:28:30  nickb
 * Bug in leaf handler raise.
 *
 * Revision 1.18  1995/07/25  11:27:41  nickb
 * Reuse stack frame on leaf handler raise.
 *
 * Revision 1.17  1995/07/05  14:45:01  nickb
 * Add space profiling code.
 *
 * Revision 1.16  1995/06/14  14:29:03  jont
 * Move to new method of preserving current handler frame when applying handler
 *
 * Revision 1.15  1995/06/02  10:42:25  nickb
 * Replace set_stack_underflow with more general code.
 *
 * Revision 1.14  1995/03/28  15:13:05  nickb
 * Add threads system.
 *
 * Revision 1.13  1995/02/23  15:01:15  matthew
 * Clear lr for intercept frame
 *
 * Revision 1.12  1994/10/27  23:05:49  jont
 * Change offsets in handler records to be ml integers
 *
 * Revision 1.11  1994/10/19  11:59:41  jont
 * Fix handler unwinding
 *
 * Revision 1.10  1994/09/15  11:53:40  jont
 * Reduce handler frame size to four words
 * by leaving out fp
 *
 * Revision 1.9  1994/09/05  12:20:36  nickb
 * Preserve o7 (link register) over non-leaf GC entry.
 *
 * Revision 1.8  1994/08/25  09:41:16  matthew
 * Change stack extension entry to free up O registers.
 *
 * Revision 1.7  1994/07/22  16:21:24  nickh
 * Add routines to get us into GC from a trap handler and back again.
 * (see gc_trap_entry, gc_trap_entry_leaf, &c).
 *
 * Revision 1.6  1994/07/06  13:31:35  nickh
 * Asm and C name prefixes differ according to OS.
 *
 * Revision 1.5  1994/07/01  10:39:59  nickh
 * Add debugger trap.
 *
 * Revision 1.4  1994/06/21  15:58:21  nickh
 * New ancillary layout.
 *
 * Revision 1.3  1994/06/15  16:16:56  jont
 * Put non ML return values in o7 when marking STACK_EVENT frames
 *
 * Revision 1.2  1994/06/09  14:30:02  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:54:32  nickh
 * new file
 *
 * Revision 1.79  1994/03/15  12:54:48  nickh
 * Fix intercept comments.
 *
 * Revision 1.78  1994/03/10  14:23:20  jont
 * Changes to handler records following LEO opcode
 *
 * Revision 1.77  1993/11/17  17:05:41  jont
 * Added the missing fields for stubs and rearranged the others into the right order
 *
 * Revision 1.76  1993/11/17  16:20:07  jont
 * Changed the header words on the strings 'stub to C' and 'stub to assembler'
 * so the value printer can understand them.
 *
 * Revision 1.75  1993/11/05  14:56:16  jont
 * Added check_event entries for leaf and non-leaf.
 *
 * Revision 1.74  1993/10/12  10:29:21  matthew
 * Fixed problem in extend_stack where g6 was getting set regardless of whether a signal had
 * been handled.
 *
 * Revision 1.73  1993/08/24  15:51:57  richard
 * Missing +8 offset on return from ml_intercept_leaf.
 *
 * Revision 1.72  1993/08/17  12:11:13  jont
 * Modified _c_raise to discard the c stack before raising its exception
 *
 * Revision 1.71  1993/06/22  11:15:56  richard
 * Marked intercept frames with STACK_INTERCEPT.  See tags.h.
 *
 * Revision 1.70  1993/06/01  14:59:00  richard
 * The interception code had some strange ideas about stack frames
 * which were confusing the garbage collector.  This goes back to the
 * time when interception was always done by overwriting the three nops
 * at the start of the code vector.
 *
 * Revision 1.69  1993/05/05  14:44:16  jont
 * Modified stack unwind code to use fp instead of sp to fix problems
 * with multiple handlers at the same stack level
 *
 * Revision 1.68  1993/04/30  15:47:08  jont
 * Changed to distinguish the real base of the stack from the stack limit pointer
 *
 * Revision 1.67  1993/04/30  12:37:57  jont
 * Made stub_asm a tail
 * Redid ml_raise to stack away current handler at top of stack rather
 * than using an unchecked save. Made ml_raise_leaf do a stack overflow
 * check before opening the stack to save current handler
 *
 * Revision 1.66  1993/04/22  16:44:18  jont
 * Added leaf raise code
 *
 * Revision 1.65  1993/04/20  13:54:25  richard
 * Ripped out old tracing mechanism and installed a new one.
 *
 * Revision 1.64  1993/04/16  14:49:15  jont
 * ml_raise no longers restores the handler chain, this is now done by the ml code
 *
 * Revision 1.63  1993/03/18  10:30:15  jont
 * Fixed some minor problems with the names of the stubs
 *
 * Revision 1.62  1993/02/26  17:52:55  jont
 * Now initialises all unused registers before calling ml.
 * This may have been a source of bad values
 *
 * Revision 1.61  1993/02/10  17:48:48  jont
 * Changes for code vector reform.
 *
 * Revision 1.60  1992/12/08  11:23:21  clive
 * Changed the type of nop used for tracing to store it being moved
 * by the scheduler
 *
 * Revision 1.59  1992/11/11  16:45:48  clive
 * Added some function needed for tracing
 *
 * Revision 1.58  1992/11/05  17:58:40  richard
 * Removed debugger related stuff and replaced it with a more general
 * event handling mechanism.
 *
 * Revision 1.57  1992/09/15  11:24:49  clive
 * Added a save of floating point registers to leaf_gc
 *
 * Revision 1.56  1992/09/09  15:16:20  clive
 * The assembler stub needed to be double-word aligned
 *
 * Revision 1.55  1992/09/02  12:13:59  clive
 * A bug in the disturbance code in the region of ext0 fixed
 *
 * Revision 1.54  1992/08/18  09:01:27  clive
 * Single-stepping wasn't working around calls to C
 *
 * Revision 1.53  1992/08/11  15:37:20  clive
 * Fixed the single-step code
 *
 * Revision 1.52  1992/08/10  13:06:43  richard
 * Added floating point reservation around calls to C and the garbage collector.
 *
 * Revision 1.51  1992/08/07  13:52:48  clive
 * Changed the functionality of some of the debugger functions - added support
 * for tracing
 *
 * Revision 1.50  1992/08/03  08:25:04  richard
 * The C and assembler calling stubs are now single static code vectors.
 * Fixed unwind_stack() for resumable exceptions.
 * Added ml_trap.
 *
 * Revision 1.49  1992/07/30  17:16:45  clive
 * Some changes to the single step hook, which now passes the 'current' function
 * to the hook
 *
 * Revision 1.48  1992/07/30  17:08:37  richard
 * Took the call counting out of the stubs until I can fix it.
 *
 * Revision 1.47  1992/07/29  14:10:59  clive
 * Changes to single-step and calling of debugger now we can callml from C - so
 * errors ironed out
 *
 * Revision 1.46  1992/07/27  14:04:05  richard
 * Implemented callasm stub and c_raise.
 *
 * Revision 1.45  1992/07/22  13:39:05  clive
 * Took out ml_profile
 *
 * Revision 1.44  1992/07/21  15:31:46  richard
 * Removed redundent `flush' instructions, and implemented a
 * _flush_windows routine which can be called from C instead.
 * Moved the unwind stack macro to macros.m4s.  Altered the
 * C calling stub slightly.
 *
 * Revision 1.43  1992/07/16  16:22:29  richard
 * Implemented re-entrant ML using stack bases.
 *
 * Revision 1.42  1992/07/16  15:53:44  clive
 * Did some work on single-stepping, and corrected some bugs in
 * the interrupt handling code
 *
 * Revision 1.41  1992/07/16  10:34:20  richard
 * Added a new way of calling C, although it isn't used yet.
 *
 * Revision 1.40  1992/07/14  15:27:06  richard
 * Removed obsolete memory profiling code and profiler entry point.
 * Changed calls to GC to include the closure of the caller.
 *
 * Revision 1.39  1992/07/09  14:39:53  clive
 * Removed call debugger - now written in ML plus C
 *
 * Revision 1.38  1992/07/08  15:09:55  clive
 * Added code for manually calling the debugger
 *
 * Revision 1.37  1992/07/03  14:40:10  richard
 * Generalised the idea of a `disturbance' and changed the way that
 * interrupts are generated and handled.
 *
 * Revision 1.36  1992/06/25  14:12:05  richard
 * Added a missing stack frame in the stack extension code.
 *
 * Revision 1.35  1992/06/23  12:59:02  richard
 * Altered stack extension return code to pop out of the stack
 * block it deallocates in case it gets unmapped.
 *
 * Revision 1.34  1992/06/22  14:55:36  clive
 * More work on the debugger
 *
 * Revision 1.33  1992/06/18  11:47:51  richard
 * Changed the way that stack extension frames are marked.  Also merged
 * in some of Clive's top level handler code.
 *
 * Revision 1.32  1992/06/17  14:37:46  richard
 * Added _ml_gc_leaf entry point.
 *
 * Revision 1.31  1992/06/11  11:08:14  clive
 * First attempt at converting a user ^C into an ML interrupt Interrupt
 * Also, entry from toplevel into the ML debugger hook function
 * Code need neatening ...
 *
 * Revision 1.30  1992/05/22  11:01:15  clive
 * ml_raise was winding back too many frames at a stack extension -
 * it wound back two before testing for the required frame
 *
 * Revision 1.29  1992/05/21  16:01:51  richard
 * Changed statistics collection to use the scratch register
 * to avoid confusion.
 *
 * Revision 1.28  1992/05/15  10:29:32  clive
 * Memory profiling result in bytes - to get tagging automatically
 *
 * Revision 1.27  1992/05/14  11:37:57  clive
 * Added memory profiling
 *
 * Revision 1.26  1992/04/15  10:25:47  richard
 * Converted to use the m4 macro processor and renamed to interface.m4s.
 * Added Clive's profiler stub.
 * Moved polymorphic equality code to a separate file.
 *
 * Revision 1.26  1992/04/14  16:06:13  richard
 * Converted to use m4 macro processor and renamed to interface.m4s.
 * Added Clive's code for profiling.
 *
 * Revision 1.24  1992/04/03  10:41:14  richard
 * Moved macros to a shared file.
 *
 * Revision 1.22  1992/03/26  15:21:42  richard
 * Added new statistics gathering code.  Removed definition of STATS.
 * COLLECT_STATS and TRAP_FLUSH are now defined by the Makefile so that
 * the behaviour can easily be reconfigured.
 *
 * Revision 1.21  1992/03/25  13:28:34  richard
 * Wrote an assembler version of polymorphic equality that intercepts
 * calls to the C version.  Very fast.
 *
 * Revision 1.20  1992/03/24  15:34:06  richard
 * Rewrote virtually everything again.  There are now far fewer save and
 * restore instructions and the `ml_external' routine looks up the
 * pervasive C function directly.
 *
 * Revision 1.19	 1992/03/18  12:23:58  clive
 * Added a flush windows in ML_TO_C2T in case a garbage collection occurs
 * whilst we are inside the C (in which case we expect the registers on the
 * stack )
 *
 * Revision 1.18	 1992/02/24  10:17:21  clive
 * ML_TO_C2 and like functions were causing one extra C-stack to be allocated
 * per ML call to C - changed them to use SAVE_C_STATE_WITHOUT_SP which saves
 * the C state but doesn't save away a new sp - this was the easiest fix to the
 * problem... C cannot now be used as a coroutine as the stack is reset to where
 * it started out
 *
 * Revision 1.17	 1992/01/20  16:48:42  richard
 * Revised some of the raise code.
 * Added a macro to call C with a window flush trap in the right place
 * for the garbage collector.
 *
 * Revision 1.16	 1992/01/15  18:18:45  richard
 * Further development of _ml_raise.
 *
 * Revision 1.15	 1992/01/14  16:26:35  richard
 * Added new exception raising code, plus other minor changes.
 *
 * Revision 1.14	 1992/01/13  11:03:44  richard
 * Used macros for C calling to simplify code for several procedures, and
 * to allow correct calls (in terms of stack frames) to the garbage collector.
 * Added ml_extend.
 *
 * Revision 1.13	 1992/01/08  14:18:17  richard
 * Rewrote almost everything to remove some redundant saves and restores.
 * Introduces the C preprocessor to allow macros.
 *
*/

#include "tags.h"
#include "offsets.h"
#include "macros.h"

/* === CALL ML FROM C ===
 *
 * callml is a C-like function which allows C to invoke an ML function in
 * the manner of a coroutine.
 *
 * The C global registers are stored in the structure c_state, and the
 * ML global state is loaded.  A new ML stack frame is allocated below
 * the base pointer of the current ML stack area (pointed to by %g6).
 * The ML function is then called.  On return the stack area base
 * pointer is restored to its value on entry, the ML state is stored
 * and the C state loaded, then control returns to C.
 *
 *
 * Parameters:
 *   %o0	 Argument for the ML function -- no multiple arg calls here.
 *   %o1	 Closure of the function to call
 *   %o7	 Link register for return to C
 * Returns:
 *   %o0	 Result of the ML function
 */

	.global C_NAME(callml)

C_NAME(callml):
	sethi	%hi(C_NAME(global_state)), %o2
	or	%o2, %lo(C_NAME(global_state)), %o2
	st	%o2, [%o2 + GLOBAL_in_ML] 	! now in ML
	ld	[%o2 + GLOBAL_current_thread], %g5 ! current thread in g5
	load_ML_state_with(%g5, %o4)
	ld	[%g5+THREAD_c_sp], %o3	! record old c_state.sp in this frame
	ld	[%g5+THREAD_ml_gc_sp], %o4 ! saved ml_state.gc_sp
	ld	[%g5+THREAD_ml_sp], %o5 ! current base of the ML stack area
	st	%sp, [%g5 + THREAD_c_sp]	! Remember C sp for calls to C
	save	%o5, -0x40, %sp		! Make first ML stack frame
	clean_current_registers
	clean_windows

	/* Ultra: l0-l7 and o2-o5 are zero, i0=arg, i1=clos, i2=global,
           i3=c_sp, i4=gc_sp, i5=ml_sp, and we're about to set o0 and o1: */

	mov	%i0, %o0
	mov	%i1, %o1		! Propagate closure and arguments
	ld	[%o1-1], %g4
	jmpl	%g4+CODE_OFFSET, %o7	! Call ML
	mov	STACK_START, %i1	! (marking start of ML stack)

/* On return from ML, i2 points to global state, i3 is the c_sp, i4 is
 * the previous ml_state.sp, i5 is the previous ml_state.base */

	mov	%o0, %i0		! Propagate result
	restore				! Get back to C stack
	store_ML_state_with(%g5)
	st	%o3, [%g5+THREAD_c_sp]  ! restore c_state.sp
	st	%o4, [%g5+THREAD_ml_gc_sp]	! restore ml_state.gc_sp
	st	%o5, [%g5+THREAD_ml_sp]! restore ml_state.sp
	st	%g0, [%o2+GLOBAL_in_ML]	! Not in ML
	retl				! Return to C
	nop

/*
 * === STUBS FROM ML ===
 *
 * These are static ML code vectors which call the routine pointed to
 * by their first closure element.  The C calling stub swaps into the C
 * state before calling the function, whereas the assembler version
 * does not.
 */

	.global	C_NAME(stub_c)
	.global	C_NAME(stub_asm)
	.global	C_NAME(stubs_code_start)
	.global	C_NAME(stubs_data_start)
	.global	C_NAME(stubs_data_end)

C_NAME(stub_c):			.word internal_stub_c+POINTER
C_NAME(stub_asm):		.word internal_stub_asm+POINTER
C_NAME(stubs_code_start):	.word stubancill
C_NAME(stubs_data_start):	.word 0
C_NAME(stubs_data_end):		.word 0

/* We have to build fake ancillary information */

	.align 	8
stubancill:				! this is a pair
	.word	stubnames + PAIRPTR
	.word	stubprofiles + PAIRPTR

	.align 8
stubnames:				! this is a pair
	.word	sc_name + POINTER
	.word	sa_name + POINTER

	.align 8
stubprofiles:				! this is a pair
	.word 0
	.word 0

	.align 	8
sc_name:
	.word	((sc_name_end - sc_name - 4) << 6) | STRING
	.asciz	'stub to C'
sc_name_end:

	.align 	8
sa_name:
	.word	((sa_name_end - sa_name - 4) << 6) | STRING
	.asciz	'stub to assembler'
sa_name_end:

	.align	8
stub_code_vector:
	.word	(((stub_code_end-stub_code_vector)-4)<<6) | CODE
	.word	stubancill + PAIRPTR

	.align 8
internal_stub_c:

	.word	(internal_stub_c - stub_code_vector) << 6 | BACKPTR
	.word	STUB_ANCILL_0		! ancillary word
	store_ML_state_with(%g5)
	ld	[%g5+THREAD_c_sp], %o5	! address of last C stack frame
	st	%sp, [%g5+THREAD_ml_sp] ! Save base of ML stack area
	save	%o5, -0x78, %sp		! Switch to C stack
	st	%sp, [%g5+THREAD_ml_gc_sp]	! Save last ML frame for GC
	ld	[%g5+THREAD_global],%i2 ! global state in i2
	std	%f0, [%sp+0x58]		! Preserve non-corrupted floats
	std	%f2, [%sp+0x60]
	std	%f6, [%sp+0x70]
	ld	[%i1+3], %o1		! address of C function to call
	mov	%i0, %o0		! propogate the argument
	jmpl	%o1, %o7		! Call the C function
	st	%g0, [%i2+GLOBAL_in_ML]	! not in ML

	st	%i2, [%i2+GLOBAL_in_ML]	! back in ML
	ld	[%i2+GLOBAL_current_thread],%g5	! current thread in g5
	mov	%o0, %i0		! Propagate the result
	ldd	[%sp+0x70], %f6
	ldd	[%sp+0x60], %f2
	ldd	[%sp+0x58], %f0
	restore				! Back to ML stack
	load_ML_state_with(%g5, %o4)

	clean_windows			! Clean dirty C windows
	ultra_clean(%o4)

	/* Ultra: we have just restored to an ML frame, so ins and
           locals are GC-safe. o0=result, o1=closure, o2=global, o5=c_sp.
           o3 is unmodified since we were in ML, so it's also GC-safe. */

	retl
	nop

	.align	8
internal_stub_asm:
	.word	(internal_stub_asm - stub_code_vector) << 6 | BACKPTR
	.word	STUB_ANCILL_1		! ancilary word
	ld	[%o1+3], %g4		! address of subroutine
	jmp	%g4			! Tail to subroutine
	nop

stub_code_end:
	.align 4
	.global	C_NAME(stubs_code_end)

C_NAME(stubs_code_end):	.word stub_code_end

/* === LOOK UP A VALUE IN THE RUNTIME ENVIRONMENT ===
 *
 * Calls directly through to env_lookup() from environment.h.
 */

	.global C_NAME(ml_lookup_pervasive)

C_NAME(ml_lookup_pervasive):
	save	%sp, -0x40, %sp
	mov	STACK_C_CALL, %i1
	mov	STACK_C_CALL, %o1
	mov	%g0, %o7		! fix return address for the GC
	mov	%i0, %o0
	ML_to_C(perv_lookup)
	mov	%o0, %i0
	ret
	restore


/*
 * These used to be called from ML when a GC was required. Now we
 * cause a trap instead, so these routines call a non-returning error
 * routine which prints the name of the calling closure instead.
 *
 * See also gc_trap_entry and gc_trap_entry_leaf, also in this file.
*/

	.global C_NAME(ml_gc)
C_NAME(ml_gc):
	call	C_NAME(ml_gc_die)
	mov	%i1, %o0

	.global C_NAME(ml_gc_leaf)
C_NAME(ml_gc_leaf):
	call	C_NAME(ml_gc_leaf_die)
	mov	%o1, %o0

/* === FLUSH REGISTER WINDOWS ===
 *
 * This routine simply invokes the window flushing trap.  It is here so
 * that C can do it neatly.
 */

	.global C_NAME(flush_windows)

C_NAME(flush_windows):
	retl
	ta ST_FLUSH_WINDOWS


/* === GET CALLER'S STACK FRAME ===
 *
 * This routine returns %fp to the caller. This is used, for instance,
 * in the signal handler, which needs to update %g6 (which is not
 * saved or restored in the sigcontext, but in the frame of the
 * _sigtramp function, which calls the handler). */

	.global C_NAME(get_callers_frame)

C_NAME(get_callers_frame):
	retl
     	mov	%fp, %o0

/*
 * === STACK OVERFLOW / ASYNCHRONOUS EVENT ===
 *
 * This code is called by ML when %sp-STACK_BUFFER < %g6 (unsigned).
 * This condition is checked by ML on function entry to ensure that
 * there is enough room for a frame, and is used by the asynchronous
 * event handler to trip up ML at a `safe' moment.
 *
 * The comments here use function names as if e called f called g, 
 * and g is the disturbed function.
 *
 * g jumps here with the following parameters:
 *
 *  %o1  closure of g
 *  %o0, %o2-%o5 arguments to g
 *  %o7  link to f
 *  %g7  minimum stack requirement of g
 *       (not including safety zone of 2kb)
 *  %g4  link to continue g
 *  %g6  current stack area or -1 for asynchronous event
 */
	.global C_NAME(ml_disturbance)

C_NAME(ml_disturbance):
	save	%sp, -0x40, %sp		/* make STACK_DISTURB_EVENT frame */
	mov	%i1, %l1		/* g's closure */
	mov	STACK_DISTURB_EVENT, %i1
	mov	%g0, %o7
	ld	[%l1-PAIRPTR],%l0
	add	%l0, CODE_OFFSET, %l0	/* code address of g */
	sub	%g4, %l0, %l0		/* offset to continue g [GC-safe] */
	ld	[%g5+IMPLICIT_stack_limit], %g4	/* true stack limit */
	sub	%sp, %g7, %o0		/* trial sp value */
	cmp	%o0, %g4		/* really extend stack? */
	bgeu	check_for_events
#ifdef COLLECT_STATS
	sethi	%hi(C_NAME(stack_extension_count)), %o0
	ld	[%o0 + %lo(C_NAME(stack_extension_count))], %o1
	add	%o1, 1, %o1
	st	%o1, [%o0 + %lo(C_NAME(stack_extension_count))]
#endif COLLECT_STATS
	sub	%g4, STACK_BUFFER+DEFAULT_STACK_SIZE, %o0
	add	%g7, STACK_BUFFER+DEFAULT_STACK_SIZE, %o1
	ML_to_C (make_ml_stack)

/* now we have to move onto the new stack block. This means resetting
 * the stack limit, unwinding the DISTURB_EVENT frame and building a
 * STACK_EXTENSION frame on the new stack block */

	ld	[%o0+4], %g7		/* top of new stack block */
	add	%o0, STACK_BUFFER+DEFAULT_STACK_SIZE, %o0
	st	%o0, [%g5+IMPLICIT_stack_limit]	/* new stack limit */
	mov	%o0, %g6
	mov	%l1, %i1		/* g's closure */
	restore	%l0, 0, %g4		/* offset to continue g */
	save	%g7, -0x40, %sp		/* first frame on new block */
	mov	%i1, %l1		/* g's closure */
	mov	%g4, %l0		/* offset to continue g */
	mov	%g0, %o7
	mov	STACK_EXTENSION, %i1

check_for_events:
	ld	[%g5+IMPLICIT_interrupt], %g4	/* has there been an event? */
	or	%g4, %g6, %g4
	cmp	%g4, %g0
	bgt	call_disturbed_fn		/* if so, ... */
	nop
	ld	[%g5+IMPLICIT_stack_limit],%g6	/* ... call ev_poll */
	st	%g0, [%g5+IMPLICIT_interrupt]
	ML_to_C (ev_poll)

call_disturbed_fn:
	mov	%l1, %o1		/* g's closure */
	mov	%i0, %o0		/* g's arguments */
	mov	%i2, %o2
	mov	%i3, %o3
	mov	%i4, %o4
	ld	[%o1-PAIRPTR], %l1
	add	%l1, CODE_OFFSET, %l1	/* g's code address [GC-safe] */
	add	%l0, %l1, %l0		/* g's continuation address */
	jmpl	%l0+8, %o7		/* continue g */
	mov	%i5, %o5		/* g's last argument */

return_from_disturbed_fn:
	cmp	%i1, STACK_EXTENSION	/* did we extend the stack? */
	bne	return_to_caller	/* if so, we have to undo it */	
	mov	%o0, %i0		/* result of g */
	restore
	save	%sp, -0x40, %sp
	ld	[%g5+IMPLICIT_stack_limit], %o0
	sub	%o0, STACK_BUFFER+DEFAULT_STACK_SIZE, %o0
	ML_to_C (unmake_ml_stack)
	add	%o0, STACK_BUFFER+DEFAULT_STACK_SIZE, %o0
	st	%o0, [%g5+IMPLICIT_stack_limit]
	mov	%o0, %g6
	ld	[%g5+IMPLICIT_interrupt], %o0
	or	%g6, %o0, %g6
return_to_caller:
	jmpl	%i7+8, %g0
	restore

/*
 * === CHECK FOR AN ML EVENT ===
 *
 * We arrive here when g6 has been detected to be -1
 *
 * All registers potentially significant
 * %o7 return address
 * %i1 function closure
 */
	.global	C_NAME(ml_event_check)
C_NAME(ml_event_check):
	save	%sp, -0x40, %sp		! Create extra frame
	ld	[%g5+IMPLICIT_stack_limit], %g6	! Restore the real stack in %g6
	st	%g0, [%g5+IMPLICIT_interrupt]	! Clear interrupt slot
	mov	STACK_EVENT, %i1
	mov	STACK_EVENT, %o1
	mov	0, %o7			! Clear link register for the GC
	ML_to_C(ev_poll)
	restore
	jmp	%o7+8			! Do the rest of the disturbed function
	nop
/*
 * %o1 function closure
 * %o7 function return address
 * %g4 return address from here
 */
	.globl	C_NAME(ml_event_check_leaf)
C_NAME(ml_event_check_leaf):
	save	%sp, -0x40, %sp		! Create a frame, so %i1 = closure
	mov	%g4, %o7		! Save return address

/* Poll code */

	save	%sp, -0x40, %sp		! Create extra frame
	ld	[%g5+IMPLICIT_stack_limit], %g6 ! Restore the real stack in %g6
	st	%g0, [%g5+IMPLICIT_interrupt]	! Clear interrupt slot
	mov	STACK_EVENT, %i1
	mov	STACK_EVENT, %o1
	mov	0, %o7			! Clear link register for the GC
	ML_to_C(ev_poll)
	restore
	jmp	%o7+8			! Do the rest of the disturbed function
	restore
	
/* === RAISE AN EXCEPTION FROM C === */
/* This is an entry point to ml_raise which may be called from C. */

	.global C_NAME(c_raise)

C_NAME(c_raise):

/*
 * We wind back the c stack explicitly to the previous ml_state.sp:
 */
	sethi	%hi(C_NAME(global_state)), %o4
	or	%o4, %lo(C_NAME(global_state)), %o4
	ld	[%o4 + GLOBAL_current_thread], %g5
	load_ML_state_with(%g5, %o4)
	ld	[%g5+THREAD_ml_gc_sp], %g4	! saved ml_state.gc_sp
	mov	%o0, %i0		! Propagate exception argument
c_raise10:
	restore				! Pop a frame
	cmp	%sp, %g4
	bne	c_raise10		! Loop until back to ml stack
	mov	%o0, %i0		! Propagate exception argument
	restore				! One more for luck (one beyond ml_state.sp)
	clean_windows

/* Ultra: we've just restored into an ML frame, so everything is GC-safe */

	mov	STACK_C_RAISE, %o1	! Mark this frame

	save	%sp, -0x40, %sp		! Make first ML stack frame below the base
	mov	%i0, %o0		! Propagate exception
        ld      [%g5+THREAD_global],%o2 ! global state in o2
        st      %o2, [%o2+GLOBAL_in_ML] ! back in ML
	! \/\/ fall through \/\/

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
 * Handler record format:
 *   -1	Previous handler
 *    3	Frame pointer of creator
 *    7	Handler function closure
 *   11	Offset within creator of continuation code
 *
 * Parameters:
 *   %o0	 The exception packet to raise
 *   %g3	 Exception handler record
 *
 * Warning. This code assumes that all procedures containing handler
 * continuations are non-leaf. This is currently true because setting
 * up a handler calls adr, which forces non-leaf because it corrupts o7.
 * However, should we produce a leaf adr by preserving o7 in g4, then
 * all hell will break loose.
 *
 */
	.global C_NAME(ml_raise)
	.global C_NAME(ml_raise_leaf)

C_NAME(ml_raise_leaf):
	cmp	%i1, STACK_RAISE
	beq,a	raise_skip
	mov	%o0, %i0
	
C_NAME(ml_raise):
	mov	STACK_RAISE, %o1	/* This frame's closure	*/
	save	%sp, -0x40, %sp		/* New frame */

raise_skip:
#ifdef COLLECT_STATS
	sethi	%hi(C_NAME(raise_count)), %o5
	or	%o5, %lo(C_NAME(raise_count)), %o5
	ld	[%o5], %g4		/* Increment raise count */
	add	%g4, 1, %g4		/* Using o5 is harmless */
	st	%g4, [%o5]
#endif
	mov	%g3, %l0		/* Remember current %g3 */
	ld	[%g3+7], %o1		/* Get handler closure */
	mov	%i0, %o0		/* Propagate exception packet */
	ld	[%o1-1], %g4
	jmpl	%g4+CODE_OFFSET, %o7	! The call to the handler ...
	ld	[%g3-1], %g3		! ... with previous handler restored
	mov	%l0, %g3		/* Reinstate handler */
	mov	%o0, %i0		/* Propagate exception result */
	restore				/* Throw away dummy frame */
	ld	[%g3+3], %g4		/* Load sp of creator function */
	unwind_stack(raise)		! Wind back to it, propagating result
unwound:
	ld	[%g3+11], %g4		! Fetch the continuation offset.
	srl	%g4, 2, %g4		! Convert to untagged int
	ld	[%i1-1], %o1		! Get address of creator function
	add	%g4, %o1, %g4		! Tagged address of continuation
	jmp	%g4+CODE_OFFSET
	nop

/* === CAUSE A FATAL ERROR ===
 *
 * Expects an error format string to follow the call instruction and
 * delay slot.
 */

error:	add	%o7, 8, %o0
	ML_to_C(error)
	ta	ST_BREAKPOINT


/*
 * === CODE VECTOR REPLACEMENT AND INTERCEPTION ===
 *
 *
 * When compiled for debugging, code vectors contain a sequence of
 * three nop operations which can be replaced with code to intercept or
 * replace the flow of control.  This is used to implement tracing,
 * profiling, etc.
 *
 *  ml_intercept (ml_intercept_leaf) is jumped to by the instructions
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
 *    %o0	parameter } of intercepted function
 *    %o1	closure   }
 *
 * Return address is in %o7, or %g4 for leaf versions.
 *
 */
	.global	C_NAME(ml_replace)
	.global	C_NAME(ml_replace_leaf)
	.global C_NAME(ml_intercept)
	.global C_NAME(ml_intercept_leaf)

C_NAME(ml_replace):
	mov	%sp, %o0		! Pass frame to replace()
	mov	STACK_INTERCEPT, %o1	! for backtrace
	ML_to_C(replace)
	ret
	restore				! Pop callers frame

C_NAME(ml_replace_leaf):
	save	%sp, -0x40, %sp		! Dummy frame for function
	mov	%sp, %o0		! Pass frame to replace()
	mov	STACK_INTERCEPT, %o1	! for backtrace
	ML_to_C(replace)
	ret				! Return to function caller
	restore				! Throw away dummy frame

C_NAME(ml_intercept):
	save	%sp, -0x40, %sp		! Local frame
	mov	STACK_INTERCEPT, %i1	! Mark it
	mov	STACK_INTERCEPT, %o1	! for backtrace
	mov	%g0, %o7		! Clear link register for the GC
	mov	%fp, %o0		! Pass frame to intercept()
	ML_to_C(intercept)
	ret				! Return to intercepted code
	restore

C_NAME(ml_intercept_leaf):
	save	%sp, -0x40, %sp		! Dummy frame for function
	mov	%g4, %o7		! Pretend it called here
	save	%sp, -0x40, %sp		! Local frame
	mov	STACK_INTERCEPT, %i1	! Mark it
	mov	STACK_INTERCEPT, %o1	! for backtrace
	mov	%g0, %o7		! Clear link register for the GC
	mov	%fp, %o0		! Pass frame to intercept()
	ML_to_C(intercept)
	restore
	jmpl	%o7+8, %g0		! Back to caller...
	restore				! ...removing its frame

/* == Replacement code ==
 *
 * These are sections of code which are inserted at the start of a code
 * vector and altered to implement interception.  They are
 * INTERCEPT_LENGTH words long (from tags.h); three in the SPARC case.
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
	ld	[%g5+IMPLICIT_replace], %g4
	jmpl	%g4, %o7
	nop

C_NAME(ml_replace_on_leaf):
	ld	[%g5+IMPLICIT_replace_leaf], %g4
	jmpl	%g4, %g4
	nop

C_NAME(ml_intercept_on):
	ld	[%g5+IMPLICIT_intercept], %g4
	jmpl	%g4, %o7
	nop

C_NAME(ml_intercept_on_leaf):
	ld	[%g5+IMPLICIT_intercept_leaf], %g4
	jmpl	%g4, %g4
	nop

C_NAME(ml_nop):
	sethi	0, %g0		! These nops are used in mach_cg so that
	sethi	0, %g0		! the scheduler does not move them.
	sethi	0, %g0

/* This generates a debugger trap. */

	.global C_NAME(generate_debugger_trap)

C_NAME(generate_debugger_trap):
	ta	ST_BREAKPOINT
	nop

/* == GARBAGE COLLECTION ENTRY POINTS ==

 * When a garbage collection is required, we cause a trap. See
 * signals.c for the trap handler, which sets up some state on the C
 * side before 'returning' to either gc_trap_entry or
 * gc_trap_entry_leaf:

	gc_trap_return_address now contains the address to which we
		should return after the GC.

	gc_trap_ret_code points to code which tags the destination
		register and returns (see gc_trap_ret_template, below).

	gc_trap_bytes contains the number of bytes requested, or -1 if
		the number is in register g4.

 * The allocation attempt has not yet modified any registers.

 * We have to fake an entry to the portable function gc(), the
 * arguments being the number of bytes requested and the closure of
 * the calling function. On entry to gc(), ml_state.heap_start should
 * point to the current allocation point plus the number of requested
 * bytes.
 *
 * We have to be careful about the closure values in any frames which
 * we push, so as not to confuse the profiler.
 */

	.global C_NAME(gc_trap_entry)

C_NAME(gc_trap_entry):

	mov	%i1, %g1			/* save closure */
	save	%sp, -64, %sp			/* make ML stack frame */

/* get return address into i7 so the stack frame looks normal */

	mov	%i7, %l0			/* Preserve link reg in l0 */
	sethi	%hi(C_NAME(gc_trap_return_address)), %o0
	or	%o0, %lo(C_NAME(gc_trap_return_address)), %o0
	ld	[%o0],%i7

/* get number of bytes requested */

	sethi	%hi(C_NAME(gc_trap_bytes)), %o0
	or	%o0, %lo(C_NAME(gc_trap_bytes)), %o0
	ld	[%o0], %o0			/* get 'bytes requested' */
	addcc	%o0, 1, %g0			/* is it -1? */
	beq,a	got_bytes
	mov	%g4, %o0			/* if so, use %g4 instead */
got_bytes:
	add	%g2, %o0, %g2			/* add to GC_HEAP_START */

/* clean up closures so the profiler doesn't get confused */

	mov	%i1, %l1			/* preserve closure in l1 */
	mov	%g0, %i1			/* then clear it */
	mov	%g0, %o1			/* clear this one too */

	mov	%g1, %o2			/* closure for arg to gc() */
	store_ML_state_with(%g5)		/* save ML state */
	st	%sp, [%g5+THREAD_ml_gc_sp]	/* Save last ML frame for GC */
	st	%sp, [%g5+THREAD_ml_sp]		/* Save base of ML stack */
	ld	[%g5+THREAD_c_sp], %o4
	ld	[%g5+THREAD_global], %o5
	save	%o4, -216, %sp			/* Switch to C stack */
	store_fps(%sp+88)			/* save FP registers */
	mov	%i0, %o0			/* arg 0 is number of bytes */
	mov	%i2, %o1			/* arg 1 is closure */
	call	C_NAME(gc)			/* call GC ... */
	st	%g0, [%i5+GLOBAL_in_ML]		/* not in ML */

/* On exit from gc(), ml_state.heap_start and ml_state.heap_limit have
 * been updated to reflect the new creation space, and ml_state.global
 * contains the address at which bytes have been allocated. */

/* We now have a tricky sequence, split between here and
 * gc_trap_ret_template (below) (which has been copied to the data
 * segment and which is pointed to by gc_trap_ret_code) . We need to
 * enter that code with one restore still to do and with g1 and g4 set
 * in particular ways:
*/

	st	%i5, [%i5+GLOBAL_in_ML]		/* back in ML */
	ld	[%i5+GLOBAL_current_thread], %g5 /* get current thread */
	load_fps(%sp+88)
	load_ML_state_with(%g5, %o4)
	restore
	clean_windows

/* Ultra: We've just restored into the frame which we created when
 * entering gc_trap_entry. ins are the outs from ML, l2-l7 and o3 are
 * still fresh, l0=old i7, l1=old i1, o0=object size, i1=o1=0, o2=closure,
 * o4=c_sp, o5=global */

	sethi	%hi(C_NAME(gc_trap_ret_code)), %g1
	or	%g1, %lo(C_NAME(gc_trap_ret_code)), %g1
	ld	[%g1], %g1			/* code address in g1 */
	mov	%i7, %g4			/* return address in g4 */
	mov	%l1, %i1			/* restore i1 */
	jmpl	%g1, %g0
	mov	%l0, %i7			/* restore link register */

/* -------- end of gc_trap_entry ----------- */

/* Code to return to ML after a GC. Note that this code is copied into
  the data segment and the instruction at gc_trap_ret_template_overwrite
  is overwritten with a result-tagging instruction, which tags
  g1. This code is called from gc_trap_entry, above.

  We enter this code with these restored g registers

	%g7 = the restored g7 value 
	%g6 = the stack limit
	%g5 = the thread state
	%g3 = the current handler
	%g2 = the GC base

  and these which still need to be restored:

	%g4 = the return address,
	%g1 = this code

  We need to get the GC return value from the thread state into g1, do
  a restore, do the tagging operation, load g1 from the thread state,
  recompute the alloc test from the alloc limit, and return to
  g4. This sequence is carefully chosen to make sure we get back to ML
  with all the registers correctly set (except g4).

  The computation of g1 is (0x7ffffffc - (limit - alloc)), 
  */

	.global C_NAME(gc_trap_ret_template)
	.global C_NAME(gc_trap_ret_template_end)
	.global C_NAME(gc_trap_ret_template_overwrite)

C_NAME(gc_trap_ret_template):
	ld	[%g5+THREAD_ml_global], %g1	/* get GC return value */
	restore
C_NAME(gc_trap_ret_template_overwrite):
	nop				/* this instr will be overwritten */
	sethi	%hi(0x7ffffffc), %g1
	or	%g1, %lo(0x7ffffffc), %g1
	ld	[%g5+IMPLICIT_gc_limit],%g2
	sub	%g1, %g2, %g1			/* g1 = 0x7ffffffc - limit */
	ld	[%g5+IMPLICIT_gc_base],%g2	/* g2 = alloc, which we keep */
	jmpl	%g4+8, %g0
	add	%g1, %g2, %g1			/* g1 += alloc */
C_NAME(gc_trap_ret_template_end):
	nop

/* gc_trap_entry_leaf is almost identical to gc_trap_entry
  (above). This is entered on return from the trap handler after an
  allocation trap in a leaf function. */

	.global C_NAME(gc_trap_entry_leaf)

C_NAME(gc_trap_entry_leaf):

	save	%sp, -64, %sp			/* make ML stack frame */
	mov	%i1, %o2			/* save closure for gc arg */
	mov	%g0, %o1			/* clear clos for profiler */

/* get return address into o7 so the stack frame looks normal */

	sethi	%hi(C_NAME(gc_trap_return_address)), %o0
	or	%o0, %lo(C_NAME(gc_trap_return_address)), %o0
	ld	[%o0],%o7

/* get number of bytes requested */

	sethi	%hi(C_NAME(gc_trap_bytes)), %o0
	or	%o0, %lo(C_NAME(gc_trap_bytes)), %o0
	ld	[%o0], %o0			/* get 'bytes requested' */
	addcc	%o0, 1, %g0			/* is it -1? */
	beq,a	leaf_got_bytes
	mov	%g4, %o0			/* if so, use %g4 instead */
leaf_got_bytes:
	add	%g2, %o0, %g2			/* add to GC_HEAP_START */

	store_ML_state_with(%g5)		/* save ML state */
	st	%sp, [%g5+THREAD_ml_sp]		/* Save base of ML stack */
	ld	[%g5+THREAD_global], %o5	/* o5 = global_state */
	ld	[%g5+THREAD_c_sp], %o4
	save	%o4, -216, %sp			/* Switch to C stack */
	st	%sp, [%g5+THREAD_ml_gc_sp]	/* Save last ML frame for GC */
	store_fps(%sp+88)			/* save FP registers */
	mov	%i0, %o0			/* arg 0 is number of bytes */
	mov	%i2, %o1			/* arg 1 is closure */
	call	C_NAME(gc)			/* call GC */
	st	%g0, [%i5+GLOBAL_in_ML]		/* not in ML */

	st	%i5, [%i5+GLOBAL_in_ML]		/* back in ML */
	ld	[%i5+GLOBAL_current_thread],%g5
	load_fps(%sp+88)
	load_ML_state_with(%g5, %o4)
	restore
	clean_windows

/* Ultra: ins are the outs from ML, locals and o3 are fresh,
 * o0=request size, o1=0, o2=closure, o4=c_sp, o5=global. */

	sethi	%hi(C_NAME(gc_trap_ret_leaf_code)), %g1
	or	%g1, %lo(C_NAME(gc_trap_ret_leaf_code)), %g1
	ld	[%g1], %g1			/* code address in g1 */
	jmpl	%g1, %g0
	mov	%o7, %g4			/* return address in g4 */

/* Code to return to an ML leaf procedure after GC. As for
  gc_trap_ret_template (above). Actually these two routines are
  identical now; they are distinct in case we want to change one of
  them later. */

	.global C_NAME(gc_trap_ret_leaf_template)
	.global C_NAME(gc_trap_ret_leaf_template_end)
	.global C_NAME(gc_trap_ret_leaf_template_overwrite)

C_NAME(gc_trap_ret_leaf_template):
	ld	[%g5+THREAD_ml_global], %g1	/* get GC return value */
	restore
C_NAME(gc_trap_ret_leaf_template_overwrite):
	nop				/* this instr will be overwritten */
	sethi	%hi(0x7ffffffc), %g1
	or	%g1, %lo(0x7ffffffc), %g1
	ld	[%g5+IMPLICIT_gc_limit],%g2
	sub	%g1, %g2, %g1			/* g1 = 0x7ffffffc - limit */
	ld	[%g5+IMPLICIT_gc_base],%g2	/* g2 = alloc, which we keep */
	jmpl	%g4+8, %g0
	add	%g1, %g2, %g1			/* g1 += alloc */
C_NAME(gc_trap_ret_leaf_template_end):
	nop

/* Space profiling. When space profiling is turned on, each
3-instruction allocation sequence of interest is replaced with one of
the following sequences:

1. non-leaf, small static size

	jmpl	%g5+IMPLICIT_profile_alloc, %g5
	li	%g4, <size>
	add	%g4, <tag>, <result>

2. non-leaf, large or dynamic size (in g4)

	jmpl	%g5+IMPLICIT_profile_alloc, %g5
	nop
	add	%g4, <tag>, <result>

3. leaf, small static size

	jmpl	%g5+IMPLICIT_profile_alloc_leaf, %g5
	li	%g4, <size>
	or	%g4, <tag>, <result>

4. leaf, large or dynamic size (in g4)

	jmpl	%g5+IMPLICIT_profile_alloc_leaf, %g5
	nop
	or	%g4, <tag>, <result>

On the implicit vector (i.e. every thread state) we place a pair of
three-instruction stubs: */

	.global	C_NAME(implicit_profile_alloc_code)
	.global	C_NAME(implicit_profile_alloc_code_end)

C_NAME(implicit_profile_alloc_code):
	sethi	%hi(C_NAME(ml_profile_alloc)), %g1
	jmpl	%g1+%lo(C_NAME(ml_profile_alloc)),%g0
	nop
	sethi	%hi(C_NAME(ml_profile_alloc_leaf)), %g1
	jmpl	%g1+%lo(C_NAME(ml_profile_alloc_leaf)),%g0
	nop
C_NAME(implicit_profile_alloc_code_end):
	nop

/*
This gets us to these two routines with the following 'arguments':

	g5 is the continuation address
	g4 is the amount to allocate
	g1 is garbage

and the following required 'result':

	g4 is the allocated object

We have to be careful about what we put in the closure (i1) and link
(i7) registers in any frame, because when a GC occurs the link slots
on the stack are fixed up according to the code address in the
caller's closure (found in the caller's frame). So our link back to
the allocating function should go in the link slot of the first frame
which we allocate (so that the fix happens correctly), and our own
link slots should not look like link slots (i.e. should not be
pointers into fromspace). Our own closure slots should not look like
closures (i.e. should be special values) */

	.global C_NAME(ml_profile_alloc)

C_NAME(ml_profile_alloc):

/* Enter and set up the frame as if it were a regular ML frame */

	mov	%i1, %g1		/* save allocator's closure ...  */
	save	%sp, -64, %sp
	mov	%g1, %o0		/* ... in o0 */
	mov	%i1, %l1		/* save allocator's o1 in l1 */
	mov	%i7, %l2		/* save allocator's o7 in l2 */

	mov	STACK_SPACE_PROFILE, %i1 /* set closure to special value */
	mov	%g5, %i7		/* set return address in case we GC */

/* Restore g1 and g5 from the thread state */

	sethi	%hi(C_NAME(global_state)), %o2
	or	%o2, %lo(C_NAME(global_state)), %o2
	ld	[%o2 + GLOBAL_current_thread], %g5	/* restore g5 */
	ld	[%g5 + IMPLICIT_gc_limit], %o3
	sethi	%hi(0x7ffffffc), %o4
	or	%o4, %lo(0x7ffffffc), %o4
	sub	%o4, %o3, %o4
	add	%o4, %g2, %g1		/* g1 = 0x7ffffffc-(limit-g2) */

/* do the allocation (non-leaf) */

	taddcctv %g1, %g4, %g1		/* allocation sequence */
	add	%g2, 0, %o3		/* result in o3 (untagged) */
	add	%g2, %g4, %g2
	mov	%o3, %g4		/* result in g4 */

/* write the heap profile info */

	ld	[%g5 + THREAD_ml_profile], %o4	/* load heap profile pointer */
	st	%o0, [%o4]		/* first word is the closure */
	st	%g4, [%o4+4]		/* second word is the alloc ptr */
	add	%o4, 8, %o4		/* inc heap profile pointer */
	st	%o4, [%g5 + THREAD_ml_profile]		/* write it back */

/* restore the allocator's stack frame and return */
	mov	%l1, %i1
	jmpl	%i7+8, %g0		/* return */
	restore	%l2, 0, %o7		/* restore allocator's o1 */


	.global C_NAME(ml_profile_alloc_leaf)

C_NAME(ml_profile_alloc_leaf):

/* Enter and set up the frame */

	save	%sp, -64, %sp
	mov	STACK_SPACE_PROFILE, %o1 /* set closure to a special value */
	mov	%g5, %o7		/* set return address in case we GC */

/* restore g5 and g1 */

	sethi	%hi(C_NAME(global_state)), %o2
	or	%o2, %lo(C_NAME(global_state)), %o2
	ld	[%o2 + GLOBAL_current_thread], %g5	/* restore g5 */
	ld	[%g5 + IMPLICIT_gc_limit], %o3
	sethi	%hi(0x7ffffffc), %o4
	or	%o4, %lo(0x7ffffffc), %o4
	sub	%o4, %o3, %o4
	add	%o4, %g2, %g1		/* g1 = 0x7ffffffc-(limit-g2) */

/* allocate */

	taddcctv %g1, %g4, %g1		/* allocation sequence */
	or	%g2, 0, %o3		/* result in o3 (untagged) */
	add	%g2, %g4, %g2
	mov	%o3, %g4		/* and then in g4 */

/* write the heap profile info */

	ld	[%g5 + THREAD_ml_profile], %o4	/* load heap profile pointer */
	st	%i1, [%o4]		/* first word is the closure */
	st	%g4, [%o4+4]		/* second word is the alloc ptr */
	add	%o4, 8, %o4		/* inc heap profile pointer */
	st	%o4, [%g5 + THREAD_ml_profile]		/* write it back */

/* restore the stack frame and return */

	jmpl	%o7+8, %g0		/* return */
	restore

	.global C_NAME(switch_to_thread)

C_NAME(switch_to_thread):
	save	%sp, -64, %sp

	add	%i7, 8, %i7			/* compute the pc = lr+8 */
	st	%i6, [%i0+THREAD_c_tsp]		/* save the old thread's sp */
	st	%i7, [%i0+THREAD_c_pc]		/* save the old thread's pc */

/* we cause a trap, flushing windows, so that future restores will be
 * from the new thread's stack. */

	ta	ST_FLUSH_WINDOWS
	ld	[%i1+THREAD_c_pc], %i7		/* new 'return address' */
	ld	[%i1+THREAD_c_tsp], %i6		/* new fp */
	jmpl	%i7, %g0
	restore

#ifdef COLLECT_STATS
	.global C_NAME(raise_count)
	.global C_NAME(stack_extension_count)
	.data
	.align 2
C_NAME(raise_count):
	.word 0
C_NAME(stack_extension_count):
	.word 0
#endif
