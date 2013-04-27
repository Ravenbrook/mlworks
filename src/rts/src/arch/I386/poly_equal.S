/* ==== POLYMORPHIC EQUALITY ====
 *              SPARC
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
 * Polymorphic equality (structural equality using runtime tags) is the
 * most critical library function for running ML.  This code is an
 * optimised version for the SPARC.
 *
 * Notes
 * -----
 * This file must be processed by the m4 macro processor to produce an
 * assebler file.
 *
 * Revision Log
 * ------------
 * $Log: poly_equal.S,v $
 * Revision 1.1  1994/10/04 16:52:12  jont
 * new file
 *
# Revision 1.3  1994/07/06  13:41:03  nickh
# Asm and C name prefixes differ according to OS.
#
# Revision 1.2  1994/06/09  14:31:23  nickh
# new file
#
# Revision 1.1  1994/06/09  10:56:07  nickh
# new file
#
 * Revision 1.10  1993/04/28  16:35:04  jont
 * Fixed eq_string to avoid using local registers which it doesn't own. Now
 * uses g4, g7, o4, o5 instead of l0 - l3
 *
 * Revision 1.9  1992/12/14  17:54:28  jont
 * More register cleaning up from poly_equal and string comparison
 *
 * Revision 1.8  1992/11/17  14:46:07  jont
 * Produced sparc coded gc safe string < and string >
 *
 * Revision 1.7  1992/11/12  14:52:56  richard
 * Changed ml_string_eq to use local registers.
 * Made sure that the registers are cleaned by string equality.
 *
 * Revision 1.6  1992/08/05  16:59:53  richard
 * Code vectors are now tagged differently to strings.
 *
 * Revision 1.5  1992/07/29  11:18:14  richard
 * Corrected argument passing to poly_equal and poly_not_equal.
 * _ml_poly_equal removed.
 *
 * Revision 1.4  1992/05/27  09:15:38  richard
 * Added instructions to clean some registers.
 *
 * Revision 1.3  1992/05/08  09:25:01  richard
 * Corrected NOT in poly_not_equal.
 *
 * Revision 1.2  1992/05/07  17:19:09  clive
 * problems with poly_equal - ret was used, but ret uses (i7) and not the o7 of call
 * We were therefore missing out code on return
 *
 * Revision 1.1  1992/04/15  10:25:28  richard
 * Initial revision
 *
 * Revision 1.1  1992/04/14  16:06:08  richard
 * Initial revision
 */

#include "macros.h"

/* === POLYMORPHIC EQUALITY ===
 *
 * Parameters to _poly_equal and _poly_not_equal:
 *   %o0  Pointer to pair containing values
 * Returns:
 *   %o0  MLTRUE iff values are (not) equal.
 *
 * Polymorphic equality tests to see whether two values are
 * structurally the same.  It is very important that this routine is
 * _fast_ as it is likely to be called many times more often than other
 * pervasive functions.
 */

	.globl C_NAME(poly_not_equal)

C_NAME(poly_not_equal):
	save    %sp, -0x40, %sp
	call	C_NAME(poly_equal)
	mov     %i0, %o0
	xor	%o0, 4, %i0
	ret
	restore  

	.globl C_NAME(poly_equal)

C_NAME(poly_equal):
	ld	[%o0+3], %o1
	ld	[%o0-1], %o0	! Unpack the argument pair
equal:	cmp	%o0, %o1	! Are the values EQ?  If so they are equal.
	bne,a	ml_eq_not_eq	! (Use a skip as this is likely to be common.)
	and	%o0, 0x7, %o2
	retl
	mov	TRUE, %o0

! o0, o1 args (clean). o2 left-arg primary (dirty)
ml_eq_not_eq:
	and	%o1, 0x7, %o3
	cmp	%o2, %o3	! Are the primary tags the same?  If not, the
	bne	ml_eq_no_clean_o2 ! values are different, jump to clean exit.
	sll	%o2, 2, %o3	! Switch on the primary tag... (cleaning o3)
	sethi	%hi(ml_eq_primary_switch), %o2
	or	%o2, %lo(ml_eq_primary_switch), %o2 ! o2 now clean
	ld	[%o2 + %o3], %o3
	jmp	%o3
	nop

