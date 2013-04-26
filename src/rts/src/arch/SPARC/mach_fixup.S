/* ==== SPARC FIX: COLLECT ONE OBJECT ====
 * 
 *  Copyright (C) 1994 Harlequin Ltd.
 * 
 *  Description
 *  -----------
 *  mach_fixup() is the most critical garbage collection routine; the
 *  GC spends most time here, even when the code is highly tweaked.
 *  This file contains a SPARC assembly language version of the
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
 *  Notes
 *  -----
 *  This file must be run through the m4 macro processor to produce an
 *  assembler file.
 * 
 *  Revision Log
 *  ------------
 *  $Log: mach_fixup.S,v $
 *  Revision 1.14  1996/08/19 14:13:06  nickb
 *  Change error behaviour.
 *
# Revision 1.13  1996/02/14  15:21:49  jont
# Changing ERROR to MLERROR
#
# Revision 1.12  1995/07/26  13:39:50  nickb
# Change statistical comments to reflect the current object distribution.
#
# Revision 1.11  1995/06/19  15:06:17  nickb
# Hack to avoid irritating assembler warning.
#
# Revision 1.10  1995/05/26  12:32:37  nickb
# We are not marking or forwarding code objects.
#
# Revision 1.9  1995/05/24  13:56:59  nickb
# Fix unuusual static objects correctly.
#
# Revision 1.8  1995/03/07  11:58:43  nickb
# Correct behaviour for backpointers in static objects.
#
# Revision 1.7  1995/02/27  16:16:28  nickb
# TYPE_LARGE becomes TYPE_STATIC
#
# Revision 1.6  1994/10/13  13:38:53  nickb
# Include arenadefs.h so we can readily change the space size.
#
# Revision 1.5  1994/08/10  11:50:41  nickh
# Fix another bug in bytearray copying (a dumb typo).
#
# Revision 1.4  1994/07/06  13:38:46  nickh
# Asm and C name prefixes differ according to OS.
#
# Revision 1.3  1994/06/15  09:31:47  nickh
# Fix bug in copying bytearrays.
#
# Revision 1.2  1994/06/09  14:31:07  nickh
# new file
#
# Revision 1.1  1994/06/09  10:55:46  nickh
# new file
#
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
 *  ========================================================================
 * 
 *  Notes on costs of fixup, and of it's principal caller, the
 *  scan macro in gc.c.. Updated by Nick Barnes 1995-07-26
 * 
 *  1. case frequency breakdown and instruction count table for scan
 *  
 *  The instruction counts include the scan loop, which makes over 95% of
 *  calls to fixup.
 *
 *  "ints" are ML integers, tested and eliminated in the scan loop.
 *  "not from" are objects not in from space. "evac" are objects already
 *  evacuated. "backptrs" are pointers to code vectors. "shared" are
 *  pointers to members of shared closures.
 *  
 *                case frequency breakdown
 *                MLWorks         Lego            instructions
 *  
 *  ints          0.4742          0.2752          11
 *  not from      0.1391          0.364           26
 *  statics	  0		  0		  16
 *  stat backptr  0		  0		  17
 *  evac          0.04496         0.07365         28
 *  pairs         0.2758          0.26183         36
 *  records       0.05052         0.02217         44
 *  strings       0.004351        0.0015640       49
 *  arrays        0.010966        0.001134        35
 *  backptrs      0.00005913      0.0005262       51
 *        evac:   0.00004553      0.0003817       41
 *  shared        0.00001379      0.0001190       52
 *	 +step:   0.00006840      0.0007084        4
 *        evac:   0.00001167      0.0001012       46
 *  
 *  +copied       0.114           0.061            6
 *  
 *  (nonints:     0.5258          0.7248)
 *  (save   :     0.3417          0.2872 (i.e. save executed in fixup))
 *
 *  total instrs  23.531          25.4932
 *
 *  bytes copied   2.795           3.734
 *
 *  instrs/word   33.676          27.309
 *  
 *  Possible improvements (see section 2 below for more details).
 *  
 *  (a) By modifying the scan macro in C, it is possible to save 2
 *  instructions on the non-int case.
 *  
 *  (b) By recoding the scan macro in assembler, it is possible to save 3
 *  instructions on the int case and 7 on non-ints (knowing what we do
 *  about what mach_fixup does with registers).
 *  
 *  (c) By coding the whole of scan into assembler, inlining mach_fixup,
 *  it would be possible to save at least 2 more instructions per loop
 *  (loading the space_type array base), and also the save instrs.
 *  
 *  2. how to improve scan
 *  
 *  2.1. Current scan
 *  
 *  2.1.1. source:
 *  
 *    while(f < (end)) {
 *      mlval value = *f; 
 *   
 *      if(FIXABLE(value)) {
 *        fix(to, f); 
 *        ++f; 
 *      } else
 *        switch(SECONDARY(value)) { ...
 *        }
 *    }
 *  
 *  2.1.2. object (generated by gcc2):
 *  
 *        0x1e718  cmp  %l0, %l2                  ; f < end
 *        0x1e71c  bcc,a   0x1e8e8
 *        0x1e720  ld  [ %l6 + 0x40 ], %l2
 *        0x1e724  ld  [ %l0 ], %l1               ; value = *f
 *        0x1e728  and  0xf, %l1, %o0             ; FIXABLE(value)
 *        0x1e72c  cmp  %o0, 0xa
 *        0x1e730  be  0x1e758
 *        0x1e734  btst  1, %l1                   ; pointer?
 *        0x1e738  be  0x1e750
 *        0x1e73c  mov  %l3, %o0                  ; set up registers for
 *        0x1e740  mov  %l0, %o1                  ; call to
 *        0x1e744  call  0x256a8 <mach_fixup>     ; mach_fixup
 *        0x1e748  mov  %l1, %o2                  ; ...
 *        0x1e74c  mov  %o0, %l3                  ; update 'to'.
 *        0x1e750  b  0x1e718                     ; loop
 *        0x1e754  add  4, %l0, %l0               ; ++f
 *  
 *  ints  11 instrs, 2t, 1n, 1an
 *  fixup 15 instrs, 1t, 2n, 1an
 *  
 *  2.2. Improvement in C:
 *  
 *  2.2.1. source:
 *  
 *    while (f < (end)) {
 *      mlval value = *f;
 *      if (value & 1) {
 *        to = mach_fixup(to,f,value);
 *        f++;
 *      } else if FIXABLE(value) {
 *        ...
 *      }
 *    }
 *  
 *  2.2.2. object generated by gcc2:
 *  
 *  loop:
 *        cmp     %i1,%i2                         ; f < end
 *        bgeu    over
 *        nop
 *        ld      [%i1],%l0                       ; value = *f
 *        andcc   %l0,1,%g0                       ; ptr?
 *        be      nonptr
 *        mov     %i0,%o0                         ; set up registers
 *        mov     %i1,%o1                         ; for call to
 *        call    _mach_fixup                     ; mach_fixup
 *        mov     %l0,%o2                         ; ...
 *        mov     %o0,%i0                         ; update 'to'
 *        b       loop                            ; loop
 *        add     %i1,4,%i1                       ; f++
 *  nonptr
 *        and     %l0,15,%o0                      ; FIXABLE
 *        cmp     %o0,10                          ; ...
 *        be      loop
 *        and     %l0,63,%o0                      ; do non-fixables
 *  
 *  ints  11 instrs, 2t, 1n
 *  fixup 13 instrs, 1t, 2n)
 *  
 *  2.2.3. code we would like to be generated:
 *  
 *  .loop:        cmp     %f, %end
 *                bcc,a   .endloop
 *                <annulled slot>
 *                ld      [%f],%val
 *                andcc   #1, %val, %foo
 *                beq,a   .nonptr
 *                and     #f, %val, %foo
 *                mov     %to, %arg0
 *                mov     %f, %arg1
 *                call    mach_fixup
 *                mov     %val, %arg2
 *                mov     %arg0, %to
 *                b       .loop
 *                add     #4, %f, %f
 *  
 *  .nonptr       cmp     %foo, 0xa
 *                bne     .loop
 *                add     #4, %f, %f
 *  
 *  ints  9 instrs, 1an, 1at, 1t  save 18%
 *  fixup 12 instrs, 2an, 1t      save 20%
 *  
 *  2.3. Assembly-language version (mach_fixup still out-of-line):
 *  
 *  keep f in arg1                (make mach_fixup take it as f+4)
 *       to in arg0
 *  
 *  .loop:        bcc,a   .endloop
 *                <annulled slot>
 *                ld      [%arg1],%arg2
 *                andcc   #1, %arg2, %foo
 *                beq,a   .nonptr
 *                and     #f, %arg2, %foo
 *                call    mach_fixup
 *                add     #4, %f, %f
 *                b       .loop
 *                cmp     %arg1, %end
 *         
 *  .nonptr       cmp     %foo, 0xa
 *                bne     .loop
 *                cmp     %arg1, %end
 *        
 *  ints  8 instrs, 1an, 1at, 1t  save 27%
 *  fixup 8 instrs, 2an, 1t       save 47%
 *  
 *  3. raw data for case frequencies:
 *  
 *  By instrumenting the C version of fixup, counts were obtained for each
 *  possible case. Two tests were run: a compilation of MLWorks, and a
 *  compilation and test of the Lego software.
 *  
 *  3.1. MLWorks compiling itself:
 *  
 * Total calls of fixup .  .  .   :    362679977
 *   non-pointers                 :    171985954 (47.42%)
 *   not from space     .  .  .   :     50456372 (26.46% of ptrs)
 *     static objects             :            0 ( 0.00% of non-from ptrs)
 *   already evacuated  .  .  .   :     16306156 (11.63% of from ptrs)
 *   copied                       :    123931495 (88.37% of from ptrs)
 *     pairs            .  .  .   :    100025407 (80.71% of copied objs)
 *     pointers                   :     19928905 (16.08% of copied objs)
 *       records        .  .  .   :     18324306 (91.95% of copied ptrs)
 *       strings                  :      1578149 ( 7.92% of copied ptrs)
 *       reals          .  .  .   :            0 ( 0.00% of copied ptrs)
 *       code objects             :            0 ( 0.00% of copied ptrs)
 *       backptrs       .  .  .   :        21447 ( 0.11% of copied ptrs)
 *         evacuated              :        16512 (76.99% of backptrs seen)
 *       shared closures   .  .   :         5003 ( 0.03% of copied ptrs)
 *         steps                  :        24808 ( 4.959 per shared closure)
 *         evacuated    .  .  .   :         4232 (84.59% shared closures)
 *     ref ptrs                   :      3977183 ( 3.21% of copied objs)
 *       arrays and weak arrays   :      3976646 (99.99% copied ref ptrs)
 *       bytearrays   .  .  .     :          537 ( 0.01% copied ref ptrs)
 * 
 *   Total copy loop iterations   :     41377495 ( 0.114 per fixup)
 *   Total bytes copied           :   1354119136 ( 3.734 per fixup)
 * 
 *  3.2. MLWorks running Lego:
 *  
 * Total calls of fixup .  .  .   :     48966306
 *   non-pointers                 :     13475451 (27.52%)
 *   not from space     .  .  .   :     17814184 (50.19% of ptrs)
 *     static objects             :            0 ( 0.00% of non-from ptrs)
 *   already evacuated  .  .  .   :      3606588 (20.40% of from ptrs)
 *   copied                       :     14070083 (79.60% of from ptrs)
 *     pairs            .  .  .   :     12820930 (91.12% of copied objs)
 *     pointers                   :      1193579 ( 8.48% of copied objs)
 *       records        .  .  .   :      1085403 (90.94% of copied ptrs)
 *       strings                  :        76581 ( 6.42% of copied ptrs)
 *       reals          .  .  .   :            0 ( 0.00% of copied ptrs)
 *       code objects             :            0 ( 0.00% of copied ptrs)
 *       backptrs       .  .  .   :        25766 ( 2.16% of copied ptrs)
 *         evacuated              :        18691 (72.54% of backptrs seen)
 *       shared closures   .  .   :         5829 ( 0.49% of copied ptrs)
 *         steps                  :        34686 ( 5.951 per shared closure)
 *         evacuated    .  .  .   :         4955 (85.01% shared closures)
 *     ref ptrs                   :        55574 ( 0.39% of copied objs)
 *       arrays and weak arrays   :        55428 (99.74% copied ref ptrs)
 *       bytearrays   .  .  .     :          146 ( 0.26% copied ref ptrs)
 * 
 *   Total copy loop iterations   :      3008191 ( 0.061 per fixup)
 *   Total bytes copied           :    136880448 ( 2.795 per fixup)
 *  
 *  =====================================================================
 */

