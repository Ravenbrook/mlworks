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
 * Revision 1.3  1998/03/19 11:54:56  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.2  1996/12/19  13:39:09  nickb
 * Add instruction cache flushing.
 *
 * Revision 1.1  1995/12/11  14:21:49  nickb
 * new unit
 * Adding space profiling for the MIPS
 *
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
 * We manipulate allocation sequences in code objects so that they all
 * cause a transfer of control to bits of code in the runtime which
 * record the allocation.
 *
 * We have to provide transformations in each direction. */

/*

Non-profiled allocation sequences:

         ...			; update alloc point register gc1 (register 2)
00430822 sub	global,gc1,gc2	; check for allocation overflow
         bltz	no_gc
         ...
8d21000x lw	global, gc_entry[thread]
				; get GC entry address
				  (gc_entry = IMPLICIT_gc or IMPLICIT_gc_leaf)
         ...

Profiled allocation sequences replace the subtraction and the load
from the thread:

00430822 sub	global,gc1,gc2

becomes

00420822 sub	global,gc1,gc1	; the bltz is never taken

8d21000x lw	global, IMPLICIT_gc[thread]

becomes

8d2100yy lw	global, IMPLICIT_profile_space[thread]

[and similarly for the leaf case]

*/

#define SUBINSTR       0x00430822
#define PROF_SUBINSTR  0x00420822

#define GC_LOAD        (0x8d210000 + IMPLICIT_gc)
#define GC_LEAF_LOAD   (0x8d210000 + IMPLICIT_gc_leaf)

#define PROF_LOAD      (0x8d210000 + IMPLICIT_profile_alloc)
#define PROF_LEAF_LOAD (0x8d210000 + IMPLICIT_profile_alloc_leaf)

/* Adding space profiling */

static inline int add_space_profiling (word *from, word *to)
{
  register word *p = from, *q = to, instr;
  register int replace_sub = 0, replace_load = 0, replace_leaf_load = 0;

  for( ; p < q ; ) { 
    instr = *p;
    if (instr == SUBINSTR) {
      *p = PROF_SUBINSTR;
      replace_sub++;
    } else if (instr == GC_LOAD) {
      *p = PROF_LOAD;
      replace_load++;
    } else if (instr == GC_LEAF_LOAD) {
      *p = PROF_LEAF_LOAD;
      replace_leaf_load++;
    }
    p++;
  }
  if (replace_load == 0)
    replace_load = replace_leaf_load;
  else if (replace_leaf_load)
    error("Code replacement from 0x%08x to 0x%08x found leaf and non-leaf",
	  from, to);
  if (replace_sub != replace_load)
    error("Code replacement from 0x%08x to 0x%08x found %d/%d mismatch",
	  from, to, replace_sub, replace_load);

  return replace_sub;
}

/* Removing space profiling */

static inline int remove_space_profiling (word *from, word *to)
{
  register word *p = from, *q = to, instr;
  register int replace_sub = 0, replace_load = 0, replace_leaf_load = 0;

  for( ; p < q ; ) { 
    instr = *p;
    if (instr == PROF_SUBINSTR) {
      *p = SUBINSTR;
      replace_sub++;
    } else if (instr == PROF_LOAD) {
      *p = GC_LOAD;
      replace_load++;
    } else if (instr == PROF_LEAF_LOAD) {
      *p = GC_LEAF_LOAD;
      replace_leaf_load++;
    }
    p++;
  }
  if (replace_load == 0)
    replace_load = replace_leaf_load;
  else if (replace_leaf_load)
    error("Code replacement from 0x%08x to 0x%08x found leaf and non-leaf",
	  from, to);
  if (replace_sub != replace_load)
    error("Code replacement from 0x%08x to 0x%08x found %d/%d mismatch",
	  from, to, replace_sub, replace_load);

  return replace_sub;
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
