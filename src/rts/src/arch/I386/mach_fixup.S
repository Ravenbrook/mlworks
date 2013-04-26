/* ==== I386 FIX: COLLECT ONE OBJECT ====
 * 
 *  Copyright (C) 1994 Harlequin Ltd.
 * 
 *  Description
 *  -----------
 *  mach_fixup() is the most critical garbage collection routine; the
 *  GC spends most time here, even when the code is highly tweaked.
 *  This file contains an I386 assembly language version of the
 *  fixup() subroutine (in fixup.c), which is called in gc.c when
 *  MACH_FIXUP is defined.  Have a look in fixup.h for documentation
 *  of the purpose of fixup().
 *  
 *  This file also contains extensive notes on the cost of fixup() and
 *  its principal caller, the scan() macro in gc.c, and on means of
 *  improving their performance by about 30%.
 *  
 *  The code here is full of clever tricks and implicit dependencies.
 *  Modify with extreme care, and test rigorously (just recompiling
 *  MLWorks is insufficient).
 * 
 *  Revision Log
 *  ------------
 *  $Log: mach_fixup.S,v $
 *  Revision 1.7  1996/08/19 15:56:25  nickb
 *  Change error behaviour.
 *
 * Revision 1.6  1996/05/13  14:57:23  nickb
 * Remove an out-of-date conditionalized instruction.
 *
 * Revision 1.5  1996/02/14  15:58:12  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.4  1995/08/21  16:28:31  jont
 * Change SPARC to I386
 *
 * Revision 1.3  1995/06/23  10:09:11  jont
 * Modify to work under NT as well
 *
 * Revision 1.2  1995/05/31  09:30:55  jont
 * Produce first version in I386 machine code
 *
 * Revision 1.1  1994/10/04  16:51:30  jont
 * new file
 *
 * Revision 1.5  1994/08/10  11:50:41  nickh
 * Fix another bug in bytearray copying (a dumb typo).
 *
 * Revision 1.4  1994/07/06  13:38:46  nickh
 * Asm and C name prefixes differ according to OS.
 *
 * Revision 1.3  1994/06/15  09:31:47  nickh
 * Fix bug in copying bytearrays.
 *
 * Revision 1.2  1994/06/09  14:31:07  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:55:46  nickh
 * new file
 *
 *  Revision 1.13  1994/02/07  16:42:13  nickh
 *  increase stack frame size; this is _not_ a leaf function!
 * 
 *  Revision 1.12  1994/02/07  13:53:58  nickh
 *  Got bytearrays and boxed double floats right.
 * 
 *  Revision 1.11  1994/01/25  16:43:49  nickh
 *  Removed int test (which is now in the fix() macro).
 * 
 *  Revision 1.10  1993/03/25  11:32:00  jont
 *  Fixed handling of byte arrays as ref tagged items
 * 
 *  Revision 1.9  1993/02/03  17:53:33  jont
 *  Shortened some of the critical loops
 * 
 *  Revision 1.8  1992/11/12  13:32:04  richard
 *  Changed fixup errors to print a message and attempt to continue
 *  rather than exiting straight away.
 * 
 *  Revision 1.7  1992/08/05  17:37:34  richard
 *  Code vectors are now tagged differently to strings.
 * 
 *  Revision 1.6  1992/07/31  09:05:41  richard
 *  Changed the memory organisation.  This required a couple of small
 *  changes to do with what were previously `block types'.
 * 
 *  Revision 1.5  1992/06/23  10:30:30  richard
 *  Added marking code for large objects.
 * 
 *  Revision 1.4  1992/05/19  13:51:36  richard
 *  Increased the size of the secondary switch table to catch more
 *  illegal secondary tags.
 * 
 *  Revision 1.3  1992/04/14  16:08:30  richard
 *  Converted to use m4 macro processor and renamed to fixup.m4s.
 * 
 *  Revision 1.2  1992/04/06  10:47:45  richard
 *  Corrected a fault in backpointer code.
 * 
 *  Revision 1.1  1992/04/03  10:46:59  richard
 *  Initial revision
 */

/*
 * This version is based in the MIPS implementation
 */

#include "tags.h"
#include "naming.h"

