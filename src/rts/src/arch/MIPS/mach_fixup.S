/* ==== MIPS FIX: COLLECT ONE OBJECT ====
 * 
 *  Copyright (C) 1994 Harlequin Ltd.
 * 
 *  Description
 *  -----------
 *  mach_fixup() is the most critical garbage collection routine; the
 *  GC spends most time here, even when the code is highly tweaked.
 *  This file contains a MIPS assembly language version of the
 *  fixup() subroutine (in fixup.c), which is called in gc.c when
 *  MACH_FIXUP is defined.  Have a look in fixup.h for documentation
 *  of the purpose of fixup().
 *  
 * See the matching SPARC file for extensive notes on the cost of
 * fixup() and its principal caller, the scan() macro in gc.c, and on
 * means of improving their performance by about 30%.
 *  
 *  The code here is full of clever tricks and implicit dependencies.
 *  Modify with extreme care, and test rigorously (just recompiling
 *  MLWorks is insufficient).
 * 
 *  Notes
 *  -----
 *  This file must be run through the m4 macro processor to produce an
 *  assembler file.
 * 
 *  Revision Log
 *  ------------
 *  $Log: mach_fixup.S,v $
 *  Revision 1.9  1996/08/19 15:37:33  nickb
 *  Change error behaviour.
 *
 *  Revision 1.8  1996/02/14  16:01:35  jont
 *  Changing ERROR to MLERROR
 *
 *  Revision 1.7  1995/06/28  11:36:30  nickb
 *  Using a loaded value in the delay slot.
 *
 *  Revision 1.6  1995/05/26  12:56:44  nickb
 *  Bus error when fixing a static shared closure.
 *
 *  Revision 1.5  1995/05/24  15:02:38  nickb
 *  Fix unuusual static objects correctly.
 *
 *  Revision 1.4  1995/05/23  13:07:29  nickb
 *  Change warning message entry code so we can continue afterwards.
 *
 *  Revision 1.3  1995/05/22  14:49:28  nickb
 *  First round of fixes.
 *
 *  Revision 1.2  1995/05/11  12:36:41  nickb
 *  write mach_fixup for MIPS.
 *
 * Revision 1.1  1994/07/12  12:07:07  jont
 * new file
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

/*  Note: various costs are listed in the code below, for instance:
 * 
 *  record size 1: 29 instrs, 3t, 2n.
 *  
 *  This means "to fixup a record of size 1 requires 29 instructions, of
 *  which 3 are taken branches and 2 are non-taken branches."
 *  
 *  The costs are measured from the entry to mach_fixup.
 *  
 *  At various points "costs so far" are noted, along with information
 *  about the current content of registers &c.
 */

#include "tags.h"

/* === FIX AN ML VALUE ===

 Parameters:
   $4   Where to copy objects to
   $5   Pointer to value to fix
   $6   Contents of that value
 Returns:
   $2   Where to copy to next

 Registers:
   $2-$15, $24,$25 are fair game.
   $1 is the assembler temporary, and should be used with care
   $16-$23, $30 are callee-saves
   $26-$28 are not to be fiddled with
   $31 is the return address
*/

.set noreorder
	.globl mach_fixup
mach_fixup:
	la	$2, space_type		/* find the space type */
	srl	$7, $6, 24
	add	$2, $7, $2
	lb	$2, 0($2)
	li	$3, 2			/* 2 = TYPE_FROM */
	beq	$2, $3, fix1
	srl	$7, $6, 3		/* header address >> 3 */
	li	$3, 5			/* 5 = TYPE_STATIC */
	beq	$2, $3, static
	sll	$7, $7, 3
return:	jr $31
	move	$2, $4			/* return 'to' */

/* pointer to a static object. There are three cases:
 * - POINTER to shared closure: must step backwards; 
 * - POINTER to BACKPTR: must skip backwards;
 * - any other pointer.
 */

static:
	and	$10, $6, 7		/* primary tag */
	li	$3, POINTER
	bne	$10, $3, static_return	/* not a special case */
	move	$2, $4			/* we return 'to' */
static_loop:
	lw	$8, 0($7)		/* the header word */
	addiu	$7, $7, -8		/* loop to find a true header */
	beq	$8, $0, static_loop
	andi	$12, $8, 63		/* secondary tag */

	li	$11, BACKPTR		/* if backptr then */
	bne	$11, $12, static_return
	addiu	$7, $7, 8
	srl	$14, $8, 6		/* skip back to true head */
	sub	$7, $7, $14
