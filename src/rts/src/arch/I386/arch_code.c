/* rts/src/arch/$ARCH/arch_code.c
 *
 * Functions for recognising and manipulating architecture-specific code
 * sequences.
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
 * $Log: arch_code.c,v $
 * Revision 1.4  1998/08/21 14:54:07  jont
 * [Bug #20133]
 * Stop modifying code vectors for space profiling
 *
 * Revision 1.3  1996/12/19  13:25:53  nickb
 * Add instruction cache flushing.
 *
 * Revision 1.2  1995/12/13  11:36:51  nickb
 * OK, now let's make it work.
 *
 * Revision 1.1  1995/12/12  17:53:14  nickb
 * new unit
 * Trial implementation of space profiling code.
 *
 */

#include "tags.h"
#include "mltypes.h"
#include "values.h"
#include "utils.h"
#include "extensions.h"
#include "environment.h"
#include "arch_code.h"
#include "i386_code.h"
#include "offsets.h"

/* Space profiling code vectors.
 *
 * We manipulate allocation sequences in code objects so that they all
 * cause a transfer of control to bits of code in the runtime which
 * record the allocation.
 *
 * We have to provide transformations in each direction. */

/*

Non-profiled allocation sequences:

	...
3bxx54	cmp	reg, gc_limit(thread)
	...
ff5604	call 	ml_gc(thread)

Profiled allocation sequences replace the comparison and the call:

3bxx54 cmp	reg, gc_limit(thread)

becomes

3bxxyy cmo	reg, gc_base(thread)	; the jb is never taken

ff5604	call	ml_gc(thread)

becomes

ff56xx	call	ml_profile_alloc(thread)

*/

#define CMP_BYTE_1	0x3b
#define CMP_BYTE_2_MASK	0xc7
#define CMP_BYTE_2_TEST	0x46
#define CMP_BYTE_3	IMPLICIT_gc_limit

#define PROF_CMP_BYTE_3	IMPLICIT_gc_base

#define CALL_BYTE_1	0xff
#define CALL_BYTE_2	0x56
#define CALL_BYTE_3	IMPLICIT_gc

#define PROF_CALL_BYTE_3 IMPLICIT_profile_alloc

/* Adding space profiling */

static inline int add_space_profiling (word *from, word *to)
{
  byte *p = (byte*) from;
  register byte *q = (byte*) to;
  register int replace_cmp = 0, replace_call = 0;

  for( ; p < q ; ) { 
    if (p[0] == CMP_BYTE_1 &&
	((p[1] & CMP_BYTE_2_MASK) == CMP_BYTE_2_TEST) &&
	p[2] == CMP_BYTE_3) {
      replace_cmp++;
      p[2] = PROF_CMP_BYTE_3;
    } else if (p[0] == CALL_BYTE_1 &&
	       p[1] == CALL_BYTE_2 &&
	       p[2] == CALL_BYTE_3) {
      replace_call++;
      p[2] = PROF_CALL_BYTE_3;
    }
    if (!read_instr(&p))
      error("Code replacement from 0x%08x to 0x%08x "
	    "found unreadable code at 0x%08x", from, to, p);
  }
  if (replace_cmp != replace_call)
    error("Code replacement from 0x%08x to 0x%08x found %d/%d mismatch",
	  from, to, replace_cmp, replace_call);

  return replace_cmp;
}

/* Removing space profiling */

static inline int remove_space_profiling (word *from, word *to)
{
  byte *p = (byte*) from;
  register byte *q = (byte*) to;
  register int replace_cmp = 0, replace_call = 0;

  for( ; p < q ; ) { 
    if (p[0] == CMP_BYTE_1 &&
	((p[1] & CMP_BYTE_2_MASK) == CMP_BYTE_2_TEST) &&
	p[2] == PROF_CMP_BYTE_3) {
      replace_cmp++;
      p[2] = CMP_BYTE_3;
    } else if (p[0] == CALL_BYTE_1 &&
	       p[1] == CALL_BYTE_2 &&
	       p[2] == PROF_CALL_BYTE_3) {
      replace_call++;
      p[2] = CALL_BYTE_3;
    }
    if (!read_instr(&p))
      error("Code replacement from 0x%08x to 0x%08x "
	    "found unreadable code at 0x%08x", from, to, p);
  }
  if (replace_cmp != replace_call)
    error("Code replacement from 0x%08x to 0x%08x found %d/%d mismatch",
	  from, to, replace_cmp, replace_call);

  return replace_cmp;
}

static void first_and_last_instructions(word**first, word **last,
					mlval codepointer)
{
  mlval codeobject  = FOLLOWBACK(codepointer);
  mlval ancillaries = CCVANCILLARY(codeobject);
  mlval profiles = FIELD(ancillaries,ANC_PROFILES);
  size_t length = NFIELDS(profiles);
  unsigned int codenumber = CCODENUMBER(codepointer);
  
  *first = (word*) (codepointer-POINTER+8);
  *last = NULL;

  if (length == codenumber+1) {
    mlval header = *(mlval*)(codeobject-POINTER);
    *last = ((word*) (codeobject-POINTER))+LENGTH(header)-1;
  } else {
    word *p = *first;
    size_t offset = (codepointer-codeobject+8);
    for(; p+=2, offset += 8; ) {
      word w = *p;
      if (SECONDARY(w) == BACKPTR && LENGTH(w) == offset) {
	*last = p-1;
	break;
      }
    }
    if (*last == NULL)
      error ("no backptr found!\n");
  }
}

extern int arch_space_unprofile_code(mlval codepointer)
{
  word *first_instruction, *last_instruction;
  int changes;
  first_and_last_instructions(&first_instruction, &last_instruction,
			      codepointer);
  changes = remove_space_profiling(first_instruction, last_instruction);
  /* would flush icache here if that was meaningful on x86 */
  return changes;
}
    
extern int arch_space_profile_code(mlval codepointer)
{
#ifdef SPACE_PROFILE_OVERFLOW
  return 0;
#else
  word *first_instruction, *last_instruction;
  int changes;
  first_and_last_instructions(&first_instruction, &last_instruction,
			      codepointer);
  changes = add_space_profiling(first_instruction, last_instruction);
  /* would flush icache here if that was meaningful on x86 */
  return changes;
#endif  
}