/* === FIX AN ML VALUE ===

 Parameters:
   0(esp)   Link
   4(esp)   Where to copy objects to
   8(esp)   Pointer to value to fix
   12(esp)  Contents of that value
 Returns:
   eax      Where to copy to next

 Registers:
   esp      Stack pointer
   ebp      Frame pointer (callee save)
   ebx      Callee save
   esi      Callee save
   edi      Callee save
   ecx      Caller save
   edx      Caller save
*/
	.global C_NAME(mach_fixup)
C_NAME(mach_fixup):
	lea	C_NAME(space_type), %edx /* Access the space_type info */
	mov	12(%esp), %ecx		/* The value we're fixing */
	shr	$24, %ecx		/* Get index into space type table */
	movb	0(%ecx, %edx), %al	/* Index the table */ /* Compiled wrong */
	mov	12(%esp), %ecx
	shr	$3, %ecx		/* Remove primary tag from *what */
	cmpb	$2, %al			/* 2 = TYPE_FROM *//* Compiled wrong */
	je	fix1			/* Branch if from */
	cmpb	$5, %al			/* 5 = 	TYPE_STATIC */
	je	static			/* Return if not static */

return:	mov	4(%esp), %eax		/* Return to */
	ret

/* pointer to a static object. There are three cases:
 * - POINTER to shared closure: must step backwards; 
 * - POINTER to BACKPTR: must skip backwards;
 * - any other pointer.
 */
static:
/* value is in static
 * stack as for mach_fixup
 * callee saves as for mach_fixup
 * eax unknown
 * ecx header address >> 3
 * edx space table
 */
	mov	12(%esp), %edx		/* *what */
	shl	$3, %ecx		/* Header address for static object */
	andl	$7, %edx		/* Primary tag */
	cmp	$POINTER, %edx		/* Is it a standard pointer? */
	jne	static_return		/* Just return to if not */
static_loop:
	mov	0(%ecx), %edx		/* The header word */
	subl	$8, %ecx		/* loop to find a true header */
	test	%edx, %edx		/* Header 0? */
	je	static_loop		/* Loop if so */
	mov	%edx, %eax
	add	$8, %ecx		/* Correct overshoot */
	and	$63, %eax		/* Secondary tag */
	cmp	$BACKPTR, %eax		/* Is it backptr? */
	jne	static_return		/* Branch if not */
	shr	$6, %edx		/* Get back pointer length */
	sub	%edx, %ecx		/* And pointer to true header */
static_return:
	movl	$0, -4(%ecx)		/* Clear the mark word */
	mov	4(%esp), %eax		/* Return to */
	ret

fix1:
/* value is in fromspace
 * stack as for mach_fixup
 * callee saves as for mach_fixup
 * eax unknown
 * ecx header address >> 3
 * edx space table
 */
	shl	$3, %ecx		/* Header address for from object */
	mov	0(%ecx), %edx		/* Value at start */
	cmp	$EVACUATED, %edx	/* Is the object evacuated? */
	jne	notevac			/* Jump if not */
	mov	4(%ecx), %ecx		/* Get forwarding pointer */
	mov	8(%esp), %edx		/* Get what */
	mov	%ecx, 0(%edx)		/* Update what with forwarding pointer */
	mov	4(%esp), %eax		/* Return to */
	ret

notevac:
/* value is in fromspace and not already evacuated.
 * stack as for mach_fixup
 * callee saves as for mach_fixup
 * eax unknown
 * ecx header address
 * edx *(header address)
 */
/* Time for some more free registers */
	push	%ebx
	push	%esi
	push	%edi
	mov	24(%esp), %ebx		/* *what */
	mov	16(%esp), %esi		/* to */
	and	$7, %ebx		/* Get its primary tag */
	mov	%esi, %edi		/* A copy of to */
	add	%ebx, %edi		/* New tagged value in to space */
	cmp	$PAIRPTR, %ebx		/* Is it a pair? */
	mov	4(%ecx), %eax		/* Get the second of the (potential) pair */
	jne	not_a_pair		/* Branch if not */
	movl	$EVACUATED, 0(%ecx)	/* Mark the pair evacuated */
	mov	%edi, 4(%ecx)		/* And put in the forwarding pointer */
	mov	%eax, 4(%esi)		/* Copy the second of the pair */
	mov	%edx, 0(%esi)		/* Copy the first of the pair */
	mov	20(%esp), %ebx		/* what */
	lea	8(%esi), %eax		/* New value of to */
	mov	%edi, 0(%ebx)		/* Fix the root */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret				/* Return to */