/*  Note: various costs are listed in the code below, for instance:
 * 
 *  record size 1: 29 instrs, 3t, 2n, 1an, save.
 *  
 *  This means "to fixup a record of size 1 requires 29 instructions, of
 *  which 3 are taken branches, 2 are non-taken branches, and 1 is a
 *  non-taken annulled branch. Registers are saved and restored."
 *  
 *  The costs are measured from the entry to mach_fixup.
 *  
 *  At various points "costs so far" are noted, along with information
 *  about the current content of registers &c.
 */

#include "tags.h"
#include "naming.h"
#include "arenadefs.h"

! === FIX AN ML VALUE ===
!
! Parameters:
!   %o0  Where to copy objects to
!   %o1  Pointer to value to fix
!   %o2  Contents of that value
! Returns:
!   %o0  Where to copy to next

	.global C_NAME(mach_fixup)
C_NAME(mach_fixup):
	sethi	%hi(C_NAME(space_type)), %o4
	srl	%o2, SPACE_WIDTH, %o3	! Calculate block number of object
	or	%o4, %lo(C_NAME(space_type)), %o4
	ldub	[%o4 + %o3], %o5	! Fetch the type of the block
	cmp	%o5, 2			! Is it TYPE_FROM?
	beq	fix1
	andn	%o2, 7, %o3		! Mask out the primary tag in any case
	cmp	%o5, 5			! Is it TYPE_STATIC
	beq,a 	static			! if so, we must clear the mark word
	and	%o2, 7, %o5
