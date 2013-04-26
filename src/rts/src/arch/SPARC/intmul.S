!
!  A multiply routine rewritten by NickH
!
!
!
! Revision Log
! ------------
! $Log: intmul.S,v $
! Revision 1.7  1996/04/19 14:36:11  matthew
! Changing exceptions
!
! Revision 1.6  1994/11/23  12:32:19  matthew
! Added assembler division and modulus functions
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

	sethi	%hi(C_NAME(perv_exn_ref_overflow)), %o5
	or	%o5, %lo(C_NAME(perv_exn_ref_overflow)), %o5
	ld	[%o5], %o4			/* perv_exn_ref_prod */
	call 	C_NAME(ml_raise_leaf)		/* raise the exception */
	ld	[%o4 + 9], %o0			/* DEREF(perv_exn_ref_prod) */

! INTEGER DIVISION & MODULUS

/*
Both function take an ML pair, save away the original arguments, untag and
make positive _both_ arguments.  Division by zero is handled and then the main
division begins:  the divisor is shifted left by 2 places until it is bigger than the 
dividend.  The fact that both integers are untagged ML ints means that we
can't shift off the end and loop forever.  Once the divisor has been shifted left,
it is then shifted right one bit at a time until it returns to its original value.
In this loop, when the dividend (which serves as the running remainder) is larger than
the shifted divisor, the divisor is subtracted and a bit added to the result.
In pseudocode:

a = positive untaggged dividend
b = positive untagged divisor

t := b
r := 0
(* shift t left *)
while t <= a do t := t << 2;
(* shift t right *)
while t <> b do
  { t := t >> 1;
    r := r << 1;
    if t <= a then {a := a - a; r := r & 1};
  }

a contains remainder
r contains divide result.

The actual code is unrolled & fiddled about with a little, but this is the
general idea (for example, the second loop is unrolled once and the whiles
have become repeat untils).

Having done the basic division, we then fiddle around with the result to take
account of negative arguments. The desired results are:

if a div b = j
then:
-a div  b = -j-1
 a div -b = -j-1
-a div -b =  j

if a mod b = k
then:
-a mod b  =  b-k
 a mod -b =  k-b
-a mod -b = -k
 
Points: div and mod just do what is necessary.  Neither is a general divmod function, so
treatment of negative args are different and mod doesn't build a result value.

We treat a div b as a special case when b = -1,0,1.  This is because an overflow should
happen for MININT div ~1.
*/

! Registers:
! o0	normalized dividend, which becomes result
! o1	closure -- not used -- debugger may need it.
! o2	original normalized divisor before shifting -- needs cleaning
! o3	original divisor
! o4	result goes in here -- needs cleaning (not used in mod)
! o5
! g7	original dividend
! g4	shifted divisor	

	.align 4
	.global C_NAME(mach_int_div)
C_NAME(mach_int_div):	
	ld	[%o0+3],%o3		/* get cdr of arg into o3 */
	ld	[%o0-1],%g7		/* get car of arg into g7 */
	sra	%g7, 2, %o0		/* shift dividend by 2 */
	sra	%o3, 2, %o2		/* shift divisor by 2 */

	orcc %o3,%g7,%g0	! quick test for all positive case
	bge,a div_setup_1
	cmp %o2,1		! Test for special case

	tst %o0			! negate args if necessary
	blt,a div_neg_arg_1
	neg %o0

div_neg_arg_1:
	tst %o2
	blt,a div_setup
	neg %o2

div_setup:
	cmp %o2,1		! Test for special case
div_setup_1:
	ble div_special_case
	mov %o2,%g4		! OK in delay
	mov %g0,%o4		! o4 is result register

	cmp %o2,%o0		! if o2 already greater than dividend
	bgt div_loop_end	! then skip inner loops
	sll %g4,2,%g4

div_shift_left:
	cmp %g4,%o0		! shift left loop
	bleu,a div_shift_left	! if g4 greater, fall through
	sll %g4,2,%g4

	srl %g4,1,%g4

div_main_loop:
	cmp %g4,%o0		! need to subtract?
	bgt div_skip_1
	sll %o4,1,%o4		! make room in result
	sub %o0,%g4,%o0
	or %o4,1,%o4

div_skip_1:
	srl %g4,1,%g4
	cmp %g4,%o0		! need to subtract?
	bgt div_skip_2
	sll %o4,1,%o4		! make room in result
	sub %o0,%g4,%o0
	or %o4,1,%o4

div_skip_2:
	cmp %g4,%o2		! g4 back to b yet?
	bne div_main_loop	! then loop
	srl %g4,1,%g4		! Not needed after so OK in delay

div_loop_end:
	xorcc %o3,%g7,%o2 	! test for negative args
	blt div_neg_result
	mov %g0,%o2		! clean o2 in delay
	sll %o4,2,%o0		! return tagged result
	retl
	mov %g0,%o4