not_a_pair:
/* value is in fromspace and not already evacuated, and not a pair
 * 0(esp)  saved value of edi
 * 4(esp)  saved value of esi
 * 8(esp)  saved value of ebx
 * 12(esp) link
 * 16(esp) to
 * 20(esp) what
 * 24(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (first element of value)
 * esi to
 * edi tagged to
 */
	cmp	$POINTER, %ebx		/* Is it a standard pointer? */
	mov	%edx, %esi		/* Prepare to get secondary tag */
	jne	not_a_ptr		/* Jump if not */
	and	$63, %esi		/* Get secondary tag */
	cmp	$RECORD, %esi		/* Is this a record? */
	jne	not_a_record		/* Branch if not */
	mov	%edx, %esi		/* Prepare to get length */
	shr	$6, %esi		/* Length */
record:
/* Value is a record
 * 0(esp)  saved value of edi
 * 4(esp)  saved value of esi
 * 8(esp)  saved value of ebx
 * 12(esp) link
 * 16(esp) to
 * 20(esp) what
 * 24(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (header itself)
 * esi length
 * edi tagged to
 */
	mov	20(%esp), %ebx		/* what */
	mov	%edi, 4(%ecx)		/* Put in forwarding pointer */
	mov	%edi, 0(%ebx)		/* Fix *what */
	movl	$EVACUATED, 0(%ecx)	/* Mark as forwarded */
	mov	16(%esp), %edi		/* to */
	sub	$2, %esi		/* Length -= 2 */
	mov	%edx, 0(%edi)		/* Save header */
	mov	%eax, 4(%edi)		/* Save first element */
	jl	copy1			/* Branch if finished */

copy0:	mov	8(%ecx), %edx
	mov	12(%ecx), %eax		/* Get two values from fromspace */
	add	$8, %edi
	add	$8, %ecx		/* Increment from and to pointers */
	mov	%edx, 0(%edi)
	sub	$2, %esi		/* Decrement length */
	mov	%eax, 4(%edi)		/* Save two values */
	jge	copy0			/* Loop if more to go */

copy1:	lea	8(%edi), %eax		/* New value of to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret				/* Return to */

not_a_record:
/* Value is standardly tagged but not a record
 * 0(esp)  saved value of edi
 * 4(esp)  saved value of esi
 * 8(esp)  saved value of ebx
 * 12(esp) link
 * 16(esp) to
 * 20(esp) what
 * 24(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (header itself)
 * esi secondary tag
 * edi tagged to
 */
/* catch string and bytearray headers here, as we can do so for one extra
 * instruction and it will catch boxed reals (which have standard POINTERs
 * to 12-byte BYTEARRAY-headed objects). */

	push	%ebp
	mov	%esi, %ebp
	and	$47, %ebp		/* Strings and bytearrays */
	cmp	$STRING, %ebp
	jne	not_a_string
	lea	192(%edx), %esi		/* Prepare to get length */
	pop	%ebp
	shr	$8, %esi		/* Length (commuted the +3 with the >> 6) */
	jmp	record	

not_a_string:
/* Value is standardly tagged but not a record or a string
 * 0(esp)  saved value of ebp
 * 4(esp)  saved value of edi
 * 8(esp)  saved value of esi
 * 12(esp) saved value of ebx
 * 16(esp) link
 * 20(esp) to
 * 24(esp) what
 * 28(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (header itself)
 * esi secondary tag
 * edi tagged to
 * ebp secondary tag & 47
 */

	cmp	$BACKPTR, %esi		/* Partway through some code? */
	jne	not_a_backptr		/* Branch if not */
/* Don't need
 * ebx : we know the tag, it's 005
 * esi : we know it's BACKPTR
 * ebp : became irrelevant when we knew we didn't have a string
 */
	mov	%edx, %esi		/* The header */
	mov	%ecx, %ebx		/* Copy of original */
	shr	$6, %esi		/* The length (back) */
	mov	%ecx, %ebp		/* Pointer to original */
	sub	%esi, %ecx		/* Point to start of original */
	mov	0(%ecx), %edx		/* Real header */
	mov	4(%ecx), %eax		/* Next word */
	cmp	$EVACUATED, %edx	/* Already done? */
	jne	back0			/* Branch if not */
	add	%esi, %eax		/* New value = forward + offset */
	mov	24(%esp), %ebx		/* what */
	mov	%edx, 0(%ebp)		/* Mark original evacuated */
	mov	%eax, 4(%ebp)		/* Forward the original */
	mov	%eax, 0(%ebx)		/* Fix *what */
	pop	%ebp
	mov	16(%esp), %eax		/* Ready to return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret				/* Return to */