return:	jmpl	%o7+8, %g0		! return
	nop

! static objects; there are three cases:
! - POINTER to BACKPTR
! - POINTER to shared closure
! - other

static:	cmp	%o5, POINTER		! if not a POINTER,
	bne	static_return		! mark the object
/* static_loop:, only the assembler warns on labels in delay slots */
	ld	[%o3], %o4		! if pointing to a zero
	cmp	%o4, %g0
	beq,a	static+8 /* static_loop */ ! take a step back and try again
	sub	%o3, 8, %o3
	and	%o4, 63, %o5		! test for BACKPTR
	cmp	%o5, BACKPTR
	bne	static_return		! If not a backptr, return
	srl	%o4, 6, %o4		! If a backptr, get the true
	sub	%o3, %o4, %o3		! object header
static_return:
	jmpl	%o7+8, %g0		! return
	st	%g0, [%o3-4]		! and clear the mark word.

fix1:	ldd	[%o3], %o4		! Load header and first word
	cmp	%o4, EVACUATED		! Is the object evacuated?
	be,a	return
	st	%o5, [%o1]		! Fix the value and return if so

! notfrom: 11 instrs, 1n, 1an
! static : 15 instrs, 1n, 1t, 1at
! staticb: 22 instrs, 3n, 1at, 1an
! statics: 21 instrs, 2n, 1t, 1an, 1at + 4 instrs, 1at per step
! already: 13 instrs, 1t, 1at.

