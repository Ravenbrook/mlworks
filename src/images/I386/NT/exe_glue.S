/*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: exe_glue.S,v $
 * Revision 1.1  1998/09/28 10:08:30  jont
 * new unit
 * Initial code for building executable
 *
 */
	.text
	.align 4
	.globl	_main
	.globl	_trampoline
	.globl	SETUP
	.globl	DECLARE
_main:
	pushl	%ebp
	movl	%esp,%ebp
	lea	DECLARE,%edx	/* Get all the global declarations done first */
	lea	SETUP+5,%eax
	push	%edx
	push	%eax
	call	_trampoline
	add	$8,%esp
	mov	%ebx,%eax
	leave
	ret
	.align	8