back0:
/* Value is an unforwarded back pointer
 * 0(esp)  saved value of ebp
 * 4(esp)  saved value of edi
 * 8(esp)  saved value of esi
 * 12(esp) saved value of ebx
 * 16(esp) link
 * 20(esp) to
 * 24(esp) what
 * 28(esp) *what
 * 
 * eax second element of value
 * ebx pointer to original backptr
 * ecx header address of entire code object
 * edx *(header address) (header itself)
 * esi length back to start
 * edi tagged to
 * ebp header address where backptr found
 */

	movl	$EVACUATED, 0(%ecx)	/* Mark object */
	mov	%edi, 4(%ecx)		/* Forward it */
	add	%esi, %edi		/* Compute fix for original */
	push	%edi			/* Can't use this until we've done the copying */
	mov	%edx, %esi
	mov	24(%esp), %edi		/* to */
	shr	$6, %esi		/* Compute length of full object */
	mov	%edx, 0(%edi)
	mov	%eax, 4(%edi)		/* Save header and first word */
	sub	$2, %esi		/* Length -= 2 */

/* now loop, copying the rest of the object */
bkcopy:	mov	8(%ecx), %edx
	mov	12(%ecx), %eax		/* Get two values from fromspace */
	add	$8, %edi
	add	$8, %ecx		/* Increment from and to pointers */
	mov	%edx, 0(%edi)
	sub	$2, %esi		/* Decrement length */
	mov	%eax, 4(%edi)		/* Save two values */
	jge	bkcopy			/* Loop if more to go */

/* can't mark or forward the original until we've done the copy! */
	mov	%ebp, %ecx
	lea	8(%edi), %eax		/* Value of to for return */
	pop	%edi
	movl	$EVACUATED, 0(%ecx)	/* Mark original evacuated */
	mov	%edi, 4(%ecx)		/* Forward original */
	mov	24(%esp), %ebx		/* what */
	pop	%ebp
	mov	%edi, 0(%ebx)		/* Fix *what */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret				/* Return to */
not_a_backptr:
/* Value is standardly tagged but not a record or a string or a backptr
 * 0(esp)  saved value of ebp
 * 4(esp)  saved value of edi
 * 8(esp)  saved value of esi
 * 12(esp) saved value of ebx
 * 16(esp) link
 * 20(esp) to
 * 24(esp) what
 * 28(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (header itself)
 * esi secondary tag
 * edi tagged to
 * ebp secondary tag & 47
 */
	test	%edx, %edx		/* Shared closure? */
	jne	not_a_shared_closure	/* Jump if not */
shared_closure:
/* loop back to the start of the closure */
/* Note edx = 0 here */
	sub	$8, %edx		/* edx accumulates -offset */
	cmp	$0, 0(%ecx,%edx)	/* Use ecx in the search */
	je	shared_closure		/* Loop until we find a non-zero header */

/* note that for shared closures we must _not_ mark or evacuate the
 * original, since this would break the pattern that the fake headers
 * in a shared closure are all 0 */
/* This comment is wrong, we can evacuate and forward,
 * because then things work properly anyway:-)
 */
/*
 * A suggested optimisation for this case (both halves)
 * is to forward all pointers at this stage
 * thus making all future references to the shared closure
 * drop out at the evac stage
 */
	push	%ecx			/* Save pointer partway through closure */
	add	%edx, %ecx		/* Point to start of closure */
	mov	0(%ecx), %ebp		/* Get header */
	cmp	$EVACUATED, %ebp	/* Already evacuated? */
	jne	clos0			/* Branch if not */
	mov	4(%ecx), %ecx		/* Where it's gone */
	pop	%esi			/* Original pointer into shared closure */
	mov	24(%esp), %ebx		/* what */
	sub	%edx, %ecx		/* Compute corrected fix */
	pop	%ebp
	mov	%ecx, 0(%ebx)		/* Fix *what */
	movl	$EVACUATED, 0(%esi)	/* Mark original */
	mov	%ecx, 4(%esi)		/* Forward original */
	mov	16(%esp), %eax		/* Return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret				/* Return to */