! after this switch, all registers are clean. Args are o0,o1

ml_eq_primary_switch:		! Primary tag switch
	.word	ml_eq_no	! INTEGER0: must be EQ
	.word	ml_eq_pair	! PAIRPTR
	.word	ml_eq_error	! HEADER:   illegal
	.word	ml_eq_no	! REFPTR:   must be EQ
	.word	ml_eq_no	! INTEGER1: must be EQ
	.word	ml_eq_pointer	! POINTER
	.word	ml_eq_error	! PRIMARY6: illegal
	.word	ml_eq_error	! PRIMARY7: illegal

ml_eq_no_clean_o3_o2:
	mov	%g0, %o3
ml_eq_no_clean_o2:
	mov	%g0, %o2	! Clean %o2 and %o3
ml_eq_no:
	jmpl	%o7+8, %g0
	mov	FALSE, %o0

ml_eq_pair:
	save	%sp, -0x40, %sp
	ldd	[%i0 - 1], %i2	! Load both pairs quickly
	ldd	[%i1 - 1], %i4
	mov	%i2, %o0
	call	equal		! Recursively check first half
	mov	%i4, %o1
	cmp	%o0, 0
	beq	ml_eq_no
	restore	%g0, 0, %g0	! Restore in either case
	mov	%o3, %o0
	ba	equal		! Tail to check second half
	mov	%o5, %o1

ml_eq_pointer:
	ld	[%o0 - 5], %o2	! Load headers from values
	ld	[%o1 - 5], %o3
	cmp	%o2, %o3	! Are the headers the same?
	bne	ml_eq_no_clean_o2 ! Not equal if they are not
	and	%o2, 0x38, %o3	! Switch on secondary tag... (o3 cleaned)
	sethi	%hi(ml_eq_secondary_switch), %o4
	srl	%o3, 1, %o5	! Still clean
	or	%o4, %lo(ml_eq_secondary_switch), %o3
	ld	[%o3 + %o5], %o4
	jmp	%o4
	srl	%o2, 6, %o3	! Extract length of object, whatever it is.
				! Note that the callee will clean this bad o3

! after this switch, o2 and o3 are dirty.
! (args still in o0,o1; o2 has header, o3 has length)

ml_eq_secondary_switch:		! Secondary tag switch
	.word	ml_eq_record	! RECORD
	.word	ml_eq_string	! STRING
	.word	ml_eq_error	! ARRAY:     should have REFPTR primary tag
	.word	ml_eq_real	! BYTEARRAY: must be a float
	.word	ml_eq_backptr	! BACKPTR:   turn on flag and return false
	.word	ml_eq_no_clean_o3_o2 ! CODE:      must be EQ
	.word	ml_eq_error	! HEADER50:  illegal
	.word	ml_eq_no_clean_o3_o2 ! WEAKARRAY: must be EQ

ml_eq_record:
	save	%sp, -0x40, %sp
	sub	%i0, 5, %i0	! Align values to point at headers
	sub	%i1, 5, %i1
	sll	%i3, 2, %i2	! Calculate length in bytes (clearing bad i2)
	add	%i0, %i2, %i3	! Find end of record (clearing bad i3)
ml_eq4:	add	%i1, %i2, %i4
	ld	[%i3], %o0	! Fetch values from records
	call	equal		! Recursively compare them
	ld	[%i4], %o1
	cmp	%o0, 0
	beq,a	ml_eq_no
	restore	%g0, 0, %g0
	subcc	%i2, 4, %i2	! Move down to next value
	bnz,a	ml_eq4
	add	%i0, %i2, %i3
	restore	%g0, 0, %g0
	jmpl	%o7+8, %g0
	mov	TRUE, %o0

ml_eq_string:
	andcc	%o3, -4, %o2	! Mask length to word boundary (clear bad o2)
	bnz,a	ml_eq6		! Are there any full words in the string?
	sub	%o0, 1, %o0	! Align values to point at first word
	ld	[%o0 - 1], %o4	! Fetch the whole strings and look at them
	ld	[%o1 - 1], %o5
	ba	ml_eq7
	andcc	%o3, 3, %o2	! Leftover bytes