div_neg_result:
	neg %o4
	cmp %o0,%g0
	bne,a div_neg_result_1	! if remainder is non-zero
	dec %o4			! subtract one

div_neg_result_1:
	sll %o4,2,%o0		! return tagged result
	retl
	mov %g0,%o4		! clean o4

div_special_case:		! if divisor is ~1,0,1
	cmp %o3,%g0		! dividing by zero?
	beq mach_int_div_div
	mov %g0,%o2		! clean in delay
	blt minus1
	nop
	retl
	mov %g7,%o0		! else dividing by one

minus1:				! dividing by minus one
	subcc %g7,1,%g0		! Error for dividend = -2**29
	bvs mach_int_div_overflow
	nop
	sra %g7,2,%o0		! else return -dividend
	neg %o0
	retl
	sll %o0,2,%o0

mach_int_div_div:
	sethi	%hi(C_NAME(perv_exn_ref_div)), %o5
	or	%o5, %lo(C_NAME(perv_exn_ref_div)), %o5
	ld	[%o5], %o4			/* perv_exn_ref_div */
	call 	C_NAME(ml_raise_leaf)		/* raise the exception */
	ld	[%o4 + 9], %o0			/* DEREF(perv_exn_ref_div) */

mach_int_div_overflow:
	sethi	%hi(C_NAME(perv_exn_ref_overflow)), %o5
	or	%o5, %lo(C_NAME(perv_exn_ref_overflow)), %o5
	ld	[%o5], %o4			/* perv_exn_ref_div */
	call 	C_NAME(ml_raise_leaf)		/* raise the exception */
	ld	[%o4 + 9], %o0			/* DEREF(perv_exn_ref_div) */

! INTEGER MODULUS

	.align 4
	.global C_NAME(mach_int_mod)
C_NAME(mach_int_mod):	
	ld	[%o0+3],%o3		/* get cdr of arg into o3 */
	ld	[%o0-1],%g7		/* get car of arg into g7 */
	sra	%g7, 2, %o0		/* shift dividend by 2 */
	sra	%o3, 2, %o2		/* shift divisor by 2 */

	orcc %o3,%g7,%g0
	bge,a mod_setup_1
	cmp %o2,%g0		! %o2 is +ve here

	tst %o0			! negate args if necessary
	blt,a mod_neg_arg_1
	neg %o0

mod_neg_arg_1:
	tst %o2
	blt,a mod_setup
	neg %o2

mod_setup:
	cmp %o2,%g0		! %o2 is +ve here
mod_setup_1:
	beq mach_int_mod_div	! division by zero
	mov %o2,%g4		! OK in delay

	cmp %g4,%o0		! shift left loop
	bgt mod_loop_end
	sll %g4,2,%g4


mod_shift_left:
	cmp %g4,%o0		! shift left loop
	bleu,a mod_shift_left	! if g4 greater, fall through
	sll %g4,2,%g4
	srl %g4,1,%g4

mod_main_loop:
	cmp %g4,%o0		! need to subtract?
	ble,a mod_skip_1
	sub %o0,%g4,%o0

mod_skip_1:
	srl %g4,1,%g4
	cmp %g4,%o0		! need to subtract?
	ble,a mod_skip_2
	sub %o0,%g4,%o0

mod_skip_2:
	cmp %g4,%o2		! g4 back to b yet?
	bne mod_main_loop	! then loop
	srl %g4,1,%g4		! Not needed after so OK in delay

mod_loop_end:
	orcc %o3,%g7,%g0 	! if either are negative
	blt mod_neg_result
	nop
mod_return:
	mov %g0,%o2		! clean o2
	retl
	sll %o0,2,%o0		! return tagged result in delay

mod_neg_result:			! o2 is (positive) divisor
	cmp %o0,%g0		! if modulus = 0, return
	beq mod_return
	nop
	cmp %o3,%g0		! test divisor
	bge,a mod_return	! dividend must be negative
	sub %o2,%o0,%o0		! so modulus := |divisor|-modulus
	cmp %g7,%g0		! else test dividend
	blt,a mod_return
	neg %o0			! both negative
	ba mod_return
	sub %o0,%o2,%o0		! modulus := modulus-|divisor|

mach_int_mod_div:
	mov %g0,%o2	! clean
	sethi	%hi(C_NAME(perv_exn_ref_div)), %o5
	or	%o5, %lo(C_NAME(perv_exn_ref_div)), %o5
	ld	[%o5], %o4			/* perv_exn_ref_div */
	call 	C_NAME(ml_raise_leaf)		/* raise the exception */
	ld	[%o4 + 9], %o0			/* DEREF(perv_exn_ref_div) */
	
