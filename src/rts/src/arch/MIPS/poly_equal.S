/* ==== POLYMORPHIC EQUALITY ====
 *              MIPS
 *
 * Copyright (C) 1995 Harlequin Ltd
 *
 * Description
 * -----------
 * Polymorphic equality (structural equality using runtime tags) is the
 * most critical library function for running ML.  This code is an
 * optimised version for the MIPS.
 *
 * Notes
 * -----
 *
 * $Log: poly_equal.S,v $
 * Revision 1.6  1997/05/23 18:28:40  andreww
 * [Bug #30047]
 * altering jump tables so that linker can correctly patch them.
 *
# Revision 1.5  1996/05/23  12:55:30  nickb
# String equality could read an unnecessary word, which
# could cause a segmentation fault.
#
# Revision 1.4  1996/05/22  10:56:07  matthew
# Fixing zero length vector equality
#
# Revision 1.3  1995/07/17  11:18:32  nickb
# Add assembler directives to remove a pair of warnings.
#
# Revision 1.2  1995/07/03  16:49:02  jont
# Fix problem with secondary switch use
# Also fix problems with bad register choice ($26)
# and minor typo substituting $5 where $4 was intended in ml_eq_record.
#
 * Revision 1.1  1995/06/28  17:18:40  jont
 * new unit
 * No reason given
 *
 */

/* === POLYMORPHIC EQUALITY ===
 *
 * Parameters to _poly_equal and _poly_not_equal:
 *   $4  Pointer to pair containing values
 *   $31 Return address
 * Returns:
 *   $4  MLTRUE iff values are (not) equal.
 *
 * Linkage: Called as a leaf function
 *
 * Polymorphic equality tests to see whether two values are
 * structurally the same.  It is very important that this routine is
 * _fast_ as it is likely to be called many times more often than other
 * pervasive functions.
 */

#include "macros.h"

#define C_NAME(x) x

	.set	noat
	.set	noreorder
	.globl C_NAME(poly_not_equal)
/*
 * Create a small frame, call poly_equal, invert the result and return
 */
C_NAME(poly_not_equal):
	sw	$30, 0($29)		/* Save previous fp */
	move	$30, $29		/* New fp */
	subu	$29, 16			/* Create new frame */
	sw	$6, 4($29)		/* Save caller's closure */
	sw	$31, 8($29)		/* Save return address */
	move	$6, $5
	bgezal	$0, poly_equal
	nop
	lw	$31, 8($29)		/* Restore lr */
	lw	$6, 4($29)		/* Restore caller's closure */
	move	$29, $30		/* Restore previous sp */
	lw	$30, 0($29)		/* Restore previous fp */
	jr	$31
	xori	$4, $4, 4		/* Invert answer */

	.globl C_NAME(poly_equal)

C_NAME(poly_equal):
	lw	$16, 3($4)
	lw	$4, -1($4)		/* Unpack arguments */
	nop
equal:	bne	$16, $4, ml_eq_not_eq	/* Branch if args not equal */
	nop
	jr	$31
	li	$4, TRUE		/* Return true if they are equal */

/*
 * $4, $16 args clean
 */
ml_eq_not_eq:
	and	$17, $4, 7
	and	$18, $16, 7		/* Get primary tags of args */
	bne	$17, $18, ml_eq_no_clean_17
	sll	$18, $17, 3		/* Switch on primary, cleaning $18 */
	.set at
	la	$17, ml_eq_primary_switch
	.set noat
	nop
	addu	$18, $18, $17
	jr	$18			/* Do the switch */
	nop

/* After the above switch, all registers are clean */

ml_eq_primary_switch:		/* Primary tag switch */
	beq $0 $0, ml_eq_no	/* INTEGER0: must be EQ */
	nop
	beq $0 $0, ml_eq_pair	/* PAIRPTR */
	nop
	beq $0 $0, ml_eq_error	/* HEADER:   illegal */
	nop
	beq $0 $0, ml_eq_no	/* REFPTR:   must be EQ */
	nop
	beq $0 $0, ml_eq_no	/* INTEGER1: must be EQ */
	nop
	beq $0 $0, ml_eq_pointer	/* POINTER */
	nop
	beq $0 $0, ml_eq_error	/* PRIMARY6: illegal */
	nop
	beq $0 $0, ml_eq_error	/* PRIMARY7: illegal */

	.text

ml_eq_no_clean_18_17:
	li	$18, 0
ml_eq_no_clean_17:
	li	$17, 0
ml_eq_no:
	jr	$31
	li	$4, FALSE		/* Return not equal */

