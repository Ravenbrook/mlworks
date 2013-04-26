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
 * Revision 1.3  1998/03/18 16:43:27  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.2  1996/12/19  13:31:53  nickb
 * Add instruction cache flushing.
 *
 * Revision 1.1  1995/07/19  13:35:17  nickb
 * new unit
 * dinking about with bits of machine code.
 *
 */

#include "tags.h"
#include "mltypes.h"
#include "values.h"
#include "utils.h"
#include "extensions.h"
#include "environment.h"
#include "arch_code.h"
#include "offsets.h"
#include "cache.h"

/* Space profiling code vectors.
 *
 * We replace allocation sequences in code objects with branches to
 * bits of code in the runtime which record the allocation.
 *
 * We have to provide transformations in each direction.
 */

/*

Non-profiled allocation sequences:

taddcctv g1, <size>, g1		      	1000 0011 0001 0000 01<size>
add/or	 g2, #<tag>, <result>		10rr rrr0 000b 0000 1010 0000 0000 0tag
add	 g2, <size>, g2			1000 0100 0000 0000 10<size>

	(where <size> = #<isize> or <size> = g4,
	 b = leaf,
	 rrrrr = result register)

Profiled allocation sequences:

jmpl	 g5+profile_alloc{_leaf}, g5	1000 1011 1100 0001 011<offset>
add/or	 g0, <size>, g4			1000 1000 0001 0000 00<size>
add	 g4, #<tag>, <result>		10rr rrr0 000b 0001 0010 0000 0000 0tag

jmpinstr = 0x8bc16000 + IMPLICIT_profile_alloc
jmpinstr_leaf = 0x8bc16000 + IMPLICIT_profile_alloc_leaf

To find non-profiled sequence, search for:

instr1 & 0xffffc000 == 0x83104000
size = instr1 & 0x00003fff
instr2 & 0xc1effff8 == 0x8000a000
leaf = (instr2 & 0x00100000)
instr3 & 0xffffc000 == 0x84008000,
size == instr3 & 0x00003fff

To make a profiled sequence:

instr1 = leaf ? jmpinstr_leaf : jmpinstr
instr2 = 0x88100000 + size
instr3 = oldinstr2 + 0x00008000

To find profiled sequence:

instr1 == jmpinstr || instr1 = jmpinstr_leaf
instr2 & 0xffffc000 == 0x88100000
size = instr2 & 0x00003fff
instr3 & 0xc1effff8 == 0x80012000

To make an unprofiled sequence:

instr1 = 0x83104000 + size
instr2 = oldinstr3 - 0x00008000
instr3 = 0x84008000 + size

*/

#define JMPINSTR      (0x8bc16000 + IMPLICIT_profile_alloc)
#define JMPINSTR_LEAF (0x8bc16000 + IMPLICIT_profile_alloc_leaf)

#define ARITH_MASK     0xffffc000
#define TADDCCTV_BITS  0x83104000
#define SIZE_MASK      0x00003fff

#define ADD_OR_MASK    0xc1effff8
#define ADD_OR_G2_BITS 0x8000a000
#define ADD_OR_G4_BITS 0x80012000
#define LEAF_MASK      0x00100000

#define ADD_BITS       0x84008000
#define MOV_BITS       0x88100000

#define G2_G4_DIFFERENCE 0x00008000

/* Adding space profiling */

static inline int add_space_profiling (word *from, word *to)
{
  register word instr1, instr2, instr3, size, leaf, *p = from, *q = to;
  register int replacements=0;

  instr1 = *p;

  for( ; p < q ; ) {
    if ((instr1 & ARITH_MASK) == TADDCCTV_BITS) {
      size = instr1 & SIZE_MASK;
      instr2 = p[1];
      if ((instr2 & ADD_OR_MASK) == ADD_OR_G2_BITS) {
	leaf = instr2 & LEAF_MASK;
	instr3 = p[2];
	if ((instr3 & ARITH_MASK) == ADD_BITS) {
	  p[0] = leaf ? JMPINSTR_LEAF : JMPINSTR;
	  p[1] = MOV_BITS + size;
	  p[2] = instr2 + G2_G4_DIFFERENCE;
	  replacements++;
	  p+= 3;
	  instr1 = *p;
	} else {
	  instr1 = instr3;
	  p += 2;
	}
      } else {
	instr1 = instr2;
	p++;
      }
    } else {
      p++;
      instr1 = *p;
    }
  }

  return replacements;
}

/* Removing space profiling */

static inline int remove_space_profiling (word *from, word *to)
{
  register word instr1, instr2, instr3, size, *p = from, *q = to;
  register int replacements=0;

  instr1 = *p;

  for( ; p < q ; ) {
    if ((instr1 == JMPINSTR_LEAF) || (instr1 == JMPINSTR)) {
      instr2 = p[1];
      if ((instr2 & ARITH_MASK) == MOV_BITS) {
	size = instr2 & SIZE_MASK;
	instr3 = p[2];
	if ((instr3 & ADD_OR_MASK) == ADD_OR_G4_BITS) {
	  p[0] = TADDCCTV_BITS + size;
	  p[1] = instr3 - G2_G4_DIFFERENCE;
	  p[2] = ADD_BITS + size;
	  replacements++;
	  p+= 3;
	  instr1 = *p;
	} else {
	  instr1 = instr3;
	  p += 2;
	}
      } else {
	instr1 = instr2;
	p++;
      }
    } else {
      p++;
      instr1 = *p;
    }
  }
  return replacements;
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

static void icache_flush(word *first, word *last)
{
  if (first < last)
    cache_flush((void*)first, (last-first)*sizeof(word));
}

extern int arch_space_unprofile_code(mlval codepointer)
{
  word *first_instruction, *last_instruction;
  int changes;
  first_and_last_instructions(&first_instruction, &last_instruction,
			      codepointer);
  changes = remove_space_profiling(first_instruction, last_instruction);
  icache_flush(first_instruction, last_instruction);
  return changes;
}
    
extern int arch_space_profile_code(mlval codepointer)
{
  word *first_instruction, *last_instruction;
  int changes;
  first_and_last_instructions(&first_instruction, &last_instruction,
			      codepointer);
  changes = add_space_profiling(first_instruction, last_instruction);
  icache_flush(first_instruction, last_instruction);
  return changes;
}
