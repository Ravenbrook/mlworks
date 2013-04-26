/* Copyright (C) 1996 Harlequin Ltd.
 * 
 * Solaris/UltraSPARC compatibility check. Allows us to exit with
 * a clean message on broken platforms, rather than a messy SEGV.
 * 
 * $Log: check_windows.S,v $
 * Revision 1.2  1997/02/06 11:41:49  nickb
 * Change to deal with new trap handler on UltraSPARCs.
 *
# Revision 1.1  1996/10/14  14:17:36  nickb
# new unit
# Register window cleaning trap incompatible between SPARC and UltraSPARC
# platforms.
#
 */

#include "naming.h"
#include "macros.h"

/* check_windows() dirties a register window, then does a clean_windows trap,
 * then SAVEs up to 16 windows. It checks in each
 * window whether the new window is dirty (l0-l7, o0-o5). If it is, it
 * returns the ORed-together value. Otherwise, it returns zero, */
	
.global	C_NAME(check_windows)

C_NAME(check_windows):
	save	%sp, -64, %sp
	mov	0xf00, %l0	/* dirty this window */
	mov	0xf01, %l1
	mov	0xf02, %l2
	mov	0xf03, %l3
	mov	0xf04, %l4
	mov	0xf05, %l5
	mov	0xf06, %l6
	mov	0xf07, %l7
	mov	0xf10, %i0
	mov	0xf11, %i1
	mov	0xf12, %i2
	mov	0xf13, %i3
	mov	0xf14, %i4
	mov	0xf15, %i5
	save	%sp, -64, %sp
	clean_windows		/* the ST_CLEAN_WINDOWS trap */
/* On UltraSPARC, this does not clean current outs, locals, and ins, so
 * we have to clean those by hand */
	mov	%g0, %o0
	mov	%g0, %o1
	mov	%g0, %o2
	mov	%g0, %o3
	mov	%g0, %o4
	mov	%g0, %o5
	mov	%g0, %l0
	mov	%g0, %l1
	mov	%g0, %l2
	mov	%g0, %l3
	mov	%g0, %l4
	mov	%g0, %l5
	mov	%g0, %l6
	mov	%g0, %l7
	mov	%g0, %i0
	mov	%g0, %i1
	mov	%g0, %i2
	mov	%g0, %i3
	mov	%g0, %i4
	mov	%g0, %i5
	call	loop		/* loop ... */
	mov	0x10, %g1	/* ... 16 times */
	restore
	mov	%g1, %i0	/* then return g1 */
	ret
	restore

loop:	save	%sp, -64, %sp
	sub	%g1, 1, %g1	/* if count zero */
	cmp	%g1, %g0
	beq	exit		/* return zero */
	nop
	or	%l0, %l1, %l0	/* or together this "clean" window */
	or	%l0, %l2, %l0
	or	%l0, %l3, %l0
	or	%l0, %l4, %l0
	or	%l0, %l5, %l0
	or	%l0, %l6, %l0
	or	%l0, %l7, %l0
	or	%l0, %o0, %l0
	or	%l0, %o1, %l0
	or	%l0, %o2, %l0
	or	%l0, %o3, %l0
	or	%l0, %o4, %l0
	or	%l0, %o5, %l0
	cmp	%l0, %g0	/* if this window is actually dirty, */
	bne,a	exit
	mov	%l0, %g1	/* return the OR'ed together content */
	call	loop
	nop
exit:	ret
	restore