clos0:
/* Value is a shared closure which hasn't been forwarded
 * 0(esp)  saved original pointer into shared closure
 * 4(esp)  saved value of ebp
 * 8(esp)  saved value of edi
 * 12(esp) saved value of esi
 * 16(esp) saved value of ebx
 * 20(esp) link
 * 24(esp) to
 * 28(esp) what
 * 32(esp) *what
 * 
 * eax second element of original value at share point
 * ebx tag(*what)
 * ecx header address of full value
 * edx -offset of value to be fixed
 * esi secondary tag
 * edi tagged to
 * ebp header of full value
 */

	neg	%edx			/* Convert to positive offset */
	mov	%ebp, %esi		/* Copy of true header */
	add	%edi, %edx		/* Fix for original place */
	movl	$EVACUATED, 0(%ecx)	/* Mark record evacuated */
	shr	$6, %esi		/* Compute record length */
	xchg	4(%ecx), %edi		/* Remember the first value in the record */
					/* And fix at the same time */
	sub	$2, %esi		/* Length -= 2 */
/*
 * eax element 2 at original place
 * ebx tag(*what)
 * ecx pointer to closure
 * edx Fix for original place
 * esi Length
 * edi Element one
 * ebp original header
 */

	mov	28(%esp), %eax		/* what */
	mov	24(%esp), %ebx		/* to */
	mov	%edx, 0(%eax)		/* fix *what */
	mov	%edx, %eax		/* Save the fix for later use */
	mov	%ebp, 0(%ebx)		/* save the header */
	mov	%edi, 4(%ebx)		/* save first word */
/* now loop, copying the rest of the object */
ccopy:	add	$8, %ebx		/* to += 8 */
	mov	8(%ecx), %ebp
	mov	12(%ecx), %edi
	mov	%ebp, 0(%ebx)
	mov	%edi, 4(%ebx)		/* Copy two words */
	add	$8, %ecx
	sub	$2, %esi
	jge	ccopy			/* Loop if more to go */
	pop	%esi			/* Original pointer into shared closure */
	pop	%ebp 
	movl	$EVACUATED, 0(%esi)	/* Mark original */
	mov	%eax, 4(%esi)		/* Forward original */
	lea	8(%ebx), %eax		/* Return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret

/* not a standard pointer, so it must be a refptr (otherwise it's an error) */

not_a_ptr:
/* value is in fromspace and not already evacuated, and not a pair or standard pointer
 * 0(esp)  saved value of edi
 * 4(esp)  saved value of esi
 * 8(esp)  saved value of ebx
 * 12(esp) link
 * 16(esp) to
 * 20(esp) what
 * 24(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (first element of value)
 * esi edx
 * edi tagged to
 */

	and	$63, %esi		/* Get secondary tag */
	cmp	$REFPTR, %ebx		/* Check primary is ref */
	jne	primary7		/* Error if not */
	mov	20(%esp), %ebx		/* what */
	cmp	$BYTEARRAY, %esi	/* Array or bytearray? */
	mov	%edi, 0(%ebx)		/* Fix *what */
	movl	$EVACUATED, 0(%ecx)	/* Mark original */
	mov	%edi, 4(%ecx)		/* Forward original */
	je	bytearray		/* Branch if bytearray */
	mov	16(%esp), %edi		/* to */
	mov	%edx, 0(%edi)		/* Copy first two words */
	mov	%eax, 4(%edi)
/*
 * eax second element of value
 * ebx REFPTR
 * ecx header address
 * edx *(header address) (first element of value)
 * esi secondary tag
 * edi to
 */
/* Now fiddle about with back pointers */
	mov	%edx, %esi		/* Copy of header word */
	mov	8(%ecx), %edx		/* Get entry list backptr */
	shr	$6, %esi		/* Compute array length */
	test	%edx, %edx		/* backptr zero? */
	je	rcopy			/* Branch if not */
	mov	%edi, 8(%eax)		/* forward->back = new address */
	mov	%edi, 4(%edx)		/* back->forward = new address */
rcopy:	mov	12(%ecx), %eax		/* Get first element of array */
	mov	%edx, 8(%edi)		/* Copy backptr */
	mov	%eax, 12(%edi)		/* and first element of array */
	sub	$2, %esi		/* Length -= 2 */
	jl	rcopy1			/* Branch if finished already */