ml_eq6:	sub	%o1, 1, %o1	! Align values to point at first word
	ld	[%o0 + %o2], %o4	! Save last few bytes for later
	ld	[%o1 + %o2], %o5
	sub	%o2, 4, %o2	! Offset of last full word
	ld	[%o0 + %o2], %g4	! Fetch four bytes at once from each string
ml_eq5:	ld	[%o1 + %o2], %g7
	cmp	%g4, %g7	! Compare four bytes at once
	bne	ml_eq_no_clean_o3_o4_o5_g7
	subcc	%o2, 4, %o2	! Move to next four bytes
	bge,a	ml_eq5
	ld	[%o0 + %o2], %g4	! Fetch four bytes at once from each string
	andcc	%o3, 3, %o2	! How many bytes left over?
ml_eq7:	bnz,a	ml_eq8		! Strings are equal iff none
	sll	%o2, 3, %o3	! *8, produces clean value
	mov	%g0, %g4	! Clean illegal ML values
	mov	%g0, %g7
	mov	%g0, %o4
	mov	%g0, %o5
	retl			! Return true
	mov	4, %o0
ml_eq8:	sethi	%hi(0x80000000), %g4
	sub	%o3, 1, %o2	! (left_over_bytes * 8)-1
	sra	%g4, %o2, %g7	! Create mask for bytes (sneaky, eh?)
	and	%o4, %g7, %o4	! Mask out excess bytes
	and	%o5, %g7, %o5
	cmp	%o4, %o5	! Compare remaining bytes
	bne	ml_eq_no
	mov	%g0, %o2	! Clean illegal ML value
	retl			! Return true
	mov	TRUE, %o0

ml_eq_no_clean_o3_o4_o5_g7:
	mov	%g0, %g7
ml_eq_no_clean_o3_o4_o5:
	mov	%g0, %o3	! Clean illegal ML values
ml_eq_no_clean_o4_o5:
	mov	%g0, %o4
	mov	%g0, %o5
	retl			! Return false
	mov	FALSE, %o0

/* Reals are stored as POINTERs to BYTEARRAYs size 12 (regular
 * BYTEARRAYs use REFPTRs, so this is unambiguous. We use bitwise
 * equality here. */

ml_eq_real:
	ldd	[%o0 + 3], %o2
	ldd	[%o1 + 3], %o4
	cmp	%o2, %o4
	bne	ml_eq_no_clean_o3_o4_o5
	mov	%g0, %o2
	cmp	%o3, %o5
	bne	ml_eq_no_clean_o4_o5
	mov	%g0, %o3
	mov	%g0, %o4
	mov	%g0, %o5
	retl
	mov	TRUE, %o0

/* If we compare two non-eq functions, set the C variable
 * ml_eq_function to 1 and return false */

ml_eq_backptr:
	sethi	%hi(C_NAME(ml_eq_function)), %o0
	or	%o0, %lo(C_NAME(ml_eq_function)), %o0	
	mov	1, %o1
	ba	ml_eq_no_clean_o3_o2
	st	%o1, [%o0]

ml_eq_error:
	ML_to_C(poly_equal_error)	! Should not return
	ta	1

/*
 * ml_string_less
 * replacement for string_less in strings.c
 * gc safe
 */
	.globl	C_NAME(ml_string_less)
C_NAME(ml_string_less):
	ld	[%o0+3], %o1
	ld	[%o0-1], %o0	! Unpack the argument pair
	cmp	%o0, %o1	! Are the values EQ?  If so they are equal.
	bne,a	ml_strl0	! (Use a skip as this is likely to be common.)
	ld	[%o0 - 5], %o2	! Head str1
	retl
	mov	FALSE, %o0
ml_strl0:
	ld	[%o1 - 5], %o3	! Head str2
	save	%sp, -0x40, %sp
	srl	%i2, 6, %i2	! Length str1
	call	ml_string_compare
	srl	%i3, 6, %i3	! Length str2
	tst	%i0
	bl	ml_strl1
	mov	TRUE, %i0
	bg	ml_strl1
	mov	FALSE, %i0
	cmp	%i2, %i3
	bl	ml_strl1
	mov	TRUE, %i0
	mov	FALSE, %i0