static_return:	
	jr	$31
	sw	$0, -4($7)		/* mark the mark word */


/* notfrom: 12 instrs, 2n
   static nonptr : 16 instrs, 1n,2t
   static ptr : 23 instrs, 3n,2t + 4 instrs, 1t per shared closure step
   static backptr : 25 instrs, 4n, 1t
*/ 

fix1:
/* value is in fromspace. 7 instrs, 1t
 *	0	1	2	3	4	5	6	7
 *	0	--	--	--	to	what	*what	&hdr>>3 */

	sll	$7, $7 ,3		/* get header address */
	lw	$8, 0($7)		/* header word */
	li	$2, EVACUATED
	bne	$8, $2, notevac		/* if EVAC... */
	lw	$9, 4($7)
	move	$2, $4			/* ... return 'to' */
	jr	$31
	sw	$9, 0($5)		/* and fix with the forwarding ptr */
/* already: 15 instrs, 1t, 1n */

notevac:
/* value is in fromspace and not already evacuated. 12 instrs, 2t
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	--	to	what	*what	&hdr
 * +8	hdr	word1	--	--	--	--	--	--	*/

	andi	$10, $6, 7		/* get primary tag */
	li	$11, PAIRPTR
	bne	$11, $10, not_a_pair
	add	$3, $10, $4		/* new tagged value */
	sw	$2, 0($7)		/* mark the pair */
	sw	$3, 4($7)		/* forward the pair */
	addiu	$2, $4, 8		/* return to+8 */
	sw	$8, 0($4)		/* copy the pair */
	sw	$9, 4($4)
	jr	$31
	sw	$3, 0($5)		/* and fix the root */

/* pair: 23 instrs, 2t, 1n */

not_a_pair:
/* 16 instrs, 3t
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	PAIRPTR	--	--	--	--	*/

	li	$11, POINTER
	bne	$11, $10, not_a_ptr
	andi	$12, $8, 63		/* secondary tag */

	li	$11, RECORD
	bne	$11, $12, not_a_record
	srl	$13, $8, 6		/* length */

record:
/* 22 instrs, 3t, 2n
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	RECORD	2dary	length	--	--	*/

	sw	$2, 0($7)		/* mark the object */
	sw	$3, 4($7)		/* forward it */
	sw	$8, 0($4)		/* save the header */
	addiu	$13, $13, -2		/* length -= 2 */
	bltz	$13, copy1		/* if finished, goto end... */
	sw	$9, 4($4)		/* ...saving first word */

/* now loop, copying the rest of the object */
/* code order here to maximise the length of load/store dependencies */
copy0:	lw	$8, 8($7)		/* get next two words */
	lw	$9, 12($7)
	addiu	$4, $4, 8		/* increment both pointers */
	addiu	$7, $7, 8
	addiu	$13, $13, -2		/* decrement the length */
	sw	$8, 0($4)		/* save the two words */
	bgez	$13, copy0		/* loop */
	sw	$9, 4($4)

copy1:	addiu	$2, $4, 8		/* return to+4 */
	jr	$31
	sw	$3, 0($5)		/* fix *what */

/* record size 1: 31 instrs, 4t, 2n
 * other record: 23 instrs, 1t, 4n; plus 8 instrs, 1t per double word
 * direct code objects: as for records but +11 instrs, +5t, -1n */

not_a_record:
/* 22 instrs, 4t, 1n
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	RECORD	2dary	length	--	--	*/

/* catch string and bytearray headers here, as we can do so for one extra
 * instruction and it will catch boxed reals (which have regular POINTERs
 * to 12-byte BYTEARRAY-headed objects). */

	andi	$14, $12, 47		/* strings and bytearrays */
	li	$11, STRING
	bne	$14, $11, not_a_string
	addiu	$14, $13, 3		/* compute length in words */
	srl	$13, $14, 2
string:	
	sw	$2, 0($7)		/* forward the object */
	sw	$3, 4($7)
	sw	$8, 0($4)		/* save the header */
	addiu	$13, $13, -2		/* length -= 2 */
	bltz	$13, scopy1		/* if finished, goto end... */
	sw	$9, 4($4)		/* ...saving first word */

/* now loop, copying the rest of the object */
/* code order here to maximise the length of load/store dependencies */
scopy0:	lw	$8, 8($7)		/* load next two words */
	lw	$9, 12($7)
	addiu	$4, $4, 8		/* increment pointers */
	addiu	$7, $7, 8
	addiu	$13, $13, -2		/* decrement length */
	sw	$8, 0($4)		/* save two words */
	bgez	$13, scopy0		/* ... and loop */
	sw	$9, 4($4)