! mach_fixup is not a leaf (it calls message() in error cases), so we
! have to push 24 words to allow for callee argument space.

	save	%sp, -0x60, %sp
	mov	EVACUATED, %o4		! Secondary for EVACUATED
	and	%i2, 7, %o3		! Mask in the primary tag
	add	%i0, %o3, %o5		! New tagged value
	cmp	%o3, PAIRPTR

! Current costs and state:
!
! 15 instrs, 1t, 1an, save.
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	fp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!				tag	EVAC	fixed	sp

	bne	not_a_pair
	st	%o5, [%i1]		! fix the original value
	std	%o4, [%i3]		! store fix
	std	%i4, [%i0]		! evacuate pair
	jmpl	%i7+8, %g0		! return
	restore %i0, 8, %o0		! increment the 'to' value and restore

! pair case: 21 instrs, 1t, 1n, 1an, save.

! Current costs and state:
!
! 17 instrs, 2t, 1an, save. *what fixed. registers:
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	fp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!				tag	EVAC	fixed	sp

not_a_pair:
	cmp	%o3, POINTER
	bne	not_a_ptr
	std	%o4, [%i3]		! do forwarding in delay slot
	and	%i4, 63, %o2
	cmp	%o2, RECORD
	bne	not_a_record
	srl	%i4, 6, %o0		! object length in delay slot

! so this is a record...

record:
	subcc	%o0, 2, %o0
	bneg	copy1
	std	%i4, [%i0]		! fixup header
copy0:	add	%i3, 8, %i3
	ldd 	[%i3], %i4
	std	%i4, [%i0 + 8]
	subcc	%o0, 2, %o0
	bpos	copy0
	add	%i0, 8, %i0
copy1:	jmpl	%i7+8, %g0
	restore	%i0, 8, %o0		! can we fill this add??
	
! record size 1: 29 instrs, 3t, 2n, 1an, save.
! record size 2,3: 35 instrs, 2t, 4n, 1an, save.
! + 6 instrs, 1t per double word.

! Current costs and state:
!
! 24 instrs, 3t, 1n, 1an, save. *what fixed, forwarded. registers:
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	fp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!	length		second	tag	EVAC	fixed	sp

