/*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: glue.S,v $
 * Revision 1.1  1998/09/28 10:08:34  jont
 * new unit
 * Initial code for building dll
 *
 */
	.text
	.globl	_MLWDLLmain@12
	.globl	ml_register_time_stamp
	.globl	uid
_MLWDLLmain@12:
	cmpl	$1,8(%esp)
	jne	l1		/* Branch if not load */
	pushl	%ebp
	movl	%esp,%ebp
	lea	uid,%eax
	call	ml_register_time_stamp	/* Declare us to the runtime system */
	leave
l1:
	mov	$1,%eax
	ret	$12
