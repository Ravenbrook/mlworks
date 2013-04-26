!
!  A multiply routine rewritten by NickH
!
!
!
! Revision Log
! ------------
! $Log: intmul.S,v $
! Revision 1.1  1994/10/04 16:50:54  jont
! new file
!
! Revision 1.5  1994/09/13  14:20:54  nickb
! Rewrite this routine to be called directly from ML, not through
! C as before (huge speedups seen).
!
! Revision 1.4  1994/07/06  13:38:02  nickh
! Asm and C name prefixes differ according to OS.
!
! Revision 1.3  1994/07/04  12:18:31  nickh
! Fix comment prefix in log.
!
! Revision 1.2  1994/06/09  14:30:37  nickh
! new file
!
! Revision 1.1  1994/06/09  10:55:09  nickh
! new file
!
!
!

#include "naming.h"

	.text
	.align 4
	.global C_NAME(mach_int_mul)
C_NAME(mach_int_mul):	

/* We are passed an ML pair containing the multiplier and mutiplicand
as ML ints. We untag the multiplier, so that the product is the
correct ML product. We case on the multiplier to choose how many
multiply steps to do (according to whether there are 4, 8, 12, 16, or
more significant bits). We do the multiply steps, then extract the
result and test for overflow. We avoid using the closure register
o1. The multiplication corrupts registers o4 and o5, so we have to
clear those on the way out. */

	ld	[%o0+3],%o2		/* get cdr of arg into o2 */
	ld	[%o0-1],%o0		/* get car of arg into o0 */
	sra	%o0, 2, %o0		/* shift multiplier by 2 */
	mov	%o0, %y			/* do the multiply.... */
	andncc	%o0, 0xf, %o4
	be	mul_4_bits_only		/* 4 bits */
	sethi	%hi(0xffff0000), %o5	
	andncc	%o0, 0xff, %o4
	be,a	 mul_8_bits_only	/* 8 bits */
	mulscc	%o4, %o2, %o4
	andncc	%o0, 0xfff, %o4
	be,a	 mul_12_bits_only	/* 12 bits */
	mulscc	%o4, %o2, %o4
	andcc	%o0, %o5, %o4
	be,a	 mul_16_bits_only	/* 16 bits */
	mulscc	%o4, %o2, %o4		
	andcc	%g0, %g0, %o4		/* clear o4 and the flags */
	mulscc	%o4, %o2, %o4		/* a full set of multiply steps ... */
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %g0, %o4
	tst	%o0
	rd	%y, %o0			/* get low bits out of y */
	bge	mul_non_neg_multiplier	/* if multiplier negative ... */
	tst	%o0
	sub	%o4, %o2, %o4	/* ... subtract multiplicand from high bits */
	
mul_non_neg_multiplier:
	bge,a	mul_pos_result+4/* if low bits positive, go to pos_result */
	addcc	%o4, %g0, %g0	/* set zero flag if the high word is zero */

mul_neg_result:				/* otherwise result is negative */
	cmp	%o4, -1			/* if high word not -1 ... */
	bnz 	mach_int_mul_overflow	/* ... overflow */
	mov	%g0, %o4		/* otherwise return clearing o4/o5 */
	retl
	mov	%g0, %o5
	
mul_8_bits_only:		/* get here having done one multiply step */
	
	mulscc	%o4, %o2, %o4	/* 8 more multiply steps */
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %g0, %o4
	rd	%y, %o5		/* get result out of y and o4 */
	sll	%o4, 8, %o0
	srl	%o5, 0x18, %o5
	orcc	%o5, %o0, %o0
	bge	mul_pos_result	/* if low bits positive */
	sra	%o4, 0x18, %o4
	cmp	%o4, -1			/* if high word not -1 ... */
	bnz 	mach_int_mul_overflow	/* ... overflow */
	mov	%g0, %o4		/* otherwise return clearing o4/o5 */
	retl
	mov	%g0, %o5
	
mul_12_bits_only:		/* get here having done one multiply step */
	
	mulscc	%o4, %o2, %o4	/* 12 more multiply steps */
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %g0, %o4
	rd	%y, %o5		/* get result out of y and o4 */
	sll	%o4, 0xc, %o0
	srl	%o5, 0x14, %o5
	orcc	%o5, %o0, %o0
	bge	mul_pos_result		/* if low bits +ve, result +ve */
	sra	%o4, 0x14, %o4
	cmp	%o4, -1			/* if high word not -1 ... */
	bnz 	mach_int_mul_overflow	/* ... overflow */
	mov	%g0, %o4		/* otherwise return clearing o4/o5 */
	retl
	mov	%g0, %o5
	
mul_16_bits_only:		/* get here having done one multiply step */
	
	mulscc	%o4, %o2, %o4	/* 16 more multiply steps */
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %g0, %o4
	rd	%y, %o5		/* get result out of y and o4 */
	sll	%o4, 0x10, %o0
	srl	%o5, 0x10, %o5
	orcc	%o5, %o0, %o0
	bge	mul_pos_result	/* if low bits +ve, result +ve */
	sra	%o4, 0x10, %o4
	cmp	%o4, -1			/* if high word not -1 ... */
	bnz 	mach_int_mul_overflow	/* ... overflow */
	mov	%g0, %o4		/* otherwise return clearing o4/o5 */
	retl
	mov	%g0, %o5
	
mul_4_bits_only:
	
	mulscc	%o4, %o2, %o4	/* do 5 multiply steps */
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %o2, %o4
	mulscc	%o4, %g0, %o4
	rd	%y, %o5		/* get result out of y and o4 */
	sll	%o4, 4, %o0
	srl	%o5, 0x1c, %o5
	orcc	%o5, %o0, %o0
	bl	mul_neg_result	/* if low bits negative, result is negative */
	sra	%o4, 0x1c, %o4
	
mul_pos_result:
	addcc	%o4, %g0, %g0 		/* if high word is not zero ... */
	bnz,a	mach_int_mul_overflow   /* ... overflow */
	mov	%g0, %o4		
	retl				/* otherwise, clear o5 and return */
	mov	%g0, %o5

mach_int_mul_overflow:

	sethi	%hi(C_NAME(perv_exn_ref_prod)), %o5
	or	%o5, %lo(C_NAME(perv_exn_ref_prod)), %o5
	ld	[%o5], %o4			/* perv_exn_ref_prod */
	call 	C_NAME(ml_raise_leaf)		/* raise the exception */
	ld	[%o4 + 9], %o0			/* DEREF(perv_exn_ref_prod) */