! catch string and bytearray headers here, as we can do so for one extra
! instruction and it will catch boxed reals (which have regular pointers
! to 12-byte bytearray-headed objects).

not_a_record:
	and	%o2, 47, %o1		! Check for bytearrays too
	cmp	%o1, STRING
	bne	not_a_string
	add	%o0, 3, %o1		! Wasted if branch taken, who cares?
	srl	%o1, 2, %o0
string:
	subcc	%o0, 2, %o0
	bneg	scopy1
	std	%i4, [%i0]
scopy0: add	%i3, 8, %i3
	ldd	[%i3], %i4
	std	%i4, [%i0 + 8]
	subcc	%o0, 2, %o0
	bpos	copy0
	add	%i0, 8, %i0
scopy1:	jmpl	%i7+8, %g0
	restore	%i0, 8, %o0

! string size 0-4: 34 instrs, 4t, 2n, 1an, save
! string size 5-12: 40 instrs, 3t, 4n, 1an, save
! +6 instrs, 1t per 8 bytes

! Current costs and state:
!
! 28 instrs, 4t, 1n, 1an, save. *what fixed, forwarded. registers:
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	fp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!	length	len+3	2dary	tag	EVAC	fixed	sp

not_a_string:
	cmp	%o2, BACKPTR
	bne	not_a_backptr
	std	%i4, [%i3]		! Undo the forwarding
	sub	%i3, %o0, %o1		! Find the actual header
	ldd	[%o1], %o2
	mov	%o4, %i4		! Copy the evacuation marker
	cmp	%o2, %o4		! Has the whole code vector been evacuated?
	bne,a	back0
	add	%o5, %o0, %i5		! New value = new pointer + offset
	add	%o3, %o0, %i5		! New value = forward + offset
	std	%i4, [%i3]		! Evacuate the original
	st	%i5, [%i1]		! Fix the original again
	jmpl	%i7+8, %g0
	restore	%g0, 0, %g0

! already-evacuated backptr, 41 instrs, 4t, 2n, 3an, save.

back0:	srl	%o2, 6, %o0		! Calculate length of code vector in words
	std	%o4, [%o1]		! Evacuate the whole code vector
	std	%o2, [%i0]
	subcc	%o0, 2, %o0
back1:	add	%o1, 8, %o1
	ldd	[%o1], %o2
	std	%o2, [%i0 + 8]		! Copy the whole code vector
	subcc	%o0, 2, %o0
	bpos	back1
	add	%i0, 8, %i0
	std	%i4, [%i3]		! Evacuate the original value
	st	%i5, [%i1]		! Fix the original value
	jmpl	%i7+8, %g0
	restore	%i0, 8, %o0

! code vector size 4: 51 instrs, 4t, 3n, 1at, 2an, save.
! + 6 instrs, 1t per double word.

! Current costs and state:
!
! 31 instrs, 5t, 1n, 2an, save. *what fixed. registers:
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	fp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!	length	&hdr-len 2dary	tag	EVAC	fixed	sp

not_a_backptr:
	cmp	%i4, 0
	bne	not_a_shared_closure

/* this stuff not so well-optimised because it's a very rare case (~0.05%) */

	sub	%i3, 8, %o0		! Who cares if we fill this slot...
shared_closure:
	ldd	[%o0], %o2		! Search back for the actual header
	cmp	%o2, %g0
	bz,a	shared_closure
	sub	%o0, 8, %o0
	sub	%i3, %o0, %o1		! Calculate the offset within the closure
	mov	%o4, %i4		! Copy evacuation marker
	cmp	%o2, %o4		! Has the whole record been evacuated?
	bne,a	clos0
	add	%o5, %o1, %i5		! New value = new pointer + offset
	add	%o3, %o1, %i5		! New value = forward + offset
	std	%i4, [%i3]		! Evacuate the original
	st	%i5, [%i1]		! Fix the original value
	jmpl	%i7+8, %g0
	restore	%g0, 0, %g0
clos0:	srl	%o2, 6, %o1		! Calculate length of closure
	std	%o4, [%o0]		! Evacuate the whole closure
	std	%o2, [%i0]		! Copy the whole closure
	subcc	%o1, 2, %o1
	bneg	clos2
	add	%i0, 8, %i0
clos1:	add	%o0, 8, %o0
	ldd	[%o0], %o2
	std	%o2, [%i0]		! Copy the whole closure
	subcc	%o1, 2, %o1
	bpos	clos1
	add	%i0, 8, %i0