rcopy0:	mov	16(%ecx), %edx
	mov	20(%ecx), %eax		/* Next two words */
	add	$8, %edi
	add	$8, %ecx		/* Increment pointers */
	mov	%edx, 8(%edi)		/* Store two words */
	sub	$2, %esi		/* Decrement count */
	mov	%eax, 12(%edi)
	jge	rcopy0			/* And loop if not finished */
rcopy1:	lea	16(%edi), %eax		/* Return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret

bytearray:
/* value is in fromspace and not already evacuated, and is a bytearray
 * 0(esp)  saved value of edi
 * 4(esp)  saved value of esi
 * 8(esp)  saved value of ebx
 * 12(esp) link
 * 16(esp) to
 * 20(esp) what
 * 24(esp) *what
 * 
 * eax second element of value
 * ebx what
 * ecx header address
 * edx *(header address) (first element of value)
 * esi BYTEARRAY
 * edi tagged to
 */
	lea	192(%edx), %esi		/* Prepare to get length */
	mov	16(%esp), %edi		/* to */
	shr	$8, %esi		/* Length (commuted the +3 with the >> 6) */
	mov	%edx, 0(%edi)		/* Save the header */
	sub	$2, %esi		/* Length -= 2 */
	mov	%eax, 4(%edi)		/* Save first word */
	jl	bcopy1			/* Branch if finished */
/* now loop, copying the rest of the object */
bcopy0:	mov	8(%ecx), %edx
	mov	12(%ecx), %eax		/* Next two words */
	add	$8, %edi
	add	$8, %ecx		/* Increment pointers */
	mov	%edx, 0(%edi)		/* Store two words */
	sub	$2, %esi		/* Decrement count */
	mov	%eax, 4(%edi)
	jge	bcopy0			/* And loop if not finished */
bcopy1:	lea	8(%edi), %eax		/* Return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret

/*
 * we only get here if we have a direct pointer to a code object,
 * which is very unusual (basically it means the GC has been entered in
 * the middle of loading a code object).
 */

not_a_shared_closure:
/* Value is standardly tagged but not a record or a string or a backptr or a shared closure
 * 0(esp)  saved value of ebp
 * 4(esp)  saved value of edi
 * 8(esp)  saved value of esi
 * 12(esp) saved value of ebx
 * 16(esp) link
 * 20(esp) to
 * 24(esp) what
 * 28(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (header itself)
 * esi secondary tag
 * edi tagged to
 * ebp secondary tag & 47
 */

	mov	%edx, %ebp
	mov	%edx, %esi
	and	$63, %ebp		/* Full secondary tag */
	shr	$6, %esi		/* Compute length */
	cmp	$CODE, %ebp		/* Code? */
	pop	%ebp			/* Straighten stack */
	je	record			/* Branch if so */
/*
 * Oops, bad header value
 * 
 * Call fixup_bad_header(what,*what,header,obj)
 */
	push	%ebp
	mov	%esp, %ebp
	push	%ecx			/* obj */
	push	%edx			/* header */
	push	36(%esp)		/* *what */
	push	36(%esp)		/* what */
	call	C_NAME(fixup_bad_header)
	add	$16, %esp		/* Junk parameters */
	pop	%ebp			/* Throw away frame */
	mov	16(%esp), %eax		/* Return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret

primary7:
/* value is in fromspace and not already evacuated, and not a pair or standard pointer
 * 0(esp)  saved value of edi
 * 4(esp)  saved value of esi
 * 8(esp)  saved value of ebx
 * 12(esp) link
 * 16(esp) to
 * 20(esp) what
 * 24(esp) *what
 * 
 * eax second element of value
 * ebx tag(*what)
 * ecx header address
 * edx *(header address) (first element of value)
 * esi secondary tag
 * edi tagged to
 *
 * Call fixup_bad_primary(what,*what)
 *
 */

	push	%ebp
	mov	%esp, %ebp
	push	28(%esp)		/* Push *what */
	push	28(%esp)		/* Push what */
	call	C_NAME(fixup_bad_primary)
	add	$8, %esp		/* Junk parameters */
	pop	%ebp			/* Throw away frame */
	mov	16(%esp), %eax		/* Return to */
	pop	%edi
	pop	%esi
	pop	%ebx
	ret