ml_strl1:
	mov	%g0, %i2
	mov	%g0, %i3
	ret
	restore
/*
 * ml_string_greater
 * replacement for string_greater in strings.c
 * gc safe
 */
	.globl	C_NAME(ml_string_greater)
C_NAME(ml_string_greater):
	ld	[%o0+3], %o1
	ld	[%o0-1], %o0	! Unpack the argument pair
	cmp	%o0, %o1	! Are the values EQ?  If so they are equal.
	bne,a	ml_strg0	! (Use a skip as this is likely to be common.)
	ld	[%o0 - 5], %o2	! Head str1
	retl
	mov	FALSE, %o0
ml_strg0:
	ld	[%o1 - 5], %o3	! Head str2
	save	%sp, -0x40, %sp
	srl	%i2, 6, %i2	! Length str1
	call	ml_string_compare
	srl	%i3, 6, %i3	! Length str2
	tst	%i0
	bl	ml_strg1
	mov	FALSE, %i0
	bg	ml_strg1
	mov	TRUE, %i0
	cmp	%i2, %i3
	bg	ml_strg1
	mov	TRUE, %i0
	mov	FALSE, %i0
ml_strg1:
	mov	%g0, %i2
	mov	%g0, %i3
	ret
	restore

/*
 * Used in ml_string_less and ml_string_greater (above) to compare two
 * strings.
 * 
 * i0 points to string1
 * i1 points to string2
 * i2 is length of string1
 * i3 is length of string2
 */

ml_string_compare:
	cmp	%i2, %i3
	bleu,a	ml_str0
	mov	%i2, %o3
	mov	%i3, %o3
ml_str0:
	sub	%i0, 1, %i0
	sub	%i1, 1, %i1
	andcc	%o3, -4, %o2	! Mask length to word boundary
	ld	[%i1 + %o2], %l3
	bnz	ml_str1		! Are there any full words in the string?
	ld	[%i0 + %o2], %l2	! Save last few bytes for later
	ba	ml_str6
	andcc	%o3, 3, %o2	! Leftover bytes
ml_str1:
	mov	0, %o4
	ld	[%i0 + %o4], %l0	! Fetch four bytes at once from each string
ml_str2:
	ld	[%i1 + %o4], %l1
	cmp	%l0, %l1	! Compare four bytes at once
	beq,a	ml_str5
	subcc	%o2, 4, %o2	! Move to next four bytes
ml_str3:
	mov	%g0, %o3
	mov	%g0, %l0
	mov	%g0, %l1
	mov	%g0, %l2
	blu,a	ml_str4
	mov	-1, %i0		! Indicate <
	mov	%g0, %l3
	retl
	mov	1, %i0		! Indicate >
ml_str4:
	retl
	mov	%g0, %l3
ml_str5:
	add	%o4, 4, %o4
	bg,a	ml_str2
	ld	[%i0 + %o4], %l0	! Fetch four bytes at once from each string
	andcc	%o3, 3, %o2	! How many bytes left over?
ml_str6:
	bnz,a	ml_str7		! Strings are equal iff none
	sll	%o2, 3, %o3
	mov	%g0, %l0
	mov	%g0, %l1
	mov	%g0, %l2
	mov	%g0, %l3
	retl			! Return equal
	mov	0, %i0
ml_str7:
	sethi	%hi(0x80000000), %l0
	sub	%o3, 1, %o2	! (left_over_bytes * 8)-1
	sra	%l0, %o2, %l1	! Create mask for bytes (sneaky, eh?)
	and	%l2, %l1, %l2	! Mask out excess bytes
	and	%l3, %l1, %l3
	mov	%g0, %o2	! Clean illegal ML value
	cmp	%l2, %l3	! Compare remaining bytes
	bne	ml_str3
	mov	0, %i0
	mov	%g0, %l0
	mov	%g0, %l1
	mov	%g0, %l2
	retl
	mov	%g0, %l3