clos2:	std	%i4, [%i3]		! Evacuate the original value
	st	%i5, [%i1]		! Fix the original value
	jmpl	%i7+8, %g0
	restore	%g0, 0, %g0

! shared closures already evac: 46 instrs, 5t, 1n, 4an, save.
! shared closures not evac: 52 instrs, 5t, 1n, 3an, 1at, save
! + 6/additional double word
! + 4 instrs, 1at per step

! 20 instrs, 3t, 1an, save. *what fixed, forwarded. registers:
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	sp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!				tag	EVAC	fixed

/* not a regular pointer, so it must be a refptr (otherwise it's an error) */

not_a_ptr:
	cmp	%o3, REFPTR
	bne	primary7
	and	%i4, 63, %o2		! Get secondary tag
	cmp	%o2, BYTEARRAY		! Is it a bytearray?
	be	bytearray
	std	%i4, [%i0]
	ldd	[%i3 + 8], %o2		! Fetch back pointer and first element
	cmp	%o2, %g0		! Is the backward pointer non-zero?
	bz	rcopy			! Copy the rest as a record
	srl	%i4, 6, %o0		! Calculate the length from the header
	st	%i0, [%i5 + 8]		! forward->back = new address
	st	%i0, [%o2 + 4]		! back->forward = new address

! Costs to here: 30 instrs, + 2 optional instrs

rcopy:	subcc	%o0, 2, %o0		! Copy double words to end of record or string
	bneg	rcopy1
	std	%o2, [%i0 + 8]		! Copy back pointer and first element
rcopy0: ldd	[%i3 + 16], %i4
	std	%i4, [%i0 + 16]
	subcc	%o0, 2, %o0
	add	%i3, 8, %i3
	bpos	rcopy0
	add	%i0, 8, %i0
rcopy1:	jmpl	%i7+8, %g0
	restore	%i0, 16, %o0

! ref cells 35 instrs, 5t, 2n, 1an, save.
! array size 2/3 41 instrs, 4t, 4n, 1an, save.
! + 6 instrs, 1t per double
! + 2 instrs, 1n, -1t if on an entry list

! Current costs and state:
!
! 26 instrs, 4t, 1n, 1an, save. *what fixed, forwarded, evac. registers:
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	sp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!			primary	tag	EVAC	fixed

bytearray:
	srl	%i4, 6, %o0
	add	%o0, 3, %o1
	srl	%o1, 2, %o0		! Round length to words
	subcc	%o0, 2, %o0		! Copy double words to end of record or string
	bneg	bcopy1
	add %i0, 8, %i0			! Could merge this with the restore
bcopy0: ldd	[%i3 + 8], %i4
	std	%i4, [%i0]
	subcc	%o0, 2, %o0
	add	%i3, 8, %i3
	bpos	bcopy0
	add	%i0, 8, %i0
bcopy1:	jmpl	%i7+8, %g0
	restore	%g0, 0, %g0

! bytearray size 0-4 34 instrs, 5t, 1n, 1an, save.
! bytearray size 5-12 40 instrs, 4t, 3n, 1an, save.
! + 6 instrs, 1t per 8 bytes.

!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	sp	return	
!	o0	o1	o2	o3	o4	o5	o6	o7
!			2dary	tag	EVAC	fixed

primary7:
	std	%i4, [%i3]		! undo forwarding
	mov	%i1, %o0
	call	C_NAME(fixup_bad_primary)
	mov	%i2, %o1
	ret
	restore

! we only get here if we have a direct pointer to a code object,
! which is very unusual (basically it means the GC has been entered in
! the middle of loading a code object).

! *what fixed.
!	i0	i1	i2	i3	i4	i5	i6	i7
!	to	what	*what	&hdr	hdr	word1	fp	return
!	o0	o1	o2	o3	o4	o5	o6	o7
!	&hdr-8	&hdr-len 2dary	tag	EVAC	fixed	sp

not_a_shared_closure:
	cmp	%o2, CODE		! extremely unusual case (<< 1 ppm)
	bne	bad_header

! In getting here, we have done a couple of things in delay slots that
! are undesireable. We have to fix them.

	srl	%i4, 6, %o0		! recalculate the length
	ba	record
	std	%o4, [%i3]		! redo the forwarding

bad_header:
	mov	%i1, %o0
	mov	%i2, %o1
	mov	%i4, %o2
	call	C_NAME(fixup_bad_header)
	mov	%i3, %o3
	ret
	restore
