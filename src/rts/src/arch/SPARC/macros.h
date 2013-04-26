/*
 * ==== ML TO C INTERFACE MACROS ====
 *
 * Copyright (C) 1992 Harlequin Ltd.
 *
 * Description
 * -----------
 * These macros are used by other SPARC assembly language routines in
 * the ML to C interface.  They deal with various conventions between
 * the C runtime system and ML.
 *
 * Notes
 * -----
 * This file must be run through the m4 macro processor to produce an
 * assembler file.
 *
 * Revision Log
 * ------------
 * $Log: macros.h,v $
 * Revision 1.8  1997/02/06 11:41:53  nickb
 * The ST_CLEAN_WINDOWS trap semantics are subtly different on UltraSPARCs. The
 * effect is that the registers which are current at the time of the trap may
 * reappear in a later register window. So whenever we invoke it, we have to
 * ensure that the current registers (ins, locals, and outs) are GC-safe.
 *
 * Revision 1.7  1996/10/31  17:21:35  nickb
 * Exchange ml_state.base and ml_state.sp, to be consistent with other platforms.
 *
 * Revision 1.6  1995/09/06  15:22:33  nickb
 * Change to c_sp protocol.
 *
 * Revision 1.5  1995/03/15  17:21:40  nickb
 * Add threads system.
 *
 * Revision 1.4  1994/07/22  14:31:10  nickh
 * Add fiddles with heap_limit field in ml_state.
 *
 * Revision 1.3  1994/07/06  13:30:52  nickh
 * Asm and C name prefixes differ according to OS.
 *
 * Revision 1.2  1994/06/09  14:30:20  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:54:50  nickh
 * new file
 *
 * Revision 1.16  1994/03/09  13:46:14  jont
 * Removed loading and storing of globals on entry/exit to C.
 * We still have to restore/save the stack pointer though.
 *
 * Revision 1.15  1993/02/26  17:52:31  jont
 * Added a macro to initialise all unused registers before calling ml
 *
 * Revision 1.14  1992/10/23  11:29:25  richard
 * Shortened some long names.  Changed event handling
 * stuff.
 *
 * Revision 1.13  1992/09/15  11:20:54  clive
 * Added macros to load and save floating point registers
 *
 * Revision 1.12  1992/07/31  08:37:03  richard
 * Removed redundant declaration of EVAC.
 *
 * Revision 1.11  1992/07/29  13:33:02  clive
 * Changes to single-step and calling of debugger now we can callml from C - so
 * errors ironed out
 *
 * Revision 1.10  1992/07/21  15:48:27  richard
 * Moved unwind_stack here from interface.m4s.  It now calls C only
 * once to unwind stack extension areas, removing the need to
 * recognise particular stack frames and thus allowing it to traverse
 * C stack.
 *
 * Revision 1.9  1992/07/16  16:31:10  richard
 * Implemented re-entrant ML.
 *
 * Revision 1.8  1992/07/16  10:58:47  clive
 * Removed load_allocation_details which is no longer needed
 *
 * Revision 1.7  1992/07/15  11:16:31  richard
 * offsets.h is now included and used.
 *
 * Revision 1.6  1992/07/03  09:55:46  richard
 * Changed the way thay interrupts are generated and handled.
 *
 * Revision 1.5  1992/06/22  15:24:32  clive
 * Wrote a macro to detect waiting interrupts, which could not be handled before as we were in C
 *
 * Revision 1.4  1992/05/15  10:31:55  clive
 * Memory profiling result in bytes - to get tagging automatically
 *
 * Revision 1.3  1992/05/08  17:14:49  clive
 * Added memory profiling
 *
 * Revision 1.2  1992/04/15  10:18:30  richard
 * Converted to use the m4 macro processor and renamed to macros.m4s.
 *
 * Revision 1.2  1992/04/14  16:35:05  richard
 * Converted to use m4 macro processor and renamed to macros.m4s.
 *
 * Revision 1.1  1992/04/02  09:45:08  richard
 * Initial revision
 */

#include "offsets.h"
#include "asm_offsets.h"
#include "naming.h"