scopy1:	addiu	$2, $4, 8
	jr	$31
	sw	$3, 0($5)

/* string size 0-4: 36 instrs, 5t, 2n
 * other strings  : 28 instrs, 2t, 4n, +8 instrs, 1t per double word */

not_a_string:
/* 26 instrs, 5t, 1n
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	STRING	2dary	length	len+3	--	*/

	li	$11, BACKPTR
	bne	$12, $11, not_a_backptr
	nop
	subu	$14, $7, $13		/* find the actual header */
	lw	$10, 0($14)		/* load the actual header */
	lw	$11, 4($14)		/* load the actual first word */
	bne	$10, $2, back0		/* if it's already evacuated... */
	nop
	add	$3, $11, $13		/* new value = forward + offset */
	sw	$2, 0($7)		/* mark the original */
	sw	$3, 4($7)		/* forward the original */
	move	$2, $4			/* get return value ready */
	jr	$31
	sw	$3, 0($5)		/* fix *what */

/* already-forwarded backptr: 39 instrs, 5t, 3n */

back0:
/* 34 instrs, 6t, 2n
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	truehd	truew1	2dary	length	&truehd	--	*/

	sw	$2, 0($14)		/* mark and forward whole object */
	sw	$3, 4($14)
	addu	$3, $3, $13		/* recompute fix for original */
	srl	$13, $10, 6		/* compute true length */
	sw	$10, 0($4)		/* copy first two words */
	sw	$11, 4($4)
	addiu	$13, $13, -2		/* length -= 2 */

/* now loop, copying the rest of the object */
bkcopy:	lw	$8, 8($14)		/* load two words */
	lw	$9, 12($14)
	addiu	$4, $4, 8		/* inc pointers and dec length */
	addiu	$13, $13, -2
	addiu	$14, $14, 8
	sw	$8, 0($4)		/* save two words */
	bgez	$13, bkcopy
	sw	$9, 4($4)

/* can't mark or forward the original until we've done the copy! */
	sw	$2, 0($7)		/* mark and forward the original */
	sw	$3, 4($7)
	sw	$3, 0($5)		/* fix *what */
	jr	$31
	addiu	$2, $4, 8

/* code from backptrs : 38 instrs, 5t, 2n, +8 instrs, 1t per double word. */

not_a_backptr:
/* 29 instrs, 6t, 1n
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	BACKPTR	2dary	length	len+3	--	*/

	bne	$8,$0,not_a_shared_closure
	move	$14,$7
shared_closure:
/* loop back to the head of the closure */
	lw	$10, -8($14)
	addiu	$8, $8, 8		/* accumulate offset in $8 */
	beq	$10,$0, shared_closure
	addiu	$14, $14,-8
	bne	$10, $2, clos0		/* if evacuated... */
	lw	$11, 4($14)
	sw	$2, 0($7)		/* mark original */
	add	$3, $8, $11		/* compute corrected fix */
	sw	$3, 4($7)		/* forward original */
	move	$2, $4			/* prepare to return 'to' */
	jr	$31			/* return */
	sw	$3, 0($5)		/* fix *what */

/* already-forwarded shared clos: 37 instrs, 6t, 4n, +4 instrs, 1t per step */

clos0:
/* 33 instrs, 7t, 3n, +4 instrs, 1t per step
 * 	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	offset	word1	truehd	truew1	2dary	length	&truehd	--	*/

	srl	$13, $10, 6		/* length */
	sw	$2, 0($14)		/* mark and forward the closure */
	sw	$3, 4($14)
	add	$3, $3, $8		/* compute the fix for the original */
	sw	$10, 0($4)		/* save the header */
	sw	$11, 4($4)		/* save first word */
	addiu	$13, $13, -2		/* length -= 2 */
/* now loop, copying the rest of the object */
ccopy:	addiu	$4, $4, 8
	lw	$8, 8($14)
	lw	$9, 12($14)
	sw	$8, 0($4)
	sw	$9, 4($4)
	addiu	$13, $13, -2
	bgez	$13, ccopy
	addiu	$14, $14, 8
	sw	$2, 0($7)		/* mark original */
	sw	$3, 4($7)		/* forward original */
	sw	$3, 0($5)		/* fix *what */
	jr	$31
	addiu	$2, $4, 8