ml_eq_pair:
/*
 * First make a new frame
 */
	sw	$30, 0($29)		/* Save previous fp */
	move	$30, $29		/* New fp */
	subu	$29, 24			/* Create new frame */
	sw	$6, 4($29)		/* Save caller's closure */
	sw	$31, 8($29)		/* Save return address */
	move	$6, $5
	sw	$24, 16($29)
	sw	$25, 20($29)		/* Free up two callee saves */
	move	$24, $4
	lw	$4, -1($24)
	move	$25, $16
	lw	$16, -1($25)		/* Get first arg of each pair */
	bgezal	$0, equal		/* Compare them */
	nop
	beq	$4, $0, ml_eq_no1	/* Branch if first pair unequal */
	lw	$31, 8($29)		/* Restore lr */
	lw	$4, 3($24)
	lw	$16, 3($25)		/* Get second of pair */
	lw	$24, 16($29)
	lw	$25, 20($29)		/* Restore callee saves */
	lw	$6, 4($29)		/* Restore caller's closure */
	move	$29, $30		/* Restore previous sp */
	lw	$30, 0($29)		/* Restore previous fp */
	beq	$0, $0, equal		/* Tail back to equal for second half */
	nop
	

ml_eq_no1:
/*
 * Restore frame
 */
	lw	$24, 16($29)
	lw	$25, 20($29)		/* Restore callee saves */
	lw	$6, 4($29)		/* Restore caller's closure */
	move	$29, $30		/* Restore previous sp */
	lw	$30, 0($29)		/* Restore previous fp */
	jr	$31
	nop				/* Return not equal */

ml_eq_pointer:
	lw	$17, -5($4)
	lw	$18, -5($16)		/* Get headers */
	nop
	bne	$17, $18, ml_eq_no_clean_17	/* Not equal if not same */
	and	$18, $17, 0x38		/* Get secondary tag, cleaning $18 */
	.set	at
	la	$19, ml_eq_secondary_switch
	.set	noat
	srl	$20, $18, 1		/* Table offset, still clean */
	addu	$20, $20, $19
	jr	$20
	srl	$18, $17, 6		/* Compute record length (callee cleans $18) */

/*
 * After this switch $17 and $18 are dirty
 * $4, $16 are args, $17 is header, $18 is length
 */

ml_eq_secondary_switch:		/* Secondary tag switch */
	beq $0 $0, ml_eq_record	/* RECORD */
	nop
	beq $0 $0, ml_eq_string	/* STRING */
	nop
	beq $0 $0, ml_eq_error	/* ARRAY: should have REFPTR primary tag */
	nop
	beq $0 $0, ml_eq_real	/* BYTEARRAY: must be a float */
	nop
	beq $0 $0, ml_eq_backptr/* BACKPTR:   turn on flag and return false */
	nop
	beq $0 $0, ml_eq_no_clean_18_17 /* CODE:      must be EQ */
	nop
	beq $0 $0, ml_eq_error	/* HEADER50:  illegal */
	nop
	beq $0 $0, ml_eq_no_clean_18_17 /* WEAKARRAY: must be EQ */
	.text

ml_eq_record:
/*
 * First make a new frame
 */
	sw	$30, 0($29)		/* Save previous fp */
	move	$30, $29		/* New fp */
	subu	$29, 32			/* Create new frame */
	sw	$6, 4($29)		/* Save caller's closure */
	sw	$31, 8($29)		/* Save return address */
	move	$6, $5
	sw	$24, 16($29)
	sw	$25, 20($29)
	sw	$14, 24($29)		/* Free up three callee saves */
	subu	$4, $4, 5
	subu	$16, $16, 5		/* Point to header words */
	sll	$14, $18, 2		/* Length in bytes */
	move	$24, $4
	move	$25, $16
	addu	$17, $14, $24		/* Point to last word, cleaning bad $17 */
	beq	$0, $14, ml_eq9		/* Check for zero length, note clean $18 in delay slot */
ml_eq4:	addu	$18, $14, $25		/* Point to last word, cleaning bad $18 */
	lw	$4, 0($17)
	lw	$16, 0($18)		/* Get two words */
	bgezal	$0, equal		/* Compare */
	nop
	beq	$4, $0, ml_eq_no2	/* Branch if first pair unequal */
	subu	$14, 4			/* One less to go */
	bne	$14, $0, ml_eq4		/* Loop if still some to do */
	addu	$17, $14, $24		/* Pointing to previous word */
/*
 * Restore frame
 */