/* we can't get these from an include file because under SunOS
 * they are in /usr/include/machine/trap.h and under Solaris they are in
 * /usr/include/sys/trap.h */

#define ST_BREAKPOINT 1
#define ST_FLUSH_WINDOWS 3
#define ST_CLEAN_WINDOWS 4

/* ML boolean values; these must agree with those defined in values.h */

#define TRUE	4
#define FALSE	0

/* Clean register windows */

#define	clean_windows    ta ST_CLEAN_WINDOWS

/* Clean the registers in the current window */

#define clean_current_registers		\
	mov	%g0,	%l0	;	\
	mov	%g0,	%l1	;	\
	mov	%g0,	%l2	;	\
	mov	%g0,	%l3	;	\
	mov	%g0,	%l4	;	\
	mov	%g0,	%l5	;	\
	mov	%g0,	%l6	;	\
	mov	%g0,	%l7	;	\
	mov	%g0,	%o2	;	\
	mov	%g0,	%o3	;	\
	mov	%g0,	%o4	;	\
	mov	%g0,	%o5

/* Saves g3 (handler), g4 (scratch), g7 (general register), g2
 * (allocation point) in the ML state of the current thread, offset
 * from the current thread register (given in the argument). */

#define store_ML_state_with(use)				\
	st	%g2, [use + IMPLICIT_gc_base] ;			\
	st	%g3, [use + IMPLICIT_handler] ;			\
	st	%g4, [use + THREAD_ml_global] ;			\
	st	%g7, [use + THREAD_ml_g7] ;

/* Loads the global registers g1, g2, g3, g4, g6, g7 from the ML state
 * of the current thread, offset from the current thread register
 * (given in the first argument). The stack limit register %g6 is ORed
 * with the interrupt stack slot in the current implicit vector, which
 * is left in the third arg */

/* Note the fiddling with g1/g2/g4 here. This is to make sure that,
   while in C, GC_HEAP_LIMIT points to the limit of the creation
   space, but while in ML, %g1 contains 0x7ffffffc - (limit-alloc). */

#define load_ML_state_with(use, intreg)				\
	ld	[use + IMPLICIT_gc_limit], %g1 ;		\
	ld	[use + IMPLICIT_gc_base], %g2 ;			\
								\
	/* set limit register g1 for trapping GC entry */	\
								\
	sethi	%hi(0x7ffffffc), %g4	;			\
	or	%g4, %lo(0x7ffffffc), %g4	;		\
	sub	%g4, %g1, %g1		;			\
	add	%g1, %g2, %g1		;			\
								\
	ld	[use + IMPLICIT_handler], %g3 ;			\
	ld	[use + THREAD_ml_global], %g4 ;			\
	ld	[use + IMPLICIT_stack_limit], %g6 ;		\
	ld	[use + THREAD_ml_g7], %g7 ;			\
	ld	[use + IMPLICIT_interrupt], intreg ;		\
	or	%g6, intreg, %g6


/* On UltraSPARC, we have to clean some registers when we do a
 * clean_windows trap. We use this macro, so that if we want to
 * conditionalize these cleans (i.e. build separate runtimes for
 * UltraSPARC and SPARC), we can do so trivially here */

#define ultra_clean(register)	mov	%g0, register

/* Call C from ML :
 * Saves the ML state and restore the C state, then calls the
 * function, propagating registers %o0 to %o2 as arguments for
 * C.	 The C return value is returned in %o0. */

/* Note that all registers must be GC-safe when ML_to_C is invoked */

#define ML_to_C(what)							\
	store_ML_state_with(%g5)	;				\
	st	%sp, [%g5+THREAD_ml_sp] ; /* Save ML stack base */	\
	ld	[%g5 + THREAD_c_sp], %o5; /* Fetch the previous C sp */	\
	save	%o5, -88, %sp		; /* Make a C stack frame */    \
	st	%sp, [%g5+THREAD_ml_gc_sp] ; /* Save topmost GCable sp */  \
	ld	[%g5+THREAD_global], %i3 ; /* get the global state */	\
	mov	%i0, %o0		; /* Propagate arguments     */	\
	mov	%i1, %o1		;				\
	mov	%i2, %o2		;				\
	call	C_NAME(what)		; /* Call function	     */	\
	st	%g0, [%i3 +GLOBAL_in_ML]; /* Not in ML ... */		\
									\
	st	%i3, [%i3 +GLOBAL_in_ML]; /* ... Back in ML */		\
	ld	[%i3 +GLOBAL_current_thread], %g5 ; /* current thread */ \
	mov	%o0, %i0		; /* Propagate result	     */	\
	load_ML_state_with(%g5,%o4)	;				\
	restore	%g0, 0, %g0		; /* Return to ML stack	     */	\
	clean_windows			; /* Clean the register windows */ \
	ultra_clean(%o4)		; /* clean %o4 */