/* shared clos: 35 instrs, 5t, 3n, +8 instrs, 1t per double word, 
 * 				   +4instrs, 1t per step
 */

/* not a regular pointer, so it must be a refptr (otherwise it's an error) */

not_a_ptr:
/* 19 instrs, 4t
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	POINTER 2dary	--	--	--	*/

	li	$11, REFPTR
	bne	$10,$11,primary7
	li	$11, BYTEARRAY
	sw	$3, 0($5)		/* fix *what */
	beq	$11,$12,bytearray	
	sw	$2, 0($7)		/* mark and forward original */
	sw	$3, 4($7)
	sw	$8, 0($4)		/* copy first two words */
	lw	$13, 8($7)		/* get entry-list backptr */
	sw	$9, 4($4)
	lw	$14, 12($7)		/* get first element */
	beq	$13, $0, rcopy		/* if backptr non-zero... */
	srl	$15, $8, 6		/* length */

	sw	$4, 8($9)		/* forward->back = new address */
	sw	$4, 4($13)		/* back->forward = new address */
rcopy:	sw	$13, 8($4)		/* copy backptr */
	addiu	$15, $15,-2
	bltz	$15, rcopy1
	sw	$14, 12($4)		/* copy first element */
rcopy0:	lw	$13, 16($7)		/* load next pair of elements */
	lw	$14, 20($7)
	addiu	$7,$7,8			/* increment pointers */
	addiu	$4,$4,8
	sw	$13, 8($4)		/* save the pair of elements */
	addiu	$15,$15,-2		/* decrement length */
	bgez	$15, rcopy0		/* loop */
	sw	$14, 12($4)
rcopy1:	jr	$31
	addiu	$2, $4, 16		/* return new 'to' pointer */

/* arrays size 1: 38 instrs, 6t, 2n
 * +8 instrs, 1t per additional double word
 * +2 instrs, 1n, -1t if on an entry list */

bytearray:
/* 25 instrs, 5t, 1n, *what fixed, original marked
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	BYTEARR BYTEARR	--	--	--	*/

	srl	$13, $8, 6		/* length */
	addiu	$13, $13, 3		/* compute length in words */
	srl	$13, $13, 2
	sw	$3, 4($7)		/* forward the original */
	sw	$8, 0($4)		/* save the header */
	addiu	$13, $13, -2		/* length -= 2 */
	bltz	$13, bcopy1		/* if finished, goto end... */
	sw	$9, 4($4)		/* ...saving first word */
/* now loop, copying the rest of the object */
bcopy0:	lw	$8, 8($7)
	lw	$9, 12($7)
	addiu	$4, $4, 8
	addiu	$13, $13, -2
	addiu	$7, $7, 8
	sw	$8, 0($4)
	bgez	$13, bcopy0
	sw	$9, 4($4)
bcopy1:	jr	$31
	addiu	$2, $4, 8

/* bytearray size 0-4: 35 instrs, 6t, 1n
 * other bytearrays : 27 instrs, 3t, 3n, +8 instrs, 1t per double word */

/* we only get here if we have a direct pointer to a code object,
 * which is very unusual (basically it means the GC has been entered in
 * the middle of loading a code object). */

not_a_shared_closure:
/* 31 instrs, 7t, 1n
 *	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	BACKPTR	2dary	length	&hdr	--	*/

	li	$11, CODE
	beq	$11, $12, record
	nop

/* Call fixup_bad_header(what, *what, header, obj) */

	addiu	$sp,$sp,-24		/* save 'to' so we can return it */
	sw	$4, 16($sp)
	sw	$31, 20($sp)
	move	$4, $5
	la	$25, fixup_bad_header
	move	$5, $6
	jalr	$31,$25
	move	$6, $8
	lw	$31,20($sp)
	lw	$2, 16($sp)
	jr	$31
	addiu	$sp,$sp,24

primary7:

/*	0	1	2	3	4	5	6	7
 *	0	--	EVAC	fixed	to	what	*what	&hdr
 * +8	hdr	word1	primary	BARRAY  2dary	--	--	--	*/

/* Call fixup_bad_primary(what, *what) */

	addiu	$sp,$sp,-24		/* save 'to' so we can return it */
	sw	$4, 16($sp)
	sw	$31, 20($sp)
	la	$25, fixup_bad_primary
	move	$4, $5
	jalr	$31,$25
	move	$5, $6
	lw	$31,20($sp)
	lw	$2, 16($sp)
	jr	$31
	addiu	$sp,$sp,24

