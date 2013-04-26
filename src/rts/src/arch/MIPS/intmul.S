/*
 * MIPS assembler multiply routine
 *
 * Revision Log
 * ------------
 * $Log: intmul.S,v $
 * Revision 1.3  1996/04/19 11:22:27  matthew
 * Exception changes
 *
# Revision 1.2  1995/06/27  11:01:22  jont
# Implement assembler integer multiply
#
 * Revision 1.1  1994/07/12  12:06:38  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:30:37  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:55:09  nickh
 * new file
 *
 *
 */

#define C_NAME(x) x

	.set	noreorder
	.text
	.align 4
	.globl C_NAME(mach_int_mul)
C_NAME(mach_int_mul):

/*
 * Leaf function
 *
 * $4 argument pointer
 * $5 closure
 * $6 caller's closure
 * $1, $16 - $23 caller save
 * 
 * $31 return address
 */

	lw	$16, -1($4)		/* Arg 1 */
	lw	$17, 3($4)		/* Arg 2 */
	sra	$16, 2			/* Remove tagging from one operand */
	mult	$16, $17		/* The actual multiplication */
	nop				/* Can't look at HI or LO yet */
	nop				/* Can't look at HI or LO yet */
	mfhi	$16
	mflo	$4
/*
 * Now check for integer overflow
 * We require $4 >> 31 == $16 for correct operation
 */
	sra	$18, $4, 31		/* The sign bit */
	bne	$18, $16, overflow	/* Branch if not good */
	li	$16, 0			/* Clear a potential gc bad value */
	jr	$31			/* Return if ok */
	li	$18, 0			/* Clear a potential gc bad value */
overflow:
/*
 * Raise Prod
 * and clear the bad register ($18)
 */
	la	$4, C_NAME(perv_exn_ref_overflow)
	la	$17, C_NAME(ml_raise_leaf)
	lw	$18, 0($4)		/* perv_exn_ref_prod */
	jalr	$17			/* raise the exception */
	lw	$4, 9($18)		/* DEREF(perv_exn_ref_prod) */