/* Ultra: ins, locals, o1 and o2 are as they were when ML_to_C was
   invoked, o0=result, o3=global, o5=c_sp. */

/* Unwind stack to a particular point
 *
 * The ML stack is unwound by repeatedly restoring register windows
 * until %sp = %g4. In the meantime, if we pass a frame with %fp =
 * c_sp, we set c_sp to %i3. The argument is a label prefix. */

#define unwind_stack(label)						\
label ## unwind:							\
	ld	[%g5 + THREAD_c_sp], %g7 ; /* cache c_sp in a register */\
	ba	label ## start	;					\
	cmp	%fp, %g7	;	/*is this the c_sp frame ? */	\
label ## loop:								\
        restore			;					\
	cmp	%fp, %g7	;	/*is this the c_sp frame ? */	\
label ## start:								\
	beq,a	label ## not_c_sp;					\
	mov	%i3, %g7	;	/* if so, reload c_sp from %i3 */\
label ## not_c_sp:							\
	cmp	%sp, %g4	;	/* Is it the final frame? */	\
	bne,a	label ## loop	;	/* if not, go around */		\
	mov	%o0, %i0	;	/* Propagate handler result */  \
	st	%g7, [%g5 + THREAD_c_sp] ; /* save c_sp back */		\
	save	%sp, -0x40, %sp	;					\
	mov	%fp, %o0	;					\
	ML_to_C(unwind_stack)	;	/* Unwind stack extensions */   \
	addcc	%g6, 1, %g0	;	/* Is an event flagged? */	\
	beq,a	label ## exit	;	/* Finished if so. */		\
	restore			;					\
	ld	[%g5+IMPLICIT_stack_limit], %g6 ; /* Install new stack area */\
	restore			;					\
label ## exit:

/* Save all the FP's away. The arg is a register pointing to the save
 * area (size 128). */

#define store_fps(where)			\
	std	%f0,  [where]		;	\
	std	%f2,  [where+8]		;	\
	std	%f4,  [where+16]	;	\
	std	%f6,  [where+24]	;	\
	std	%f8,  [where+32]	;	\
	std	%f10, [where+40]	;	\
	std	%f12, [where+48]	;	\
	std	%f14, [where+56]	;	\
	std	%f16, [where+64]	;	\
	std	%f18, [where+72]	;	\
	std	%f20, [where+80]	;	\
	std	%f22, [where+88]	;	\
	std	%f24, [where+96]	;	\
	std	%f26, [where+104]	;	\
	std	%f28, [where+112]	;	\
	std	%f30, [where+120]

/* Load the FPs. The arg is a register pointing to the saved values */

#define load_fps(from_where)			\
	ldd	[from_where],     %f0	;	\
	ldd	[from_where+8],   %f2	;	\
	ldd	[from_where+16],  %f4	;	\
	ldd	[from_where+24],  %f6	;	\
	ldd	[from_where+32],  %f8	;	\
	ldd	[from_where+40],  %f10	;	\
	ldd	[from_where+48],  %f12	;	\
	ldd	[from_where+56],  %f14	;	\
	ldd	[from_where+64],  %f16	;	\
	ldd	[from_where+72],  %f18	;	\
	ldd	[from_where+80],  %f20	;	\
	ldd	[from_where+88],  %f22	;	\
	ldd	[from_where+96],  %f24	;	\
	ldd	[from_where+104], %f26	;	\
	ldd	[from_where+112], %f28	;	\
	ldd	[from_where+120], %f30