ml_eq9:
	lw	$24, 16($29)
	lw	$25, 20($29)		/* Restore callee saves */
	lw	$14, 24($29)		/* Restore callee saves */
	lw	$31, 8($29)		/* Restore lr */
	lw	$6, 4($29)		/* Restore caller's closure */
	move	$29, $30		/* Restore previous sp */
	lw	$30, 0($29)		/* Restore previous fp */
	jr	$31
	li	$4, TRUE		/* Return equal */

ml_eq_no2:
/*
 * Restore frame
 */
	lw	$24, 16($29)
	lw	$25, 20($29)		/* Restore callee saves */
	lw	$14, 24($29)		/* Restore callee saves */
	lw	$31, 8($29)		/* Restore lr */
	lw	$6, 4($29)		/* Restore caller's closure */
	move	$29, $30		/* Restore previous sp */
	lw	$30, 0($29)		/* Restore previous fp */
	jr	$31
	nop				/* Return not equal */

ml_eq_string:
	li	$1, -4
	and	$17, $18, $1		/* Mask length to word boundary (clear bad $17) */
	bne	$17, $0, ml_eq6		/* Branch if any full words in string */
	subu	$4, 1			/* Point to first word of string */
	lw	$19, 0($4)
	lw	$20, -1($16)		/* Fetch the whole strings */
	beq	$0, $0, ml_eq7
	andi	$17, $18, 3		/* Get string length */
ml_eq6:
	subu	$16, 1			/* Point to first word of string */
	andi	$19, $18, 3		/* if no leftover bytes, ... */
	beq	$19, $0, ml_eq10	/* ... don't try to load them */
	addu	$19, $17, $4		/* otherwise you might get a SEGV */
	addu	$20, $17, $16
	lw	$19, 0($19)
	lw	$20, 0($20)		/* Save last word of each string for later */
ml_eq10:
	subu	$17, 4			/* Offset of last word */
ml_eq5:
	lw	$21, 0($4)
	lw	$22, 0($16)		/* Fetch four bytes at once from each string */
	addu	$4, 4
	addu	$16, 4			/* Increment pointers */
	bne	$21, $22, ml_eq_no_clean_18_19_20_21_22
	subu	$17, 4
	bgez	$17, ml_eq5
	nop				/* Can't load here, we might not need this */
					/* word, and it might be in the next page */
					/* and thus cause a bus error */
	andi	$17, $18, 3		/* Number of bytes left over */
ml_eq7:
	bne	$17, $0, ml_eq8		/* Branch if still some bytes */
	sll	$18, $17, 3		/* Multiply by 8, cleaning $18 */
/*
 * No bytes to be compared, string equal
 */
	li	$22, 0
	li	$21, 0
	li	$20, 0
	li	$19, 0
	jr	$31
	li	$4, TRUE		/* Return equal */
ml_eq8:
	lui	$1, 0x8000
	subu	$17, $18, 1		/* (left over bytes * 8) -1 */
	sra	$1, $1, $17		/* Mask for significant excess bytes */
	li	$21, 0
	li	$22, 0
	and	$19, $19, $1
	and	$20, $20, $1		/* These values are now gc safe */
	bne	$19, $20, ml_eq_no
	li	$17, 0			/* Clean final value */
	jr	$31
	li	$4, TRUE		/* Return equal */	
	
ml_eq_no_clean_18_19_20_21_22:
	li	$22, 0
	li	$21, 0
	li	$20, 0
	li	$19, 0
ml_eq_no_clean_18:
	li	$18, 0
	jr	$31
	li	$4, FALSE

/*
 * Reals are stored as POINTERs to BYTEARRAYs size 12 (regular
 * BYTEARRAYs use REFPTRs, so this is unambiguous. We use bitwise
 * equality here.
 */

ml_eq_real:
	lw	$17, 3($4)
	lw	$18, 3($16)
	nop
	bne	$17, $18, ml_eq_no_clean_18
	li	$17, 0
	lw	$17, 7($4)
	lw	$18, 7($16)
	nop
	bne	$17, $18, ml_eq_no_clean_18
	li	$17, 0
	li	$18, 0
	jr	$31
	li	$4, TRUE		/* Return equal */

/*
 * If we compare two non-eq functions, set the C variable
 * ml_eq_function to 1 and return false
 */

ml_eq_backptr:
	la	$18, C_NAME(ml_eq_function)
	li	$17, 1
	beq	$0, $0, ml_eq_no_clean_17
	sw	$17, 0($18)

ml_eq_error:
	move	$5, $16			/* C calling convention */
	ML_to_C(poly_equal_error)	/* Should not return */
